Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9A72EC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjFMTte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjFMTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E11170E;
        Tue, 13 Jun 2023 12:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF3E560AB8;
        Tue, 13 Jun 2023 19:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29E4C433D9;
        Tue, 13 Jun 2023 19:49:20 +0000 (UTC)
Date:   Tue, 13 Jun 2023 20:49:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Move the ARCH_DMA_MINALIGN definition to asm/cache.h
Message-ID: <ZIjIPquLFAeC2p0k@arm.com>
References: <20230613155245.1228274-1-catalin.marinas@arm.com>
 <5cc13519-e606-4dca-b22c-2dcb7bf06d32@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cc13519-e606-4dca-b22c-2dcb7bf06d32@csgroup.eu>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:42:40PM +0000, Christophe Leroy wrote:
> 
> 
> Le 13/06/2023 à 17:52, Catalin Marinas a écrit :
> > Hi,
> > 
> > The ARCH_KMALLOC_MINALIGN reduction series defines a generic
> > ARCH_DMA_MINALIGN in linux/cache.h:
> > 
> > https://lore.kernel.org/r/20230612153201.554742-2-catalin.marinas@arm.com/
> > 
> > Unfortunately, this causes a duplicate definition warning for
> > microblaze, powerpc (32-bit only) and sh as these architectures define
> > ARCH_DMA_MINALIGN in a different file than asm/cache.h. Move the macro
> > to asm/cache.h to avoid this issue and also bring them in line with the
> > other architectures.
> 
> What about mips ?
> 
> arch/mips/include/asm/mach-generic/kmalloc.h:#define ARCH_DMA_MINALIGN	128
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN	32
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN	128
> arch/mips/include/asm/mach-n64/kmalloc.h:#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> arch/mips/include/asm/mach-tx49xx/kmalloc.h:#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES

Sorry, I should have mentioned it in the cover letter (discussed here -
https://lore.kernel.org/r/ZIhPaixb%2F0ve7zZo@arm.com/). These kmalloc.h
files are included in asm/cache.h, based on which machine is enabled, so
there's no problem for mips. It makes more sense to keep them in those
mach-*/kmalloc.h files instead of having lots of #ifdefs in cache.h.

-- 
Catalin
