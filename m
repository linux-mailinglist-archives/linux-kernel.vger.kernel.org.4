Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494A715AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjE3KAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjE3J7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB980AD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587F462CCB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FCC433EF;
        Tue, 30 May 2023 09:59:44 +0000 (UTC)
Date:   Tue, 30 May 2023 10:59:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] riscv: allow kmalloc() caches aligned to the
 smallest value
Message-ID: <ZHXJDevEVwUEoOq4@arm.com>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-6-jszhang@kernel.org>
 <20230529-fidelity-booted-0d4055d1f559@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529-fidelity-booted-0d4055d1f559@wendy>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:17:46PM +0100, Conor Dooley wrote:
> On Sat, May 27, 2023 at 12:59:57AM +0800, Jisheng Zhang wrote:
> > After this patch, a simple test of booting to a small buildroot rootfs
> > on qemu shows:
> > 
> > kmalloc-96           5041    5041     96  ...
> > kmalloc-64           9606    9606     64  ...
> > kmalloc-32           5128    5128     32  ...
> > kmalloc-16           7682    7682     16  ...
> > kmalloc-8           10246   10246      8  ...
> > 
> > So we save about 1268KB memory. The saving will be much larger in normal
> > OS env on real HW platforms.
> > 
> > [1] Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031-1-catalin.marinas@arm.com/
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Fails to build chief, with loads of:
> linux/dma-mapping.h:546:19: error: redefinition of 'dma_get_cache_alignment'
> 
> And for 32-bit there's also a rake of:
> include/linux/slab.h:239:9: warning: 'ARCH_KMALLOC_MINALIGN' macro redefined [-Wmacro-redefined]
> 
> At the very least, reproducable with rv32_defconfig.

Have you this it on top of the KMALLOC_MINALIGN preparation series?

https://lore.kernel.org/r/20230524171904.3967031-1-catalin.marinas@arm.com/

-- 
Catalin
