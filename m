Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00832626BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiKLVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:11:33 -0500
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 13:11:30 PST
Received: from mta-out1.inet.fi (mta-out1.inet.fi [62.71.2.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E5A101E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:11:30 -0800 (PST)
Received: from johanna3.inet.fi (unknown [10.16.62.35])
        by em201-smtpout82.rokki.sonera.fi (Postfix) with ESMTP id E6CA2538D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:03:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inet.fi;
        s=smtpgw-3485-2022-03-15; t=1668286991;
        bh=4jagjcZDvr+YlNL8Gp9xiYD4SpSxb178EDJezChee/M=;
        h=Date:To:From:Subject:From;
        b=jkz5ARMWrzqGG9Y50U1urU1QfWL5B4KAkI0k6/6NskeN+c96EBeYBWDxqCbk1KKqp
         bDh+yLTN2SigcS5UOs9AeU3vODX+8SKozppm8r4P6chi1ZUvGiVyjiNJVxJJgscNME
         EcgvEqDMFdqzQ/pQxxCsEq7abCLhh+aipauoVgxQ=
Received: from [192.168.1.82] (84.251.203.111) by johanna3.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 63468112027E86BB for linux-kernel@vger.kernel.org; Sat, 12 Nov 2022 23:03:10 +0200
Message-ID: <616b754a-deb2-c80d-cbb4-7f0172b90f3a@pp.inet.fi>
Date:   Sat, 12 Nov 2022 23:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: AMD GPU splat and network error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's two problems that have started appearing with 6.0. They might be 
unrelated.


1) There is a repeating warning from AMD GPU in logs (see below).

Visually I don't see this causing other problems but in case this is 
related to the second issue..


2) Network connections start silently failing after the computer has 
been on for a while.

DNS requests start failing, downloads slow to a trickle and so on. 
Restarting the network hardware does not

solve this, only rebooting the affected computer helps.


Is there commonality that might cause both? Or are they two entirely 
separate things? It is a discrete graphics card

while the Ethernet controller is integrated on the motherboard so I 
don't see them being related on that level.


Hardware:

NIC: 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network 
Connection (rev 03)
GPU: 09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)


[  147.235047] ------------[ cut here ]------------
[  147.235051] WARNING: CPU: 6 PID: 2559 at 
drivers/gpu/drm/drm_modeset_lock.c:276 drm_modeset_drop_locks+0x4b/0x60
[  147.235058] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) 
snd_seq(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E) vfat(E) fat(E) 
amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E) iosf_mbi(E) 
gpu_sched(E) drm_buddy(E) edac_mce_amd(E) snd_usb_audio(E) kvm_amd(E) 
drm_display_helper(E) kvm(E) cec(E) snd_usbmidi_lib(E) 
snd_hda_codec_hdmi(E) snd_hda_codec_realtek(E) drm_ttm_helper(E) 
snd_hda_codec_generic(E) ledtrig_audio(E) ttm(E) snd_hda_intel(E) 
snd_intel_dspcfg(E) snd_rawmidi(E) snd_hda_codec(E) drm_kms_helper(E) 
snd_seq_device(E) irqbypass(E) hid_sony(E) evdev(E) snd_hda_core(E) 
mc(E) syscopyarea(E) crct10dif_pclmul(E) snd_hwdep(E) ff_memless(E) 
sysfillrect(E) input_leds(E) sysimgblt(E) snd_pcm(E) joydev(E) ccp(E) 
crc32_pclmul(E) snd_timer(E) fb_sys_fops(E) snd(E) 
ghash_clmulni_intel(E) aesni_intel(E) rng_core(E) k10temp(E) 
crypto_simd(E) soundcore(E) sg(E) wmi_bmof(E) cryptd(E) 
tiny_power_button(E) button(E) acpi_cpufreq(E) rapl(E) nfsd(E) 
auth_rpcgss(E) nfs_acl(E)
[  147.235088]  lockd(E) grace(E) sunrpc(E) msr(E) fuse(E) configfs(E) 
efi_pstore(E) dmi_sysfs(E) ip_tables(E) x_tables(E) ipv6(E) autofs4(E) 
efivarfs(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) 
async_pq(E) async_xor(E) xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) 
raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) hid_generic(E) 
usbhid(E) hid(E) xhci_pci(E) crc32c_intel(E) xhci_hcd(E) sd_mod(E) 
i2c_piix4(E) t10_pi(E) usbcore(E) igb(E) crc64_rocksoft(E) crc64(E) 
usb_common(E) dca(E) wmi(E) thermal(E)
[  147.235111] CPU: 6 PID: 2559 Comm: kwin_wayland Tainted: G            
E      6.0.8-stable #111
[  147.235114] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
[  147.235116] RIP: 0010:drm_modeset_drop_locks+0x4b/0x60
[  147.235118] Code: 8b 50 08 48 8d b8 60 ff ff ff 48 89 51 08 48 89 0a 
48 89 00 48 89 40 08 e8 c2 08 29 00 48 8b 43 70 48 39 c5 75 d2 5b 5d c3 
cc <0f> 0b 8b 7f 68 e8 db fa ff ff eb b5 66 0f 1f 84 00 00 00 00 00 53
[  147.235120] RSP: 0018:ffffc90003327c70 EFLAGS: 00010282
[  147.235122] RAX: ffff888197fb3b01 RBX: ffffc90003327ce8 RCX: 
0000000000012406
[  147.235123] RDX: 0000000000012386 RSI: 00000000000000c0 RDI: 
ffffc90003327ce8
[  147.235124] RBP: 0000000000000000 R08: ffff8881097e8d50 R09: 
ffff8881097e8d50
[  147.235125] R10: 0000000000000000 R11: ffff8881097e8d50 R12: 
0000000000000000
[  147.235126] R13: ffff888197fb3140 R14: 0000000000000000 R15: 
0000000000000000
[  147.235127] FS:  00007fe7d088df00(0000) GS:ffff88881e980000(0000) 
knlGS:0000000000000000
[  147.235129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.235130] CR2: 0000564e5d4923f8 CR3: 00000001a2e0c000 CR4: 
0000000000350ee0
[  147.235131] Call Trace:
[  147.235132]  <TASK>
[  147.235134]  drm_mode_atomic_ioctl+0x345/0xae0
[  147.235137]  ? find_held_lock+0x2b/0x80
[  147.235140]  ? drm_atomic_set_property+0xb30/0xb30
[  147.235142]  drm_ioctl_kernel+0x9c/0x140
[  147.235145]  drm_ioctl+0x217/0x410
[  147.235146]  ? drm_atomic_set_property+0xb30/0xb30
[  147.235148]  ? lock_release+0x93/0x1c0
[  147.235150]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
[  147.235153]  amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
[  147.235283]  __x64_sys_ioctl+0x88/0xc0
[  147.235287]  do_syscall_64+0x3a/0x80
[  147.235290]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  147.235292] RIP: 0033:0x7fe7d551caeb
[  147.235293] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  147.235295] RSP: 002b:00007ffc54a2de50 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  147.235297] RAX: ffffffffffffffda RBX: 0000564e5cc68f00 RCX: 
00007fe7d551caeb
[  147.235298] RDX: 00007ffc54a2def0 RSI: 00000000c03864bc RDI: 
0000000000000017
[  147.235299] RBP: 00007ffc54a2def0 R08: 0000000000000000 R09: 
0000000000000000
[  147.235300] R10: 0000000000000000 R11: 0000000000000246 R12: 
00000000c03864bc
[  147.235301] R13: 0000000000000017 R14: 0000564e5ddd6940 R15: 
0000564e5ddd6960
[  147.235303]  </TASK>
[  147.235304] ---[ end trace 0000000000000000 ]---
[  147.235387] drm_modeset_lock attempting to lock a contended lock 
without backoff:
                   modeset_lock+0xef/0x1e0
                   drm_atomic_get_plane_state+0x73/0x170
                   drm_atomic_normalize_zpos+0x188/0x2b0
                   amdgpu_dm_atomic_check+0x3c2/0x1060 [amdgpu]
                   drm_atomic_check_only+0x5c0/0xa30
                   drm_mode_atomic_ioctl+0x6d5/0xae0
                   drm_ioctl_kernel+0x9c/0x140
                   drm_ioctl+0x217/0x410

--

  - Ilkka


