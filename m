Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD76420B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiLEAKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71964EE07;
        Sun,  4 Dec 2022 16:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C01B807E5;
        Mon,  5 Dec 2022 00:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D05C433D7;
        Mon,  5 Dec 2022 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670199038;
        bh=wHwBkSo7+9OsXeSnyzm3ampLGK0mAtM78dM7PJjSBzA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=LYVLlfwQlNqL4IrP/fLTZ3aY/WveKlAsLqqhxuFI9pBkv+61ywlfdBNMfEMI9et2f
         thECXDLwAUFxfeeVM8QUEWgp7TBGxEtSu5VlmPcK+J60pVhutgNhTlH7p8UBnE9jL0
         8X/2rQRT2w9Zvb+FeyUc2vBdRx4qP182YKwbzfhWLUI37EPceVJP8CYXp5PSZ/S6Ot
         ZrVHhapPO83mb1NbCEtQgjoKxhc3/EF4Xo1vmN6QZXLu+zdKgWFWxFMQw+DBlVk4Gc
         FF/sP7sHmrgqSCOEICFxjr6Nkk+MmIRkCoVRyhcUR9/XALh3NdyB+FgAouCnRPCGH6
         dF0ChJteyChfw==
Date:   Mon, 05 Dec 2022 00:10:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/3=5D_RISC-V=3A_time=3A_initialize?= =?US-ASCII?Q?_hrtimer_based_broadcast_clock_event_device?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201123954.1111603-2-apatel@ventanamicro.com>
References: <20221201123954.1111603-1-apatel@ventanamicro.com> <20221201123954.1111603-2-apatel@ventanamicro.com>
Message-ID: <04CBEBD4-3EDC-4FA0-BB11-DDD6B710C60C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 December 2022 12:39:52 GMT, Anup Patel <apatel@ventanamicro=2Ecom> wr=
ote:
>From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>
>Similarly to commit 022eb8ae8b5e ("ARM: 8938/1: kernel: initialize
>broadcast hrtimer based clock event device"), RISC-V needs to initiate
>hrtimer based broadcast clock event device before C3STOP can be used=2E
>Otherwise, the introduction of C3STOP for the RISC-V arch timer in
>commit 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped
>during CPU suspend") leaves us without any broadcast timer registered=2E
>This prevents the kernel from entering oneshot mode, which breaks timer
>behaviour, for example clock_nanosleep()=2E
>
>A test app that sleeps each cpu for 6, 5, 4, 3 ms respectively, HZ=3D250
>& C3STOP enabled, the sleep times are rounded up to the next jiffy:
>=3D=3D CPU: 1 =3D=3D      =3D=3D CPU: 2 =3D=3D      =3D=3D CPU: 3 =3D=3D =
     =3D=3D CPU: 4 =3D=3D
>Mean: 7=2E974992    Mean: 7=2E976534    Mean: 7=2E962591    Mean: 3=2E952=
179
>Std Dev: 0=2E154374 Std Dev: 0=2E156082 Std Dev: 0=2E171018 Std Dev: 0=2E=
076193
>Hi: 9=2E472000      Hi: 10=2E495000     Hi: 8=2E864000      Hi: 4=2E73600=
0
>Lo: 6=2E087000      Lo: 6=2E380000      Lo: 4=2E872000      Lo: 3=2E40300=
0
>Samples: 521      Samples: 521      Samples: 521      Samples: 521
>
>Link: https://lore=2Ekernel=2Eorg/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
>Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped durin=
g CPU suspend")
>Suggested-by: Samuel Holland <samuel@sholland=2Eorg>
>Signed-off-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>Reviewed-by: Samuel Holland <samuel@sholland=2Eorg>
>Acked-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>

Huh, thought I replied already but I just have forgotten to=2E=2E=2E
Since you've added this patch to your series,  it needs your SoB appended=
=2E

Thanks,
Conor=2E

>---
> arch/riscv/kernel/time=2Ec | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/riscv/kernel/time=2Ec b/arch/riscv/kernel/time=2Ec
>index 8217b0f67c6c=2E=2E1cf21db4fcc7 100644
>--- a/arch/riscv/kernel/time=2Ec
>+++ b/arch/riscv/kernel/time=2Ec
>@@ -5,6 +5,7 @@
>  */
>=20
> #include <linux/of_clk=2Eh>
>+#include <linux/clockchips=2Eh>
> #include <linux/clocksource=2Eh>
> #include <linux/delay=2Eh>
> #include <asm/sbi=2Eh>
>@@ -29,6 +30,8 @@ void __init time_init(void)
>=20
> 	of_clk_init(NULL);
> 	timer_probe();
>+
>+	tick_setup_hrtimer_broadcast();
> }
>=20
> void clocksource_arch_init(struct clocksource *cs)
