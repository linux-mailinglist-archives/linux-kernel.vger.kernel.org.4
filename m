Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A26A0ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBWRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:38:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D891422A;
        Thu, 23 Feb 2023 09:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E04F61762;
        Thu, 23 Feb 2023 17:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CFDC433D2;
        Thu, 23 Feb 2023 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677173904;
        bh=9W4gims8Mm2IpZOCJYIDgAGRI8Wx50OPT3F4rTDQPdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nr4v0pOuoCqKwPXbnrPLZIWN0bjWSHoDrwRuMHrULbwWRhRwYz6mW/JTG2gcQTSc1
         zFRmvHD26xw60zzkrECstSq2p7RExVGQnbKhNpGDCpiX88C3/H1aFebrEUegAr+noj
         qlMKSdIWb5uY5jlvxwl7tb0SLh4To7CSxy3m5w9Z/ihHRIMM2T8ygwsSUacsvwZdAe
         10xAZ4Ew5PetMXO83VvDvbcKVB+qY9tXCPlzKYQ0C2l2UzTVF9SpgshYaA2guy9CCR
         0F2QUruA/RmO9RumynwcPe4J/955jI3Adh2tYTjRn+OLEZMLGZ8wyyNJQcVah6avHJ
         8k/mxguOURb6w==
Date:   Thu, 23 Feb 2023 18:38:20 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>, deren.wu@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [6.3][regression] commit
 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28 definitely causes use-after-free
Message-ID: <Y/ekjIpVHG/jZ2Fu@lore-desk>
References: <CABXGCsOnzrZa80BMZdJU=16Z7SZP2a-zbtkDQ10P+NyLhioqRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BxhCZxuR3kfBUT65"
Content-Disposition: inline
In-Reply-To: <CABXGCsOnzrZa80BMZdJU=16Z7SZP2a-zbtkDQ10P+NyLhioqRA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BxhCZxuR3kfBUT65
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
> new kernel release cycle returning with new bugs
> Today Fedora Rawhide updated the kernel to 5b7c4cabbb65 commit.
> And in logs appears unpleasant message with such trace:
>=20
> usb 3-3.3.4: reset high-speed USB device number 8 using xhci_hcd
> iwlwifi 0000:05:00.0: Detected RF HR B3, rfid=3D0x10a100
> iwlwifi 0000:05:00.0: base HW address: 50:eb:71:79:02:57
> iwlwifi 0000:05:00.0 wlp5s0: renamed from wlan0
> mt76x2u 3-3.3.4:1.0: ASIC revision: 76320044
> usb 3-3.3.1: 1:3 : unsupported format bits 0x100000000
> mt76x2u 3-3.3.4:1.0: could not get hardware semaphore for ROM PATCH
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 13 PID: 983 at lib/refcount.c:28 refcount_warn_saturate+0xb=
a/0x110
> Modules linked in: snd_seq_midi snd_seq_midi_event mt76x2u(+)
> mt76x2_common mt76x02_usb mt76_usb iwlmvm mt76x02_lib mt76
> snd_hda_codec_realtek intel_rapl_msr snd_hda_codec_generic
> snd_hda_codec_hdmi intel_rapl_common snd_hda_intel mac80211
> snd_intel_dspcfg snd_usb_audio(+) snd_intel_sdw_acpi btusb
> edac_mce_amd snd_hda_codec btrtl btbcm snd_usbmidi_lib snd_hda_core
> btintel snd_rawmidi btmtk snd_hwdep libarc4 mc iwlwifi kvm_amd snd_seq
> vfat bluetooth eeepc_wmi asus_ec_sensors snd_seq_device fat kvm
> cfg80211 asus_wmi snd_pcm irqbypass ledtrig_audio sparse_keymap rapl
> wmi_bmof platform_profile xpad snd_timer k10temp ff_memless i2c_piix4
> rfkill snd joydev soundcore acpi_cpufreq loop zram amdgpu
> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> polyval_generic drm_ttm_helper ttm video iommu_v2 ucsi_ccg drm_buddy
> gpu_sched typec_ucsi ghash_clmulni_intel drm_display_helper igb
> sha512_ssse3 typec ccp nvme cec sp5100_tco nvme_core dca nvme_common
> wmi ip6_tables ip_tables fuse
> BTRFS info (device nvme1n1): enabling ssd optimizations
> CPU: 13 PID: 983 Comm: (udev-worker) Tainted: G        W    L
> -------  ---  6.3.0-0.rc0.20230222git5b7c4cabbb65.3.fc39.x86_64+debug
> #1
> BTRFS info (device nvme1n1): auto enabling async discard
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 4601 02/02/2023
> RIP: 0010:refcount_warn_saturate+0xba/0x110
> Code: 01 01 e8 69 a6 83 ff 0f 0b e9 52 f4 85 00 80 3d 69 6f ec 01 00
> 75 85 48 c7 c7 d0 25 b3 a9 c6 05 59 6f ec 01 01 e8 46 a6 83 ff <0f> 0b
> e9 2f f4 85 00 80 3d 47 6f ec 01 00 0f 85 5e ff ff ff 48 c7
> RSP: 0018:ffffb4010456fb78 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffffffffa9b17e3e RDI: 00000000ffffffff
> RBP: ffff8d15877336c0 R08: 0000000000000000 R09: ffffb4010456fa00
> R10: 0000000000000003 R11: ffff8d246e2fffe8 R12: 0000000000000080
> R13: ffff8d15b42fd000 R14: 0000000000000000 R15: ffff8d1587736a58
> FS:  00007fc05ae34940(0000) GS:ffff8d2425e00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d801f1d540 CR3: 000000011df60000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  mt76u_queues_deinit+0x2a0/0x370 [mt76_usb]
>  mt76x2u_probe+0xf3/0x130 [mt76x2u]
>  usb_probe_interface+0xe8/0x300
>  really_probe+0x1b6/0x410
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach+0xd2/0x1c0
>  ? __pfx___driver_attach+0x10/0x10
>  bus_for_each_dev+0x8a/0xd0
>  bus_add_driver+0x141/0x230
>  driver_register+0x77/0x120
>  usb_register_driver+0xaf/0x170
>  ? __pfx_init_module+0x10/0x10 [mt76x2u]
>  do_one_initcall+0x6e/0x350
>  do_init_module+0x4a/0x220
>  __do_sys_init_module+0x192/0x1c0
>  ? lock_is_held_type+0xce/0x120
>  do_syscall_64+0x5b/0x80
>  ? lock_is_held_type+0xce/0x120
>  ? asm_exc_page_fault+0x22/0x30
>  ? lockdep_hardirqs_on+0x7d/0x100
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fc05b1351be
> Code: 48 8b 0d 4d 0c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 1a 0c 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd947c0988 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> RAX: ffffffffffffffda RBX: 000055d801f2b090 RCX: 00007fc05b1351be
> RDX: 00007fc05b65c07d RSI: 00000000000234be RDI: 000055d802c6b170
> RBP: 00007ffd947c0a40 R08: 000055d8019b4690 R09: 0000000000022000
> R10: 000000055d8019b4 R11: 0000000000000246 R12: 00007fc05b65c07d
> R13: 0000000000020000 R14: 000055d801f39770 R15: 000055d801f47780
>  </TASK>
> irq event stamp: 186313
> hardirqs last  enabled at (186323): [<ffffffffa81c675e>]
> __up_console_sem+0x5e/0x70
> hardirqs last disabled at (186332): [<ffffffffa81c6743>]
> __up_console_sem+0x43/0x70
> softirqs last  enabled at (186022): [<ffffffffa811d2f7>]
> __irq_exit_rcu+0xd7/0x160
> softirqs last disabled at (186017): [<ffffffffa811d2f7>]
> __irq_exit_rcu+0xd7/0x160
> ---[ end trace 0000000000000000 ]---
> mt76x2u: probe of 3-3.3.4:1.0 failed with error -110
> usbcore: registered new interface driver mt76x2u
> kauditd_printk_skb: 32 callbacks suppressed
>=20
> git bisect blame this commit in this:
>=20
> =E2=9D=AF git bisect bad
> 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28 is the first bad commit
> commit 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Tue Jan 17 14:53:15 2023 +0100
>=20
>     wifi: mt76: switch to page_pool allocator
>=20
>     In order to reduce possible memory allocation failures due to memory
>     fragmentation caused by page_frag_cache allocator, switch to page_pool
>     allocator for dma and usb mt76 drivers.
>     Remove per rx-queue page_frag_cache
>=20
>     Co-developed-by: Felix Fietkau <nbd@nbd.name>
>     Tested-by: Deren Wu <deren.wu@mediatek.com>
>     Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>=20
>  drivers/net/wireless/mediatek/mt76/Kconfig       |  1 +
>  drivers/net/wireless/mediatek/mt76/dma.c         | 72 ++++++++++++------=
------
>  drivers/net/wireless/mediatek/mt76/mac80211.c    | 42 ++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h        | 21 ++++++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 55 +++++++-----------
>  drivers/net/wireless/mediatek/mt76/usb.c         | 42 +++++++-------
>  6 files changed, 139 insertions(+), 94 deletions(-)
>=20
> Unfortunately I couldn't revert this commit staying on
> a5c95ca18a98d742d0a4a04063c32556b5b66378 because of conflicts:
>=20
> =E2=9D=AF git revert -n 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28
> Auto-merging drivers/net/wireless/mediatek/mt76/dma.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/=
dma.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mac80211.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt76.h
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> error: could not revert 2f5c3c77fc9b... wifi: mt76: switch to
> page_pool allocator
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
>=20
> Who wants to see the full kernel log could see an attached archive.
>=20
> --=20
> Best Regards,
> Mike Gavrilov.

Hi Mike,

can you please check if the patch below fixes the issue?

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireles=
s/mediatek/mt76/usb.c
index b88959ef38aa..5e5c7bf51174 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -706,6 +706,7 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_q=
ueue *q)
 		q->entry[i].urb =3D NULL;
 	}
 	page_pool_destroy(q->page_pool);
+	q->page_pool =3D NULL;
 }
=20
 static void mt76u_free_rx(struct mt76_dev *dev)


> git bisect start
> # status: waiting for both good and bad commits
> # good: [89f5349e0673322857bd432fa23113af56673739] Merge tag 'x86-platfor=
m-2023-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 89f5349e0673322857bd432fa23113af56673739
> # status: waiting for bad commit, 1 good commit known
> # bad: [5b7c4cabbb65f5c469464da6c5f614cbd7f730f2] Merge tag 'net-next-6.3=
' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
> # good: [72bc7f163179cb0b39e1a18dbf69e175267ce500] Merge branch '100GbE' =
of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
> git bisect good 72bc7f163179cb0b39e1a18dbf69e175267ce500
> # good: [8bf1a529cd664c8e5268381f1e24fe67aa611dd3] Merge tag 'arm64-upstr=
eam' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 8bf1a529cd664c8e5268381f1e24fe67aa611dd3
> # bad: [ee8d72a157ebb4b8c4b8b664f5a78a341fede2ef] Merge tag 'for-netdev' =
of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> git bisect bad ee8d72a157ebb4b8c4b8b664f5a78a341fede2ef
> # bad: [935ef47b16cc5bc15fcd2b3dbc61abb0b7ea671a] wifi: cfg80211: get rid=
 of gfp in cfg80211_bss_color_notify
> git bisect bad 935ef47b16cc5bc15fcd2b3dbc61abb0b7ea671a
> # bad: [7fcae8f7f8158d22e667ed55a40e6a1829cc55b0] wifi: mwifiex: Replace =
one-element arrays with flexible-array members
> git bisect bad 7fcae8f7f8158d22e667ed55a40e6a1829cc55b0
> # bad: [6b733f7c5a749dbd089077165986bc3d9b7aabf5] wifi: mt76: increase wc=
id size to 1088
> git bisect bad 6b733f7c5a749dbd089077165986bc3d9b7aabf5
> # good: [aed8d9b506c22848add261ffad8fdabc57f21964] wifi: mt76: fix switch=
 default case in mt7996_reverse_frag0_hdr_trans
> git bisect good aed8d9b506c22848add261ffad8fdabc57f21964
> # bad: [a97a467a4421babc218bd3546b093e4e84027487] wifi: mt76: mt7915: rel=
ease rxwi in mt7915_wed_release_rx_buf
> git bisect bad a97a467a4421babc218bd3546b093e4e84027487
> # good: [09f4417a451be137a3e848b1888a1e32f8325046] wifi: mt76: mt7921: re=
duce polling time in pmctrl
> git bisect good 09f4417a451be137a3e848b1888a1e32f8325046
> # good: [412d19b42042fb7e7148ee5293a7ce682a76a0f2] wifi: mt76: mt7915: fi=
x memory leak in mt7915_mmio_wed_init_rx_buf
> git bisect good 412d19b42042fb7e7148ee5293a7ce682a76a0f2
> # bad: [192ad4066065ef67cbcaae557e4412871fa8d369] wifi: mt76: enable page=
_pool stats
> git bisect bad 192ad4066065ef67cbcaae557e4412871fa8d369
> # bad: [2f5c3c77fc9b6a34b68b97231bfa970e1194ec28] wifi: mt76: switch to p=
age_pool allocator
> git bisect bad 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28
> # first bad commit: [2f5c3c77fc9b6a34b68b97231bfa970e1194ec28] wifi: mt76=
: switch to page_pool allocator



--BxhCZxuR3kfBUT65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/ekjAAKCRA6cBh0uS2t
rE9BAQCWFwyVNt8m/QQXvld5dWYXftZXZaElZ3+4RWlhRpp+sgD/ZjKhnEHKuVxh
zIHB5E8seji+jVcglqBrIQoNCn+gNQ8=
=Nydr
-----END PGP SIGNATURE-----

--BxhCZxuR3kfBUT65--
