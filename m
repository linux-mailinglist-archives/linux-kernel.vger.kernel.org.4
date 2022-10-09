Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572B35F8AED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJILjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJILjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:39:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528228718;
        Sun,  9 Oct 2022 04:39:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so8229105pjl.3;
        Sun, 09 Oct 2022 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y234xSENi2SKcHwk9esppsyM8BZNtv04RcsXtbPGHV0=;
        b=XesemWWmCunhugVGT8OI5lUjVN2/47bcaoN6rF2vJM7m3Sx8zx/Mp6h8d57pt5/McQ
         +RzApiRrrqx4XFB7rljgzuZ1AzB9TCNc3gRH4EtzQxmkf0aRS2FKwvDeryTDhBI4aXXm
         cw1DIVVedj4gifrO2mMRXFHr0C2d2rwdpD+9odUNSXac2eD0XX3w2nS4/7brV0i+6quc
         2wDoUNqJcxraHw+/I7TViGDBOBE5A5vECgqoiyPZOX7SbBibXbX7WY9Dw3l4KEwjzeeW
         KQbzM3nUeGVVCg2DmctczBwYYsIxO7PdcZlSLE5qXakg2/2VvkLKJY3fl5hQrRBggo6r
         d/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y234xSENi2SKcHwk9esppsyM8BZNtv04RcsXtbPGHV0=;
        b=1XCS7c9xm01QZx13aooRy6hOSzGwBD+UjicxC59tKJqI9M5+cT8tI2WQjSmrX2uR2H
         ra253im/qdMmLk7rvstEmAE363Re4CEJ86gPgA35p0/kh+gairOrRg8v/YbRmy5zm4z5
         Q0BPSaTIUGEAO91dsr86aTuTv1oOnrjPjvZ3zCtWbCsDExotUt+tb0sVDmMDuz9mZayg
         ufIYslzPz9UN6OHvt4ZMySr1yKzH9ZQSHTSmvcXqv37uAyMS0VfoQWW2Z3DGVIN9Hv78
         J+CAD2GzrSrLuto4FZ8HDdB00g68TfH9uLJvROvNhtDFTC4YCetXaNJ0zPN83ILArgQn
         ADTA==
X-Gm-Message-State: ACrzQf0fNwDLBIne92f/0XXerCsrGZDPC4eNjQViVdGcTnnV3nbj2foa
        yatUBilnVYcKJkD1Mz6W7hkFpFuPoRYA50dqxILhmmpECRhnxpfn
X-Google-Smtp-Source: AMsMyM6XB0WrtZ5KnmaqWqSbPVgdPExcXNpX+OxqnsptLqkk3FQQyKyVyx+4IzqZ/4reJYqOOqOCkeASkYKxfML7YOE=
X-Received: by 2002:a17:90b:38c3:b0:20d:406e:26d9 with SMTP id
 nn3-20020a17090b38c300b0020d406e26d9mr239942pjb.121.1665315558654; Sun, 09
 Oct 2022 04:39:18 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 9 Oct 2022 16:39:07 +0500
Message-ID: <CABXGCsMmvxi9kCZ+sUm+Vb_jxaPXE308GAwkUmiduuJXh_o2fg@mail.gmail.com>
Subject: [bug][6.1] Enable run-time checking of dynamic memcpy() and memmove()
 lengths causes warning on every boot at net/wireless/wext-core.c:623 (size 4)
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        johannes@sipsolutions.net, linville@tuxdriver.com,
        Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Enable run-time checking of dynamic memcpy() and memmove() lengths
causes warning on every boot:
[   19.544552] ------------[ cut here ]------------
[   19.545634] memcpy: detected field-spanning write (size 16) of
single field "&compat_event->pointer" at net/wireless/wext-core.c:623
(size 4)
[   19.546503] WARNING: CPU: 14 PID: 9 at net/wireless/wext-core.c:623
wireless_send_event+0x482/0x490
[   19.547052] Modules linked in: nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink qrtr bnep intel_rapl_msr intel_rapl_common
snd_sof_amd_renoir sunrpc snd_sof_amd_acp mt7921e mt7921_common
snd_sof_pci mt76_connac_lib snd_hda_codec_realtek snd_sof
snd_hda_codec_generic snd_hda_codec_hdmi snd_sof_utils mt76
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi edac_mce_amd
binfmt_misc snd_hda_codec mac80211 snd_soc_core kvm_amd snd_hda_core
vfat btusb fat btrtl btbcm snd_hwdep snd_compress snd_seq ac97_bus
btintel snd_seq_device snd_pcm_dmaengine btmtk libarc4 snd_pci_acp6x
kvm snd_pcm snd_pci_acp5x irqbypass bluetooth snd_timer
snd_rn_pci_acp3x cfg80211 rapl pcspkr snd_acp_config snd joydev
snd_soc_acpi asus_nb_wmi wmi_bmof soundcore snd_pci_acp3x i2c_piix4
k10temp asus_wireless amd_pmc
[   19.547126]  zram amdgpu drm_ttm_helper ttm hid_asus asus_wmi
ledtrig_audio iommu_v2 sparse_keymap gpu_sched platform_profile
drm_buddy hid_multitouch crct10dif_pclmul crc32_pclmul rfkill
drm_display_helper ucsi_acpi crc32c_intel nvme serio_raw
ghash_clmulni_intel typec_ucsi video ccp nvme_core sp5100_tco cec
r8169 typec wmi i2c_hid_acpi i2c_hid ip6_tables ip_tables fuse
[   19.551473] CPU: 14 PID: 9 Comm: kworker/u32:0 Tainted: G        W
  L     6.0.0-latest-a6afa4199d3d038fbfdff5511f7523b0e30cb774+ #117
[   19.552099] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.318 03/29/2022
[   19.552732] Workqueue: phy0 ieee80211_iface_work [mac80211]
[   19.553387] RIP: 0010:wireless_send_event+0x482/0x490
[   19.553999] Code: cf fd ff ff b9 04 00 00 00 48 89 ee 48 89 04 24
48 c7 c2 10 17 9a 96 48 c7 c7 00 3d 84 96 c6 05 e1 00 14 01 01 e8 c3
ab 04 00 <0f> 0b 48 8b 04 24 e9 9e fd ff ff 0f 1f 00 0f 1f 44 00 00 41
56 49
[   19.554664] RSP: 0018:ffffb7ec40147798 EFLAGS: 00010292
[   19.555543] RAX: 0000000000000081 RBX: ffff92d213144e00 RCX: 0000000000000000
[   19.556804] RDX: 0000000000000001 RSI: ffffffff968d45b5 RDI: 00000000ffffffff
[   19.557495] RBP: 0000000000000010 R08: 0000000000000000 R09: ffffb7ec40147648
[   19.558135] R10: 0000000000000003 R11: ffff92e11d2fffe8 R12: ffffffff965b695c
[   19.558792] R13: ffff92d23678e000 R14: 0000000000000014 R15: ffff92d213145b00
[   19.559448] FS:  0000000000000000(0000) GS:ffff92e0d9a00000(0000)
knlGS:0000000000000000
[   19.560081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.560727] CR2: 00007f0d080323e8 CR3: 000000013ee88000 CR4: 0000000000750ee0
[   19.561594] PKRU: 55555554
[   19.562579] Call Trace:
[   19.563288]  <TASK>
[   19.563944]  __cfg80211_connect_result+0x3cb/0x7c0 [cfg80211]
[   19.564613]  ? cfg80211_rx_assoc_resp+0x1df/0x2f0 [cfg80211]
[   19.565248]  cfg80211_rx_assoc_resp+0x1df/0x2f0 [cfg80211]
[   19.565922]  ieee80211_rx_mgmt_assoc_resp.cold+0x2b3/0x1cbe [mac80211]
[   19.566622]  ieee80211_sta_rx_queued_mgmt+0x15c/0x920 [mac80211]
[   19.567413]  ? mark_held_locks+0x50/0x80
[   19.568357]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   19.569161]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   19.569789]  ? lockdep_hardirqs_on+0x7d/0x100
[   19.570412]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[   19.571022]  ieee80211_iface_work+0x32c/0x450 [mac80211]
[   19.571681]  process_one_work+0x2a0/0x600
[   19.572296]  worker_thread+0x4f/0x3a0
[   19.572923]  ? process_one_work+0x600/0x600
[   19.573777]  kthread+0xf5/0x120
[   19.574737]  ? kthread_complete_and_exit+0x20/0x20
[   19.575439]  ret_from_fork+0x22/0x30
[   19.576052]  </TASK>
[   19.576668] irq event stamp: 225109
[   19.577260] hardirqs last  enabled at (225117):
[<ffffffff9518c2be>] __up_console_sem+0x5e/0x70
[   19.577886] hardirqs last disabled at (225126):
[<ffffffff9518c2a3>] __up_console_sem+0x43/0x70
[   19.578508] softirqs last  enabled at (225088):
[<ffffffff950fe9d9>] __irq_exit_rcu+0xf9/0x170
[   19.579113] softirqs last disabled at (225077):
[<ffffffff950fe9d9>] __irq_exit_rcu+0xf9/0x170
[   19.580092] ---[ end trace 0000000000000000 ]---


Related code was added back in 2009.

$ git blame net/wireless/wext-core.c -L 613,633
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 613)
 compat_wrqu.length = wrqu->data.length;
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 614)
 compat_wrqu.flags = wrqu->data.flags;
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 615)
 memcpy(&compat_event->pointer,
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 616)
         ((char *) &compat_wrqu) + IW_EV_COMPAT_POINT_OFF,
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 617)
         hdr_len - IW_EV_COMPAT_LCP_LEN);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 618)
 if (extra_len)
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 619)
         memcpy(((char *) compat_event) + hdr_len,
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 620)
                 extra, extra_len);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 621)     } else {
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 622)
 /* extra_len must be zero, so no if (extra) needed */
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 623)
 memcpy(&compat_event->pointer, wrqu,
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 624)
         hdr_len - IW_EV_COMPAT_LCP_LEN);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 625)     }
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 626)
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 627)
nlmsg_end(compskb, nlh);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 628)
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 629)
skb_shinfo(skb)->frag_list = compskb;
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 630) #endif
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 631)
skb_queue_tail(&dev_net(dev)->wext_nlevents, skb);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 632)
schedule_work(&wireless_nlevent_work);
3d23e349d8071 (Johannes Berg 2009-09-29 23:27:28 +0200 633) }

I suppose this code should be fixed instead of fixing
54d9469bc515dc5fcbc20eecbe19cea868b70d68 commit which I fing by
bisecting this issue.

Full kernel log: https://pastebin.com/sQVzYgAb

-- 
Best Regards,
Mike Gavrilov.
