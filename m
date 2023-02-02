Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0656873A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBBDFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjBBDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:05:10 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80523313;
        Wed,  1 Feb 2023 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=07BiCaPOrteX+5h2GBhhzld4j64PeVgOXBt0lQwwlvk=; b=EIIMKEk78qw6SCeHYpxtopyXqZ
        cdDbP/KNWbGTtIg5TvAh3nG8eN7VdHMgdpRRFTGa5HGAI8DmuPDfQoSu25UeANAmGmHR+c9Z/P6K9
        bVbN028jqRCkrGBKzhSKbcX472YW5c2FwGmuHBwxVZUQO/BK/1WozfjGrHJoJJzkLC/pDdzDtLjTo
        RtxguZEuI3XrHW6D9JUGOEh/nNdVNyMm1EQnVMWirX70lYLJu7CZcopJzAEAAghPuWSHAF/EON0Rp
        nYMDe1JySsZwOUchX4tEgD+npClFgahiQ91YVoX4/mzvMNceXN2y8Je2rsMeKXnWH/x2IkeeaPIiU
        3+6eR6/A==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1pNPu1-000ymN-0U; Thu, 02 Feb 2023 03:04:45 +0000
Date:   Thu, 2 Feb 2023 03:04:44 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     iommu@lists.linux.dev, mchehab@kernel.org, hch@lst.de,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <Y9soTEzU42p7yfua@gallifrey>
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 02:48:30 up 327 days, 13:14,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hans Verkuil (hverkuil@xs4all.nl) wrote:
> Hi Dave,

Hi Hans,
  Thanks for the reply,

> It is probably related to the use of VM_IOREMAP in drivers/media/v4l2-cor=
e/videobuf-dma-sg.c.
>=20
> If you drop that flag, does it work?

No, doesn't seem to change it unfortunately.

> I'm not really sure what it does in the first place,
> or if it should be used at all. The videobuf code is very old and messy.

It seems to have come from commit 7b4eeed174b71c325705ff8c53f333bc79d0ee7a
that's some Xen related hack to get allocation under 4GB at the Xen layer
I think; but I can't say I understand how.

> In fact, the plan is to replace the old and deprecated videobuf framework=
 by the vb2
> framework in the bttv driver in the next 2-3 months or so. That will also=
 automatically
> solve this problem.

Yeh I realised things were moving in that direction once I started
poking at this code and saw patches for other drivers on the list.

Dave

> Regards,
>=20
> 	Hans
>=20
> On 01/02/2023 17:26, Dr. David Alan Gilbert wrote:
> > Hi,
> >   I've got a regression that started out somewhere around 5.17
> > that's triggered in the v4l/bttv code when IOMMU is enabled.
> >=20
> > A bisection got me to:
> >=20
> > GOOD [37fcacb50be7071d146144a6c5c5bf0194b9a1cf] phy: PHY_FSL_LYNX_28G s=
hould depend on ARCH_LAYERSCAPE
> > BAD [f5ff79fddf0efecca538046b5cc20fb3ded2ec4f] dma-mapping: remove CONF=
IG_DMA_REMAP
> > GOOD [e62c17f0455a74b182ce6373e2777817256afaa1] MAINTAINERS: update mai=
ntainer list of DMA MAPPING BENCHMARK
> > GOOD [0fb3436b4b36cf69f4544385aa2bb8c5a4913509] sparc: Remove usage of =
the deprecated "pci-dma-compat.h" API
> > GOOD [fba09099c6e506608e05e08ac717bf34501f821b] media: v4l2-pci-skeleto=
n: Remove usage of the deprecated "pci-dma-compat.h" API
> >=20
> > dg@major:~/kernel/kernel-clone$ git bisect good
> > f5ff79fddf0efecca538046b5cc20fb3ded2ec4f is the first bad commit
> > commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Sat Feb 26 16:40:21 2022 +0100
> >=20
> >     dma-mapping: remove CONFIG_DMA_REMAP
> >=20
> > It still happens on 6.2rc6
> >=20
> > a) Trigger
> >=20
> >    cat /dev/vbi0 > /dev/null
> >=20
> >   (Originally found using Alistair Buxton's Teletext recovery script)
> >=20
> >   xawtv works fine on this card/box, so it's only the vbi that seems to
> >    be upset.
> >=20
> > b) Symptom
> >   On head we get:
> > Feb 01 13:58:00 major kernel: ------------[ cut here ]------------
> > Feb 01 13:58:00 major kernel: WARNING: CPU: 1 PID: 899 at mm/vmalloc.c:=
490 __vmap_pages_range_noflush+0x3e4/0x4e0
> > Feb 01 13:58:00 major kernel: Modules linked in: rfkill qrtr intel_powe=
rclamp tuner_simple tuner_types tuner coretemp tda7432 kvm_intel binfmt_mis=
c snd_hda_codec_via snd_hda_codec_generic tvaudio kvm msp3400 snd_hda_codec=
_hdmi ledtrig_a>
> > Feb 01 13:58:00 major kernel:  firewire_ohci r8169 scsi_mod realtek mdi=
o_devres crc32c_intel libphy lpc_ich firewire_core i2c_smbus usb_common scs=
i_common crc_itu_t button
> > Feb 01 13:58:00 major kernel: CPU: 1 PID: 899 Comm: cat Tainted: G     =
     I        6.2.0-rc6dg #21
> > Feb 01 13:58:00 major kernel: Hardware name: To Be Filled By O.E.M. To =
Be Filled By O.E.M./P55M Pro, BIOS P1.50 09/10/2009
> > Feb 01 13:58:00 major kernel: RIP: 0010:__vmap_pages_range_noflush+0x3e=
4/0x4e0
> > Feb 01 13:58:00 major kernel: Code: 48 48 83 c6 08 4d 39 d6 0f 85 39 fd=
 ff ff 48 83 c4 58 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 0f 0b=
 e9 5f fc ff ff <0f> 0b b8 f4 ff ff ff e9 bd fc ff ff 48 8b 4c 24 18 48 31 =
cf 48 21
> > Feb 01 13:58:00 major kernel: RSP: 0018:ffffb02a41773c30 EFLAGS: 000102=
46
> > Feb 01 13:58:00 major kernel: RAX: 000000000004dc48 RBX: ffff894a2b4da2=
00 RCX: ffffe7c549054640
> > Feb 01 13:58:00 major kernel: RDX: 000000026e241519 RSI: 00000000000000=
00 RDI: 000000026e241519
> > Feb 01 13:58:00 major kernel: RBP: 0000000000000000 R08: 00000000000009=
b8 R09: ffffb02a41850000
> > Feb 01 13:58:00 major kernel: R10: ffffb02a41850000 R11: ffffb02a418510=
00 R12: 8000000000000063
> > Feb 01 13:58:00 major kernel: R13: ffffb02a41840000 R14: ffffb02a418500=
00 R15: ffff894a2c360380
> > Feb 01 13:58:00 major kernel: FS:  00007fd7738c0740(0000) GS:ffff894a2f=
c40000(0000) knlGS:0000000000000000
> > Feb 01 13:58:00 major kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > Feb 01 13:58:00 major kernel: CR2: 00007fd77389e000 CR3: 000000011f21e0=
00 CR4: 00000000000006e0
> > Feb 01 13:58:00 major kernel: Call Trace:
> > Feb 01 13:58:00 major kernel:  <TASK>
> > Feb 01 13:58:00 major kernel:  vmap+0xa7/0x100
> > Feb 01 13:58:00 major kernel:  __videobuf_iolock+0x5b2/0x670 [videobuf_=
dma_sg]
> > Feb 01 13:58:00 major kernel:  vbi_buffer_prepare+0x1b2/0x2c0 [bttv]
> > Feb 01 13:58:00 major kernel:  __videobuf_read_start+0xb9/0x1d0 [videob=
uf_core]
> > Feb 01 13:58:00 major kernel:  videobuf_read_stream+0x2d7/0x330 [videob=
uf_core]
> > Feb 01 13:58:00 major kernel:  bttv_read+0xc8/0x210 [bttv]
> > Feb 01 13:58:00 major kernel:  v4l2_read+0x73/0x90 [videodev]
> > Feb 01 13:58:00 major kernel:  vfs_read+0xa9/0x2d0
> > Feb 01 13:58:00 major kernel:  ? handle_mm_fault+0xd7/0x2b0
> > Feb 01 13:58:00 major kernel:  ksys_read+0x67/0xe0
> > Feb 01 13:58:00 major kernel:  do_syscall_64+0x3e/0x90
> > Feb 01 13:58:00 major kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > Feb 01 13:58:00 major kernel: RIP: 0033:0x7fd7739bb0ed
> > Feb 01 13:58:00 major kernel: Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d f6=
 54 0a 00 e8 39 fe 01 00 66 0f 1f 84 00 00 00 00 00 80 3d f1 24 0e 00 00 74=
 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 =
48 83 ec
> > Feb 01 13:58:00 major kernel: RSP: 002b:00007fffe000df38 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000000
> > Feb 01 13:58:00 major kernel: RAX: ffffffffffffffda RBX: 00000000000200=
00 RCX: 00007fd7739bb0ed
> > Feb 01 13:58:00 major kernel: RDX: 0000000000020000 RSI: 00007fd77389f0=
00 RDI: 0000000000000003
> > Feb 01 13:58:00 major kernel: RBP: 0000000000020000 R08: 00000000ffffff=
ff R09: 0000000000000000
> > Feb 01 13:58:00 major kernel: R10: 00007fd7738d2b40 R11: 00000000000002=
46 R12: 00007fd77389f000
> > Feb 01 13:58:00 major kernel: R13: 0000000000000003 R14: 00000000000200=
00 R15: 0000000000000000
> > Feb 01 13:58:00 major kernel:  </TASK>
> > Feb 01 13:58:00 major kernel: ---[ end trace 0000000000000000 ]---
> >=20
> > On the first version after the bisect the failure is a BUG rather than =
the warn:
> >=20
> > [   78.988024] BUG: unable to handle page fault for address: ffffbd7fc1=
100000
> > [   78.988033] #PF: supervisor write access in kernel mode
> > [   78.988036] #PF: error_code(0x000b) - reserved bit violation
> > [   78.988038] PGD 100000067 P4D 100000067 PUD 1001a6067 PMD 22b791067 =
PTE 8000270800cb9063
> > [   78.988046] Oops: 000b [#1] PREEMPT SMP PTI
> > [   78.988050] CPU: 7 PID: 879 Comm: cat Tainted: G          I       5.=
17.0-rc1dg+ #20
> > [   78.988054] Hardware name: To Be Filled By O.E.M. To Be Filled By O.=
E.M./P55M Pro, BIOS P1.50 09/10/2009
> > [   78.988056] RIP: 0010:__memset+0x24/0x30
> > [   78.988063] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1=
 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6=
 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> > [   78.988067] RSP: 0018:ffffbd7fc0cc7d50 EFLAGS: 00010206
> > [   78.988071] RAX: 0000000000000000 RBX: ffff9679eb788a88 RCX: 0000000=
000002000
> > [   78.988073] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffbd7=
fc1100000
> > [   78.988076] RBP: 0000000080000000 R08: 0000000000000000 R09: ffffbd7=
fc1100000
> > [   78.988079] R10: 0000000000010000 R11: ffffbd7fc1100000 R12: 0000000=
000000010
> > [   78.988081] R13: 0000000000000010 R14: ffff9679ec8e4130 R15: 0000000=
000000010
> > [   78.988084] FS:  00007f91fb65a740(0000) GS:ffff9679efdc0000(0000) kn=
lGS:0000000000000000
> > [   78.988087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   78.988090] CR2: ffffbd7fc1100000 CR3: 000000022ce02000 CR4: 0000000=
0000006e0
> > [   78.988093] Call Trace:
> > [   78.988096]  <TASK>
> > [   78.988100]  __videobuf_iolock+0x5cd/0x659 [videobuf_dma_sg]
> > [   78.988110]  vbi_buffer_prepare+0x1aa/0x2b0 [bttv]
> > [   78.988125]  __videobuf_read_start+0xb9/0x1d0 [videobuf_core]
> > [   78.988133]  videobuf_read_stream+0x2cb/0x330 [videobuf_core]
> > [   78.988140]  bttv_read+0xc5/0x1d0 [bttv]
> > [   78.988151]  v4l2_read+0x6b/0x80 [videodev]
> > [   78.988169]  vfs_read+0x97/0x190
> > [   78.988175]  ksys_read+0x63/0xe0
> > [   78.988179]  do_syscall_64+0x3a/0x80
> > [   78.988185]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   78.988191] RIP: 0033:0x7f91fb7550ed
> > [   78.988194] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d f6 54 0a 00 e8 39=
 fe 01 00 66 0f 1f 84 00 00 00 00 00 80 3d f1 24 0e 00 00 74 17 31 c0 0f 05=
 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> > [   78.988198] RSP: 002b:00007ffdad058348 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> > [   78.988202] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f9=
1fb7550ed
> > [   78.988204] RDX: 0000000000020000 RSI: 00007f91fb350000 RDI: 0000000=
000000003
> > [   78.988207] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000=
000000000
> > [   78.988209] R10: 00007f91fb66cb40 R11: 0000000000000246 R12: 00007f9=
1fb350000
> > [   78.988212] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000=
000000000
> > [   78.988216]  </TASK>
> > [   78.988218] Modules linked in: rfkill qrtr tuner_simple tuner_types =
intel_powerclamp coretemp tuner snd_hda_codec_via tda7432 kvm_intel snd_hda=
_codec_generic snd_hda_codec_hdmi tvaudio ledtrig_audio msp3400 snd_hda_int=
el kvm snd_intel_dspcfg bttv snd_intel_sdw_acpi snd_hda_codec irqbypass tea=
575x snd_hda_core tveeprom videobuf_dma_sg intel_cstate videobuf_core video=
dev snd_hwdep snd_bt87x intel_uncore snd_pcm serio_raw pcspkr iTCO_wdt i7co=
re_edac mc joydev intel_pmc_bxt snd_timer iTCO_vendor_support snd watchdog =
soundcore sg evdev acpi_cpufreq firewire_sbp2 fuse msr configfs efi_pstore =
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 nouveau s=
d_mod t10_pi crc_t10dif crct10dif_generic ata_generic crct10dif_common hid_=
generic usbhid hid mxm_wmi wmi video i2c_algo_bit drm_ttm_helper ttm drm_km=
s_helper cec rc_core drm ahci libahci pata_via libata ehci_pci ehci_hcd psm=
ouse r8169 usbcore scsi_mod crc32c_intel realtek i2c_i801 mdio_devres i2c_s=
mbus libphy firewire_ohci
> > [   78.988301]  firewire_core lpc_ich usb_common scsi_common crc_itu_t =
button
> > [   78.988311] CR2: ffffbd7fc1100000
> > [   78.988314] ---[ end trace 0000000000000000 ]---
> > [   78.988316] RIP: 0010:__memset+0x24/0x30
> > [   78.988320] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1=
 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6=
 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> > [   78.988324] RSP: 0018:ffffbd7fc0cc7d50 EFLAGS: 00010206
> > [   78.988327] RAX: 0000000000000000 RBX: ffff9679eb788a88 RCX: 0000000=
000002000
> > [   78.988329] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffbd7=
fc1100000
> > [   78.988332] RBP: 0000000080000000 R08: 0000000000000000 R09: ffffbd7=
fc1100000
> > [   78.988334] R10: 0000000000010000 R11: ffffbd7fc1100000 R12: 0000000=
000000010
> > [   78.988337] R13: 0000000000000010 R14: ffff9679ec8e4130 R15: 0000000=
000000010
> > [   78.988340] FS:  00007f91fb65a740(0000) GS:ffff9679efdc0000(0000) kn=
lGS:0000000000000000
> > [   78.988343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   78.988346] CR2: ffffbd7fc1100000 CR3: 000000022ce02000 CR4: 0000000=
0000006e0
> >=20
> > c) Hardware
> >   Motherboard: ASRock P55M Pro=20
> >     + 8GB RAM
> >   Video capture card: Hauppage WinTV 44805
> >      That's a 32bit PCI card
> >   =20
> > 01:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video =
Capture (rev 11)
> > 	Subsystem: Hauppauge computer works Inc. WinTV Series
> > 	Flags: bus master, medium devsel, latency 32, IRQ 21, IOMMU group 15
> > 	Memory at d5bfe000 (32-bit, prefetchable) [size=3D4K]
> > 	Capabilities: [44] Vital Product Data
> > 	Capabilities: [4c] Power Management version 2
> > 	Kernel driver in use: bttv
> > 	Kernel modules: bttv
> >=20
> > 01:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Captur=
e (rev 11)
> > 	Subsystem: Hauppauge computer works Inc. WinTV Series
> > 	Flags: bus master, medium devsel, latency 32, IRQ 21, IOMMU group 15
> > 	Memory at d5bff000 (32-bit, prefetchable) [size=3D4K]
> > 	Capabilities: [44] Vital Product Data
> > 	Capabilities: [4c] Power Management version 2
> > 	Kernel driver in use: snd_bt87x
> > 	Kernel modules: snd_bt87x
> >=20
> > d) Bug link
> >    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1029968
> >    I origianlly triggered this on Debian 12's kernel which has iommu on
> >    by default, but it triggers on upstream as long as I turn iommu on
> >=20
> > e) kernel command line
> >    root=3DUUID=3Dbce3fb05-edb4-4c73-b71d-86707031ffd1 ro intel_iommu=3D=
on intremap=3Dnosid quiet
> >=20
> >    The intremap issue is a long known problem on this board.
> >=20
> > f) Some more debug
> >=20
> > I added some more debug:
> >         switch (vb->memory) {
> >         case V4L2_MEMORY_MMAP:
> >         case V4L2_MEMORY_USERPTR:
> > +                pr_warn("__videobuf_iolock: USERPTR case; size=3D%zx b=
addr=3D%lx bsize=3D%lx\n",
> > +                        vb->size, vb->baddr, vb->bsize);
> >                 if (0 =3D=3D vb->baddr) {
> >                         /* no userspace addr -- kernel bounce buffer */
> >                         pages =3D PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
> >=20
> > [  890.606742] __videobuf_iolock: USERPTR case; size=3D10000 baddr=3D0 =
bsize=3D10000
> >=20
> > +++ b/mm/vmalloc.c
> > @@ -487,8 +487,11 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsign=
ed long addr,
> >                         return -EBUSY;
> >                 if (WARN_ON(!page))
> >                         return -ENOMEM;
> > -               if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > +               if (WARN_ON(!pfn_valid(page_to_pfn(page)))) {
> > +                        pr_warn("vmap_pages_pte_range pfn not valid nr=
=3D%d page=3D%p pfn=3D%lx addr=3D%lx end=3D%lx\n",
> > +                                 *nr, page, page_to_pfn(page), addr, e=
nd);
> >                         return -EINVAL;
> > +                }
> >=20
> > [  395.134606] vmap_pages_pte_range pfn not valid nr=3D0 page=3D0000000=
0ec8bb27c pfn=3D1b0280053 addr=3Dffffaaef00ce0000 end=3Dffffaaef00cf0000
> >=20
> > g) Note
> > There are some DMAR warnings during boot, so I'm not sure if it's
> > just this system or not, but hmm I doubt it from the other debug?
> > Feb 01 15:38:31 major kernel: DMAR: Host address width 36
> > Feb 01 15:38:31 major kernel: DMAR: DRHD base: 0x000000fed91000 flags: =
0x0
> > Feb 01 15:38:31 major kernel: DMAR: dmar0: reg_base_addr fed91000 ver 1=
:0 cap c9008010e60262 ecap f0206a
> > Feb 01 15:38:31 major kernel: DMAR: DRHD base: 0x000000fed90000 flags: =
0x1
> > Feb 01 15:38:31 major kernel: DMAR: dmar1: reg_base_addr fed90000 ver 1=
:0 cap c90780106f0462 ecap f020ea
> > Feb 01 15:38:31 major kernel: DMAR: RMRR base: 0x000000000e4000 end: 0x=
000000000e8bff
> > Feb 01 15:38:31 major kernel: DMAR: [Firmware Bug]: Your BIOS is broken=
; bad RMRR [0x00000000000e4000-0x00000000000e8bff]
> >                               BIOS vendor: American Megatrends Inc.; Ve=
r: P1.50; Product Version: To Be Filled By O.E.M.
> > Feb 01 15:38:31 major kernel: DMAR: RMRR base: 0x000000cf7eb400 end: 0x=
000000cf7fffff
> > Feb 01 15:38:31 major kernel: DMAR: [Firmware Bug]: Your BIOS is broken=
; bad RMRR [0x00000000cf7eb400-0x00000000cf7fffff]
> >                               BIOS vendor: American Megatrends Inc.; Ve=
r: P1.50; Product Version: To Be Filled By O.E.M.
> > Feb 01 15:38:31 major kernel: DMAR-IR: IOAPIC id 8 under DRHD base  0xf=
ed90000 IOMMU 1
> > Feb 01 15:38:31 major kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed9=
0000
> > Feb 01 15:38:31 major kernel: DMAR-IR: IRQ remapping was enabled on dma=
r0 but we are not in kdump mode
> > Feb 01 15:38:31 major kernel: DMAR: DRHD: handling fault status reg 400
> > Feb 01 15:38:31 major kernel: DMAR-IR: IRQ remapping was enabled on dma=
r1 but we are not in kdump mode
> > Feb 01 15:38:31 major kernel: DMAR-IR: Enabled IRQ remapping in xapic m=
ode
> > Feb 01 15:38:31 major kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2=
 apic2=3D-1 pin2=3D-1
> >=20
> > Thanks in advance for any suggestions,
> >=20
> > Dave
> >=20
>=20
--=20
 -----Open up your eyes, open up your mind, open up your code -------  =20
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
