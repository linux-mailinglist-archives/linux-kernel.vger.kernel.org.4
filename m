Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04B6A14D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBXCMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBXCMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:12:47 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DB5EEE1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:12:37 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id bh19-20020a056830381300b00690bf2011b2so3088863otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7wKmSpHtP7KzMICT81VECq4KErqeU37TanTcAAg1qo=;
        b=bu2LP25NHDBDmq1HrnRw5kB9I5IBWn3dQyV9BGKaLT69R4h0DssEtwupy74L89iX5h
         Gw6tpa/Jix7zN+UMqiXZ85OrTH10LdNXLJmIRxvnMD/q65c6D4vLBMlD+E4VmmHmni81
         dZ+DFmDRehYfdbysc58vEFTjHbXEFpfQOMIfZ+Tw7REfLoKCxaoh+DxEer0kVRMsU5oG
         E+6LsD/B2PnbPsT+QiGolsWRT4I9+Xixnd1thwooMbN/GIWZ5nDsXsQWZ9KF/400oaGR
         Np4olcJz4ePUHX0xr/SWpcXqs5EqXoQbxBoBrkPjYWKFitlo8yz//XcbdJowWqAe0M/L
         xg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7wKmSpHtP7KzMICT81VECq4KErqeU37TanTcAAg1qo=;
        b=ZvSNNJ+n50bRvDmFQZlwOvU6j59iA2PrJyi56TRUsmcCbJvPhMm0StO1S4F3zRmTYy
         k5YmsuNN+aCVqSnEHulL6wnJya4dce8kH52wbXU02X6fcQMYPmWPd9nc5fCjFlDbHfJK
         9RFwPwqQQPvf/5SJ2OCPq3MRXoYNEnoMaxNjWSa0gust/aejrCEiF43T301VwkYy28kQ
         RVcuB1dNvms+AxLe5cgtdaVQCd2IZrF8EOPFRd4KR3EyyXtsrzr54rhgPmrry0E7aktn
         YfGJoIngiA/Zzc7ir3vn+uTGOWbYjdO9ak5vR2Klrdl40VgLQP+Oz7yxGZz30wD4/yqk
         do+Q==
X-Gm-Message-State: AO0yUKXf5pJJr16yoJK8g9HwLxqc6d39mnmm15tg13nbGXKjxz5flkt+
        IMaU647tFM4yBQpoaKmhE2Ggu8u/g/8GJPAE+iqFpA==
X-Google-Smtp-Source: AK7set82A7b0aujPuLQW8c1XvWvbBFPBRvTR34GsDmcnzgAv8xyex/IjgVX6GnDpS7f37Keea9fMdntteRO8MBzS6h0=
X-Received: by 2002:a05:6830:39c2:b0:68b:df56:c83b with SMTP id
 bt2-20020a05683039c200b0068bdf56c83bmr1140500otb.1.1677204756593; Thu, 23 Feb
 2023 18:12:36 -0800 (PST)
MIME-Version: 1.0
From:   Can Sun <cansun@arista.com>
Date:   Fri, 24 Feb 2023 10:12:25 +0800
Message-ID: <CANxia+Sh3oVE_0VTpoPU_LsVYO-m7TiWpKO9-est+a0xn4F_QA@mail.gmail.com>
Subject: IO-APIC irq timer setup not wroking properly
To:     x86@kernel.org
Cc:     Kevin Mitchell <kevmitch@arista.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I=E2=80=99m trying to load a new kernel (v5.10.165) on a panic, using lkdtm
with cpoint_name=3DINT_HW_IRQ_EN and cpoint_type=3DLOOP. However, during
the startup of the new kernel, I=E2=80=99m seeing the following errors
occasionally. (setup_IO_APIC -> check_timer)

[   11.752393] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   11.908594] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   11.978490] ...trying to set up timer (IRQ0) through the 8259A ...
[   12.052551] ..... (found apic 0 pin 2) ...
[   12.185840] ....... failed.
[   12.219273] ...trying to set up timer as Virtual Wire IRQ...
[   12.371299] ..... failed.
[   12.402650] ...trying to set up timer as ExtINT IRQ...
[   12.566638] ..... works.

Looks like it is failing the first timer_irq_works here
https://elixir.bootlin.com/linux/v5.10.165/source/arch/x86/kernel/apic/io_a=
pic.c#L2200,
and falls back to external interrupt.

Then, it seems the external interrupt is not working

[   75.292939] ata1.00: qc timeout (cmd 0xec)
[   75.342006] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[   75.727103] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   86.044934] ata1.00: qc timeout (cmd 0xec)
[   86.094007] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[   86.167027] ata1: limiting SATA link speed to 3.0 Gbps
[   86.543102] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   87.296933] usb 1-1: device not accepting address 2, error -110
[   87.492932] usb 1-1: new high-speed USB device number 3 using ehci-pci
[   88.320932] usb 2-1: device not accepting address 2, error -110
[   88.516934] usb 2-1: new high-speed USB device number 3 using ehci-pci
[  103.680933] usb 1-1: device not accepting address 3, error -110
[  103.751877] usb usb1-port1: attempt power cycle

This only happens occasionally, and if the IO-APIC works, the new
kernel starts normally without the =E2=80=9CMP-BIOS bug=E2=80=9D message an=
d the
interrupt method fallback mechanism.

I added the following command line to the new kernel.
maxcpus=3D1, mce=3Doff
And the kernel is configured with CONFIG_NR_CPUS=3D2.
It is likely to hit on Broadwell-DE cpus, for example Intel D-1528.

We started seeing this from kernel 4.9, but in 4.9 without patch
https://github.com/torvalds/linux/commit/86a82ae0b5095ea24c55898a3f025791e7=
958b21,
the crash kernel will fail to fallback to external interrupt, and
panic after that.

Here=E2=80=99re some additional observations when I added counters for
interrupt vectors and outputs for the counters after timer_irq_works
decided.

When it works:
[   11.502800] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   11.592314] start loop
[   11.620538] timer works
[   11.649807] vec: 36, count: 1
[   11.685325] -------------------
[   11.722927] vec: 37, count: 1
[   11.758445] -------------------
[   11.796047] vec: 48, irq: 0, count: 11
[   11.840945] irq name: edge, handler: handle_edge_irq+0x0/0xd7
[   11.909800] action: timer_interrupt+0x0/0x17
[   11.960944] -------------------
[   11.998545] vec: 50, irq: 2, count: 0
[   12.042400] irq name: (null), handler: handle_level_irq+0x0/0xa2
[   12.114370] -------------------
[   12.151977] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x36c70be9129, max_idle_ns: 881590792349 ns

[   11.666697] x2apic: IRQ remapping doesn't support X2APIC mode
[   11.736054] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   11.825577] start loop
[   11.853803] timer works
[   11.883076] vec: 37, count: 1
[   11.918597] -------------------
[   11.956203] vec: 38, count: 1
[   11.991725] -------------------
[   12.029330] vec: 39, count: 1
[   12.064852] -------------------
[   12.102458] vec: 48, irq: 0, count: 11
[   12.147362] irq name: edge, handler: handle_edge_irq+0x0/0xd7
[   12.216222] action: timer_interrupt+0x0/0x17
[   12.267365] -------------------
[   12.304971] vec: 50, irq: 2, count: 0
[   12.348828] irq name: (null), handler: handle_level_irq+0x0/0xa2
[   12.420808] -------------------
[   12.458420] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x36c59e6618a, max_idle_ns: 881590545732 ns

When it doesn't work:
[   11.902528] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   12.058721] start loop
[   12.086947] timer not works
[   12.120384] vec: 37, count: 1
[   12.155905] -------------------
[   12.193510] vec: 38, count: 1
[   12.229030] -------------------
[   12.266635] vec: 41, count: 1
[   12.302156] -------------------
[   12.339760] vec: 45, count: 1
[   12.375281] -------------------
[   12.412885] vec: 46, count: 1
[   12.448406] -------------------
[   12.486011] vec: 47, count: 1
[   12.521533] -------------------
[   12.559137] vec: 48, irq: 0, count: 8
[   12.602998] irq name: edge, handler: handle_edge_irq+0x0/0xd7
[   12.671858] action: timer_interrupt+0x0/0x17
[   12.723005] -------------------
[   12.760609] vec: 49, count: 1
[   12.796130] -------------------
[   12.833738] vec: 50, irq: 2, count: 0
[   12.877592] irq name: (null), handler: handle_level_irq+0x0/0xa2
[   12.949568] -------------------
[   12.987174] vec: 51, count: 1
[   13.022694] -------------------
[   13.060299] vec: 52, count: 1
[   13.095819] -------------------
[   13.133424] vec: 53, count: 1
[   13.168945] -------------------
[   13.206549] vec: 54, count: 1
[   13.242070] -------------------
[   13.279674] vec: 55, count: 1
[   13.315196] -------------------
[   13.352800] vec: 56, count: 1
[   13.388322] -------------------
[   13.425926] vec: 57, count: 1
[   13.461446] -------------------
[   13.499052] vec: 58, count: 1
[   13.534572] -------------------
[   13.572176] vec: 59, count: 1
[   13.607698] -------------------
[   13.645302] vec: 61, count: 1
[   13.680822] -------------------
[   13.718428] vec: 62, count: 1
[   13.753948] -------------------
[   13.791552] vec: 63, count: 2
[   13.827074] -------------------
[   13.864678] vec: 64, count: 1831
[   13.903324] -------------------
[   13.940942] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   14.010838] ...trying to set up timer (IRQ0) through the 8259A ...
[   14.084902] ..... (found apic 0 pin 2) ...
...

[   11.131979] x2apic: IRQ remapping doesn't support X2APIC mode
[   11.200917] __common_interrupt: 0.47 No irq handler for vector
[   11.270816] __common_interrupt: 0.46 No irq handler for vector
[   11.340716] __common_interrupt: 0.45 No irq handler for vector
[   11.410616] __common_interrupt: 0.44 No irq handler for vector
[   11.480517] __common_interrupt: 0.43 No irq handler for vector
[   11.550419] __common_interrupt: 0.42 No irq handler for vector
[   11.620319] __common_interrupt: 0.41 No irq handler for vector
[   11.690223] __common_interrupt: 0.37 No irq handler for vector
[   11.760121] __common_interrupt: 0.36 No irq handler for vector
[   11.830032] __common_interrupt: 0.42 No irq handler for vector
[   11.900379] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   12.056586] start loop
[   12.084815] timer not works
[   12.118254] vec: 36, count: 1
[   12.153777] -------------------
[   12.191384] vec: 37, count: 1
[   12.226909] -------------------
[   12.264516] vec: 41, count: 1
[   12.300039] -------------------
[   12.337646] vec: 42, count: 2
[   12.373169] -------------------
[   12.410777] vec: 43, count: 1
[   12.446300] -------------------
[   12.483907] vec: 44, count: 1
[   12.519430] -------------------
[   12.557037] vec: 45, count: 1
[   12.592561] -------------------
[   12.630168] vec: 46, count: 1
[   12.665691] -------------------
[   12.703299] vec: 47, count: 1
[   12.738822] -------------------
[   12.776429] vec: 48, irq: 0, count: 8
[   12.820292] irq name: edge, handler: handle_edge_irq+0x0/0xd7
[   12.889158] action: timer_interrupt+0x0/0x17
[   12.940309] -------------------
[   12.977916] vec: 49, count: 1
[   13.013439] -------------------
[   13.051046] vec: 50, irq: 2, count: 0
[   13.094905] irq name: (null), handler: handle_level_irq+0x0/0xa2
[   13.166889] -------------------
[   13.204495] vec: 51, count: 1
[   13.240019] -------------------
[   13.277625] vec: 52, count: 1
[   13.313149] -------------------
[   13.350756] vec: 53, count: 1
[   13.386281] -------------------
[   13.423897] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   13.493795] ...trying to set up timer (IRQ0) through the 8259A ...

When it doesn't work, we can see that there are more counters on
vectors which are not timer_interrupt, number 41~47, 49, 51~.

Are there any ideas why it only fails occasionally, and why the
external interrupt is not working when we fall back to it?

Thanks,
Can Sun
