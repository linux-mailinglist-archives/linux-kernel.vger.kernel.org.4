Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16726D0408
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjC3Lxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC3Lxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DFB460;
        Thu, 30 Mar 2023 04:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FC16204C;
        Thu, 30 Mar 2023 11:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26940C433AA;
        Thu, 30 Mar 2023 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680177127;
        bh=Lg8Woq7ScP2NFdPayLKkYeMtRMZwMJRAR9+KtXakJhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szgi2AGJBTiRQ58jY7BtDVpishu6YXxB3MID/h/iLnY6weieQpEEBjD5U4dJKUZJo
         NyrFHSlcuLma/JgU04Kyl/teOBwE2aqvJirDrSyFmIOb/MgyJ5jbYzY27e7K0/FB3v
         CGl1zaVIaqHqL9jEmUV6o9JaD3e9FPV5dCV6/OyKRUcn2nGSc77XIBQZ4V3nd48tRE
         MXMuKMr76f/IZcL1m1wvAHaMqdCUnLP5+1pyn+Oivk5n7icXvXAiLs6rb+QGNifsx4
         s+2w00OYui+zTpJ8W2EjziNZVSk+jRvfupY8WA5Y6La/gJ22X/s8u0ZbXc6MKI1CFs
         Gh6YkXLHZHYVw==
Received: by mail-lf1-f52.google.com with SMTP id g19so11034911lfr.9;
        Thu, 30 Mar 2023 04:52:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9ft5A7WJCknKgnZ3X+jipHPJIOsmWAmuopg6M9eJX6eQz3aA7s4
        EQgGRwRdqFLaFGTSjQi+FLYILDCHpiUj7JnhrQg=
X-Google-Smtp-Source: AKy350aaxBOgSqlP959KpS9cfZAsDCsvbSuFf+7QcLc+VlamdgSrDzoUdXNjAn81KSsW2remp6yjeVooIQhT3qtniP0=
X-Received: by 2002:a19:f007:0:b0:4db:b4:c8d7 with SMTP id p7-20020a19f007000000b004db00b4c8d7mr1755725lfc.2.1680177124990;
 Thu, 30 Mar 2023 04:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-19-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Mar 2023 13:51:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNjrmTr1R+-09UYtHSgvT6fSgZxvpbEOfeTFxhWtgGcQ@mail.gmail.com>
Message-ID: <CAMj1kXGNjrmTr1R+-09UYtHSgvT6fSgZxvpbEOfeTFxhWtgGcQ@mail.gmail.com>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
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
        Max Filippov <jcmvbkbc@gmail.com>,
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
        linux-xtensa@linux-xtensa.org, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 14:18, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cache management operations for noncoherent DMA on ARMv6 work
> in two different ways:
>
>  * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>    DMA buffers lead to data corruption when the prefetched data is written
>    back on top of data from the device.
>
>  * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>    is not seen by the other core(s), leading to inconsistent contents
>    accross the system.
>
> As a consequence, neither configuration is actually safe to use in a
> general-purpose kernel that is used on both MPCore systems and ARM1176
> with prefetching enabled.
>
> We could add further workarounds to make the behavior more dynamic based
> on the system, but realistically, there are close to zero remaining
> users on any ARM11MPCore anyway, and nobody seems too interested in it,
> compared to the more popular ARM1176 used in BMC2835 and AST2500.
>
> The Oxnas platform has some minimal support in OpenWRT, but most of the
> drivers and dts files never made it into the mainline kernel, while the
> Arm Versatile/Realview platform mainly serves as a reference system but
> is not necessary to be kept working once all other ARM11MPCore are gone.
>
> Take the easy way out here and drop support for multiprocessing on
> ARMv6, along with the CONFIG_DMA_CACHE_RWFO option and the cache
> management implementation for it. This also helps with other ARMv6
> issues, but for the moment leaves the ability to build a kernel that
> can run on both ARMv7 SMP and single-processor ARMv6, which we probably
> want to stop supporting as well, but not as part of this series.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-oxnas@groups.io
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
