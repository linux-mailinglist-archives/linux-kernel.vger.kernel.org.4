Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549F06028A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJRJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJRJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:45:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4410D9E68A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:45:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ms8B629rKz4xG5;
        Tue, 18 Oct 2022 20:45:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1666086350;
        bh=LitIpUNPJXX8A9YpEnigfaQI8c2vxCGJKc4gdWmVIFE=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=rqZPiBsB0Ww7hyYbrZd5urgIXB4qH9jcisblvip9lqLDowogvSSEB0qLiUfsdatM0
         Qf5VoUDxZCdQpc67pYd1x7SoJpLZZQojn5wL3Dpnl9JpwfQHliI013LM+De6orxIAn
         QP/04qPPoRK0Ye/mNB6Tyys/xUwFIG2PhMXp4JpBAoSQr0cWjt6Uw446X1iadXktC/
         sE7s83t2bV7PwXfg1VPvJaXFsdX+V80AWfBUfm9I2flYtZjOIjRolxAvzACkGPoH4p
         qQUUjgO5minl06snJTer3UJc/pNvTpQuXBtHIftIfFf5mHfVfDrb/0kr0oaZOSSXZ3
         d+r12lTvER4uw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
References: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
Date:   Tue, 18 Oct 2022 20:45:46 +1100
Message-ID: <87mt9tlb1x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> Most architectures(except arm64/x86/sparc) simply return 1 for
> kern_addr_valid(), which is only used in read_kcore(), and it
> calls copy_from_kernel_nofault() which could check whether the
> address is a valid kernel address, so no need kern_addr_valid(),
> let's remove unneeded kern_addr_valid() completely.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/alpha/include/asm/pgtable.h          |  2 -
>  arch/arc/include/asm/pgtable-bits-arcv2.h |  2 -
>  arch/arm/include/asm/pgtable-nommu.h      |  2 -
>  arch/arm/include/asm/pgtable.h            |  4 --
>  arch/arm64/include/asm/pgtable.h          |  2 -
>  arch/arm64/mm/mmu.c                       | 47 -----------------------
>  arch/arm64/mm/pageattr.c                  |  3 +-
>  arch/csky/include/asm/pgtable.h           |  3 --
>  arch/hexagon/include/asm/page.h           |  7 ----
>  arch/ia64/include/asm/pgtable.h           | 16 --------
>  arch/loongarch/include/asm/pgtable.h      |  2 -
>  arch/m68k/include/asm/pgtable_mm.h        |  2 -
>  arch/m68k/include/asm/pgtable_no.h        |  1 -
>  arch/microblaze/include/asm/pgtable.h     |  3 --
>  arch/mips/include/asm/pgtable.h           |  2 -
>  arch/nios2/include/asm/pgtable.h          |  2 -
>  arch/openrisc/include/asm/pgtable.h       |  2 -
>  arch/parisc/include/asm/pgtable.h         | 15 --------
>  arch/powerpc/include/asm/pgtable.h        |  7 ----

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
