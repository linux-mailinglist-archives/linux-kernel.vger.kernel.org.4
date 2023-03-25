Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2D6C8E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCYMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCYMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:35:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A464113E0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:35:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q102so3671896pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679747736;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe8cQ6OdJNbKTG8bCM5wAFqlI2bmhmLFZdZxky33Dl0=;
        b=RxyCBoSTP72DhxtuUqW9/D004PTlWR7j74F2Lfrlx4qK5AQdApub6ECQVlHGQghfy0
         YE6k9/A9Q/p1wHTPNiWmPe2n3J4lk9OdYh5kPzZVCYioNKdAlvHpJAyr6d7CVOu/IB5H
         AoDW9eNbxCmiU85UWCEhlPuKZTOHASeUEBLpgFdf/gFXPizDcrFPEj0ltmnsUnRX/lhJ
         wnEMaVaJMVFMlf8ILWjkWw82qCxJjpnKfd1Yde/xTSMpfYO3xcNrkOupI1kRL2bP5sZI
         n19PN8KnpyMA+Ro3O+OMOYuZR9B3Vbapvz8HY0nZu+0uB2P9fCHlX1XPVv0Zp8hlAvPm
         DDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679747736;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe8cQ6OdJNbKTG8bCM5wAFqlI2bmhmLFZdZxky33Dl0=;
        b=b80Y1oMaUMh27zkyi/Qz8KJu/ZD58T8japwzNemZxC/E2q1ydMnZ8qADp48ipKhaN/
         LuX//fxKdGe+R5bQZduaAinF44iI5PXWAGQCh9WObNpsHv72VB1UB+hbRqFtX69F7n1/
         +HFET2K/yAvyKwzwMFMPMTC8SzQHg/8FfCvtPH4cZMztuG+kcNrMz3S309bDqELoepAi
         ePWnaz6iep2+UuS4DX+0TdbngQJrSR4SkCUP/GqiIDlBblSU1mHVd75kbs2/B7CAVBMb
         p3cgysUV+xnGOqHy1ycoESXn5IHHr7RWzjHrvhtvTzBYQglMz1Pu9AG8OSgtBdYhZIBK
         8rxA==
X-Gm-Message-State: AAQBX9d8AfumG201OoK+5rcpf7l/ksHJVPr7zGC6A0Dnyt+rmbnPk0Fd
        XFT8OOElSe5G/hIta94lGzK1E2/bhC/fcw==
X-Google-Smtp-Source: AKy350aCaLvh7SqkX9KNb6mdK6BXachlmSAMfY5m4iFJ5WhftCBENJ0xuTBwrf/1Qd2uh9oLQS6FFg==
X-Received: by 2002:a17:903:249:b0:19c:d452:b282 with SMTP id j9-20020a170903024900b0019cd452b282mr6386027plh.12.1679747736262;
        Sat, 25 Mar 2023 05:35:36 -0700 (PDT)
Received: from mainframe.localdomain ([111.94.206.5])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902728700b00194c90ca320sm15828906pll.204.2023.03.25.05.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:35:35 -0700 (PDT)
Date:   Sat, 25 Mar 2023 19:34:47 +0700
From:   Ketsui <esgwpl@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     esgwpl@gmail.com
Subject: general protection fault in folio_mark_dirty()
Message-ID: <20230325123447.GA101034@mainframe.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been trying to bisect between kernel 6.1 and 6.2 to find the offending=
 commit
that lowers performance after I resume my system from suspend but I've been
skipping lots of versions that I couldn't test because of a kernel crash on=
 boot.
Since I don't get these crashes on 6.2.7 I'm assuming that this has been fi=
xed but
after searching for a bit I couldn't find a way to track down this issue, c=
an anyone
please point me in the right direction? Below is a snippet and the full log=
 of the crash.

Mar 24 20:04:44 kernel: general protection fault, probably for non-canonica=
l address 0xdead000000000498: 0000 [#1] PREEMPT SMP NOPTI
Mar 24 20:04:44 kernel: CPU: 1 PID: 939 Comm: pulseaudio Not tainted 6.1.0-=
1-bisect-07411-g1ca06f1c1ace #1 f06b10f786641bb24be3f64215f325d83828c2d9
Mar 24 20:04:44 kernel: Hardware name: To Be Filled By O.E.M. To Be Filled =
By O.E.M./B450M-HDV R4.0, BIOS P3.20 07/31/2019
Mar 24 20:04:44 kernel: RIP: 0010:folio_mark_dirty+0x29/0x60
Mar 24 20:04:44 kernel: Code: 00 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 =
ce 1d 02 00 48 85 c0 74 27 48 89 c7 48 8b 03 a9 00 00 04 00 74 05 f0 80 63 =
02 fb <48> 8b 87 98 00 00 00 48 89 de 5b 48 8b 40 18 e9 d3 da d7 00 cc 48
Mar 24 20:04:44 kernel: RSP: 0000:ffffad1b02dd3d68 EFLAGS: 00010246
Mar 24 20:04:44 kernel: RAX: 02ffff0000000001 RBX: fffff7ac84cd1e40 RCX: ff=
ffa0d11effb000
Mar 24 20:04:44 kernel: RDX: 0000000000000000 RSI: 8000000133479867 RDI: de=
ad000000000400
Mar 24 20:04:44 kernel: RBP: ffffa0cea9f73be0 R08: 0000000000039c40 R09: 00=
00000000000012
Mar 24 20:04:44 kernel: R10: 00007f9009438000 R11: ffffa0cea9cfb80c R12: ff=
ffa0cea9f73be0
Mar 24 20:04:44 kernel: R13: fffff7ac84cd1e40 R14: 0000000117a32067 R15: 00=
00000000000000
Mar 24 20:04:44 kernel: FS:  00007f900948f840(0000) GS:ffffa0d110640000(000=
0) knlGS:0000000000000000
Mar 24 20:04:44 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 24 20:04:44 kernel: CR2: 00007f9009438000 CR3: 0000000117de4000 CR4: 00=
000000003506e0
Mar 24 20:04:44 kernel: Call Trace:
Mar 24 20:04:44 kernel:  <TASK>
Mar 24 20:04:44 kernel:  fault_dirty_shared_page+0x32/0x110
Mar 24 20:04:44 kernel:  do_fault+0x2f7/0x410
Mar 24 20:04:44 kernel:  __handle_mm_fault+0x660/0xfa0
Mar 24 20:04:44 kernel:  handle_mm_fault+0xdf/0x2d0
Mar 24 20:04:44 kernel:  do_user_addr_fault+0x1be/0x6a0
Mar 24 20:04:44 kernel:  exc_page_fault+0x74/0x170
Mar 24 20:04:44 kernel:  asm_exc_page_fault+0x26/0x30
Mar 24 20:04:44 kernel: RIP: 0033:0x7f9004fa8d4c
Mar 24 20:04:44 kernel: Code: 01 00 00 00 41 88 46 29 66 41 83 7e 28 00 4d =
89 66 20 0f 84 b6 01 00 00 49 89 5e 30 f6 45 19 01 75 0d 66 0f 6f 05 54 d3 =
02 00 <41> 0f 11 04 24 49 8b 46 18 41 8b 56 04 48 c7 85 28 01 00 00 00 00
Mar 24 20:04:44 kernel: RSP: 002b:00007ffe1873a3d0 EFLAGS: 00010246
Mar 24 20:04:44 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00=
00000000000321
Mar 24 20:04:44 kernel: RDX: 0000555a760d6550 RSI: 00007f9009fe8b00 RDI: 00=
00555a760d62c0
Mar 24 20:04:44 kernel: RBP: 0000555a760d6040 R08: 0000555a760d6240 R09: 00=
00000081000000
Mar 24 20:04:44 kernel: R10: 0000000000000001 R11: fa17c30891e05e1c R12: 00=
007f9009438000
Mar 24 20:04:44 kernel: R13: 0000000000000000 R14: 0000555a760d5fc0 R15: 00=
00000000000000
Mar 24 20:04:44 kernel:  </TASK>
Mar 24 20:04:44 kernel: Modules linked in: ccm algif_aead cbc des_generic l=
ibdes ecb algif_skcipher cmac cfg80211 md4 algif_hash af_alg rfkill nft_rej=
ect_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_limit nft_ct nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink nct6775 nct6775_core=
 hwmon_vid vfat amdgpu snd_hda_codec_realtek fat snd_hda_codec_generic ledt=
rig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec s=
nd_hwdep intel_rapl_msr drm_ttm_helper intel_rapl_common snd_hda_core ttm s=
nd_pcm gpu_sched kvm_amd drm_buddy snd_timer kvm snd r8169 drm_display_help=
er mousedev irqbypass joydev soundcore cec realtek video wmi_bmof rapl mdio=
_devres libphy i2c_piix4 pcspkr k10temp gpio_amdpt wmi gpio_generic acpi_cp=
ufreq mac_hid loop fuse ip_tables x_tables xfs libcrc32c crc32c_generic usb=
hid crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_gene=
ric gf128mul ghash_clmulni_intel sha512_ssse3 aesni_intel ccp crypto_simd c=
ryptd sp5100_tco xhci_pci
Mar 24 20:04:44 kernel:  xhci_pci_renesas dm_mirror dm_region_hash dm_log p=
kcs8_key_parser dm_multipath dm_mod
Mar 24 20:04:44 kernel: ---[ end trace 0000000000000000 ]---

Full dmesg: http://ix.io/4rMK
