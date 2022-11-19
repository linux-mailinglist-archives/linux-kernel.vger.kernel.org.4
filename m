Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1FD631046
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiKSS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiKSS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 13:27:01 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF16461
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 10:26:56 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 11925 invoked from network); 19 Nov 2022 19:26:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1668882412; bh=JiDeIKKQfSQrplNYPsSN+J6zD/aol+A33Vksvn/hxg0=;
          h=Subject:To:Cc:From;
          b=oNKOHWwiFOxiPk7iTL3MZBNbt+S0L4f8l4OYx1lQwu7AvTX2/nxRv15ZhzT39yi+G
           1YXHrFjltEhxbIpqnzsxguPkbWlJoyWxdmX3Heh7SMl+PCevX22aaEJHo1iyvBeOx/
           1yiU8CGcHSgEgPbqLMPLLCUd+j0M+SYeXmlX8t9Y=
Received: from aafn183.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.143.183])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <brian.gix@intel.com>; 19 Nov 2022 19:26:52 +0100
Message-ID: <5a49e718-bf8e-753b-2ac4-5e4c95cf8955@o2.pl>
Date:   Sat, 19 Nov 2022 19:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Content-Language: en-GB
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     luiz.dentz@gmail.com, "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
References: <20221102175927.401091-1-brian.gix@intel.com>
 <20221102175927.401091-2-brian.gix@intel.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: d08c0637f4bb6a22f4b364d115aa5549
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [QVN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 2.11.2022 o 18:59, Brian Gix pisze:
> The msft_set_filter_enable() command was using the deprecated
> hci_request mechanism rather than hci_sync. This caused the warning error:
> hci0: HCI_REQ-0xfcf0
>
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
>  net/bluetooth/msft.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)

Hello,

On the first time I was testing this patch, I was heavily testing
various Bluetooth functionality. Eventually, something stopped working
and I was no longer able to establish a Bluetooth connection between
my mobile phone and my laptop. To try to resolve this issue, I tried suspending
my laptop, but after resume, I got a kernel panic (dmesg attached below, I may
provide journal extracts on request).

Unfortunately, I am unable to reproduce this issue. Just before this,
I was trying to stream music from my laptop to mobile phone by Bluetooth.
I was trying various knobs and options, but without installing proprietary codecs.
I do not use Bluetooth audio normally.

Rough testing notes:

1. Sending an image file to mobile phone - OK.
2. Sending an image file from mobile phone to laptop - failed somehow,
    turning Bluetooth on and off on mobile phone helped.
3. Bluetooth network tethering from mobile phone - OK.
4. Sending an image file from mobile phone to laptop - worked
    (though slow, but it has always been this way).
5. Sending audio from my laptop to mobile phone - failed
    (probably because I did not install proprietary media codecs).

Today, I have successfully configured a BLE server on my laptop roughly using this guide:
https://punchthrough.com/creating-a-ble-peripheral-with-bluez/
and verified it with the "BLE Scanner (Connect & Notify)" tool from Google Play
(the BLE apps from F-Droid I have tried have limited functionality).
This is (from what I understand) the functionality this patch touches.

Today, sending / receiving image files from / to mobile phone works correctly,
but is slow as always (roughly ~100kB/s).

I don't see the following messages in dmesg any more:
      hci0: HCI_REQ-0xfcf0
but I see the following ones:
      Bluetooth: hci0: HCI_REQ-0x0401
which are triggered by "hcitool scan".

I'm also seeing things like this in "dmesg --level err":

[ 4627.435040] Bluetooth: hci0: Opcode 0x 401 failed: -16
[ 4633.217405] Bluetooth: hci0: HCI_REQ-0x0401
[ 4637.336968] Bluetooth: hci0: Opcode 0x 401 failed: -16
[ 4647.433017] Bluetooth: hci0: Opcode 0x 401 failed: -16
[ 4658.855938] Bluetooth: Frame is too long (len 8, expected len 4)
[ 4658.857868] Bluetooth: Frame is too long (len 12, expected len 5)
[ 4688.427075] Bluetooth: hci0: Opcode 0x 401 failed: -16
[ 4707.594811] rtw_8822be 0000:02:00.0: coex request time out

but don't know yet if they are connected and occur on older kernels also.

I'll leave it to Mr Luiz Augusto von Dentz to determine if this testing is enough.

Greetings,

Mateusz

-----------------

Laptop: HP 17-by0001nw, Ubuntu 20.04,
"Realtek RTL8822BE 802.11 ac 2×2 WiFi + Bluetooth 4.2 Combo Adapter (MU-MIMO supported)"
Sometimes (rarely), I see "AER: Multiple Corrected error received" errors for this device (on the PCI / WiFi side).

Mobile phone: Sony Xperia 10 i4113 with LineageOS 19.1 / Android 12L,

hcitool info output:

                BD Address:  38:78:62:66:AC:9B
                OUI Company: Sony Mobile Communications Inc (38-78-62)
                Device Name: I4113
                LMP Version: 5.0 (0x9) LMP Subversion: 0x2be
                Manufacturer: Qualcomm (29)
                Features page 0: 0xff 0xfe 0x8f 0xfe 0xd8 0x3f 0x5b 0x87
                        <3-slot packets> <5-slot packets> <encryption> <slot offset>
                        <timing accuracy> <role switch> <hold mode> <sniff mode>
                        <RSSI> <channel quality> <SCO link> <HV2 packets>
                        <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                        <power control> <transparent SCO> <broadcast encrypt>
                        <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                        <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                        <extended SCO> <AFH cap. slave> <AFH class. slave>
                        <LE support> <3-slot EDR ACL> <5-slot EDR ACL>
                        <sniff subrating> <pause encryption> <AFH cap. master>
                        <AFH class. master> <EDR eSCO 2 Mbps> <extended inquiry>
                        <LE and BR/EDR> <simple pairing> <encapsulated PDU>
                        <non-flush flag> <LSTO> <inquiry TX power> <EPC>
                        <extended features>
                Features page 1: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00

--------------

dmesg after kernel panic (from pstore):

Panic#2 Part15
<6>[  843.981950] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822b_fw.bin
<6>[  843.982034] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822b_config.bin
<6>[  843.982071] Bluetooth: hci0: RTL: cfg_sz 14, total sz 20270
<4>[  843.996623] done.
<5>[  843.996642] random: crng reseeded on system resumption
<6>[  844.002354] PM: suspend exit
<6>[  844.079998]  sdc: sdc1
<6>[  844.465016] Generic FE-GE Realtek PHY r8169-0-100:00: attached PHY driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
<6>[  844.624126] r8169 0000:01:00.0 enp1s0: Link is Down
<6>[  844.725021] Bluetooth: hci0: RTL: fw version 0xab6b705c
<6>[  844.792238] Bluetooth: MGMT ver 1.22
<6>[  911.157979] input: I4113 (AVRCP) as /devices/virtual/input/input28
<3>[  913.752689] Bluetooth: hci0: SCO packet for unknown connection handle 2
<3>[  913.752693] Bluetooth: hci0: SCO packet for unknown connection handle 2
<3>[  913.752697] Bluetooth: hci0: SCO packet for unknown connection handle 2
<3>[ 1417.158396] Bluetooth: hci0: HCI_REQ-0x0401
<3>[ 1491.031848] Bluetooth: hci0: HCI_REQ-0x0401
<3>[ 1560.106722] Bluetooth: hci0: HCI_REQ-0x0401
<3>[ 1675.442588] Bluetooth: hci0: HCI_REQ-0x0401
<6>[ 1676.503967] wlp2s0: authenticate with 50:c7:bf:2c:a9:32
<6>[ 1676.503984] wlp2s0: 80 MHz not supported, disabling VHT
<6>[ 1676.986692] wlp2s0: send auth to 50:c7:bf:2c:a9:32 (try 1/3)
<6>[ 1677.050265] wlp2s0: authenticated
<6>[ 1677.051683] wlp2s0: associate with 50:c7:bf:2c:a9:32 (try 1/3)
<6>[ 1677.053975] wlp2s0: RX AssocResp from 50:c7:bf:2c:a9:32 (capab=0x431 status=0 aid=6)
<6>[ 1677.054248] wlp2s0: associated
<6>[ 1677.079041] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
<6>[ 1745.214391] wlp2s0: deauthenticating from 50:c7:bf:2c:a9:32 by local choice (Reason: 3=DEAUTH_LEAVING)
Panic#2 Part14
<6>[ 1748.491602] PM: suspend entry (deep)
<6>[ 1748.538479] Filesystems sync: 0.046 seconds
<6>[ 1748.635818] Freezing user space processes ... (elapsed 0.080 seconds) done.
<6>[ 1748.716711] OOM killer disabled.
<6>[ 1748.716714] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
<6>[ 1748.719025] printk: Suspending console(s) (use no_console_suspend to debug)
<5>[ 1748.727478] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
<5>[ 1748.727527] sd 0:0:0:0: [sda] Synchronizing SCSI cache
<5>[ 1748.727688] sd 1:0:0:0: [sdb] Stopping disk
<5>[ 1748.727743] sd 0:0:0:0: [sda] Stopping disk
<6>[ 1749.647886] ACPI: EC: interrupt blocked
<6>[ 1749.677630] ACPI: PM: Preparing to enter system sleep state S3
<6>[ 1749.678568] ACPI: EC: event blocked
<6>[ 1749.678571] ACPI: EC: EC stopped
<6>[ 1749.678573] ACPI: PM: Saving platform NVS memory
<6>[ 1749.678725] Disabling non-boot CPUs ...
<6>[ 1749.680769] smpboot: CPU 1 is now offline
<6>[ 1749.683467] smpboot: CPU 2 is now offline
<6>[ 1749.686769] smpboot: CPU 3 is now offline
<6>[ 1749.690874] ACPI: PM: Low-level resume complete
<0>[ 1749.690904] traps: PANIC: double fault, error_code: 0xffffffffbb0d0203
<1>[ 1749.690910] BUG: unable to handle page fault for address: fffffe000000b000
<1>[ 1749.690911] #PF: supervisor read access in kernel mode
<1>[ 1749.690913] #PF: error_code(0x0000) - not-present page
<6>[ 1749.690914] PGD 46eff4067 P4D 46eff4067 PUD 46eff3067 PMD 46eff1067 PTE 0
<4>[ 1749.690918] Oops: 0000 [#1] PREEMPT SMP PTI
<4>[ 1749.690921] CPU: 0 PID: 15 Comm: rcu_preempt Not tainted 6.1.0-rc5unif9-00001-g4b27c67b41bf #264
<4>[ 1749.690924] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/29/2022
<4>[ 1749.690925] RIP: 0010:__die_header+0x22/0x82
Panic#2 Part13
<4>[ 1749.690930] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
<4>[ 1749.690933] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1749.690935] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1749.690936] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1749.690937] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1749.690938] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1749.690939] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1749.690941] FS:  0000000000000000(0000) GS:ffff95981ec00000(0000) knlGS:0000000000000000
<4>[ 1749.690942] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1749.690944] CR2: fffffe000000b000 CR3: 00000001e437e001 CR4: 00000000003706f0
<4>[ 1749.690945] Call Trace:
<4>[ 1749.690946]  <#DF>
<4>[ 1749.690948]  __die+0x1d/0x37
<4>[ 1749.690952]  die+0x30/0x60
<4>[ 1749.690955]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.690959]  exc_double_fault+0x175/0x190
<4>[ 1749.690963]  asm_exc_double_fault+0x1f/0x50
<4>[ 1749.690968]  </#DF>
<4>[ 1749.690969]  <TASK>
<4>[ 1749.690970]  ? __switch_to+0x141/0x4e0
<4>[ 1749.690971]  ? __switch_to_asm+0x34/0x60
<4>[ 1749.690975]  ? __schedule+0xb45/0x17e0
<4>[ 1749.690979]  ? rcu_accelerate_cbs+0x22/0x80
<4>[ 1749.690982]  ? rcu_gp_cleanup+0x332/0x4c0
<4>[ 1749.690985]  ? schedule+0x6b/0x110
<4>[ 1749.690988]  ? rcu_gp_kthread+0x112/0x170
<4>[ 1749.690991]  ? rcu_gp_cleanup+0x4c0/0x4c0
<4>[ 1749.690993]  ? kthread+0xff/0x130
<4>[ 1749.690996]  ? kthread_complete_and_exit+0x20/0x20
<4>[ 1749.690998]  ? ret_from_fork+0x22/0x30
Panic#2 Part12
<4>[ 1749.691002]  </TASK>
<4>[ 1749.691003] Modules linked in: rfcomm ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables xt_conntrack iptable_filter xt_REDIRECT xt_owner xt_set xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter ip_set_hash_ip ip_set nfnetlink algif_hash algif_skcipher af_alg bnep nls_iso8859_1 snd_hda_codec_hdmi snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio mei_pxp snd_hda_intel snd_intel_dspcfg intel_rapl_msr snd_hda_codec snd_hda_core snd_hwdep snd_pcm intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp btusb binfmt_misc btrtl kvm_intel uvcvideo btbcm snd_seq_midi kvm btintel snd_seq_midi_event btmtk videobuf2_vmalloc rtw88_8822be videobuf2_memops rapl snd_rawmidi intel_cstate bluetooth joydev videobuf2_v4l2 videobuf2_common rtw88_8822b snd_seq ecdh_generic ecc rtw88_pci hp_wmi input_leds sparse_keymap platform_profile videodev rtw88_core wmi_bmof serio_raw mc snd_seq_device snd_timer intel_wmi_thunderbolt
mac80211 ee1004
<4>[ 1749.691049]  snd processor_thermal_device_pci_legacy cfg80211 soundcore processor_thermal_device processor_thermal_rfim processor_thermal_mbox libarc4 intel_pch_thermal mei_me processor_thermal_rapl intel_xhci_usb_role_switch intel_rapl_common mei intel_soc_dts_iosf int3403_thermal int340x_thermal_zone int3400_thermal wireless_hotkey acpi_thermal_rel acpi_pad sch_fq_codel coretemp parport_pc parport ramoops reed_solomon ip_tables x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic uas usb_storage usbhid i915 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel drm_buddy sha512_ssse3 aesni_intel nvme drm_display_helper psmouse crypto_simd cryptd nvme_core i2c_i801 i2c_smbus xhci_pci cec xhci_pci_renesas i2c_hid_acpi i2c_hid video hid wmi
Panic#2 Part11
<4>[ 1749.691081] CR2: fffffe000000b000
<4>[ 1749.691083] ---[ end trace 0000000000000000 ]---
<4>[ 1749.692130] ------------[ cut here ]------------
<4>[ 1749.692130] WARNING: CPU: 0 PID: 15 at arch/x86/kernel/fpu/core.c:60 irq_fpu_usable+0x3e/0x50
<4>[ 1749.692136] Modules linked in: rfcomm ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables xt_conntrack iptable_filter xt_REDIRECT xt_owner xt_set xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter ip_set_hash_ip ip_set nfnetlink algif_hash algif_skcipher af_alg bnep nls_iso8859_1 snd_hda_codec_hdmi snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio mei_pxp snd_hda_intel snd_intel_dspcfg intel_rapl_msr snd_hda_codec snd_hda_core snd_hwdep snd_pcm intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp btusb binfmt_misc btrtl kvm_intel uvcvideo btbcm snd_seq_midi kvm btintel snd_seq_midi_event btmtk videobuf2_vmalloc rtw88_8822be videobuf2_memops rapl snd_rawmidi intel_cstate bluetooth joydev videobuf2_v4l2 videobuf2_common rtw88_8822b snd_seq ecdh_generic ecc rtw88_pci hp_wmi input_leds sparse_keymap platform_profile videodev rtw88_core wmi_bmof serio_raw mc snd_seq_device snd_timer intel_wmi_thunderbolt
mac80211 ee1004
Panic#2 Part10
<4>[ 1749.692172]  snd processor_thermal_device_pci_legacy cfg80211 soundcore processor_thermal_device processor_thermal_rfim processor_thermal_mbox libarc4 intel_pch_thermal mei_me processor_thermal_rapl intel_xhci_usb_role_switch intel_rapl_common mei intel_soc_dts_iosf int3403_thermal int340x_thermal_zone int3400_thermal wireless_hotkey acpi_thermal_rel acpi_pad sch_fq_codel coretemp parport_pc parport ramoops reed_solomon ip_tables x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic uas usb_storage usbhid i915 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel drm_buddy sha512_ssse3 aesni_intel nvme drm_display_helper psmouse crypto_simd cryptd nvme_core i2c_i801 i2c_smbus xhci_pci cec xhci_pci_renesas i2c_hid_acpi i2c_hid video hid wmi
<4>[ 1749.692198] CPU: 0 PID: 15 Comm: rcu_preempt Tainted: G      D            6.1.0-rc5unif9-00001-g4b27c67b41bf #264
<4>[ 1749.692200] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/29/2022
<4>[ 1749.692201] RIP: 0010:irq_fpu_usable+0x3e/0x50
<4>[ 1749.692204] Code: f0 00 75 26 65 8a 0d 29 05 fe 44 31 c0 84 c9 75 13 b8 01 00 00 00 f7 c2 00 00 0f 00 74 06 80 e6 ff 0f 94 c0 5d c3 cc cc cc cc <0f> 0b 31 c0 5d c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 0f 1f 44 00
<4>[ 1749.692206] RSP: 0018:fffffe000000a8d8 EFLAGS: 00010006
<4>[ 1749.692207] RAX: 0000000000110003 RBX: 0000000000000003 RCX: ffff9594c01edfe0
<4>[ 1749.692209] RDX: 0000000080110003 RSI: ffff959647c12fe0 RDI: 0000000000000001
<4>[ 1749.692210] RBP: fffffe000000a8d8 R08: ffffffffbca10000 R09: fffffffffffffff8
Panic#2 Part9
<4>[ 1749.692211] R10: 0000000000ffff0a R11: 0000000000000004 R12: 8000000000000006
<4>[ 1749.692212] R13: 0000000000000007 R14: fffffe000000a958 R15: fffffe000000a960
<4>[ 1749.692213] FS:  0000000000000000(0000) GS:ffff95981ec00000(0000) knlGS:0000000000000000
<4>[ 1749.692215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1749.692216] CR2: fffffe000000b000 CR3: 00000001e437e001 CR4: 00000000003706f0
<4>[ 1749.692218] Call Trace:
<4>[ 1749.692218]  <#DF>
<4>[ 1749.692219]  kernel_fpu_begin_mask+0x2e/0xe0
<4>[ 1749.692222]  ? down_trylock+0x2e/0x40
<4>[ 1749.692224]  virt_efi_query_variable_info_nonblocking+0x66/0x140
<4>[ 1749.692228]  efi_query_variable_store+0xb2/0x1a0
<4>[ 1749.692231]  efivar_set_variable_locked+0xb2/0xf0
<4>[ 1749.692236]  efi_pstore_write+0x154/0x1d0
<4>[ 1749.692240]  pstore_dump+0x122/0x340
<4>[ 1749.692244]  ? efi_pstore_read+0xf0/0xf0
<4>[ 1749.692246]  ? pstore_dump+0x122/0x340
<4>[ 1749.692251]  kmsg_dump+0x63/0x80
<4>[ 1749.692253]  oops_exit.cold+0x18/0x1e
<4>[ 1749.692255]  oops_end+0x4d/0xa0
<4>[ 1749.692258]  page_fault_oops+0x169/0x290
<4>[ 1749.692262]  ? __die_header+0x22/0x82
<4>[ 1749.692265]  ? search_exception_tables+0x5f/0x70
<4>[ 1749.692269]  kernelmode_fixup_or_oops.constprop.0+0x96/0xf0
<4>[ 1749.692273]  __bad_area_nosemaphore.constprop.0+0x157/0x190
<4>[ 1749.692277]  bad_area_nosemaphore+0x13/0x20
<4>[ 1749.692280]  do_kern_addr_fault+0x87/0xa0
<4>[ 1749.692283]  exc_page_fault+0xd8/0x180
<4>[ 1749.692286]  asm_exc_page_fault+0x27/0x30
<4>[ 1749.692288] RIP: 0010:__die_header+0x22/0x82
<4>[ 1749.692291] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
Panic#2 Part8
<4>[ 1749.692293] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1749.692295] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1749.692296] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1749.692297] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1749.692298] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1749.692299] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1749.692300]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692302]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692304]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692307]  __die+0x1d/0x37
<4>[ 1749.692310]  die+0x30/0x60
<4>[ 1749.692312]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692314]  exc_double_fault+0x175/0x190
<4>[ 1749.692317]  asm_exc_double_fault+0x1f/0x50
<4>[ 1749.692322]  </#DF>
<4>[ 1749.692322]  <TASK>
<4>[ 1749.692323]  ? __switch_to+0x141/0x4e0
<4>[ 1749.692324]  ? __switch_to_asm+0x34/0x60
<4>[ 1749.692327]  ? __schedule+0xb45/0x17e0
<4>[ 1749.692331]  ? rcu_accelerate_cbs+0x22/0x80
<4>[ 1749.692333]  ? rcu_gp_cleanup+0x332/0x4c0
<4>[ 1749.692336]  ? schedule+0x6b/0x110
<4>[ 1749.692339]  ? rcu_gp_kthread+0x112/0x170
<4>[ 1749.692342]  ? rcu_gp_cleanup+0x4c0/0x4c0
<4>[ 1749.692344]  ? kthread+0xff/0x130
<4>[ 1749.692347]  ? kthread_complete_and_exit+0x20/0x20
<4>[ 1749.692349]  ? ret_from_fork+0x22/0x30
<4>[ 1749.692353]  </TASK>
<4>[ 1749.692354] ---[ end trace 0000000000000000 ]---
<4>[ 1749.692356] ------------[ cut here ]------------
<4>[ 1749.692356] WARNING: CPU: 0 PID: 15 at arch/x86/kernel/fpu/core.c:427 kernel_fpu_begin_mask+0xc2/0xe0
Panic#2 Part7
<4>[ 1749.692360] Modules linked in: rfcomm ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables xt_conntrack iptable_filter xt_REDIRECT xt_owner xt_set xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter ip_set_hash_ip ip_set nfnetlink algif_hash algif_skcipher af_alg bnep nls_iso8859_1 snd_hda_codec_hdmi snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio mei_pxp snd_hda_intel snd_intel_dspcfg intel_rapl_msr snd_hda_codec snd_hda_core snd_hwdep snd_pcm intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp btusb binfmt_misc btrtl kvm_intel uvcvideo btbcm snd_seq_midi kvm btintel snd_seq_midi_event btmtk videobuf2_vmalloc rtw88_8822be videobuf2_memops rapl snd_rawmidi intel_cstate bluetooth joydev videobuf2_v4l2 videobuf2_common rtw88_8822b snd_seq ecdh_generic ecc rtw88_pci hp_wmi input_leds sparse_keymap platform_profile videodev rtw88_core wmi_bmof serio_raw mc snd_seq_device snd_timer intel_wmi_thunderbolt
mac80211 ee1004
<4>[ 1749.692395]  snd processor_thermal_device_pci_legacy cfg80211 soundcore processor_thermal_device processor_thermal_rfim processor_thermal_mbox libarc4 intel_pch_thermal mei_me processor_thermal_rapl intel_xhci_usb_role_switch intel_rapl_common mei intel_soc_dts_iosf int3403_thermal int340x_thermal_zone int3400_thermal wireless_hotkey acpi_thermal_rel acpi_pad sch_fq_codel coretemp parport_pc parport ramoops reed_solomon ip_tables x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic uas usb_storage usbhid i915 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel drm_buddy sha512_ssse3 aesni_intel nvme drm_display_helper psmouse crypto_simd cryptd nvme_core i2c_i801 i2c_smbus xhci_pci cec xhci_pci_renesas i2c_hid_acpi i2c_hid video hid wmi
Panic#2 Part6
<4>[ 1749.692420] CPU: 0 PID: 15 Comm: rcu_preempt Tainted: G      D W          6.1.0-rc5unif9-00001-g4b27c67b41bf #264
<4>[ 1749.692422] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/29/2022
<4>[ 1749.692423] RIP: 0010:kernel_fpu_begin_mask+0xc2/0xe0
<4>[ 1749.692426] Code: 04 25 28 00 00 00 75 30 48 83 c4 10 5b 5d c3 cc cc cc cc f0 80 4f 01 40 48 81 c7 c0 0c 00 00 e8 a4 fe ff ff eb a6 db e3 eb cf <0f> 0b e9 6d ff ff ff 0f 0b e9 75 ff ff ff e8 db b0 dc 00 66 66 2e
<4>[ 1749.692427] RSP: 0018:fffffe000000a8e8 EFLAGS: 00010046
<4>[ 1749.692428] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff9594c01edfe0
<4>[ 1749.692429] RDX: 0000000080110003 RSI: ffff959647c12fe0 RDI: 0000000000000001
<4>[ 1749.692431] RBP: fffffe000000a900 R08: ffffffffbca10000 R09: fffffffffffffff8
<4>[ 1749.692432] R10: 0000000000ffff0a R11: 0000000000000004 R12: 8000000000000006
<4>[ 1749.692433] R13: 0000000000000007 R14: fffffe000000a958 R15: fffffe000000a960
<4>[ 1749.692434] FS:  0000000000000000(0000) GS:ffff95981ec00000(0000) knlGS:0000000000000000
<4>[ 1749.692435] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1749.692436] CR2: fffffe000000b000 CR3: 00000001e437e001 CR4: 00000000003706f0
<4>[ 1749.692437] Call Trace:
<4>[ 1749.692438]  <#DF>
<4>[ 1749.692438]  ? down_trylock+0x2e/0x40
<4>[ 1749.692440]  virt_efi_query_variable_info_nonblocking+0x66/0x140
<4>[ 1749.692443]  efi_query_variable_store+0xb2/0x1a0
<4>[ 1749.692446]  efivar_set_variable_locked+0xb2/0xf0
<4>[ 1749.692450]  efi_pstore_write+0x154/0x1d0
<4>[ 1749.692454]  pstore_dump+0x122/0x340
<4>[ 1749.692458]  ? efi_pstore_read+0xf0/0xf0
Panic#2 Part5
<4>[ 1749.692459]  ? pstore_dump+0x122/0x340
<4>[ 1749.692464]  kmsg_dump+0x63/0x80
<4>[ 1749.692466]  oops_exit.cold+0x18/0x1e
<4>[ 1749.692468]  oops_end+0x4d/0xa0
<4>[ 1749.692471]  page_fault_oops+0x169/0x290
<4>[ 1749.692474]  ? __die_header+0x22/0x82
<4>[ 1749.692477]  ? search_exception_tables+0x5f/0x70
<4>[ 1749.692481]  kernelmode_fixup_or_oops.constprop.0+0x96/0xf0
<4>[ 1749.692484]  __bad_area_nosemaphore.constprop.0+0x157/0x190
<4>[ 1749.692488]  bad_area_nosemaphore+0x13/0x20
<4>[ 1749.692491]  do_kern_addr_fault+0x87/0xa0
<4>[ 1749.692494]  exc_page_fault+0xd8/0x180
<4>[ 1749.692497]  asm_exc_page_fault+0x27/0x30
<4>[ 1749.692500] RIP: 0010:__die_header+0x22/0x82
<4>[ 1749.692502] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
<4>[ 1749.692504] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1749.692505] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1749.692506] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1749.692507] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1749.692508] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1749.692509] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1749.692510]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692512]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692514]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692517]  __die+0x1d/0x37
<4>[ 1749.692520]  die+0x30/0x60
<4>[ 1749.692522]  ? finish_task_switch+0xa3/0x300
<4>[ 1749.692524]  exc_double_fault+0x175/0x190
<4>[ 1749.692527]  asm_exc_double_fault+0x1f/0x50
<4>[ 1749.692532]  </#DF>
<4>[ 1749.692532]  <TASK>
Panic#2 Part4
<4>[ 1749.692533]  ? __switch_to+0x141/0x4e0
<4>[ 1749.692534]  ? __switch_to_asm+0x34/0x60
<4>[ 1749.692537]  ? __schedule+0xb45/0x17e0
<4>[ 1749.692541]  ? rcu_accelerate_cbs+0x22/0x80
<4>[ 1749.692543]  ? rcu_gp_cleanup+0x332/0x4c0
<4>[ 1749.692546]  ? schedule+0x6b/0x110
<4>[ 1749.692549]  ? rcu_gp_kthread+0x112/0x170
<4>[ 1749.692552]  ? rcu_gp_cleanup+0x4c0/0x4c0
<4>[ 1749.692554]  ? kthread+0xff/0x130
<4>[ 1749.692556]  ? kthread_complete_and_exit+0x20/0x20
<4>[ 1749.692559]  ? ret_from_fork+0x22/0x30
<4>[ 1749.692563]  </TASK>
<4>[ 1749.692563] ---[ end trace 0000000000000000 ]---
<4>[ 1750.270504] RIP: 0010:__die_header+0x22/0x82
<4>[ 1750.270512] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
<4>[ 1750.270514] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1750.270517] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1750.270519] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1750.270520] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1750.270521] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1750.270522] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1750.270524] FS:  0000000000000000(0000) GS:ffff95981ec00000(0000) knlGS:0000000000000000
<4>[ 1750.270525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1750.270527] CR2: fffffe000000b000 CR3: 00000001e437e001 CR4: 00000000003706f0
<0>[ 1750.270529] Kernel panic - not syncing: Fatal exception in interrupt
<4>[ 1750.270533] unchecked MSR access error: RDMSR from 0x803 at rIP: 0xffffffffbb06f1f6 (native_apic_msr_read+0x16/0x50)
Panic#2 Part3
<4>[ 1750.270538] Call Trace:
<4>[ 1750.270539]  <#DF>
<4>[ 1750.270542]  clear_local_APIC+0x39/0x2c0
<4>[ 1750.270546]  apic_soft_disable+0xe/0x50
<4>[ 1750.270549]  disable_local_APIC+0x22/0x30
<4>[ 1750.270552]  native_stop_other_cpus+0x91/0x180
<4>[ 1750.270555]  panic+0x171/0x2c9
<4>[ 1750.270558]  oops_end.cold+0xc/0x18
<4>[ 1750.270561]  page_fault_oops+0x169/0x290
<4>[ 1750.270565]  ? __die_header+0x22/0x82
<4>[ 1750.270567]  ? search_exception_tables+0x5f/0x70
<4>[ 1750.270572]  kernelmode_fixup_or_oops.constprop.0+0x96/0xf0
<4>[ 1750.270576]  __bad_area_nosemaphore.constprop.0+0x157/0x190
<4>[ 1750.270580]  bad_area_nosemaphore+0x13/0x20
<4>[ 1750.270583]  do_kern_addr_fault+0x87/0xa0
<4>[ 1750.270586]  exc_page_fault+0xd8/0x180
<4>[ 1750.270590]  asm_exc_page_fault+0x27/0x30
<4>[ 1750.270593] RIP: 0010:__die_header+0x22/0x82
<4>[ 1750.270596] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
<4>[ 1750.270598] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1750.270599] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1750.270600] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1750.270601] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1750.270603] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1750.270604] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1750.270605]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270607]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270610]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270612]  __die+0x1d/0x37
Panic#2 Part2
<4>[ 1750.270615]  die+0x30/0x60
<4>[ 1750.270618]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270620]  exc_double_fault+0x175/0x190
<4>[ 1750.270623]  asm_exc_double_fault+0x1f/0x50
<4>[ 1750.270628]  </#DF>
<4>[ 1750.270628]  <TASK>
<4>[ 1750.270629]  ? __switch_to+0x141/0x4e0
<4>[ 1750.270631]  ? __switch_to_asm+0x34/0x60
<4>[ 1750.270634]  ? __schedule+0xb45/0x17e0
<4>[ 1750.270638]  ? rcu_accelerate_cbs+0x22/0x80
<4>[ 1750.270641]  ? rcu_gp_cleanup+0x332/0x4c0
<4>[ 1750.270644]  ? schedule+0x6b/0x110
<4>[ 1750.270647]  ? rcu_gp_kthread+0x112/0x170
<4>[ 1750.270650]  ? rcu_gp_cleanup+0x4c0/0x4c0
<4>[ 1750.270652]  ? kthread+0xff/0x130
<4>[ 1750.270654]  ? kthread_complete_and_exit+0x20/0x20
<4>[ 1750.270657]  ? ret_from_fork+0x22/0x30
<4>[ 1750.270661]  </TASK>
<4>[ 1750.270663] unchecked MSR access error: WRMSR to 0x832 (tried to write 0x0000000000010000) at rIP: 0xffffffffbb06f2c7 (native_apic_msr_write+0x27/0x50)
<4>[ 1750.270667] Call Trace:
<4>[ 1750.270668]  <#DF>
<4>[ 1750.270669]  ? clear_local_APIC+0x93/0x2c0
<4>[ 1750.270672]  apic_soft_disable+0xe/0x50
<4>[ 1750.270675]  disable_local_APIC+0x22/0x30
<4>[ 1750.270678]  native_stop_other_cpus+0x91/0x180
<4>[ 1750.270680]  panic+0x171/0x2c9
<4>[ 1750.270683]  oops_end.cold+0xc/0x18
<4>[ 1750.270686]  page_fault_oops+0x169/0x290
<4>[ 1750.270689]  ? __die_header+0x22/0x82
<4>[ 1750.270691]  ? search_exception_tables+0x5f/0x70
<4>[ 1750.270696]  kernelmode_fixup_or_oops.constprop.0+0x96/0xf0
<4>[ 1750.270699]  __bad_area_nosemaphore.constprop.0+0x157/0x190
<4>[ 1750.270703]  bad_area_nosemaphore+0x13/0x20
<4>[ 1750.270706]  do_kern_addr_fault+0x87/0xa0
<4>[ 1750.270709]  exc_page_fault+0xd8/0x180
<4>[ 1750.270712]  asm_exc_page_fault+0x27/0x30
<4>[ 1750.270714] RIP: 0010:__die_header+0x22/0x82
Panic#2 Part1
<4>[ 1750.270717] Code: 00 00 00 e9 d0 29 2e ff 0f 1f 44 00 00 55 8b 05 1a 78 52 01 49 89 fa 48 89 e5 85 c0 75 0e 48 c7 c7 00 47 27 bd b9 2a 00 00 00 <f3> a5 48 8b 0d 13 98 2e 01 48 c7 c6 53 96 76 bc 0f b7 d2 49 c7 c1
<4>[ 1750.270718] RSP: 0018:fffffe000000aea0 EFLAGS: 00010046
<4>[ 1750.270720] RAX: 0000000000000000 RBX: fffffe000000af60 RCX: 0000000000000002
<4>[ 1750.270721] RDX: ffffffffbb0d0203 RSI: fffffe000000b000 RDI: ffffffffbd2747a0
<4>[ 1750.270722] RBP: fffffe000000aea0 R08: 0000000000000002 R09: 0000000000000020
<4>[ 1750.270723] R10: ffffffffbc768e19 R11: 000000000000000f R12: ffffffffbc768e19
<4>[ 1750.270724] R13: fffffe000000af60 R14: ffffffffbb0d0203 R15: ffffffffbb0d0203
<4>[ 1750.270725]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270727]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270729]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270732]  __die+0x1d/0x37
<4>[ 1750.270734]  die+0x30/0x60
<4>[ 1750.270737]  ? finish_task_switch+0xa3/0x300
<4>[ 1750.270739]  exc_double_fault+0x175/0x190
<4>[ 1750.270742]  asm_exc_double_fault+0x1f/0x50
<4>[ 1750.270746]  </#DF>
<4>[ 1750.270747]  <TASK>
<4>[ 1750.270747]  ? __switch_to+0x141/0x4e0
<4>[ 1750.270749]  ? __switch_to_asm+0x34/0x60
<4>[ 1750.270752]  ? __schedule+0xb45/0x17e0
<4>[ 1750.270755]  ? rcu_accelerate_cbs+0x22/0x80
<4>[ 1750.270757]  ? rcu_gp_cleanup+0x332/0x4c0
<4>[ 1750.270760]  ? schedule+0x6b/0x110
<4>[ 1750.270763]  ? rcu_gp_kthread+0x112/0x170
<4>[ 1750.270766]  ? rcu_gp_cleanup+0x4c0/0x4c0
<4>[ 1750.270768]  ? kthread+0xff/0x130
<4>[ 1750.270770]  ? kthread_complete_and_exit+0x20/0x20
<4>[ 1750.270773]  ? ret_from_fork+0x22/0x30
<4>[ 1750.270777]  </TASK>
<0>[ 1750.270786] Kernel Offset: 0x3a000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

