Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF064DCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:17:46 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F51D66D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:17:44 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id i12so1963233qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qH65EB/srLKMMOVQiHunpW5uoOREGYljGlOJUVjZEo=;
        b=kiLin910Dkxx4YI8jEFzf7bt/XAy1ykcrbRZEK+Q1JTMQJigASH2vlPlrgbqVHn2/O
         OON/Wn22uMMbN2RrKOMwyWX5Eaq0SW05VWuDtNycu68cyW8ZvLyFPiReP/OSk77E/wQ9
         1TfZJm7ftMSCYe9DA8XV+1rbrZj8QyE68AIHpElLh70pmE1Seh9k3SgEYAhAw5lJ4y4B
         rTm7M9YHvfe6T72/8B7UOnrs5WjrvkUODsiOuiuP7I0io8sjr6KKCby69CwKt/SiW/Ut
         1mibxLTBN9AdkbOaXezSF56bQEPyTuMOwMTw/JhIJLlCSTIZgh7yzdRjmqrNPidFJ4H/
         XqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qH65EB/srLKMMOVQiHunpW5uoOREGYljGlOJUVjZEo=;
        b=fur9fr9A72BwfgguFR5dPNsLqzb3hSWXiBXorxC3GURA3Ehk5hB3tj2hQ/vkT8GvcK
         b5GCqv4dfhX1AoOgZUBlz+fGhP0mp4IzziFMHHafegDwlbs7/jBsPmwbH8Xl2uWdFG2v
         LbV3ZWDRf5fIMYJymwH9wuuoZ21oah6SCXYF3jo/ZQvBFVm7WPXvCmTREmMFZyyLba1t
         W+bBHkneKRWwA1I1MTospk1HpxVP/k58oc4/eeRVlxwIXBOfsBBxPyVUVPzteOhzXG7Y
         nBxybXk3BeHDjfOBCdFe/ePcjzKt4wKl38uSKM/1EfvpwOfW+FYofetfjxBNt2mxm2eP
         FHTw==
X-Gm-Message-State: ANoB5plzDazYw1caLOKe6w+Xopr9BbTgJcdB4mNzQKC93ZzfSeL7bC/d
        vmNGesJv3XD7UNDQG0TYNXKKmnne86/pHXXK2DJVG/pzl5KkXY2w
X-Google-Smtp-Source: AA0mqf61VROXNrPU5+FuWTNFcWXOeVMQG8uZV0LJnw+b/QXiLq/7g1unckZRhULbJ0u09LFK7qhTSC+BzVe6xfh00Zk=
X-Received: by 2002:a05:6214:5009:b0:4c7:8f9:6eb4 with SMTP id
 jo9-20020a056214500900b004c708f96eb4mr39985068qvb.62.1671113863707; Thu, 15
 Dec 2022 06:17:43 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 15 Dec 2022 19:17:32 +0500
Message-ID: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
Subject: [6.2][regression] after commit ffcb754584603adf7039d7972564fbf6febdc542
 all sound devices disappeared (due BUG at mm/page_alloc.c:3592!)
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        hch@lst.de, m.szyprowski@samsung.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

Hi,
The kernel 6.2 preparation cycle has begun and yesterday after the
kernel was updated on my Fedora Rawhide all audio devices disappeared.

The backtrace of the issue looks like:
[  133.033269] page:00000000e4a2c44b refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x207490
[  133.033353] head:00000000e4a2c44b order:2 compound_mapcount:0
subpages_mapcount:0 compound_pincount:0
[  133.033360] flags: 0x17ffffc0010000(head|node=0|zone=2|lastcpupid=0x1fffff)
[  133.033369] raw: 0017ffffc0010000 0000000000000000 dead000000000122
0000000000000000
[  133.033376] raw: 0000000000000000 0000000000000000 00000001ffffffff
0000000000000000
[  133.033381] page dumped because: VM_BUG_ON_PAGE(PageCompound(page))
[  133.033392] ------------[ cut here ]------------
[  133.033397] kernel BUG at mm/page_alloc.c:3592!
[  133.033406] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  133.033410] CPU: 22 PID: 1673 Comm: wireplumber Tainted: G        W
   L    -------  ---
6.2.0-0.rc0.20221214gite2ca6ba6ba01.3.fc38.x86_64 #1
[  133.033415] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
[  133.033417] RIP: 0010:split_page+0xa2/0x160
[  133.033425] Code: 00 48 83 c7 40 48 39 d7 75 d7 0f 1f 44 00 00 89
ee 48 89 df 5b 5d e9 2d fe 06 00 48 c7 c6 d8 ca 9a 95 48 89 df e8 8e
77 fc ff <0f> 0b 48 89 f8 f7 c7 ff 0f 00 00 0f 85 7a ff ff ff 48 8b 17
f7 c2
[  133.033428] RSP: 0018:ffff9f5645177b98 EFLAGS: 00010286
[  133.033432] RAX: 0000000000000037 RBX: ffffeb89c81d2400 RCX: 0000000000000000
[  133.033435] RDX: 0000000000000001 RSI: ffffffff959f0673 RDI: 00000000ffffffff
[  133.033438] RBP: 0000000000000002 R08: 0000000000000000 R09: ffff9f5645177a08
[  133.033440] R10: 0000000000000003 R11: ffff8d032e2fffe8 R12: 0000000000000007
[  133.033442] R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000001
[  133.033445] FS:  00007f7e55702800(0000) GS:ffff8d02e8200000(0000)
knlGS:0000000000000000
[  133.033448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.033450] CR2: 00007f7e556cb000 CR3: 00000001f604e000 CR4: 0000000000350ee0
[  133.033453] Call Trace:
[  133.033455]  <TASK>
[  133.033458]  __iommu_dma_alloc_noncontiguous.constprop.0+0x2de/0x3e0
[  133.033468]  ? rcu_read_lock_sched_held+0x3f/0x80
[  133.033475]  iommu_dma_alloc_noncontiguous+0x66/0xb0
[  133.033481]  dma_alloc_noncontiguous+0x54/0x1a0
[  133.033489]  snd_dma_noncontig_alloc+0x25/0x120 [snd_pcm]
[  133.033505]  snd_dma_sg_wc_alloc+0x13/0xb0 [snd_pcm]
[  133.033519]  snd_dma_alloc_dir_pages+0x50/0x90 [snd_pcm]
[  133.033532]  do_alloc_pages+0x49/0xa0 [snd_pcm]
[  133.033546]  snd_pcm_lib_malloc_pages+0xf1/0x1e0 [snd_pcm]
[  133.033560]  snd_pcm_hw_params+0x57f/0x620 [snd_pcm]
[  133.033576]  snd_pcm_common_ioctl+0x1e4/0x12a0 [snd_pcm]
[  133.033595]  snd_pcm_ioctl+0x23/0x40 [snd_pcm]
[  133.033607]  __x64_sys_ioctl+0x90/0xd0
[  133.033613]  do_syscall_64+0x5b/0x80
[  133.033618]  ? do_syscall_64+0x67/0x80
[  133.033622]  ? lockdep_hardirqs_on+0x7d/0x100
[  133.033627]  ? do_syscall_64+0x67/0x80
[  133.033630]  ? do_syscall_64+0x67/0x80
[  133.033633]  ? do_syscall_64+0x67/0x80
[  133.033636]  ? do_syscall_64+0x67/0x80
[  133.033640]  ? lockdep_hardirqs_on+0x7d/0x100
[  133.033644]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  133.033648] RIP: 0033:0x7f7e55b5f65f
[  133.033671] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[  133.033674] RSP: 002b:00007ffd24c51ec0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  133.033678] RAX: ffffffffffffffda RBX: 00007ffd24c520f0 RCX: 00007f7e55b5f65f
[  133.033681] RDX: 00007ffd24c520f0 RSI: 00000000c2604111 RDI: 0000000000000023
[  133.033683] RBP: 0000556c04c4ff60 R08: 0000000000000000 R09: 0000000000000000
[  133.033685] R10: 0000000000000004 R11: 0000000000000246 R12: 0000556c04c4fee0
[  133.033688] R13: 00007ffd24c52360 R14: 00007ffd24c527b0 R15: 00007ffd24c520f0
[  133.033696]  </TASK>
[  133.033698] Modules linked in: snd_seq_dummy snd_hrtimer
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
sunrpc binfmt_misc iwlmvm hid_logitech_hidpp btusb btrtl btbcm
snd_seq_midi snd_seq_midi_event btintel btmtk snd_usb_audio bluetooth
snd_usbmidi_lib iwlwifi xpad snd_rawmidi ff_memless mc intel_rapl_msr
joydev intel_rapl_common snd_hda_codec_realtek edac_mce_amd
snd_hda_codec_generic snd_hda_codec_hdmi mt76x2u snd_hda_intel kvm_amd
snd_intel_dspcfg mt76x2_common snd_intel_sdw_acpi mt76x02_usb
snd_hda_codec asus_ec_sensors mt76_usb kvm vfat snd_hda_core fat
mt76x02_lib snd_hwdep eeepc_wmi mt76 snd_seq asus_wmi ledtrig_audio
snd_seq_device irqbypass sparse_keymap snd_pcm rapl platform_profile
wmi_bmof pcspkr snd_timer mac80211 k10temp snd i2c_piix4 soundcore
libarc4 acpi_cpufreq
[  133.033777]  cfg80211 hid_logitech_dj rfkill zram amdgpu
drm_ttm_helper ttm crct10dif_pclmul crc32_pclmul video crc32c_intel
polyval_clmulni iommu_v2 gpu_sched polyval_generic drm_buddy nvme
ucsi_ccg drm_display_helper typec_ucsi ghash_clmulni_intel ccp igb
sha512_ssse3 typec nvme_core sp5100_tco cec dca nvme_common wmi
ip6_tables ip_tables fuse
[  133.033832] ---[ end trace 0000000000000000 ]---

I bisected problematic commit and find this:
ffcb754584603adf7039d7972564fbf6febdc542 is the first bad commit
commit ffcb754584603adf7039d7972564fbf6febdc542
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Nov 9 08:37:17 2022 +0100

    dma-mapping: reject __GFP_COMP in dma_alloc_attrs

    DMA allocations can never be turned back into a page pointer, so
    requesting compound pages doesn't make sense and it can't even be
    supported at all by various backends.

    Reject __GFP_COMP with a warning in dma_alloc_attrs, and stop clearing
    the flag in the arm dma ops and dma-iommu.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

 arch/arm/mm/dma-mapping.c | 17 -----------------
 drivers/iommu/dma-iommu.c |  3 ---
 kernel/dma/mapping.c      |  8 ++++++++
 3 files changed, 8 insertions(+), 20 deletions(-)

Reverting this commit and rebuilding the kernel confirmed the
correctness of the find.

I hope my report helps fix the problem quickly.

Full kernel log is here: https://pastebin.com/5hsuhifY

-- 
Best Regards,
Mike Gavrilov.
