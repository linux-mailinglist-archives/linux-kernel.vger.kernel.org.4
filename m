Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F7695D67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBNIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:46:36 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44498CDD6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1676364394;
        bh=H6e5KBXUJHMcDLyQ/BFYqS0gPcEakg+isU2JEhLTeyM=;
        h=Subject:From:To:Cc:Date:From;
        b=EOwMFCvOU4Mz4idsY5QoQO/4tnaadZ0L9Zx4D46QqKwuPpUQycYKBAFGwgUp3D0+U
         BIt6OoamZYo5Y24kwd9Z7Uohys6ryeYnKoQmgNLMHyRrayM7sMLi7O0EvDdZAjEFwY
         e7woHUT/8UVCVe/yV8ZhdYXtha2JThJShaS9VYOk=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0624366868;
        Tue, 14 Feb 2023 03:46:32 -0500 (EST)
Message-ID: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
Subject: "kernel ade access" oops on LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Date:   Tue, 14 Feb 2023 16:46:30 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a "help wanted" message :(.

I've recently run into some strange kernel oops testing Glibc for LoongArch=
.  A log looks like:

[11569.195043] Kernel ade access[#1]:
[11569.198441] CPU: 1 PID: 1132296 Comm: ld-linux-loonga Not tainted 6.2.0-=
rc8+ #61
[11569.205792] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V0.1-EV=
B/Loongson-LS3A5000-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05383-b=
eta10 1
[11569.219536] $ 0   : 0000000000000000 90000000005e3448 90000001113a0000 9=
0000001113a3ab0
[11569.227505] $ 4   : 90000001113a3af8 1000000000cf16d0 5555555555555850 0=
00000000000000c
[11569.235475] $ 8   : 90000000009caa10 0000000000000000 00000000000002ca 0=
00000000000008b
[11569.243438] $12   : 0000000000000001 9000000000cf1258 ffffffffffffffff 0=
0007ffffb93c000
[11569.251402] $16   : 0000000000000000 0000000000000140 0000000000000000 0=
000000000000020
[11569.259366] $20   : 90000001113a3ec8 9000000000a97ee0 00007ffffb93bfa0 1=
555555555555613
[11569.267334] $24   : 1000000000cf16d0 000000000000000c 9000000000cf1258 9=
0000000009caa10
[11569.275303] $28   : 90000001113a3af8 0aaaaaaaaaaaab0a 00007ffffb93bde0 9=
0000001113a3ec0
[11569.283268] era   : 90000000009caa10 cmp_ex_search+0x0/0x28
[11569.288814] ra    : 90000000005e3448 bsearch+0x58/0xa8
[11569.293921] CSR crmd: 000000b0=09
[11569.293923] CSR prmd: 00000004=09
[11569.297037] CSR euen: 00000000=09
[11569.300152] CSR ecfg: 00071c1c=09
[11569.303266] CSR estat: 00480000=09
[11569.309587] ExcCode : 8 (SubCode 1)
[11569.313049] BadVA : 1000000000cf16d0
[11569.316596] PrId  : 0014c011 (Loongson-64bit)
[11569.320923] Modules linked in: amdgpu nls_cp936 vfat fat input_leds drm_=
ttm_helper ttm video gpu_sched drm_buddy snd_hda_codec_generic drm_display_=
helper ledtrig_audio drm_kms_helper led_class snd_hda_intel sha256_generic =
snd_intel_dspcfg cfbfillrect libsha256 snd_hda_codec syscopyarea snd_hda_co=
re hid_generic cfbimgblt cfg80211 snd_pcm sysfillrect usbhid sysimgblt snd_=
timer cfbcopyarea hid snd igb soundcore efivarfs
[11569.357709] Process ld-linux-loonga (pid: 1132296, threadinfo=3D00000000=
3cbd0caa, task=3D000000005bcd27a6)
[11569.366977] Stack : 00007ffffb93bd60 0000000000000000 9000000180a36a40 0=
000000000000001
[11569.374940]         90000001113a3bb0 00007ffffb93c000 9000000000224c94 9=
0000000009cab2c
[11569.382899]         0000000000000001 9000000000224c94 00007ffff3258000 9=
00000000025a1b4
[11569.390866]         90000001113a3bb0 900000000022f4cc 00007ffffb93c000 9=
00000000022f74c
[11569.398834]         9000000180a36a40 0000000000000001 0000000000000000 0=
0007ffffb93c000
[11569.406800]         90000001113a3bb0 900000000022f8f8 90000001113a3ec0 0=
0007ffffb93bde0
[11569.414768]         00007ffffb93bd60 0000000000000000 0000000000000000 0=
0007fffff7c4600
[11569.422734]         9000000182ebab70 9000000000d08000 0000000046505501 9=
00000000022ee6c
[11569.430698]         0000000000000000 9000000000224b84 90000001113a0000 9=
0000001113a3cf0
[11569.438661]         0000000000000000 00007ffffb93c0d0 0000000000000000 0=
000000000000040
[11569.446627]         ...
[11569.449058] Call Trace:
[11569.449062] [<90000000009caa10>] cmp_ex_search+0x0/0x28
[11569.456681] [<90000000005e3448>] bsearch+0x58/0xa8
[11569.461443] [<90000000009cab2c>] search_extable+0x28/0x34
[11569.466807] [<900000000025a1b4>] search_exception_tables+0x48/0x7c
[11569.472953] [<900000000022f4cc>] fixup_exception+0x18/0xcc
[11569.478410] [<900000000022f74c>] do_sigsegv+0x174/0x1b0
[11569.483605] [<900000000022f8f8>] do_page_fault+0x170/0x344
[11569.489058] [<900000000022ee6c>] tlb_do_page_fault_1+0x128/0x1c4
[11569.495029] [<9000000000224b84>] handle_signal+0x634/0x884
[11569.500487] [<9000000000225704>] arch_do_signal_or_restart+0xb4/0xe0
[11569.506808] [<90000000002b5b30>] exit_to_user_mode_prepare+0xbc/0x100
[11569.513214] [<9000000000a02628>] syscall_exit_to_user_mode+0x30/0x4c
[11569.519533] [<90000000002214a4>] handle_syscall+0xc4/0x160

[11569.526472] Code: 4c000020  02800404  4c000020 <240000ac> 26000084  0010=
b0a5  680014a4  00129484  00111004=20

[11569.537704] ---[ end trace 0000000000000000 ]---

"BadVA : 1000000000cf16d0" may suggest the highest bit of an address is
somehow cleared.

The issue is not deterministic, but it seems easily reproduced by:

1. Compile Glibc:

../glibc/configure --prefix=3D/usr                      \
             --disable-werror                         \
             --enable-kernel=3D5.19                     \
             --enable-stack-protector=3Dstrong          \
             --with-headers=3D/usr/include              \
             libc_cv_slibdir=3D/usr/lib
make -j4

2. Check Glibc:

make check -j4

3. If the oops did not happen during the last step, run a specific test
in a dead loop:

while true; do make test t=3Dmalloc/tst-mallocfork3-malloc-check; done

Then an oops would likely show up in several minutes.

Though the oops is nondeterministic, I'm almost sure it's not a hardware
stability issue because I'm getting exactly same stack traces for each
oops message.  I cannot easily rule out the possibility about "the
compiler miscompiles kernel code" though.

I'm running 6.2-rc8 with the following patches from loongarch-next:

ACPI: Define ACPI_MACHINE_WIDTH to 64 for LoongArch
PCI: loongson: Improve the MRRS quirk for LS7A
PCI: Add quirk for LS7A to avoid reboot failure
irqchip/loongson-liointc: Save/restore int_edge/int_pol registers during S3=
/S4
LoongArch: Add vector extensions support
tools: Add LoongArch build infrastructure
libbpf: Add LoongArch support to bpf_tracing.h
selftests/seccomp: Add LoongArch selftesting support
SH: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
LoongArch: Add CPU HWMon platform driver

Any idea to fix the issue or suggestion to debug it further?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
