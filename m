Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17B616AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKBRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKBRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A62E6B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA68B820D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01EEC433C1;
        Wed,  2 Nov 2022 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410673;
        bh=C7djWQbBJX1AM7fSvtoWtTiF2BgIva+pASKAjGZVevU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odUT8QDh+qqr4P3f6EboSgGzToIq6ljdiISZHN7EIT3GuRbEUzStj66n/ONbIs/39
         ZF4ZBaZd5KpfFDMvgRoZxbPx0t7+7ufnbDe2PGz1fAPssxhwtht1dD/PRgfvxF244o
         3Vj7KqrscxfgNNyM7XbqDb0MTJaxtcLIdUUXbFElgRq+ArV0rqY02VqNuP/ASo1v5m
         nYo0q+tu6idts2WGIcTxoTV7Wqy18/2LR0tDT/53iX9S/bT2BzENBmY0wki0+ODLtP
         R/DYbNlh2mEksAb9vOVEd2EZjoSxepk8soefhHWWI3g9PFEb46DmVWL36Ikj6UaWnZ
         hbh68oPdfPIig==
Date:   Thu, 3 Nov 2022 01:28:11 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: vdso: fix section overlapping under some
 conditions
Message-ID: <Y2Koq5QELaoBe7nj@xhacker>
References: <20221031175842.1699-1-jszhang@kernel.org>
 <20221101091942.k7pgcbbkudgjk4ae@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101091942.k7pgcbbkudgjk4ae@kamzik>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:19:42AM +0100, Andrew Jones wrote:
> On Tue, Nov 01, 2022 at 01:58:42AM +0800, Jisheng Zhang wrote:
> > lkp reported a build error, I tried the config and can reproduce
> > build error as below:
> > 
> >   VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
> > ld.lld: error: section .note file range overlaps with .text
> > >>> .note range is [0x7C8, 0x803]
> > >>> .text range is [0x800, 0x1993]
> > 
> > ld.lld: error: section .text file range overlaps with .dynamic
> > >>> .text range is [0x800, 0x1993]
> > >>> .dynamic range is [0x808, 0x937]
> > 
> > ld.lld: error: section .note virtual address range overlaps with .text
> > >>> .note range is [0x7C8, 0x803]
> > >>> .text range is [0x800, 0x1993]
> > 
> > Fix it by removing the hardcoding 0x800 and related comments.
> > 
> > Link: https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/#r
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> > index 01d94aae5bf5..344209d2e128 100644
> > --- a/arch/riscv/kernel/vdso/vdso.lds.S
> > +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> > @@ -31,13 +31,7 @@ SECTIONS
> >  
> >  	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
> >  
> > -	/*
> > -	 * This linker script is used both with -r and with -shared.
> > -	 * For the layouts to match, we need to skip more than enough
> > -	 * space for the dynamic symbol table, etc. If this amount is
> > -	 * insufficient, ld -shared will error; simply increase it here.
> > -	 */
> > -	. = 0x800;
> 
> Hi Jisheng,

Hi Andrew,

> 
> Removing this hard coded value is a good thing, but I don't understand
> why, if it was necessary before, that it's no longer necessary. Can you
> please explain that in the commit message? If the linker improved in

To be honest, I dunno. The hardcoded 0x800 was there from day1, maybe
Palmer knew the details.

> this regard, then do we need to document a new minimum linker version?


> 
> > +	. = ALIGN(16);
> 
> Aligning text to a 4-byte boundary makes sense to me, but I don't

Aha, I think align text to 4byte is fine. In my old memories, I was
told to align function entry at 16byte boundary, I'm not sure this
is still true.

PS: I just sent out v2 of this fix. The fix method is different and
think v2 is the correct fix while this v1 is an improvement.
