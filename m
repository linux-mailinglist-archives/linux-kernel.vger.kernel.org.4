Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C780716117
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjE3NIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjE3NIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824AC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4411C62ED8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E7C433D2;
        Tue, 30 May 2023 13:08:13 +0000 (UTC)
Date:   Tue, 30 May 2023 14:08:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] riscv: allow kmalloc() caches aligned to the
 smallest value
Message-ID: <ZHX1OqjQQRheIvv+@arm.com>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-6-jszhang@kernel.org>
 <20230529-fidelity-booted-0d4055d1f559@wendy>
 <ZHXJDevEVwUEoOq4@arm.com>
 <20230530-gyration-handheld-ef4e44e89d61@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530-gyration-handheld-ef4e44e89d61@wendy>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:34:06AM +0100, Conor Dooley wrote:
> On Tue, May 30, 2023 at 10:59:41AM +0100, Catalin Marinas wrote:
> > On Mon, May 29, 2023 at 12:17:46PM +0100, Conor Dooley wrote:
> > > On Sat, May 27, 2023 at 12:59:57AM +0800, Jisheng Zhang wrote:
> > > > After this patch, a simple test of booting to a small buildroot rootfs
> > > > on qemu shows:
> > > > 
> > > > kmalloc-96           5041    5041     96  ...
> > > > kmalloc-64           9606    9606     64  ...
> > > > kmalloc-32           5128    5128     32  ...
> > > > kmalloc-16           7682    7682     16  ...
> > > > kmalloc-8           10246   10246      8  ...
> > > > 
> > > > So we save about 1268KB memory. The saving will be much larger in normal
> > > > OS env on real HW platforms.
> > > > 
> > > > [1] Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031-1-catalin.marinas@arm.com/
> 
> While I think of it, Link: goes at the start of the line, the [1] should
> go at the end (although I don't think you actually reference the link
> anywhere in the text & it'll probably not be particularly relevant if a
> subsequent revision of that patchset is applied.

I plan to post at least one more. I'd suggest the risc-v patchset to
only go in once my series landed.

> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > 
> > > Fails to build chief, with loads of:
> > > linux/dma-mapping.h:546:19: error: redefinition of 'dma_get_cache_alignment'
> > > 
> > > And for 32-bit there's also a rake of:
> > > include/linux/slab.h:239:9: warning: 'ARCH_KMALLOC_MINALIGN' macro redefined [-Wmacro-redefined]
> > > 
> > > At the very least, reproducable with rv32_defconfig.
> > 
> > Have you this it on top of the KMALLOC_MINALIGN preparation series?
> > 
> > https://lore.kernel.org/r/20230524171904.3967031-1-catalin.marinas@arm.com/
> 
> Oh, no. Thanks for pointing that out.
> Our automation stuff only uses what is in riscv/{for-next,master,fixes}.
> Unless my reading comprehension is particularly bad of late it was
> non-obvious that this depended on something that had not yet been
> applied - it sounded like your series had already been merged last year.

Yeah, it was only obvious to me since it was my series ;).

-- 
Catalin
