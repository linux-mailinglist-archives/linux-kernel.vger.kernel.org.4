Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC56547C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLVVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiLVVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:20:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8DE18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:20:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D292933C7F;
        Thu, 22 Dec 2022 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671744039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSuwWje+CAHOikdD4vSzFBYTIJtQeoueiV2B1HvJKLE=;
        b=oS/zclCLy5GyjQLAfTFjKaDy6bRO2UeTRhQUcBf7KuErLUzw6iv+FGO3xuY5ZROivMYqmm
        aTvZWvuWTnlApMuqEVOKsbGz6aCMNK/JbafgMFjkAsz3oownccg31woTgJR+U383n6Xa70
        IgBSuKdCxkHToatSV/fOeVCtuKymtQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671744039;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSuwWje+CAHOikdD4vSzFBYTIJtQeoueiV2B1HvJKLE=;
        b=HWwx6lrQ6XHzWT5pEvyGSpkzgK0At+IyLU1z0y+IM0Oc4KglUfFZrXAHxKWiZyTTjoePX7
        PnujBroijy5ADbAw==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAC282C141;
        Thu, 22 Dec 2022 21:20:39 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 9172060974; Thu, 22 Dec 2022 22:20:37 +0100 (CET)
Date:   Thu, 22 Dec 2022 22:20:37 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu refcount saturation
Message-ID: <20221222212037.bynlebvgt6ejehut@lion.mk-sys.cz>
References: <Y52tzASAKNAJEER3@zn.tnic>
 <0ac03934-27dc-e045-fece-5a4b4328de6c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ac03934-27dc-e045-fece-5a4b4328de6c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 09:23:05AM +0100, Christian König wrote:
> Am 17.12.22 um 12:53 schrieb Borislav Petkov:
> > Hi folks,
> > 
> > this is with Linus' tree from Wed:
> > 
> > 041fae9c105a ("Merge tag 'f2fs-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs")
> > 
> > on a CZ laptop:
> > 
> > [    7.782901] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4)
> > 
> > The splat is kinda messy:
> 
> Thanks for the notice, going to take a look today.
> 
> Regards,
> Christian.

In case it might help, I have similar crashes with 6.2 merge window
snapshots on a desktop machine with Radeon WX2100

    [   16.045850] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6995 0x1002:0x0B0C 0x00).

The behavior seems pretty deterministic so far, the system boots
cleanly, login into KDE is fine but then it crashes as soon as I start
firefox.

Unfortunately, just like Boris, I always seem to have multiple stack
traces tangled together.

Michal


Commit 77856d911a8c:
------------------------------------------------------------------------------
[  165.210008] ------------[ cut here ]------------
[  165.215427] refcount_t: underflow; use-after-free.
[  165.221026] WARNING: CPU: 14 PID: 1165 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[  165.230420] Modules linked in: echainiv esp4 af_packet tun 8021q garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG sm4_aesni_avx_x86_64 nf_log_syslog sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common camellia_generic xt_conntrack camellia_aesni_avx2 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic cast_common ipt_REJECT nf_reject_ipv4 vsock des_generic libdes sm3_generic rfkill xt_tcpudp sm3_avx_x86_64 sm3 xt_set vmw_vmci cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu
[  165.230464]  intel_rapl_msr uvcvideo videobuf2_vmalloc iommu_v2 videobuf2_memops drm_buddy i2c_dev videobuf2_v4l2 gpu_sched video intel_rapl_common snd_usb_audio videodev xfs drm_display_helper videobuf2_common snd_usbmidi_lib drm_ttm_helper ttm libcrc32c edac_mce_amd joydev mc irqbypass cec pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 tiny_power_button rc_core igb dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel xhci_pci polyval_clmulni xhci_pci_renesas polyval_generic gf128mul xhci_hcd ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd nvme cryptd usbcore ccp sr_mod sp5100_tco cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm snd_timer snd_rawmidi snd_seq_device snd soundcore sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[  165.339552] ------------[ cut here ]------------
[  165.339552] ------------[ cut here ]------------
[  165.339553] refcount_t: saturated; leaking memory.
[  165.339557] WARNING: CPU: 18 PID: 6237 at lib/refcount.c:19 refcount_warn_saturate+0x97/0x110
[  165.339562] Modules linked in: echainiv esp4 af_packet tun 8021q garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG sm4_aesni_avx_x86_64 nf_log_syslog sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common camellia_generic xt_conntrack camellia_aesni_avx2 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic cast_common ipt_REJECT nf_reject_ipv4 vsock des_generic libdes sm3_generic rfkill xt_tcpudp sm3_avx_x86_64 sm3 xt_set vmw_vmci cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu
[  165.339588]  intel_rapl_msr uvcvideo videobuf2_vmalloc iommu_v2 videobuf2_memops drm_buddy i2c_dev videobuf2_v4l2 gpu_sched video intel_rapl_common snd_usb_audio videodev xfs drm_display_helper videobuf2_common snd_usbmidi_lib drm_ttm_helper ttm libcrc32c edac_mce_amd joydev mc irqbypass cec pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 tiny_power_button rc_core igb dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel xhci_pci polyval_clmulni xhci_pci_renesas polyval_generic gf128mul xhci_hcd ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd nvme cryptd usbcore ccp sr_mod sp5100_tco cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm snd_timer snd_rawmidi snd_seq_device snd soundcore sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[  165.339613] CPU: 18 PID: 6237 Comm: Renderer Kdump: loaded Tainted: G           OE      6.1.0-1-g77856d911a8c-lp153.1.g31c4e7c-default #1 openSUSE Tumbleweed (unreleased) 0a5448e9051496e556e87d2b25245d24e80e3753
[  165.339616] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[  165.339617] RIP: 0010:refcount_warn_saturate+0x97/0x110
[  165.339619] Code: 01 01 e8 4e 86 61 00 0f 0b c3 cc cc cc cc 80 3d d9 75 6c 01 00 75 a8 48 c7 c7 68 6c 02 93 c6 05 c9 75 6c 01 01 e8 2b 86 61 00 <0f> 0b c3 cc cc cc cc 80 3d b3 75 6c 01 00 75 85 48 c7 c7 c0 6c 02
[  165.339620] RSP: 0018:ffffa66a028378e8 EFLAGS: 00010282
[  165.339621] RAX: 0000000000000000 RBX: ffffa66a02837960 RCX: ffff9001feea24c8
[  165.339622] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9001feea24c0
[  165.339622] RBP: ffff8ff3ef1890c0 R08: ffffffff93fd1ac0 R09: ffffa66a02837880
[  165.339623] R10: 0000000000000001 R11: 000000000000000d R12: 00000000ffffffff
[  165.339623] R13: ffff8ff3ef1890c0 R14: ffffa66a02837ae8 R15: 0000000000139800
[  165.339624] FS:  00007fa0e68eb700(0000) GS:ffff9001fee80000(0000) knlGS:0000000000000000
[  165.339625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  165.339625] CR2: 00007fa0b2a85000 CR3: 000000017f168000 CR4: 0000000000750ee0
[  165.339626] PKRU: 55555554
[  165.339627] Call Trace:
[  165.339628]  <TASK>
[  165.339628]  dma_resv_iter_walk_unlocked.part.0+0x14a/0x180
[  165.339633]  dma_resv_iter_first_unlocked+0x25/0x70
[  165.339635]  amdgpu_vm_sdma_update+0x63/0x360 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.339810]  amdgpu_vm_ptes_update+0x2a6/0x7e0 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.339936]  amdgpu_vm_update_range+0x21b/0x750 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340059]  amdgpu_vm_bo_update+0x287/0x570 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340181]  amdgpu_gem_va_ioctl+0x4e9/0x510 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340302]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340421]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340540]  drm_ioctl_kernel+0xb4/0x140
[  165.340543]  drm_ioctl+0x1e5/0x450
[  165.340545]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340664]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.340780]  __x64_sys_ioctl+0x8b/0xc0
[  165.340784]  do_syscall_64+0x5c/0x90
[  165.340787]  ? __x64_sys_futex+0x81/0x1c0
[  165.340790]  ? do_user_addr_fault+0x1db/0x6a0
[  165.340793]  ? exit_to_user_mode_prepare+0x190/0x1f0
[  165.340794]  ? syscall_exit_to_user_mode+0x17/0x40
[  165.340797]  ? do_syscall_64+0x69/0x90
[  165.340798]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  165.340800] RIP: 0033:0x7fa0eb30cc27
[  165.340801] Code: 90 90 90 48 8b 05 69 c2 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 c2 2d 00 f7 d8 64 89 01 48
[  165.340802] RSP: 002b:00007fa0e68e8208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  165.340803] RAX: ffffffffffffffda RBX: 00007fa065e4fac0 RCX: 00007fa0eb30cc27
[  165.340803] RDX: 00007fa0e68e8250 RSI: 00000000c0286448 RDI: 0000000000000008
[  165.340804] RBP: 00007fa0e68e8250 R08: 0000000139200000 R09: 000000000000000e
[  165.340804] R10: 000000000000009d R11: 0000000000000246 R12: 00000000c0286448
[  165.340805] R13: 0000000000000008 R14: 0000000001010000 R15: 00007fa0ebd95100
[  165.340806]  </TASK>
[  165.340806] ---[ end trace 0000000000000000 ]---
[  165.340815] ------------[ cut here ]------------
[  165.340815] refcount_t: saturated; leaking memory.
[  165.340818] WARNING: CPU: 18 PID: 6237 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
[  165.340822] Modules linked in: echainiv esp4 af_packet tun 8021q garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG sm4_aesni_avx_x86_64 nf_log_syslog sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common camellia_generic xt_conntrack camellia_aesni_avx2 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic cast_common ipt_REJECT nf_reject_ipv4 vsock des_generic libdes sm3_generic rfkill xt_tcpudp sm3_avx_x86_64 sm3 xt_set vmw_vmci cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu
[  165.340844]  intel_rapl_msr uvcvideo videobuf2_vmalloc iommu_v2 videobuf2_memops drm_buddy i2c_dev videobuf2_v4l2 gpu_sched video intel_rapl_common snd_usb_audio videodev xfs drm_display_helper videobuf2_common snd_usbmidi_lib drm_ttm_helper ttm libcrc32c edac_mce_amd joydev mc irqbypass cec pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 tiny_power_button rc_core igb dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel xhci_pci polyval_clmulni xhci_pci_renesas polyval_generic gf128mul xhci_hcd ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd nvme cryptd usbcore ccp sr_mod sp5100_tco cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm snd_timer snd_rawmidi snd_seq_device snd soundcore sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[  165.340867] CPU: 18 PID: 6237 Comm: Renderer Kdump: loaded Tainted: G        W  OE      6.1.0-1-g77856d911a8c-lp153.1.g31c4e7c-default #1 openSUSE Tumbleweed (unreleased) 0a5448e9051496e556e87d2b25245d24e80e3753
[  165.340868] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[  165.340869] RIP: 0010:refcount_warn_saturate+0x51/0x110
[  165.340870] Code: 84 bc 00 00 00 c3 cc cc cc cc 85 f6 74 46 80 3d 1e 76 6c 01 00 75 ee 48 c7 c7 68 6c 02 93 c6 05 0e 76 6c 01 01 e8 71 86 61 00 <0f> 0b c3 cc cc cc cc 80 3d fa 75 6c 01 00 75 cb 48 c7 c7 90 6c 02
[  165.340871] RSP: 0018:ffffa66a02837788 EFLAGS: 00010282
[  165.340872] RAX: 0000000000000000 RBX: ffff8ff3ef1890c0 RCX: ffff9001feea24c8
[  165.340873] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9001feea24c0
[  165.340873] RBP: ffff8ff35d95a458 R08: ffffffff93fd1ac0 R09: ffffa66a02837720
[  165.340874] R10: 0000000000000001 R11: 0000000000001000 R12: 0000000000000000
[  165.340874] R13: ffff8ff3ef1890f8 R14: ffff8ff30fe25f20 R15: ffff8ff30fe25f00
[  165.340875] FS:  00007fa0e68eb700(0000) GS:ffff9001fee80000(0000) knlGS:0000000000000000
[  165.340876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  165.340876] CR2: 00007fa0b2a85000 CR3: 000000017f168000 CR4: 0000000000750ee0
[  165.340877] PKRU: 55555554
[  165.340877] Call Trace:
[  165.340878]  <TASK>
[  165.340878]  ttm_bo_add_move_fence.constprop.0+0x148/0x160 [ttm fcae6956db0c19a17837d67fe868f42f3841f057]
[  165.340884]  ttm_bo_mem_space+0xb0/0x230 [ttm fcae6956db0c19a17837d67fe868f42f3841f057]
[  165.340888]  ttm_bo_validate+0xa0/0x140 [ttm fcae6956db0c19a17837d67fe868f42f3841f057]
[  165.340892]  ? ttm_bo_validate+0x5/0x140 [ttm fcae6956db0c19a17837d67fe868f42f3841f057]
[  165.340896]  ttm_bo_init_reserved+0xdc/0x1a0 [ttm fcae6956db0c19a17837d67fe868f42f3841f057]
[  165.340900]  amdgpu_bo_create+0x192/0x450 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341019]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341137]  ? amdgpu_bo_gpu_offset_no_check+0x26/0x50 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341255]  amdgpu_bo_create_vm+0x2e/0x80 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341373]  amdgpu_vm_pt_create+0xf5/0x260 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341495]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341613]  amdgpu_vm_ptes_update+0x504/0x7e0 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341735]  amdgpu_vm_update_range+0x21b/0x750 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341856]  amdgpu_vm_bo_update+0x287/0x570 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.341976]  amdgpu_gem_va_ioctl+0x4e9/0x510 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.342103]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.342221]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.342340]  drm_ioctl_kernel+0xb4/0x140
[  165.342342]  drm_ioctl+0x1e5/0x450
[  165.342343]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.342462]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.342576]  __x64_sys_ioctl+0x8b/0xc0
[  165.342578]  do_syscall_64+0x5c/0x90
[  165.342579]  ? __x64_sys_futex+0x81/0x1c0
[  165.342581]  ? do_user_addr_fault+0x1db/0x6a0
[  165.342583]  ? exit_to_user_mode_prepare+0x190/0x1f0
[  165.342584]  ? syscall_exit_to_user_mode+0x17/0x40
[  165.342585]  ? do_syscall_64+0x69/0x90
[  165.342586]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  165.342588] RIP: 0033:0x7fa0eb30cc27
[  165.342589] Code: 90 90 90 48 8b 05 69 c2 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 c2 2d 00 f7 d8 64 89 01 48
[  165.342589] RSP: 002b:00007fa0e68e8208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  165.342590] RAX: ffffffffffffffda RBX: 00007fa065e4fac0 RCX: 00007fa0eb30cc27
[  165.342591] RDX: 00007fa0e68e8250 RSI: 00000000c0286448 RDI: 0000000000000008
[  165.342591] RBP: 00007fa0e68e8250 R08: 0000000139200000 R09: 000000000000000e
[  165.342592] R10: 000000000000009d R11: 0000000000000246 R12: 00000000c0286448
[  165.342592] R13: 0000000000000008 R14: 0000000001010000 R15: 00007fa0ebd95100
[  165.342594]  </TASK>
[  165.342594] ---[ end trace 0000000000000000 ]---
[  165.399457] CPU: 14 PID: 1165 Comm: sdma0 Kdump: loaded Tainted: G        W  OE      6.1.0-1-g77856d911a8c-lp153.1.g31c4e7c-default #1 openSUSE Tumbleweed (unreleased) 0a5448e9051496e556e87d2b25245d24e80e3753
[  165.404860] refcount_t: addition on 0; use-after-free.
[  165.404864] WARNING: CPU: 0 PID: 2397 at lib/refcount.c:25 refcount_warn_saturate+0x74/0x110
[  165.410175] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[  165.410176] RIP: 0010:refcount_warn_saturate+0xba/0x110
[  165.415825] Modules linked in: echainiv esp4
[  165.425112] Code: 01 01 e8 2b 86 61 00 0f 0b c3 cc cc cc cc 80 3d b3 75 6c 01 00 75 85 48 c7 c7 c0 6c 02 93 c6 05 a3 75 6c 01 01 e8 08 86 61 00 <0f> 0b c3 cc cc cc cc 80 3d 8e 75 6c 01 00 0f 85 5e ff ff ff 48 c7
[  165.425114] RSP: 0018:ffffa66a010bbe68 EFLAGS: 00010286
[  165.513048]  af_packet tun 8021q
[  165.594093] 
[  165.594094] RAX: 0000000000000000 RBX: ffff8ff38e79be78 RCX: 0000000000000000
[  165.594095] RDX: ffff9001fedaf168 RSI: ffff9001feda24c0 RDI: ffff9001feda24c0
[  165.613896]  garp mrp stp llc
[  165.624950] RBP: ffff8ff30fe25e28 R08: 0000000000000000 R09: 00000000fffeffff
[  165.624951] R10: ffffa66a010bbd20 R11: ffff9001fe7fffe8 R12: ffff8ff3ef15adc0
[  165.624951] R13: ffff8ff38e79be00 R14: ffff8ff30fe2cab8 R15: ffff8ff38e79a800
[  165.630971]  iscsi_ibft iscsi_boot_sysfs xt_REDIRECT
[  165.650763] FS:  0000000000000000(0000) GS:ffff9001fed80000(0000) knlGS:0000000000000000
[  165.650764] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  165.656782]  xt_MASQUERADE xt_nat iptable_nat
[  165.664746] CR2: 00007fa064012008 CR3: 0000000610610000 CR4: 0000000000750ee0
[  165.664747] PKRU: 55555554
[  165.672621]  nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64
[  165.680654] Call Trace:
[  165.680656]  <TASK>
[  165.688616]  xt_LOG sm4_aesni_avx_x86_64 nf_log_syslog
[  165.696582]  drm_sched_entity_pop_job+0x1b7/0x430 [gpu_sched 49a78bc0ca14ba43b21b85e650a83354884c8272]
[  165.705515]  sm4 twofish_generic twofish_avx_x86_64
[  165.712067]  drm_sched_main+0xcd/0x400 [gpu_sched 49a78bc0ca14ba43b21b85e650a83354884c8272]
[  165.720030]  twofish_x86_64_3way twofish_x86_64 twofish_common camellia_generic
[  165.723402]  ? __pfx_autoremove_wake_function+0x10/0x10
[  165.726668]  xt_conntrack camellia_aesni_avx2
[  165.729510]  ? __pfx_drm_sched_main+0x10/0x10 [gpu_sched 49a78bc0ca14ba43b21b85e650a83354884c8272]
[  165.735885]  nf_conntrack nf_defrag_ipv6
[  165.741553]  kthread+0xd8/0x100
[  165.751105]  nf_defrag_ipv4 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2
[  165.760657]  ? __pfx_kthread+0x10/0x10
[  165.760658]  ret_from_fork+0x2c/0x50
[  165.770457]  serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic
[  165.779833]  </TASK>
[  165.779834] ---[ end trace 0000000000000000 ]---
[  165.789370]  blowfish_x86_64
[  165.805263] BUG: unable to handle page fault for address: ffffffffc0d1d5b0
[  165.809709]  vmnet(OE)
[  165.814401] #PF: supervisor write access in kernel mode
[  165.814402] #PF: error_code(0x0003) - permissions violation
[  165.814403] PGD 610615067 P4D 610615067 PUD 610617067 
[  165.818569]  blowfish_common
[  165.828559] PMD 10b3cb067 PTE 10fad5161
[  165.828560] Oops: 0003 [#1] PREEMPT SMP NOPTI
[  165.828562] CPU: 15 PID: 0 Comm: swapper/15 Kdump: loaded Tainted: G        W  OE      6.1.0-1-g77856d911a8c-lp153.1.g31c4e7c-default #1 openSUSE Tumbleweed (unreleased) 0a5448e9051496e556e87d2b25245d24e80e3753
[  165.837584]  ppdev
[  165.842100] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[  165.842101] RIP: 0010:dma_fence_signal_timestamp_locked+0x45/0x100
[  165.846356]  parport_pc
[  165.851213] Code: 31 c0 f0 48 0f ba 6f 30 00 0f 82 c6 00 00 00 48 8b 47 10 49 89 e4 48 89 fd 4c 89 60 08 48 89 04 24 48 8b 47 18 48 89 44 24 08 <4c> 89 20 48 89 77 10 f0 80 4f 30 02 66 90 48 8b 34 24 48 8b 1e 48
[  165.851214] RSP: 0018:ffffa66a00584d78 EFLAGS: 00010046
[  165.851215] RAX: ffffffffc0d1d5b0 RBX: ffff8ff3ef1890c0 RCX: 0000000000000017
[  165.856351]  parport
[  165.862102] RDX: 0000000000bcc8f2 RSI: 0000002686959ae3 RDI: ffff8ff3ef1890c0
[  165.862103] RBP: ffff8ff3ef1890c0 R08: 0000000000000000 R09: ffffffffffffffff
[  165.862104] R10: 0000000000000000 R11: ffffa66a00584ff8 R12: ffffa66a00584d78
[  165.867682]  cast5_avx_x86_64
[  165.872196] R13: 0000000000000001 R14: ffff8ff30fe20000 R15: 00000000ffffffff
[  165.872197] FS:  0000000000000000(0000) GS:ffff9001fedc0000(0000) knlGS:0000000000000000
[  165.872198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  165.872198] CR2: ffffffffc0d1d5b0 CR3: 0000000610610000 CR4: 0000000000750ee0
[  165.878040]  vmw_vsock_vmci_transport
[  165.882379] PKRU: 55555554
[  165.882379] Call Trace:
[  165.882380]  <IRQ>
[  165.882382]  ? __pfx_drm_sched_fence_free_rcu+0x10/0x10 [gpu_sched 49a78bc0ca14ba43b21b85e650a83354884c8272]
[  165.902085]  cast5_generic
[  165.910561]  dma_fence_signal+0x2c/0x50
[  165.910563]  drm_sched_job_done.isra.0+0x5d/0x130 [gpu_sched 49a78bc0ca14ba43b21b85e650a83354884c8272]
[  165.918524]  cast_common
[  165.926485]  dma_fence_signal_timestamp_locked+0x7a/0x100
[  165.926486]  dma_fence_signal+0x2c/0x50
[  165.934447]  ipt_REJECT
[  165.942408]  amdgpu_fence_process+0xce/0x140 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.950370]  nf_reject_ipv4
[  165.953301]  sdma_v3_0_process_trap_irq+0x64/0x90 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.958614]  vsock
[  165.964085]  amdgpu_irq_dispatch+0x106/0x230 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  165.969664]  des_generic
[  165.979037]  amdgpu_ih_process+0x66/0x100 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  166.066990]  libdes
[  166.147963]  amdgpu_irq_handler+0x1f/0x60 [amdgpu a70a7113837b00a71a821b24709a752a95bf48d2]
[  166.167669]  sm3_generic
[  166.178794]  __handle_irq_event_percpu+0x46/0x190
[  166.184816]  rfkill
[  166.204608]  handle_irq_event+0x34/0x70
[  166.204610]  handle_edge_irq+0x87/0x220
[  166.210632]  xt_tcpudp
[  166.218592]  __common_interrupt+0x3e/0xa0
[  166.218595]  common_interrupt+0x7b/0xa0
[  166.226557]  sm3_avx_x86_64
[  166.234518]  </IRQ>
[  166.234518]  <TASK>
[  166.234518]  asm_common_interrupt+0x22/0x40
[  166.242393]  sm3
[  166.250425] RIP: 0010:cpuidle_enter_state+0xd8/0x410
[  166.250428] Code: 00 00 31 ff e8 a9 e4 7b ff 45 84 ff 74 16 9c 58 0f 1f 40 00 f6 c4 02 0f 85 18 03 00 00 31 ff e8 4e 81 83 ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  166.259362]  xt_set
[  166.265911] RSP: 0018:ffffa66a001efe90 EFLAGS: 00000246
[  166.265912] RAX: ffff9001fedf3fc0 RBX: 0000000000000001 RCX: 000000000000001f
[  166.265913] RDX: 0000000000000000 RSI: 0000000022983930 RDI: 0000000000000000
[  166.265914] RBP: ffff8ff3067a6800 R08: 000000269ac37f1f R09: 0000000000000008
[  166.273875]  vmw_vmci
[  166.277332] R10: 0000000000000006 R11: 0000000000000001 R12: ffffffff9362ad80
[  166.277333] R13: 000000269ac37f1f R14: 0000000000000001 R15: 0000000000000000
[  166.277334]  cpuidle_enter+0x29/0x40
[  166.280531]  cmac
[  166.283370]  do_idle+0x1fc/0x2a0
[  166.283372]  cpu_startup_entry+0x19/0x20
[  166.293807]  xcbc
[  166.302649]  start_secondary+0x114/0x140
[  166.302652]  secondary_startup_64_no_verify+0xe5/0xeb
[  166.311408]  iptable_filter
[  166.320250]  </TASK>
[  166.320250] Modules linked in: echainiv esp4 af_packet tun 8021q
[  166.329448]  vmmon(OE)
[  166.338644]  garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG sm4_aesni_avx_x86_64 nf_log_syslog sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common camellia_generic xt_conntrack camellia_aesni_avx2 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic cast_common ipt_REJECT nf_reject_ipv4 vsock des_generic libdes sm3_generic rfkill xt_tcpudp sm3_avx_x86_64 sm3 xt_set vmw_vmci cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu intel_rapl_msr uvcvideo videobuf2_vmalloc iommu_v2
[  166.338664]  videobuf2_memops drm_buddy i2c_dev videobuf2_v4l2 gpu_sched video intel_rapl_common snd_usb_audio videodev xfs drm_display_helper videobuf2_common snd_usbmidi_lib drm_ttm_helper ttm libcrc32c edac_mce_amd joydev mc irqbypass cec pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 tiny_power_button rc_core igb dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel xhci_pci polyval_clmulni xhci_pci_renesas polyval_generic gf128mul xhci_hcd ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd nvme cryptd usbcore ccp sr_mod sp5100_tco cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm snd_timer snd_rawmidi snd_seq_device snd soundcore sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[  166.338688] CR2: ffffffffc0d1d5b0
------------------------------------------------------------------------------


Commit b6bb9676f216:
------------------------------------------------------------------------------
[   87.503013] ------------[ cut here ]------------
[   87.508432] refcount_t: addition on 0; use-after-free.
[   87.514384] WARNING: CPU: 3 PID: 5171 at lib/refcount.c:25 refcount_warn_saturate+0x74/0x110
[   87.523723] Modules linked in: 8021q garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG nf_log_syslog sm4_aesni_avx_x86_64 sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 xt_conntrack twofish_common nf_conntrack camellia_generic nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport ipt_REJECT cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic nf_reject_ipv4 cast_common vsock des_generic rfkill libdes xt_tcpudp vmw_vmci sm3_generic xt_set sm3_avx_x86_64 sm3 cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu uvcvideo iommu_v2
[   87.523777]  videobuf2_vmalloc
[   87.532990] ------------[ cut here ]------------
[   87.610862]  drm_buddy
[   87.614674] refcount_t: saturated; leaking memory.
[   87.614679] WARNING: CPU: 20 PID: 1152 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
[   87.620087]  videobuf2_memops gpu_sched
[   87.623194] Modules linked in: 8021q garp mrp stp llc
[   87.628777]  videobuf2_v4l2 video
[   87.638150]  iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64
[   87.642674]  videodev
[   87.648587]  xt_LOG nf_log_syslog sm4_aesni_avx_x86_64 sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 xt_conntrack twofish_common
[   87.652678]  intel_rapl_msr
[   87.665662]  nf_conntrack camellia_generic nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport ipt_REJECT cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic nf_reject_ipv4 cast_common vsock des_generic rfkill libdes xt_tcpudp vmw_vmci sm3_generic xt_set sm3_avx_x86_64 sm3 cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu uvcvideo iommu_v2 videobuf2_vmalloc drm_buddy videobuf2_memops gpu_sched videobuf2_v4l2 video
[   87.668700]  snd_usb_audio
[   87.683636]  videodev intel_rapl_msr snd_usb_audio i2c_dev intel_rapl_common drm_display_helper snd_usbmidi_lib videobuf2_common xfs drm_ttm_helper libcrc32c tiny_power_button
[   87.687191]  i2c_dev
[   87.753864]  edac_mce_amd mc joydev irqbypass ttm pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 cec igb rc_core dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel xhci_pci xhci_pci_renesas sha512_ssse3 xhci_hcd aesni_intel crypto_simd cryptd ccp usbcore nvme sp5100_tco
[   87.757349]  intel_rapl_common
[   87.773955]  sr_mod cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm
[   87.776898]  drm_display_helper
[   87.817003]  snd_timer
[   87.820815]  snd_usbmidi_lib videobuf2_common
[   87.831337]  snd_rawmidi snd_seq_device snd soundcore sg dm_multipath
[   87.835241]  xfs
[   87.838348]  dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[   87.838351] CPU: 20 PID: 1152 Comm: sdma0 Kdump: loaded Tainted: G           OE      6.1.0-2-gb6bb9676f216-lp153.1.g2c89d56-default #1 openSUSE Tumbleweed (unreleased) c1e72e89c7d509c25789f27966fb394c07b2a770
[   87.838353] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[   87.838355] RIP: 0010:refcount_warn_saturate+0x51/0x110
[   87.838357] Code: 84 bc 00 00 00 c3 cc cc cc cc 85 f6 74 46 80 3d be 76 6c 01 00 75 ee 48 c7 c7 20 87 42 b3 c6 05 ae 76 6c 01 01 e8 b3 56 64 00 <0f> 0b c3 cc cc cc cc 80 3d 9a 76 6c 01 00 75 cb 48 c7 c7 48 87 42
[   87.838359] RSP: 0018:ffffb65c01113e68 EFLAGS: 00010286
[   87.838360] RAX: 0000000000000000 RBX: ffff98f20cc43780 RCX: ffff98fffef224c8
[   87.838360] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff98fffef224c0
[   87.838361] RBP: ffff98f103425e28 R08: ffffffffb43d6ac0 R09: ffffb65c01113e00
[   87.843499]  drm_ttm_helper
[   87.850755] R10: 0000000000000001 R11: 0000000037313554 R12: 0000000000000000
[   87.850756] R13: ffff98f13d4b0e00 R14: ffff98f10342cab8 R15: ffff98f13d4b1200
[   87.850757] FS:  0000000000000000(0000) GS:ffff98fffef00000(0000) knlGS:0000000000000000
[   87.850758] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.850759] CR2: 00007f19ad8b24f8 CR3: 000000016e260000 CR4: 0000000000750ee0
[   87.853250]  libcrc32c
[   87.859518] PKRU: 55555554
[   87.859519] Call Trace:
[   87.859520]  <TASK>
[   87.859522]  drm_sched_entity_pop_job+0x3b3/0x430 [gpu_sched 6d68b5979a6bfbb06286516e2330a5b15acb01f1]
[   87.859529]  drm_sched_main+0xcd/0x400 [gpu_sched 6d68b5979a6bfbb06286516e2330a5b15acb01f1]
[   87.879076]  tiny_power_button
[   87.890126]  ? __pfx_autoremove_wake_function+0x10/0x10
[   87.896147]  edac_mce_amd mc
[   87.915872]  ? __pfx_drm_sched_main+0x10/0x10 [gpu_sched 6d68b5979a6bfbb06286516e2330a5b15acb01f1]
[   87.921956]  joydev irqbypass ttm pcspkr
[   87.929842]  kthread+0xd8/0x100
[   87.937870]  wmi_bmof gigabyte_wmi k10temp i2c_piix4 cec igb rc_core dca thermal button
[   87.945836]  ? __pfx_kthread+0x10/0x10
[   87.945838]  ret_from_fork+0x2c/0x50
[   87.945841]  </TASK>
[   87.945842] ---[ end trace 0000000000000000 ]---
[   87.945847] ------------[ cut here ]------------
[   87.945848] refcount_t: underflow; use-after-free.
[   87.945851] WARNING: CPU: 20 PID: 1152 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[   87.945869] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   87.945870] #PF: supervisor write access in kernel mode
[   87.945871] #PF: error_code(0x0002) - not-present page
[   87.945872] PGD 0 P4D 0 
[   87.945874] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   87.945875] CPU: 15 PID: 0 Comm: swapper/15 Kdump: loaded Tainted: G        W  OE      6.1.0-2-gb6bb9676f216-lp153.1.g2c89d56-default #1 openSUSE Tumbleweed (unreleased) c1e72e89c7d509c25789f27966fb394c07b2a770
[   87.945878] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37d 07/27/2022
[   87.945879] RIP: 0010:dma_fence_signal_timestamp_locked+0x34/0x100
[   87.945882] Code: 83 ec 18 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 f0 48 0f ba 6f 30 00 0f 82 c6 00 00 00 48 8b 47 10 49 89 e4 48 89 fd <4c> 89 60 08 48 89 04 24 48 8b 47 18 48 89 44 24 08 4c 89 20 48 89
[   87.945884] RSP: 0018:ffffb65c00584d78 EFLAGS: 00010046
[   87.945885] RAX: 0000000000000000 RBX: ffff98f20cc43780 RCX: 0000000000000017
[   87.945886] RDX: 0000000000fe7af8 RSI: 00000014661fbce8 RDI: ffff98f20cc43780
[   87.945887] RBP: ffff98f20cc43780 R08: 00000000000000e0 R09: 00000000000000e0
[   87.945887] R10: 0000000000000000 R11: ffffb65c00584ff8 R12: ffffb65c00584d78
[   87.945888] R13: 0000000000000002 R14: ffff98f103420000 R15: 00000000ffffffff
[   87.945889] FS:  0000000000000000(0000) GS:ffff98fffedc0000(0000) knlGS:0000000000000000
[   87.945890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.945891] CR2: 0000000000000008 CR3: 0000000133274000 CR4: 0000000000750ee0
[   87.945892] PKRU: 55555554
[   87.945892] Call Trace:
[   87.945894]  <IRQ>
[   87.945895]  ? __pfx_read_tsc+0x10/0x10
[   87.945898]  dma_fence_signal+0x2c/0x50
[   87.945902]  drm_sched_job_done.isra.0+0x5d/0x130 [gpu_sched 6d68b5979a6bfbb06286516e2330a5b15acb01f1]
[   87.945908]  dma_fence_signal_timestamp_locked+0x7a/0x100
[   87.945909]  dma_fence_signal+0x2c/0x50
[   87.945911]  amdgpu_fence_process+0xce/0x140 [amdgpu 8c17887efba5d4ec504ba4125e259aa15c52f60d]
[   87.946145]  sdma_v3_0_process_trap_irq+0x64/0x90 [amdgpu 8c17887efba5d4ec504ba4125e259aa15c52f60d]
[   87.946387]  amdgpu_irq_dispatch+0x106/0x230 [amdgpu 8c17887efba5d4ec504ba4125e259aa15c52f60d]
[   87.946620]  amdgpu_ih_process+0x66/0x100 [amdgpu 8c17887efba5d4ec504ba4125e259aa15c52f60d]
[   87.946849]  amdgpu_irq_handler+0x1f/0x60 [amdgpu 8c17887efba5d4ec504ba4125e259aa15c52f60d]
[   87.947077]  __handle_irq_event_percpu+0x46/0x190
[   87.947081]  handle_irq_event+0x34/0x70
[   87.947083]  handle_edge_irq+0x87/0x220
[   87.947085]  __common_interrupt+0x3e/0xa0
[   87.947088]  common_interrupt+0x7b/0xa0
[   87.947091]  </IRQ>
[   87.947092]  <TASK>
[   87.947092]  asm_common_interrupt+0x22/0x40
[   87.947094] RIP: 0010:cpuidle_enter_state+0xd8/0x410
[   87.947097] Code: 00 00 31 ff e8 e9 15 79 ff 45 84 ff 74 16 9c 58 0f 1f 40 00 f6 c4 02 0f 85 18 03 00 00 31 ff e8 7e b2 80 ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[   87.947099] RSP: 0018:ffffb65c001efe90 EFLAGS: 00000246
[   87.947100] RAX: ffff98fffedf3fc0 RBX: 0000000000000002 RCX: 000000000000001f
[   87.947101] RDX: 0000000000000000 RSI: 00000000229839cd RDI: 0000000000000000
[   87.947101] RBP: ffff98f101e78800 R08: 0000001479fb6ed2 R09: 0000000000000018
[   87.947102] R10: 00000000000009a0 R11: 00000000000005f6 R12: ffffffffb3a2ad80
[   87.947103] R13: 0000001479fb6ed2 R14: 0000000000000002 R15: 0000000000000000
[   87.947105]  cpuidle_enter+0x29/0x40
[   87.947106]  do_idle+0x1fc/0x2a0
[   87.947109]  cpu_startup_entry+0x19/0x20
[   87.947110]  start_secondary+0x114/0x140
[   87.947112]  secondary_startup_64_no_verify+0xe5/0xeb
[   87.947116]  </TASK>
[   87.947116] Modules linked in: 8021q garp mrp stp llc iscsi_ibft iscsi_boot_sysfs xt_REDIRECT xt_MASQUERADE xt_nat iptable_nat nf_nat deflate sm4_generic sm4_aesni_avx2_x86_64 xt_LOG nf_log_syslog sm4_aesni_avx_x86_64 sm4 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 xt_conntrack twofish_common nf_conntrack camellia_generic nf_defrag_ipv6 nf_defrag_ipv4 camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 vmnet(OE) blowfish_common ppdev parport_pc parport ipt_REJECT cast5_avx_x86_64 vmw_vsock_vmci_transport cast5_generic nf_reject_ipv4 cast_common vsock des_generic rfkill libdes xt_tcpudp vmw_vmci sm3_generic xt_set sm3_avx_x86_64 sm3 cmac xcbc iptable_filter vmmon(OE) rmd160 bpfilter dmi_sysfs ip_set_hash_ip af_key ip_set xfrm_algo nfnetlink msr hwmon_vid dm_crypt essiv authenc trusted asn1_encoder tee amdgpu uvcvideo iommu_v2
[   87.947148]  videobuf2_vmalloc drm_buddy videobuf2_memops gpu_sched videobuf2_v4l2 video videodev intel_rapl_msr snd_usb_audio i2c_dev intel_rapl_common drm_display_helper snd_usbmidi_lib videobuf2_common xfs drm_ttm_helper libcrc32c tiny_power_button edac_mce_amd mc joydev irqbypass ttm pcspkr wmi_bmof gigabyte_wmi k10temp i2c_piix4 cec igb rc_core dca thermal button acpi_cpufreq fuse configfs ip_tables x_tables ext4 mbcache jbd2 hid_generic uas usb_storage usbhid crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel xhci_pci xhci_pci_renesas sha512_ssse3 xhci_hcd aesni_intel crypto_simd cryptd ccp usbcore nvme sp5100_tco sr_mod cdrom nvme_core wmi snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_pcm snd_timer snd_rawmidi snd_seq_device snd soundcore sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[   87.947180] CR2: 0000000000000008
------------------------------------------------------------------------------
