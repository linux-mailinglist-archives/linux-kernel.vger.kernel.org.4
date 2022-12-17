Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1164F8E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLQLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:53:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F20140B5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 03:53:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E11F51EC034B;
        Sat, 17 Dec 2022 12:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671278034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=xTlpZ1jSx2p+jIwZfrDGi/XHci5k3jjdth12y44Wpsg=;
        b=oyu0aISS+Kp4R3LpGTkdU1haXnixEAPUKYQ951Kahdk7FxDdF7f+hnYfi8VDV1SAcC8BBg
        P5G3ykymnFMIRfCX3RmdBij+pepAoI3z2q+YS0L5CkQqiRzh6muGfgaQl7yoxvcYcaJlzd
        8LNRr4g018ByMCIjNsg/7PFs+rSLG1o=
Date:   Sat, 17 Dec 2022 12:53:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: amdgpu refcount saturation
Message-ID: <Y52tzASAKNAJEER3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

this is with Linus' tree from Wed:

041fae9c105a ("Merge tag 'f2fs-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs")

on a CZ laptop:

[    7.782901] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4)

The splat is kinda messy:

---

[    7.755306] [drm] amdgpu kernel modesetting enabled.
[    7.779110] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[    7.780417] Console: switching to colour dummy device 80x25
[    7.782901] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
[    7.783244] [drm] register mmio base: 0xD0C00000
[    7.783405] [drm] register mmio size: 262144
[    7.784182] [drm] add ip block number 0 <vi_common>
[    7.784375] [drm] add ip block number 1 <gmc_v8_0>
[    7.784555] [drm] add ip block number 2 <cz_ih>
[    7.784717] [drm] add ip block number 3 <gfx_v8_0>
[    7.784925] [drm] add ip block number 4 <sdma_v3_0>
[    7.785094] [drm] add ip block number 5 <powerplay>
[    7.785264] [drm] add ip block number 6 <dm>
[    7.785413] [drm] add ip block number 7 <uvd_v6_0>
[    7.785580] [drm] add ip block number 8 <vce_v3_0>
[    7.800919] [drm] BIOS signature incorrect 5b 7
[    7.801095] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000cbfff window]
[    7.801544] caller pci_map_rom+0x68/0x1c0 mapping multiple BARs
[    7.801838] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR
[    7.802067] amdgpu: ATOM BIOS: SWBRT27354.001
[    7.802272] [drm] UVD is enabled in physical mode
[    7.802438] [drm] VCE enabled in physical mode
[    7.802592] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    7.803100] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[    7.803387] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    7.803708] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[    7.804007] [drm] Detected VRAM RAM=512M, BAR=512M
[    7.804174] [drm] RAM width 128bits UNKNOWN
[    7.804703] [drm] amdgpu: 512M of VRAM memory ready
[    7.804882] [drm] amdgpu: 7638M of GTT memory ready.
[    7.805164] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    7.805484] [drm] PCIE GART of 1024M enabled (table at 0x000000F400A00000).
[    7.808418] amdgpu: hwmgr_sw_init smu backed is smu8_smu
[    7.809070] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[    7.809413] [drm] UVD ENC is disabled
[    7.810321] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    7.812036] amdgpu: smu version 18.62.00
[    7.818378] [drm] DM_PPLIB: values for Engine clock
[    7.818566] [drm] DM_PPLIB:	 300000
[    7.818689] [drm] DM_PPLIB:	 360000
[    7.818811] [drm] DM_PPLIB:	 423530
[    7.818934] [drm] DM_PPLIB:	 514290
[    7.819056] [drm] DM_PPLIB:	 626090
[    7.819179] [drm] DM_PPLIB:	 720000
[    7.819302] [drm] DM_PPLIB: Validation clocks:
[    7.819456] [drm] DM_PPLIB:    engine_max_clock: 72000
[    7.819633] [drm] DM_PPLIB:    memory_max_clock: 80000
[    7.819810] [drm] DM_PPLIB:    level           : 8
[    7.819977] [drm] DM_PPLIB: values for Display clock
[    7.820148] [drm] DM_PPLIB:	 300000
[    7.820271] [drm] DM_PPLIB:	 400000
[    7.820394] [drm] DM_PPLIB:	 496560
[    7.820563] [drm] DM_PPLIB:	 626090
[    7.820694] [drm] DM_PPLIB:	 685720
[    7.820857] [drm] DM_PPLIB:	 757900
[    7.820979] [drm] DM_PPLIB: Validation clocks:
[    7.821133] [drm] DM_PPLIB:    engine_max_clock: 72000
[    7.821310] [drm] DM_PPLIB:    memory_max_clock: 80000
[    7.821487] [drm] DM_PPLIB:    level           : 8
[    7.821653] [drm] DM_PPLIB: values for Memory clock
[    7.821821] [drm] DM_PPLIB:	 333000
[    7.821944] [drm] DM_PPLIB:	 800000
[    7.822066] [drm] DM_PPLIB: Validation clocks:
[    7.822220] [drm] DM_PPLIB:    engine_max_clock: 72000
[    7.822397] [drm] DM_PPLIB:    memory_max_clock: 80000
[    7.822574] [drm] DM_PPLIB:    level           : 8
[    7.823044] [drm] Display Core initialized with v3.2.215!
[    7.903994] [drm] UVD initialized successfully.
[    8.103416] [drm] VCE initialized successfully.
[    8.104616] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
[    8.109430] [drm] Initialized amdgpu 3.49.0 20150101 for 0000:00:01.0 on minor 0
[    8.120099] fbcon: amdgpudrmfb (fb0) is primary device
[    8.886332] Console: switching to colour frame buffer device 320x90
[    8.902118] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer device
[    8.967565] process '/usr/bin/fstype' started with executable stack
[    8.979419] PM: Image not found (code -22)
[    9.043724] EXT4-fs (sda2): mounted filesystem c34989f9-7c8f-49ae-8285-7896af84c685 with ordered data mode. Quota mode: disabled.
[    9.540346] systemd-udevd[1404]: /etc/udev/rules.d/storage_devices.rules:1 Invalid value for OPTIONS key, ignoring: 'all_partitions'
[    9.766687] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input10
[    9.770181] ACPI: button: Power Button [PWRB]
[    9.782936] acpi_cpufreq: overriding BIOS provided _PSD data
[    9.784086] ACPI: AC: AC Adapter [AC] (off-line)
[    9.789339] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input11
[    9.792905] ACPI: button: Sleep Button [SLPB]
[    9.815432] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input12
[    9.840976] ACPI: button: Lid Switch [LID]
[    9.842731] ACPI: battery: Slot [BAT0] (battery present)
[    9.862066] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input13
[    9.884592] ACPI: button: Power Button [PWRF]
[    9.998674] cryptd: max_cpu_qlen set to 1000
[   10.011682] input: PC Speaker as /devices/platform/pcspkr/input/input14
[   10.019917] AVX2 version of gcm_enc/dec engaged.
[   10.020328] AES CTR mode by8 optimization enabled
[   10.024120] systemd-udevd[1427]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   10.025845] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.089758] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.092829] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[   10.113060] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   10.114044] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95762) rev 5762100] (PCI Express) MAC address fc:3f:db:fc:10:9f
[   10.120860] tg3 0000:01:00.0 eth0: attached PHY is 5762C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   10.121311] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   10.121588] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   10.141135] snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[   10.156355] Intel(R) Wireless WiFi driver for Linux
[   10.162066] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input15
[   10.163016] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/sound/card0/input16
[   10.163881] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/sound/card0/input17
[   10.165613] iwlwifi 0000:02:00.0: loaded firmware version 29.1044073957.0 7265D-29.ucode op_mode iwlmvm
[   10.170553] snd_hda_codec_generic hdaudioC1D0: autoconfig for Generic: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   10.171019] snd_hda_codec_generic hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.171349] snd_hda_codec_generic hdaudioC1D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[   10.171662] snd_hda_codec_generic hdaudioC1D0:    mono: mono_out=0x0
[   10.171901] snd_hda_codec_generic hdaudioC1D0:    inputs:
[   10.172111] snd_hda_codec_generic hdaudioC1D0:      Internal Mic=0x1a
[   10.172358] snd_hda_codec_generic hdaudioC1D0:      Mic=0x19
[   10.194871] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/sound/card0/input18
[   10.196005] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:09.2/sound/card1/input19
[   10.196800] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:09.2/sound/card1/input20
[   10.341545] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
[   10.347851] thermal thermal_zone5: failed to read out thermal zone (-61)
[   10.370248] iwlwifi 0000:02:00.0: base HW address: 18:5e:0f:ef:3f:49, OTP minor version: 0x0
[   10.442314] systemd-udevd[1415]: Using default interface naming scheme 'v243'.
[   10.450847] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   10.460077] systemd-udevd[1415]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   10.461982] systemd-udevd[1430]: Using default interface naming scheme 'v243'.
[   10.472784] systemd-udevd[1430]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   10.990278] SVM: TSC scaling supported
[   10.992345] kvm: Nested Virtualization enabled
[   10.994632] SVM: kvm: Nested Paging enabled
[   10.997010] SVM: Virtual GIF supported
[   10.999325] SVM: LBR virtualization supported

...

[   11.923155] Adding 15721468k swap on /dev/sda1.  Priority:-2 extents:1 across:15721468k SS
[   11.959678] EXT4-fs (sda2): re-mounted c34989f9-7c8f-49ae-8285-7896af84c685. Quota mode: disabled.
[   12.431892] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[   12.457215] loop: module loaded
[   12.583033] EXT4-fs (sda5): mounted filesystem d78a2e53-75c6-4d4a-887c-f4a66a64ba8c with ordered data mode. Quota mode: disabled.
[   12.586978] tg3 0000:01:00.0 eth0: Link is up at 100 Mbps, full duplex
[   12.588511] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   12.589552] /dev/stick1: Can't open blockdev
[   12.589847] tg3 0000:01:00.0 eth0: EEE is disabled
[   12.593385] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.638763] ------------[ cut here ]------------
[   15.638772] ------------[ cut here ]------------
[   15.638910] refcount_t: underflow; use-after-free.
[   15.638937] WARNING: CPU: 1 PID: 1214 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[   15.639052] refcount_t: saturated; leaking memory.
[   15.639078] WARNING: CPU: 3 PID: 2437 at lib/refcount.c:19 refcount_warn_saturate+0x74/0x110
[   15.639192] Modules linked in: loop
[   15.639433] Modules linked in: loop
[   15.639574]  dm_crypt dm_mod edac_mce_amd
[   15.639815]  dm_crypt dm_mod
[   15.639919]  kvm_amd ccp rng_core kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel iwlmvm sha512_ssse3 sha512_generic mac80211 libarc4 snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi iwlwifi snd_hda_intel snd_intel_dspcfg snd_hda_codec aesni_intel
[   15.639941]  edac_mce_amd kvm_amd
[   15.640045]  snd_hda_core
[   15.640047]  ccp
[   15.640049]  crypto_simd pcspkr
[   15.640167]  rng_core kvm irqbypass
[   15.640254]  cryptd snd_pcm
[   15.641109]  crct10dif_pclmul
[   15.641215]  fam15h_power cfg80211
[   15.641311]  crc32_pclmul crc32c_intel
[   15.641380]  snd_timer k10temp
[   15.641494]  ghash_clmulni_intel
[   15.641496]  snd
[   15.641499]  iwlmvm sha512_ssse3 sha512_generic
[   15.641623]  rfkill tg3 soundcore
[   15.641725]  mac80211
[   15.641727]  battery acpi_cpufreq ac
[   15.641834]  libarc4 snd_hda_codec_generic
[   15.641955]  button input_leds
[   15.642089]  ledtrig_audio snd_hda_codec_hdmi
[   15.642199]  led_class psmouse
[   15.642315]  iwlwifi snd_hda_intel
[   15.642385]  serio_raw amdgpu drm_buddy
[   15.642545]  snd_intel_dspcfg snd_hda_codec
[   15.642663]  gpu_sched
[   15.642665]  aesni_intel
[   15.642667]  drm_display_helper video wmi
[   15.642752]  snd_hda_core crypto_simd

[   15.642881]  pcspkr cryptd
[   15.643026] CPU: 1 PID: 1214 Comm: sdma1 Not tainted 6.1.0+ #1
[   15.643135]  snd_pcm fam15h_power
[   15.643288] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   15.643291] RIP: 0010:refcount_warn_saturate+0xba/0x110
[   15.643399]  cfg80211 snd_timer k10temp
[   15.643521] Code: 07 01 e8 3d 7b 52 00 0f 0b e9 92 ec 57 00 80 3d 0e 1e ee 07 00 75 85 48 c7 c7 78 20 fe 81 c6 05 fe 1d ee 07 01 e8 1a 7b 52 00 <0f> 0b e9 6f ec 57 00 80 3d e9 1d ee 07 00 0f 85 5e ff ff ff 48 c7
[   15.643657]  snd rfkill
[   15.643805] RSP: 0018:ffffc90000acbe60 EFLAGS: 00010286
[   15.643892]  tg3 soundcore battery

[   15.643986] RAX: 0000000000000026 RBX: ffff888103624040 RCX: 0000000000000027
[   15.644127]  acpi_cpufreq ac button
[   15.644257] RDX: ffff88842f49f3c8 RSI: 0000000000000001 RDI: ffff88842f49f3c0
[   15.644260] RBP: ffff8881051531f0 R08: 80000000fff003ff R09: ffffc90000acbe00
[   15.644316]  input_leds led_class
[   15.644415] R10: 0000000000000001 R11: ffffffffffffffff R12: ffff88810e2bdc00
[   15.644417] R13: ffff88810e2bdc78 R14: ffff888103624000 R15: ffff8881051cd008
[   15.644622]  psmouse
[   15.644739] FS:  0000000000000000(0000) GS:ffff88842f480000(0000) knlGS:0000000000000000
[   15.645011]  serio_raw amdgpu drm_buddy
[   15.645193] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.645195] CR2: 00005563d7a6d000 CR3: 0000000103e9c000 CR4: 00000000001506e0
[   15.645329]  gpu_sched drm_display_helper video
[   15.645962] Call Trace:
[   15.645965]  <TASK>
[   15.646052]  wmi
[   15.646057] CPU: 3 PID: 2437 Comm: Xorg Not tainted 6.1.0+ #1
[   15.646235]  drm_sched_entity_pop_job+0xfb/0x430 [gpu_sched]
[   15.646357] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   15.646360] RIP: 0010:refcount_warn_saturate+0x74/0x110
[   15.646416]  drm_sched_main+0x99/0x3f0 [gpu_sched]
[   15.646662] Code: 07 01 e8 83 7b 52 00 0f 0b e9 d8 ec 57 00 80 3d 57 1e ee 07 00 75 cb 48 c7 c7 20 20 fe 81 c6 05 47 1e ee 07 01 e8 60 7b 52 00 <0f> 0b e9 b5 ec 57 00 80 3d 32 1e ee 07 00 75 a8 48 c7 c7 48 20 fe
[   15.646785]  ? __pfx_autoremove_wake_function+0x10/0x10
[   15.647030] RSP: 0000:ffffc90001b33ca0 EFLAGS: 00010286
[   15.647276]  ? __pfx_drm_sched_main+0x10/0x10 [gpu_sched]
[   15.647394] RAX: 0000000000000026 RBX: ffffc90001b33ce0 RCX: 0000000000000027
[   15.647397] RDX: ffff88842f59f3c8 RSI: 0000000000000001 RDI: ffff88842f59f3c0
[   15.647640]  kthread+0xd4/0x100
[   15.647886] RBP: ffff888103624040 R08: 80000000fff00401 R09: ffffc90001b33c40
[   15.647888] R10: 0000000000000001 R11: ffffffffffffffff R12: 00000000ffffffff
[   15.647967]  ? __pfx_kthread+0x10/0x10
[   15.648244] R13: ffff888103624040 R14: ffff88810e968058 R15: ffff888000000000
[   15.648247]  ret_from_fork+0x2c/0x50
[   15.648383] FS:  00007f385db36a00(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   15.648586]  </TASK>
[   15.648588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.648591] CR2: 00007f37d3016df0 CR3: 0000000103e9c000 CR4: 00000000001506e0
[   15.648833] ---[ end trace 0000000000000000 ]---
[   15.654004] Call Trace:
[   15.654006]  <TASK>
[   15.654007]  dma_resv_iter_walk_unlocked.part.0+0x147/0x180
[   15.654015]  dma_resv_iter_first_unlocked+0x25/0x70
[   15.654018]  dma_resv_test_signaled+0x22/0xb0
[   15.654021]  ttm_bo_vm_fault_reserved+0x43/0x350
[   15.654886]  amdgpu_gem_fault+0x7f/0xf0 [amdgpu]
[   15.655696]  __do_fault+0x41/0x240
[   15.655974]  __handle_mm_fault+0xcf4/0x1740
[   15.655978]  ? do_mmap+0x33d/0x4f0
[   15.655981]  handle_mm_fault+0xb5/0x180
[   15.655984]  do_user_addr_fault+0x19b/0x6b0
[   15.656574]  exc_page_fault+0x6d/0x140
[   15.656715]  asm_exc_page_fault+0x22/0x30
[   15.656723] RIP: 0033:0x7f385d17b1bb
[   15.657027] Code: 00 00 48 01 d6 48 01 d7 4c 8d 1d 00 0b 05 00 49 63 14 93 49 8d 14 13 ff e2 0f 0b 0f 1f 40 00 48 81 ea 80 00 00 00 0f 28 4e f0 <0f> 29 4f f0 0f 28 56 e0 0f 29 57 e0 0f 28 5e d0 0f 29 5f d0 0f 28
[   15.657030] RSP: 002b:00007ffdc75943a8 EFLAGS: 00010202
[   15.657032] RAX: 00007f37d3015000 RBX: 00007f37d3015000 RCX: 0000000000010000
[   15.657034] RDX: 0000000000001d80 RSI: 00007f37f000ae00 RDI: 00007f37d3016e00
[   15.658395] RBP: 0000000000000001 R08: 00007f37d3016df0 R09: 0000000000000000
[   15.658396] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000080e1
[   15.658397] R13: 00005563d7c23e78 R14: 00007f37f0009000 R15: 0000000000001e00
[   15.658400]  </TASK>
[   15.659189] ---[ end trace 0000000000000000 ]---
[   15.668798] ------------[ cut here ]------------
[   15.669007] refcount_t: saturated; leaking memory.
[   15.669201] WARNING: CPU: 1 PID: 2479 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
[   15.669492] Modules linked in: loop dm_crypt dm_mod edac_mce_amd kvm_amd ccp rng_core kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel iwlmvm sha512_ssse3 sha512_generic mac80211 libarc4 snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi iwlwifi snd_hda_intel snd_intel_dspcfg snd_hda_codec aesni_intel snd_hda_core crypto_simd pcspkr cryptd snd_pcm fam15h_power cfg80211 snd_timer k10temp snd rfkill tg3 soundcore battery acpi_cpufreq ac button input_leds led_class psmouse serio_raw amdgpu drm_buddy gpu_sched drm_display_helper video wmi
[   15.671256] CPU: 1 PID: 2479 Comm: Xorg:cs0 Tainted: G        W          6.1.0+ #1
[   15.671510] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   15.671774] RIP: 0010:refcount_warn_saturate+0x51/0x110
[   15.671954] Code: 84 bc 00 00 00 e9 ff ec 57 00 85 f6 74 23 80 3d 79 1e ee 07 00 75 ee 48 c7 c7 20 20 fe 81 c6 05 69 1e ee 07 01 e8 83 7b 52 00 <0f> 0b e9 d8 ec 57 00 80 3d 57 1e ee 07 00 75 cb 48 c7 c7 20 20 fe
[   15.672626] RSP: 0018:ffffc90000beb820 EFLAGS: 00010282
[   15.672812] RAX: 0000000000000026 RBX: ffff888103624040 RCX: 0000000000000027
[   15.672815] RDX: ffff88842f49f3c8 RSI: 0000000000000001 RDI: ffff88842f49f3c0
[   15.672816] RBP: 0000000000000003 R08: 0000000000000058 R09: 00000000ffefffff
[   15.672818] R10: ffffffff8224a280 R11: 0000000000000003 R12: ffff888105153000
[   15.672820] R13: ffff8881051c0000 R14: ffff888105493f48 R15: ffff888105153000
[   15.672822] FS:  00007f38541ff640(0000) GS:ffff88842f480000(0000) knlGS:0000000000000000
[   15.672824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.672826] CR2: 00005563d7a6d000 CR3: 0000000103e9c000 CR4: 00000000001506e0
[   15.672828] Call Trace:
[   15.674888]  <TASK>
[   15.674889]  amdgpu_sync_resv+0x191/0x1e0 [amdgpu]
[   15.675956]  amdgpu_vm_sdma_prepare.part.0+0x4b/0x90 [amdgpu]
[   15.677154]  amdgpu_vm_update_range+0x140/0x6e0 [amdgpu]
[   15.678185]  amdgpu_vm_bo_update+0x32e/0x570 [amdgpu]
[   15.679068]  amdgpu_vm_handle_moved+0x5e/0x120 [amdgpu]
[   15.679999]  amdgpu_cs_ioctl+0x1289/0x1e00 [amdgpu]
[   15.681234]  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
[   15.682257]  drm_ioctl_kernel+0xbf/0x160
[   15.682398]  drm_ioctl+0x21c/0x500
[   15.682517]  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
[   15.683403]  ? futex_wake+0x6d/0x160
[   15.683533]  amdgpu_drm_ioctl+0x5e/0xb0 [amdgpu]
[   15.684394]  __x64_sys_ioctl+0xb6/0xd0
[   15.684589]  ? exit_to_user_mode_prepare+0x97/0x140
[   15.684774]  do_syscall_64+0x3a/0x90
[   15.684784]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   15.685094] RIP: 0033:0x7f385d12d957
[   15.685229] Code: 3c 1c 48 f7 d8 4c 39 e0 77 b9 e8 24 ff ff ff 85 c0 78 be 4c 89 e0 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 94 0c 00 f7 d8 64 89 01 48
[   15.685232] RSP: 002b:00007f38541fe868 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   15.685236] RAX: ffffffffffffffda RBX: 00007f38541fe8d0 RCX: 00007f385d12d957
[   15.685238] RDX: 00007f38541fe8d0 RSI: 00000000c0186444 RDI: 000000000000000e
[   15.685239] RBP: 00000000c0186444 R08: 00007f38541fea00 R09: 0000000000000020
[   15.685241] R10: 00007f38541fea00 R11: 0000000000000246 R12: 00005563d7964490
[   15.685242] R13: 000000000000000e R14: 0000000000000000 R15: 00005563d7b4f6a0
[   15.685245]  </TASK>
[   15.685247] ---[ end trace 0000000000000000 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
