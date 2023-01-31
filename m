Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEE6833D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjAaR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAaR1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:27:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720030E7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236E1615E8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669F2C433D2;
        Tue, 31 Jan 2023 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675186035;
        bh=/194TMVcoyvwrdvsuob2l66EPZ81yrnoUt3khM0r5vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqQ9XXEseOqgiU8jSLrHUTBmOTO7/pl0n1skuHURUwOQN2siSC8B27scGTGTiAuVT
         GpLcoJNJrL3XBpBnA1uLC+c1aGaAZPYy7cc/7OEXOOfQWIKFNp7hJ01A/EFrDTYRZG
         Vi7XGUfJAUIImFa2zcrdDc1KsmQacL3n1laPE0R0AxozA5pV9I5wyCJm/f5uA8Ih7X
         iHRZR6sduLplFkm3AYPDrXvjJxqJh9Fpkxdlmi+srdPC4bcRBn3dNMgLjuFKj5eVZt
         hxCtgMcESRyEvPwQMCbKN+PPj0MsA8JcNaAK6iHFfZ7ZQ0nz6JnCk8dKWRgkC5WTuw
         vNXS1GnBCaALQ==
Date:   Tue, 31 Jan 2023 09:27:13 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] objtool: reduce maximum memory usage
Message-ID: <20230131172713.lhsunmdhww4kduwv@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20230129214339.76hyytrllggbvuat@t-8ch.de>
 <20230131000356.5u2siglndnjyarql@treble>
 <20230131035442.yzq4opasci7azt2j@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131035442.yzq4opasci7azt2j@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:54:42AM +0000, Thomas Weißschuh wrote:
> On Mon, Jan 30, 2023 at 04:03:56PM -0800, Josh Poimboeuf wrote:
> > On Sun, Jan 29, 2023 at 09:43:39PM +0000, Thomas Weißschuh wrote:
> > > On Tue, Dec 27, 2022 at 04:00:57PM +0000, Thomas Weißschuh wrote:
> > > > The processing of vmlinux.o with objtool is the most memory-intensive step
> > > > of a kernel build. By reducing the maximum memory usage here we can reduce
> > > > the maximum memory usage of the whole kernel build.
> > > > Therefore memory pressure on memory starved machines is relieved during
> > > > kernel builds and the build is faster as less swapping has to occur.
> > > 
> > > Friendly ping.
> > > 
> > > These patches can also applied one by one, the only dependency is from
> > > patch 5 to patch 4.
> > 
> > Thanks, I'll go ahead and take five of them now.
> 
> Thanks.
> 
> I have another half-finished series that replaces the doubly-linked
> list_heads used by elf.h with a custom singly-linked list.
> This would save a few pointers per struct.
> 
> Do you think this is worth it?

Maybe, depending on the memory savings.

-- 
Josh
