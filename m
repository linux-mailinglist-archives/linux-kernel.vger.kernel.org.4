Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E463F71F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLASIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLASIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:08:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C29D811
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B3EB81FCA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E3FC433D6;
        Thu,  1 Dec 2022 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669918083;
        bh=eV3341lb7+6XNgTLaIktuIdCJWmIKdKYI2s1ijZKMoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+zPGiLMYc5v/FcCKV7AL61qlcz+UajvuQOLjlB36s0iW8umPovln0c9qhmepMJ3s
         wHoCZXrfKolXi145YCVFHm7mdzYzubwMq62NDQmOQ/ZMZRJMSUoBPMMZDCoW2ZoTf1
         /+HlzfOO0nZaJtVfAXFpoBQN1hIkwYPn/5HgPCFn9JeNPhTl3E1e+vLOryLHdSkZda
         QmOL7opnC8pJTLpmIMbPAz4NkbOAo4oEWiDZdC4q5rwSS5GRxyuBRz14Qqb3/P5FRU
         Z5eMogzHFPVtiknCB88tYl9m0Bm41g4tGhhFMZYOtG9jzVlCF/hlBEgvU4nfleNSlq
         KWb8blwMxFaSg==
Date:   Thu, 1 Dec 2022 18:07:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>
Cc:     Song Shuai <suagrfillet@gmail.com>, guoren@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@atishpatra.org, heiko@sntech.de, anshuman.khandual@arm.com,
        liaochang1@huawei.com, juerg.haefliger@canonical.com,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv : select
 FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <Y4jtfrJt+/Q5nMOz@spud>
References: <20221201151336.8044-1-suagrfillet@gmail.com>
 <Y4jICn5oxLozsv6m@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4jICn5oxLozsv6m@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:28:10PM +0000, Conor Dooley wrote:
> On Thu, Dec 01, 2022 at 11:13:36PM +0800, Song Shuai wrote:
> > In RISC-V, -fpatchable-function-entry option is used to support
> > dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> > don't have to be called to create the __mcount_loc section before
> > the vmlinux linking.
> > 
> > Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > Makefile not to run recordmcount.
> > 
> > Link_v1: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> > Link_v2: https://lore.kernel.org/linux-riscv/CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com/T/#m62138d7a76664798d00051818a438a601eff4cf1
> 
> Hey Song Shuai,
> 
> For future patches, please use normal "Link:" tags. If you're just
> linking to prior versions of the patch, just put them below the ---
> line so they don't end up in the git history.

> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 572973103d73..c19cddb8feb9 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -277,6 +277,7 @@ config ARCH_RV64I
> >  	select 64BIT
> >  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> > +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE

Also, why are these not added in alphabetical order, like the current
list is? I don't see HAVE_DYNAMIC_FTRACE in linux-next from the other
day so that probably needs fixing in the series you are based on too.

> >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  	select HAVE_SAMPLE_FTRACE_DIRECT
> > -- 
> > 2.20.1
> > 
