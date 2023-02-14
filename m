Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA07B69675F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjBNOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjBNOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:52:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EC2B613
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2393A61724
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCE9C4339B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386319;
        bh=U5DFjUqh2ny78KGnnav+Jqbho0ENCFT2So2JYaB05t0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qn/EgaBSaPjryAsuKezf4hEmgn0/7eBXwesO8KQoo66WBQwI6uEF50t1b8bdXXXuQ
         hAXtFITQpQQKKBy35IW1jRhCiYd7fAd6RYjqOlQ2FkV6JikRxttU2P1OSm2PyggYxB
         Rrucf94yaAXOl25JtsUT1ljtjYd1GmhM4wcYHsl6dvoNdbO+MS9eumo3fOsSWf34S3
         vVNzAIkqIVWLpDhqqR0H/WQIZ7YZpUDZvdCCDzKt18W9H4Wft5AVggCnRNKIMKmjc7
         GHtKs+//6h9lZy5OGVf4I6gJ8PzeUPVF4zyxR5GdmW7kfl8453nvqRxh0ZGQhQ1pLX
         QnHdw+liPhGWQ==
Received: by mail-ej1-f43.google.com with SMTP id sa10so40677130ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:51:59 -0800 (PST)
X-Gm-Message-State: AO0yUKWIOtHImpffCNoEgyTetfHmb/MUIftGLw0K77g4W61r18xQendc
        rZx4mSqGr/HR6K9RBUIiAbcWmyFAe35HsLHPn/U=
X-Google-Smtp-Source: AK7set/9WDrehwjo3A47zZGeWnusro/YXsYPd0KNCp9OhkKOiI7z1upthcWoH05Ar0k5/9s8v0eoC7pT23RqCyXR8u4=
X-Received: by 2002:a17:906:8592:b0:878:8061:e114 with SMTP id
 v18-20020a170906859200b008788061e114mr1110158ejx.0.1676386317768; Tue, 14 Feb
 2023 06:51:57 -0800 (PST)
MIME-Version: 1.0
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
In-Reply-To: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 14 Feb 2023 22:51:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7co2Sx5c7oGA8nb12Ohh_jCvsuq5i6d5qnmV4an3M47Q@mail.gmail.com>
Message-ID: <CAAhV-H7co2Sx5c7oGA8nb12Ohh_jCvsuq5i6d5qnmV4an3M47Q@mail.gmail.com>
Subject: Re: "kernel ade access" oops on LoongArch
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

It seems to have something related to Youling's relative exception patchset=
.

Huacai

On Tue, Feb 14, 2023 at 4:46 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> This is a "help wanted" message :(.
>
> I've recently run into some strange kernel oops testing Glibc for LoongAr=
ch.  A log looks like:
>
> [11569.195043] Kernel ade access[#1]:
> [11569.198441] CPU: 1 PID: 1132296 Comm: ld-linux-loonga Not tainted 6.2.=
0-rc8+ #61
> [11569.205792] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V0.1-=
EVB/Loongson-LS3A5000-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05383=
-beta10 1
> [11569.219536] $ 0   : 0000000000000000 90000000005e3448 90000001113a0000=
 90000001113a3ab0
> [11569.227505] $ 4   : 90000001113a3af8 1000000000cf16d0 5555555555555850=
 000000000000000c
> [11569.235475] $ 8   : 90000000009caa10 0000000000000000 00000000000002ca=
 000000000000008b
> [11569.243438] $12   : 0000000000000001 9000000000cf1258 ffffffffffffffff=
 00007ffffb93c000
> [11569.251402] $16   : 0000000000000000 0000000000000140 0000000000000000=
 0000000000000020
> [11569.259366] $20   : 90000001113a3ec8 9000000000a97ee0 00007ffffb93bfa0=
 1555555555555613
> [11569.267334] $24   : 1000000000cf16d0 000000000000000c 9000000000cf1258=
 90000000009caa10
> [11569.275303] $28   : 90000001113a3af8 0aaaaaaaaaaaab0a 00007ffffb93bde0=
 90000001113a3ec0
> [11569.283268] era   : 90000000009caa10 cmp_ex_search+0x0/0x28
> [11569.288814] ra    : 90000000005e3448 bsearch+0x58/0xa8
> [11569.293921] CSR crmd: 000000b0
> [11569.293923] CSR prmd: 00000004
> [11569.297037] CSR euen: 00000000
> [11569.300152] CSR ecfg: 00071c1c
> [11569.303266] CSR estat: 00480000
> [11569.309587] ExcCode : 8 (SubCode 1)
> [11569.313049] BadVA : 1000000000cf16d0
> [11569.316596] PrId  : 0014c011 (Loongson-64bit)
> [11569.320923] Modules linked in: amdgpu nls_cp936 vfat fat input_leds dr=
m_ttm_helper ttm video gpu_sched drm_buddy snd_hda_codec_generic drm_displa=
y_helper ledtrig_audio drm_kms_helper led_class snd_hda_intel sha256_generi=
c snd_intel_dspcfg cfbfillrect libsha256 snd_hda_codec syscopyarea snd_hda_=
core hid_generic cfbimgblt cfg80211 snd_pcm sysfillrect usbhid sysimgblt sn=
d_timer cfbcopyarea hid snd igb soundcore efivarfs
> [11569.357709] Process ld-linux-loonga (pid: 1132296, threadinfo=3D000000=
003cbd0caa, task=3D000000005bcd27a6)
> [11569.366977] Stack : 00007ffffb93bd60 0000000000000000 9000000180a36a40=
 0000000000000001
> [11569.374940]         90000001113a3bb0 00007ffffb93c000 9000000000224c94=
 90000000009cab2c
> [11569.382899]         0000000000000001 9000000000224c94 00007ffff3258000=
 900000000025a1b4
> [11569.390866]         90000001113a3bb0 900000000022f4cc 00007ffffb93c000=
 900000000022f74c
> [11569.398834]         9000000180a36a40 0000000000000001 0000000000000000=
 00007ffffb93c000
> [11569.406800]         90000001113a3bb0 900000000022f8f8 90000001113a3ec0=
 00007ffffb93bde0
> [11569.414768]         00007ffffb93bd60 0000000000000000 0000000000000000=
 00007fffff7c4600
> [11569.422734]         9000000182ebab70 9000000000d08000 0000000046505501=
 900000000022ee6c
> [11569.430698]         0000000000000000 9000000000224b84 90000001113a0000=
 90000001113a3cf0
> [11569.438661]         0000000000000000 00007ffffb93c0d0 0000000000000000=
 0000000000000040
> [11569.446627]         ...
> [11569.449058] Call Trace:
> [11569.449062] [<90000000009caa10>] cmp_ex_search+0x0/0x28
> [11569.456681] [<90000000005e3448>] bsearch+0x58/0xa8
> [11569.461443] [<90000000009cab2c>] search_extable+0x28/0x34
> [11569.466807] [<900000000025a1b4>] search_exception_tables+0x48/0x7c
> [11569.472953] [<900000000022f4cc>] fixup_exception+0x18/0xcc
> [11569.478410] [<900000000022f74c>] do_sigsegv+0x174/0x1b0
> [11569.483605] [<900000000022f8f8>] do_page_fault+0x170/0x344
> [11569.489058] [<900000000022ee6c>] tlb_do_page_fault_1+0x128/0x1c4
> [11569.495029] [<9000000000224b84>] handle_signal+0x634/0x884
> [11569.500487] [<9000000000225704>] arch_do_signal_or_restart+0xb4/0xe0
> [11569.506808] [<90000000002b5b30>] exit_to_user_mode_prepare+0xbc/0x100
> [11569.513214] [<9000000000a02628>] syscall_exit_to_user_mode+0x30/0x4c
> [11569.519533] [<90000000002214a4>] handle_syscall+0xc4/0x160
>
> [11569.526472] Code: 4c000020  02800404  4c000020 <240000ac> 26000084  00=
10b0a5  680014a4  00129484  00111004
>
> [11569.537704] ---[ end trace 0000000000000000 ]---
>
> "BadVA : 1000000000cf16d0" may suggest the highest bit of an address is
> somehow cleared.
>
> The issue is not deterministic, but it seems easily reproduced by:
>
> 1. Compile Glibc:
>
> ../glibc/configure --prefix=3D/usr                      \
>              --disable-werror                         \
>              --enable-kernel=3D5.19                     \
>              --enable-stack-protector=3Dstrong          \
>              --with-headers=3D/usr/include              \
>              libc_cv_slibdir=3D/usr/lib
> make -j4
>
> 2. Check Glibc:
>
> make check -j4
>
> 3. If the oops did not happen during the last step, run a specific test
> in a dead loop:
>
> while true; do make test t=3Dmalloc/tst-mallocfork3-malloc-check; done
>
> Then an oops would likely show up in several minutes.
>
> Though the oops is nondeterministic, I'm almost sure it's not a hardware
> stability issue because I'm getting exactly same stack traces for each
> oops message.  I cannot easily rule out the possibility about "the
> compiler miscompiles kernel code" though.
>
> I'm running 6.2-rc8 with the following patches from loongarch-next:
>
> ACPI: Define ACPI_MACHINE_WIDTH to 64 for LoongArch
> PCI: loongson: Improve the MRRS quirk for LS7A
> PCI: Add quirk for LS7A to avoid reboot failure
> irqchip/loongson-liointc: Save/restore int_edge/int_pol registers during =
S3/S4
> LoongArch: Add vector extensions support
> tools: Add LoongArch build infrastructure
> libbpf: Add LoongArch support to bpf_tracing.h
> selftests/seccomp: Add LoongArch selftesting support
> SH: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
> LoongArch: Add CPU HWMon platform driver
>
> Any idea to fix the issue or suggestion to debug it further?
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
