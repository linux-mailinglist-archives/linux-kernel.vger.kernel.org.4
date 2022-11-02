Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC01617094
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FEA474
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AF061C7B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34911C433D6;
        Wed,  2 Nov 2022 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667427744;
        bh=tHrNBW9mMlHHU97INamlJtFogG4JV+2Fd+CPniqM56M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+UN9Hsk9O5pYn6r2EWR5jGCatbDYYprh7TtCc0u5H1/2qvSOgHNstQ6oGqnQi9Z7
         KmAUwwTIIbDA15fjbG2Gp0rcLqqYfn3/zHQZDMAlOCxMrxIhDiFLOIIgO/o7Wxc8CA
         QjU4ht38UYUN97aT9DtpfX/msdvheL4uI+yHp3uoN++km0TIbPiwhNnEx7LywpJ8OD
         u7CSfw5lSUrG0TlqdWymM7kCCw8PZ8LBpaDaXTrDrrsXF99aDkoWh0FW16FLnU4cRz
         t/tornJFlUDL00mq9rW6sQrSkvc35dGL2r2EGRJb3Z+dEPbzpawtVGQz24cz98JTGL
         E30DT8B744tuA==
Date:   Wed, 2 Nov 2022 15:22:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, djwong@kernel.org,
        yujie.liu@intel.com, tglx@linutronix.de, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: Re: [PATCH 3/5] objtool: Avoid O(bloody terrible) behaviour -- an
 ode to libelf
Message-ID: <20221102222222.r4xkj6uynlj6n2t6@treble>
References: <20221028194022.388521751@infradead.org>
 <20221028194453.461658986@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028194453.461658986@infradead.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:40:25PM +0200, Peter Zijlstra wrote:
> Due to how gelf_update_sym*() requires an Elf_Data pointer, and how
> libelf keeps Elf_Data in a linked list per section,
> elf_update_symbol() ends up having to iterate this list on each
> update to find the correct Elf_Data for the index'ed symbol.
> 
> By allocating one Elf_Data per new symbol, the list grows per new
> symbol, giving an effective O(n^2) insertion time. This is obviously
> bloody terrible.
> 
> Therefore over-allocate the Elf_Data when an extention is needed.
> Except it turns out libelf disregards Elf_Scn::sh_size in favour of
> the sum of Elf_Data::d_size. IOW it will happily write out all the
> unused space and fill it with:
> 
>   0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> 
> entries (aka zeros). Which obviously violates the STB_LOCAL placement
> rule, and is a general pain in the backside for not being the desired
> behaviour.
> 
> Manually fix-up the Elf_Data size to avoid this problem before calling
> elf_update().
> 
> This significantly improves performance when adding a significant
> number of symbols.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Instead of going through libelf to add each symbol, and
adjusting/shifting/reallocating the d_buf one symbol at a time, it would
probably be a lot easier (and faster) to just manually do all that at
the end, just before writing the file.

See for example what kpatch does:

  https://github.com/dynup/kpatch/blob/master/kpatch-build/kpatch-elf.c#L725

-- 
Josh
