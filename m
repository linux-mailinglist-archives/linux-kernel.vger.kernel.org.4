Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85FA73D421
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFYUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:36:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F849B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:36:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so830460f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687725383; x=1690317383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1QCxq2dS3A9zFHU0ctTjyuMeOoqHJBwt33K34S6GLs=;
        b=qDpWQG7/8gfvwva5nS8MBjW5kZT5z5d5g30QsNzoeLw3jdpHpmI7FldH+fNSwEUT11
         e/tp2C+Gnry2QtaoObwowWMRQoLd+K0kBk/2IuFav45hYSctyKKDkz/79qIUPk53XO7f
         41+3vtDJik1QXiWjNPlBCtUWI+f3ByK/KkKHdonPOioAQjEu058EUo7Cbobkh74j+rtE
         2+sVlRrM4yramIiq5HL20gjd2hWfAdT9Evb4+mEgxer9cMKeB2qa2y9wnwNylE1p24hr
         IsdsipkiR+vlTKXxf6kfpybXr7jhjs59tg76vxFbAHh25ibiHmk/m/jDT1dOCd1XSoFu
         KQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687725383; x=1690317383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1QCxq2dS3A9zFHU0ctTjyuMeOoqHJBwt33K34S6GLs=;
        b=FiZYs0Onh3Hm8DiFdEB5VjSpQDcHKFaDpnJ6lE2H3YyS1SlpX+oA/wHF2bHd7xUoi8
         prTWdB66sGmdzhxmd+wk6zAZyGjYzH0DXoJUXa+KawpBT3M5f9iWhexhw/J1YoXtnQ8i
         dU3LnnA3DRf+YaBfpXbwVO7swLgBK+c4VqbTx1UhuFykui6gHExarBas/wPvycHDRqui
         rMyiUzAbiy8sqIdM+PMkA0JcuSbMSDVg1utH7heZcGW2sWNiKUXAaWU0wco2rZIeT+Dq
         97iOO7vW5lS1/3X4ovgfgidI76/7ZvlkSMPRR0KAGcvI7HOHpPHEI9o0gbZ7l04Lb4Xg
         r9iQ==
X-Gm-Message-State: AC+VfDzAwv1hvIzIKcYmErrgFPfpVNd8q/MZLeEiayIfZG3pFZkXtzWb
        XkkULCpo0wQ/CF+XjC7EBCrQDBT447cEatHxRCzZ0A==
X-Google-Smtp-Source: ACHHUZ64p9n/gQ4cEcP/GRL/TzccMkjLQQFYw4orjcfuoDJUzO0/9AprWI0Ofwdd4UQdovW4AvDwmtQwv5jpqsruS14=
X-Received: by 2002:adf:e5c7:0:b0:30a:e3bb:ba8b with SMTP id
 a7-20020adfe5c7000000b0030ae3bbba8bmr29849132wrn.29.1687725382689; Sun, 25
 Jun 2023 13:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Sun, 25 Jun 2023 22:36:11 +0200
Message-ID: <CAHVXubgJcGPq_uC6iJCLTys5J6Ooa1EYcfOhBjEQwYfd+baWxw@mail.gmail.com>
Subject: Re: [PATCH V1 0/3] Revert huge-paged linear mapping and its related fixups
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, mpe@ellerman.id.au, arnd@arndb.de,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Sun, Jun 25, 2023 at 4:10=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
> We have encountered these two issues about huge-paged linear mapping sinc=
e v6.4-rc1:
>
> 1. Bug report: kernel paniced when system hibernates[1]
>
> OpenSbi [v0.8,v1.3) set the PMP regions as !no-map, and the commit 333506=
8f8721
> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") mapped them in li=
near mapping.
> The hibernation process attempted to save/restore these mapped regions re=
sulting in access fault.
>
> This issue was temporarily fixed by commit ed309ce52218 ("RISC-V: mark hi=
bernation as nonportable").
> But as Alex's RFC and Rob's response stats in another thread [2] ,
> "Hibernation is only one case. Speculative accesses could also occur."
> So this fixing commit seems not the perfect answer to this issue.
>
>
> 2. Bug report: kernel paniced while booting (with UEFI )[3]
>
> During the booting with UEFI, UEFI Memory Mapping overwrote the memblock.
> The phys_ram_base was set as the end address of mmoderes0 (like 0x8004000=
0 for 256 KiB mmoderes0@80000000),
> which resulted the VA based on 2M-aligned PA was not 2M-aligned using va_=
pa_offset
> (PAGE_OFFSET - phys_ram_base) to translate.
>
> The best_map_size() from commit 3335068f8721 didn't check the virtual ali=
gnment
> before choosing a map size. and then a "VA hole" was created where page f=
aults always occurred.
>
> This issue was fixed by commit 49a0a3731596 ("riscv: Check the virtual al=
ignment before choosing a map size"),
> But this fixing commit has a side-effect ("the possible third one" as Ale=
x said in this thread).
> There are numerous PTE allocations slowing down the boot time and consumi=
ng some system memory when UEFI booting
> (Note that it's not involved when booting directly with OpenSbi, where ph=
ys_ram_base is the 2M-aligned base of DRAM).
>
> In my test, compared with/out reverting both commit 49a0a3731596 and comm=
it 3335068f8721,
> I must wait ~20s for the linear mapping creation and mem_init_print_info(=
) reported ~8M extra reserved memory.

Indeed, phys_ram_base is not aligned on a 2MB boundary when booting
with EDK2, IIRC that's because the first chunk of memory at
0x8000_0000 is marked as UC and is then completely evicted.

>
> To eliminate this side-effect, We should find a way to align VA and PA on=
 a 2MB boundary.
> The simplest way is reverting the commit 3335068f8721 ("riscv: Use PUD/P4=
D/PGD pages for the linear mapping").
>

I disagree, the simplest way is to align phys_ram_base on a 2MB
boundary, either by aligning to the upper boundary (and then wastes
memory, like we used to) or by aligning to the lower boundary (but I
want to make sure it works).

I'll come up with something tomorrow.

Thanks,

Alex

>
>
> Using PUD/P4D/PGD pages for the linear mapping to improve the performance=
 is marginal from a recent talk [4]
> from Mike Rapoport. OpenSbi had marked all the PMP-protected regions as "=
no-map" [5] to practice this talk.
>
> For all those reasons, let's revert these related commits:
>
> - commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mappi=
ng")
> - commit 49a0a3731596 ("riscv: Check the virtual alignment before choosin=
g a map size")
> - commit ed309ce52218 ("RISC-V: mark hibernation as nonportable")
>
> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_v=
hB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-kernel/20230530080425.18612-1-alexghit=
i@rivosinc.com/
> [3]: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1=
@qq.com/
> [4]: https://lwn.net/Articles/931406/
> [5]: https://github.com/riscv-software-src/opensbi/commit/8153b2622b08802=
cc542f30a1fcba407a5667ab9
>
> Song Shuai (3):
>   Revert "RISC-V: mark hibernation as nonportable"
>   Revert "riscv: Check the virtual alignment before choosing a map size"
>   Revert "riscv: Use PUD/P4D/PGD pages for the linear mapping"
>
>  arch/riscv/Kconfig            |  5 +---
>  arch/riscv/include/asm/page.h | 16 -------------
>  arch/riscv/mm/init.c          | 43 +++++++----------------------------
>  arch/riscv/mm/physaddr.c      | 16 -------------
>  drivers/of/fdt.c              | 11 ++++-----
>  5 files changed, 14 insertions(+), 77 deletions(-)
>
> --
> 2.20.1
>
