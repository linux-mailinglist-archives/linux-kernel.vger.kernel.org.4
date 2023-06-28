Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB37417CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjF1SK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1SKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CCB10D8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29AD36137F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA31C433C8;
        Wed, 28 Jun 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687975821;
        bh=mRw+zSjf9GVtwo3Ud86Z4s79jqjy9EQmP9Bk+yry79A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xl5IPOjHQkFkteFmgywK0YHyez1XmlRv472aammeiNpNloRidnxLudrm8amkVjY80
         ghvB49te5naUnLaUpzaakeQsuO6SSZHRWtZkLV36FyGmkdylV5pTXA2zPbNNjaB9N1
         1+TN1te5e+WOGkViNY8rkqx2xOVAWZtKl99z8KlbqPMamqRINyT3yBETdljldChXvK
         RwWTFmC2jUgRn/7fh0VfdpQkqvoAWecD5nB4Df/1PlO6bEgbM8b8bCFykQvfEJxx4N
         k48wxinIXNh9NmEyV3ww3D1LAJVKcHG9V+dgzJs73Ceq369EmMQ5SGY/HVI0LIKY8v
         Ko7/OTESN2ELA==
Date:   Wed, 28 Jun 2023 11:10:19 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628181019.cmgfbygxfvwamzur@treble>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
 <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
 <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
 <20230628170530.derop5w2gtmgjeis@treble>
 <20230628172659.6qwbswgz4ki24wyv@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628172659.6qwbswgz4ki24wyv@lion.mk-sys.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:26:59PM +0200, Michal Kubecek wrote:
> I digged some more and my guess is that the problem is that
> elf_open_read() does
> 
> 	memset(elf, 0, offsetof(struct elf, sections));
> 
> but commit eb0481bbc4ce ("objtool: Fix reloc_hash size") added
> num_relocs after sections so that it is not zeroed (0xbabababababababa
> is probably some kind of poison).

Argh, that memset() is subtle as heck.  Peter, why?!?

-- 
Josh
