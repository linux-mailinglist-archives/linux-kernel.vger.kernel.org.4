Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1D6CA96A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjC0Pnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjC0Png (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:43:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26014C2B;
        Mon, 27 Mar 2023 08:43:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id z10so5399459pgr.8;
        Mon, 27 Mar 2023 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679931790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRasUUTOEu/ok1S92mQy2tcMp/4KwW2lXbLEiKBj/7o=;
        b=HZFjetxTrU0/nv8Y55FAOK1Apm3VUH13SuQEA6blI4LQsquf470BO/HxA5cmFNd3aK
         KhVXkKlmZq93fBkC6giJvUDlt7FuVro1W64JdaQrEtphQxoptl43dqOAsJuOdXDllTly
         etHqoII3GsZRYL1O1XM8c2+DB4jJ3oBH+CWict03ya4f003TK7u/v0bAMMATlIwbsHEE
         Eab9bSU2vOsS7u7Hi3cpukhSfrOKg/M8N1PXdsx2k+lYCOOyiPnKWQEclkXPeaKbVR3e
         gND/Ow1eDKT0AYLAkJBh79+oSz/WTGmxOT1B4ufDuEkJHS9CEZchC2NFdFV6xpk2+oqj
         wINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRasUUTOEu/ok1S92mQy2tcMp/4KwW2lXbLEiKBj/7o=;
        b=2uXRTuoC1ocHq0ysOFqUlq7tujubPS5okZDsune7qMxOyo25dhaVI5SZ1QHqX8NUus
         FJh2FZtnhnVTprMF6/Ff4287oGeqBK7zi7a5zAT1J02g5xm9FH/p4HxtNCyp4SOqLtEE
         Zly9EVfqiJ0YnAhRbL4ObVSUzK+YPFvwGSlDst/MGf2vCE3L5TpF9l3Q1O2Oh31KCStZ
         rZes7he4CRBInLrtdJCLPhygt/lxgqUn3j3RhMaI6TuyI/mDTiQEzzo6ymLjxvjrApXy
         5m6lwHnXNALRoTSYjWdGZg6+PbMGzb7/TdOJll6rP54VGSheRLTifBKNhRWEXMHIzz7F
         oy5Q==
X-Gm-Message-State: AAQBX9edXI9GmIk2aek5dCRmQIDAdBdWUw9WsNWqhrt1Y+avnMwk13Xm
        WM2NjJZpTWKtrswOzpUxV7kGWn8+MoEDMNhT6iA=
X-Google-Smtp-Source: AKy350ZLARTDoGqBnXYfSrHDqt1ndSavaTIx5HilksseUiOHQOdKd5qG9m3KbOwJxwDn1K1TODO6L/v92bKQLX9gh5M=
X-Received: by 2002:a63:e20f:0:b0:50a:592b:25ba with SMTP id
 q15-20020a63e20f000000b0050a592b25bamr3326211pgh.3.1679931790647; Mon, 27 Mar
 2023 08:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-3-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-3-arnd@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 27 Mar 2023 08:42:59 -0700
Message-ID: <CAMo8BfJwjcQxWVW9o6brvBYTgUe9v=QGgs39=_V6Oc9-OKv7Sw@mail.gmail.com>
Subject: Re: [PATCH 02/21] xtensa: dma-mapping: use normal cache invalidation rules
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 5:14=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> xtensa is one of the platforms that has both write-back and write-through
> caches, and needs to account for both in its DMA mapping operations.
>
> It does this through a set of operations that is different from any
> architecture. This is not a problem by itself, but it makes it rather
> hard to figure out whether this is correct or not, and to unify this
> implementation with the others.
>
> Change the semantics to the usual ones for non-speculating CPUs:
>
>  - On DMA_TO_DEVICE, call __flush_dcache_range() to perform the
>    writeback even on writethrough caches, where this is a nop.
>
>  - On DMA_FROM_DEVICE, invalidate the mapping before the DMA rather
>    than afterwards.
>
>  - On DMA_BIDIRECTIONAL, combine the pre-writeback with the
>    post-invalidate into a call to __flush_invalidate_dcache_range()
>    that turns into a simple invalidate on writeback caches.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/xtensa/Kconfig                  |  1 -
>  arch/xtensa/include/asm/cacheflush.h |  6 +++---
>  arch/xtensa/kernel/pci-dma.c         | 29 +++++-----------------------
>  3 files changed, 8 insertions(+), 28 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
