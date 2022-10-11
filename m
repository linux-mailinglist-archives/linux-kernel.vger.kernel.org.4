Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7F5FB28D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJKMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJKMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D772A14D0F;
        Tue, 11 Oct 2022 05:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F7061184;
        Tue, 11 Oct 2022 12:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5397AC433D6;
        Tue, 11 Oct 2022 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665491987;
        bh=kunzchOrNhxJ4TlX1sA1be9vS/JGs0Lekk2gqipkh8Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jW6jtcsL5GXOGod6XfiNRBewRwunQAWa38fQIEmsdAz7o3RJ82VNKWvN+uvZqJ5bn
         SJ7rX5AGavoVzTI/PcoW4V9Xaeacosk2vmhIgKbBIrDhewNRtxjqh1DeMLI/BXJ6kD
         LJvgXBB7Vg5ucZevccOuIKKLm0F8hVZSCTgKIDkJoIeh/w5xxbq8s89Ck9zO30vUXC
         Uy5ui+/BgBsaKXiLgcqCfLh3s4sxuUKtHsi7jyu4MhYH6fWtD4E57TeoyM+C6lUVhw
         zT/7k9+a3eUPRb91/lZDYp8/Z5IF+MDqpCgWILW8SVBoYgsTgTY3C26/qzRQhCVky1
         WbCf0qEEbwHTg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>,
        Conor Dooley <conor@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v2 0/2] riscv: Support HAVE_ARCH_HUGE_VMAP and
 HAVE_ARCH_HUGE_VMALLOC
In-Reply-To: <20221008140506.1066805-1-liushixin2@huawei.com>
References: <20221008140506.1066805-1-liushixin2@huawei.com>
Date:   Tue, 11 Oct 2022 14:39:44 +0200
Message-ID: <87tu4ah6un.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liu Shixin <liushixin2@huawei.com> writes:

> Since riscv64 has already support SATP_MODE_57 by default, it is time to
> support more hugepage-related features. These two patches will enable
> HAVE_ARCH_HUGE_VMAP and HAVE_ARCH_HUGE_VMALLOC.
>

Just a note; The HP support does not require sv57. Pmd/Mega- and
pud/gigapages work for sv39 and sv48 as well.

> v1->v2: Fix the build error reported by kernel-test.
>
> Liu Shixin (2):
>   riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
>   riscv: Enable HAVE_ARCH_HUGE_VMALLOC for 64BIT
>
>  .../features/vm/huge-vmap/arch-support.txt    |  2 +-
>  arch/riscv/Kconfig                            |  2 +
>  arch/riscv/include/asm/vmalloc.h              | 18 ++++
>  arch/riscv/mm/Makefile                        |  1 +
>  arch/riscv/mm/pgtable.c                       | 83 +++++++++++++++++++
>  5 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/pgtable.c
>

I've taken this series for a spin, and tested huge pud pages via
ioremap(), and huge pmd pages via vmalloc_huge() on qemu for sv39, sv48,
and sv57.

Patch 2 have a spelling error in the commit message: "enbale" vs
"enable".

Fix up the spelling error in patch 2, and after that feel free to add
for the whole series:

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


Nice work!
Bj=C3=B6rn

