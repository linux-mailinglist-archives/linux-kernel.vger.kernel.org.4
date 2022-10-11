Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195735FB1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJKMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:02:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF75895D1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:02:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y1so6166458pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfxJnJZucKSPmID0msGF+fwgjBsd24MeWZHIhxGDkdw=;
        b=EUN+cPbI0yqljNSE8kOice/UJf9Fw1hsUaa0QW19DFv48ITggW2rQe/MtoBoxePsD/
         6DvGnbkVVZEAapgKvJFylHbp3wMCmXzLsIVi+1Sssdpj/cPV7jj9oU2T/ZAgeoknhZY/
         QXL5XRtwuJ/zPr+MPRjirf7UiYV/p6GO1TrdKt38JNZM9WHViWPPL8pHakLuL/nwGwbX
         0MF2ZyyVvY+QljYlJmweEdyibiwPihqDpKh/dGvW7p5p/IDnJGkDSCnBohuf6MsHHN2q
         43KrvXlOvXFmgEr4j/SatC7QRx8LnEbs4L9xbQlpRC+XwVMc2PvVZl1fp2FGprnCPAzf
         +SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfxJnJZucKSPmID0msGF+fwgjBsd24MeWZHIhxGDkdw=;
        b=Ki55mQ1O7SaNXgVyzd8TPSbMQOcAgX9N5AzWvjvYAZgpef20H65ww/wHbqRUVgOpju
         4lh8RO1J5narojI0M8sLvCFwzYdHyWepSF/BPbVLl0ysxoxyI3H3khghxcVo3OzCxrf4
         /dkYL057CXZ79ra+3/1sRjZYBejvDEIcoXPNBpuqpBNZ4KNzLtRT0KujzxhSTvcTOTXn
         P2JCxko1k8Eerd7e9sRX4s2ZnLGTyc37qO6bFhSZGGB3wUpamQ9jvv4O863P4GYNRjXA
         pocSH47S1Btn9Jgrv068be7jRL9rY2jwOODdMT3SFSljBhujC72tymOwM7C+34uBcRJA
         hX0A==
X-Gm-Message-State: ACrzQf3xiridrBmlMGzrqTpt7alr029VhDvxgaKFAnfeiRR3Y9nJEACI
        JH0Yt4ZwOINHZgIvY6fUOw4XRz85QY22EUkprKGVL3xW1nminK7S
X-Google-Smtp-Source: AMsMyM6A+mlptygfE/6R0lzMZOEhaopjChWb/Cc6EpTAdMQbOxaQx3Gz7wNHtH0vbMbV5UaYjRi32gAmAHgSbjI6yLY=
X-Received: by 2002:a65:6e0e:0:b0:434:59e0:27d3 with SMTP id
 bd14-20020a656e0e000000b0043459e027d3mr20022363pgb.185.1665489768209; Tue, 11
 Oct 2022 05:02:48 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 11 Oct 2022 17:02:36 +0500
Message-ID: <CABXGCsNrh7xxty_zG4ux2b_35jrO9ikeJs=O-AVnTF_R23KPtA@mail.gmail.com>
Subject: [regression][6.1] After commit e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86
 system randomly hungs
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Arvind.Yadav@amd.com,
        "Grodzovsky, Andrey" <andrey.grodzovsky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
The hungs occurs randomly, but I found good reproductive scenario
(This is running the campaign in the game Halo Infinite)
The backtrace is look like this:

[  147.260971] BUG: kernel NULL pointer dereference, address: 0000000000000=
088
[  147.260987] ------------[ cut here ]------------
[  147.260988] WARNING: CPU: 3 PID: 0 at kernel/softirq.c:321
__local_bh_disable_ip+0x9e/0xb0
[  147.260993] Modules linked in: uinput rfcomm snd_seq_dummy
snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink qrtr bnep sunrpc snd_sof_amd_renoir intel_rapl_msr
snd_sof_amd_acp intel_rapl_common mt7921e snd_sof_pci mt7921_common
binfmt_misc snd_sof mt76_connac_lib snd_sof_utils vfat
snd_hda_codec_realtek snd_soc_core snd_hda_codec_generic mt76 fat
snd_hda_codec_hdmi snd_hda_intel edac_mce_amd snd_compress ac97_bus
btusb kvm_amd snd_intel_dspcfg snd_pcm_dmaengine btrtl
snd_intel_sdw_acpi btbcm snd_hda_codec snd_pci_acp6x mac80211 kvm
snd_hda_core btintel btmtk irqbypass snd_hwdep snd_seq libarc4
snd_seq_device bluetooth snd_pcm snd_pci_acp5x snd_timer
snd_rn_pci_acp3x cfg80211 rapl pcspkr joydev asus_nb_wmi wmi_bmof
snd_acp_config snd snd_soc_acpi k10temp
[  147.261033]  soundcore i2c_piix4 snd_pci_acp3x asus_wireless
amd_pmc zram amdgpu drm_ttm_helper ttm hid_asus iommu_v2 asus_wmi
gpu_sched ledtrig_audio sparse_keymap drm_buddy platform_profile
drm_display_helper crct10dif_pclmul crc32_pclmul nvme rfkill
crc32c_intel ucsi_acpi hid_multitouch video ghash_clmulni_intel
nvme_core ccp typec_ucsi serio_raw r8169 cec sp5100_tco typec
i2c_hid_acpi wmi i2c_hid ip6_tables ip_tables fuse
[  147.261045] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W    L
   6.0.0-rc2-02-907cc346ff6a69a08b4786c4ed2a78ac0120b9da+ #124
[  147.261046] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.318 03/29/2022
[  147.261047] RIP: 0010:__local_bh_disable_ip+0x9e/0xb0
[  147.261048] Code: 25 00 1e 02 00 48 89 df e8 6f 23 08 00 85 c0 75
0e 48 89 9d 30 1c 00 00 5b 5d c3 cc cc cc cc 31 ff 31 db e8 54 23 08
00 eb e7 <0f> 0b e9 76 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
44 00
[  147.261049] RSP: 0018:ffffa4e1c028c8d8 EFLAGS: 00010006
[  147.261050] RAX: 0000000080010005 RBX: 0000000000000201 RCX: 00000000000=
00018
[  147.261051] RDX: 00000f440b255950 RSI: 0000000000000201 RDI: ffffffffc1b=
652e5
[  147.261051] RBP: ffff93a4eaf00fd8 R08: 0000000000000001 R09: 00000000000=
00000
[  147.261052] R10: 7635d840c31a8942 R11: fcca632b3d1b0d46 R12: ffff93a4f78=
31000
[  147.261052] R13: ffff93a4eaf00ee0 R14: ffff93a4efd84178 R15: ffff93a4efd=
84000
[  147.261053] FS:  0000000000000000(0000) GS:ffff93b396e00000(0000)
knlGS:0000000000000000
[  147.261054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.261055] CR2: 0000000000000088 CR3: 000000012a610000 CR4: 00000000007=
50ee0
[  147.261056] PKRU: 55555554
[  147.261056] Call Trace:
[  147.261060]  <IRQ>
[  147.261068]  _raw_spin_lock_bh+0x1d/0x80
[  147.261074]  ieee80211_queue_skb+0x125/0x7a0 [mac80211]
[  147.261113]  ? __skb_get_hash+0x55/0x200
[  147.261117]  ieee80211_tx_8023+0x9c/0x1c0 [mac80211]
[  147.261155]  ieee80211_subif_start_xmit_8023+0x2b5/0x510 [mac80211]
[  147.261191]  netpoll_start_xmit+0x121/0x190
[  147.261199]  netpoll_send_skb+0x1fc/0x300
[  147.261202]  write_msg+0xdc/0xf0 [netconsole]
[  147.261207]  console_emit_next_record.constprop.0+0x17d/0x300
[  147.261214]  console_unlock+0xf3/0x1f0
[  147.261215]  vprintk_emit+0x152/0x350
[  147.261217]  ? plist_add+0xba/0xf0
[  147.261223]  _printk+0x48/0x4e
[  147.261231]  ? rcu_read_lock_sched_held+0x10/0x80
[  147.261235]  page_fault_oops.cold+0xcf/0x1f9
[  147.261240]  ? do_user_addr_fault+0x65/0x6b0
[  147.261243]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[  147.261247]  exc_page_fault+0x7e/0x300
[  147.261249]  asm_exc_page_fault+0x22/0x30
[  147.261252] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x1e0 [gpu_sched]
[  147.261255] Code: 89 d7 e8 87 02 0d f0 e9 54 ff ff ff 48 89 d7 e8
ea 66 37 f0 e9 47 ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 41 54 55 53
48 89 fb <48> 8b af 88 00 00 00 f0 ff 8d 70 02 00 00 48 8b 85 a8 03 00
00 f0
[  147.261256] RSP: 0018:ffffa4e1c028cdc8 EFLAGS: 00010093
[  147.261257] RAX: ffffffffc06dc380 RBX: 0000000000000000 RCX: 00000000000=
00018
[  147.261257] RDX: 00000efa9afe3594 RSI: ffff93a7a4c1ec90 RDI: 00000000000=
00000
[  147.261258] RBP: ffff93a7a4c1ee10 R08: 0000000000000001 R09: 00000000000=
00000
[  147.261259] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa4e1c02=
8cde8
[  147.261259] R13: 0000000000000086 R14: 00000000ffffffff R15: ffff93a4fbe=
d0198
[  147.261261]  ? drm_sched_job_done.isra.0+0x1e0/0x1e0 [gpu_sched]
[  147.261266]  dma_fence_signal_timestamp_locked+0x9e/0x1c0
[  147.261274]  dma_fence_signal+0x36/0x70
[  147.261276]  amdgpu_fence_process+0xd5/0x140 [amdgpu]
[  147.261497]  sdma_v5_2_process_trap_irq+0x10d/0x130 [amdgpu]
[  147.261737]  amdgpu_irq_dispatch+0xcc/0x270 [amdgpu]
[  147.261918]  amdgpu_ih_process+0x80/0x100 [amdgpu]
[  147.262072]  amdgpu_irq_handler+0x1f/0x60 [amdgpu]
[  147.262227]  __handle_irq_event_percpu+0x93/0x330
[  147.262231]  handle_irq_event+0x34/0x70
[  147.262232]  handle_edge_irq+0x9f/0x240
[  147.262233]  __common_interrupt+0x71/0x150
[  147.262236]  common_interrupt+0xb4/0xd0
[  147.262237]  </IRQ>
[  147.262238]  <TASK>

bisect points to this commit: e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86

$ git bisect bad
e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86 is the first bad commit
commit e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86
Author: Arvind Yadav <Arvind.Yadav@amd.com>
Date:   Wed Sep 14 22:13:20 2022 +0530

    drm/sched: Use parent fence instead of finished

    Using the parent fence instead of the finished fence
    to get the job status. This change is to avoid GPU
    scheduler timeout error which can cause GPU reset.

    Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
    Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20220914164321.2156=
-6-Arvind.Yadav@amd.com
    Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

--=20
Best Regards,
Mike Gavrilov.
