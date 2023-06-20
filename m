Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659D736767
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFTJOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjFTJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754931726;
        Tue, 20 Jun 2023 02:13:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBXPk-0002Rh-OK; Tue, 20 Jun 2023 11:12:40 +0200
Message-ID: <0826b484-8bbc-d58f-2caf-7015bd30f827@leemhuis.info>
Date:   Tue, 20 Jun 2023 11:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: iosm: detected field-spanning write for XMM7360
Content-Language: en-US, de-DE
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Klink <flokli@flokli.de>
References: <dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687252400;e95200e6;
X-HE-SMSGID: 1qBXPk-0002Rh-OK
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 10:44, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:

Bagas, you can't know this, as we didn't have such a sitaution until
now, so FYI:

Please don't add "field-spanning write" warnings to the regression
tracking, that's not worth the trouble (at least for the time beeing).
Just forward them to Kees, who might look into them if the developer in
question doesn't care. That was the approach we agreed on here:

https://lore.kernel.org/all/f1ca3cea-01ae-998a-2aa8-c3e40cf46975@leemhuis.info/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot inconclusive: a field-spanning write warning

>> Hey!
>>
>> I'm using Linux 6.3.0 on x86_64. Distro is NixOS.
>>
>> I'm using the XMM7360 WWAN device:
>>
>> 05:00.0 Wireless controller [0d40]: Intel Corporation XMM7360 LTE Advanced Modem (rev 01)
>>
>> As discussed in https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/612, the device currently needs some manual babysitting due to broken suspend/resume, and some (slightly patched) python script sending commands to `/dev/wwan0xmmrpc0`:
>>
>> ```
>> echo 1 > /sys/bus/pci/devices/0000:05:00.0/reset
>> echo 1 > /sys/bus/pci/devices/0000:05:00.0/remove
>> echo 1 > /sys/bus/pci/rescan
>> # wait
>> open_xdatachannel.py --apn "internet"
>> ```
>>
>>
>> I saw the following messages in dmesg:
>> ```
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:01: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:02: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:03: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:04: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:05: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:06: Allocating resources
>> [Sa Jun 17 20:09:42 2023] pci_bus 0000:07: Allocating resources
>> [Sa Jun 17 20:09:49 2023] iosm 0000:05:00.0: msg timeout
>> [Sa Jun 17 20:09:49 2023] iosm 0000:05:00.0: msg timeout
>> [Sa Jun 17 20:09:49 2023] pci 0000:05:00.0: Removing from iommu group 15
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: [8086:7360] type 00 class 0x0d4000
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: reg 0x10: [mem 0xfd500000-0xfd500fff 64bit]
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: reg 0x18: [mem 0xfd501000-0xfd5013ff 64bit]
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: Adding to iommu group 15
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: BAR 0: assigned [mem 0xfd500000-0xfd500fff 64bit]
>> [Sa Jun 17 20:09:52 2023] pci 0000:05:00.0: BAR 2: assigned [mem 0xfd501000-0xfd5013ff 64bit]
>> [Sa Jun 17 20:10:09 2023] ------------[ cut here ]------------
>> [Sa Jun 17 20:10:09 2023] memcpy: detected field-spanning write (size 16) of single field "&adth->dg" at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 (size 8)
>> [Sa Jun 17 20:10:09 2023] WARNING: CPU: 11 PID: 0 at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 ipc_mux_ul_adb_finish+0x17e/0x290 [iosm]
>> [Sa Jun 17 20:10:09 2023] Modules linked in: hid_multitouch qrtr ccm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device hid_lenovo uhid xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_tables nfnetlink af_packet rfcomm cmac algif_hash algif_skcipher af_alg bnep nls_iso8859_1 nls_cp437 vfat fat joydev mousedev amdgpu iwlmvm r8153_ecm cdc_ether snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn usbnet snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp mac80211 snd_sof_pci snd_sof_xtensa_dsp snd_ctl_led snd_sof snd_hda_codec_realtek snd_sof_utils intel_rapl_msr snd_hda_codec_generic libarc4 iommu_v2 snd_hda_codec_hdmi snd_soc_core uvcvideo btusb gpu_sched snd_compress edac_mce_amd videobuf2_vmalloc drm_ttm_helper btrtl snd_hda_intel ac97_bus edac_core snd_pcm_dmaengine uvc btbcm videobuf2_memops ttm snd_intel_dspcfg intel_rapl_common videobuf2_v4l2 snd_intel_sdw_acpi crc32_pclmul btintel tps6598x snd_pci_ps polyval_clmulni regmap_i2c snd_hda_codec btmtk snd_rpl_pci_acp6x think_lmi
>> [Sa Jun 17 20:10:09 2023]  polyval_generic iwlwifi wmi_bmof firmware_attributes_class videodev drm_display_helper snd_acp_pci gf128mul snd_hda_core bluetooth ghash_clmulni_intel thinkpad_acpi r8152 r8169 videobuf2_common snd_pci_acp6x snd_hwdep nvram drm_kms_helper cfg80211 snd_pci_acp5x ucsi_acpi mii sp5100_tco rapl ledtrig_audio mc psmouse ecdh_generic snd_pcm drm_buddy platform_profile typec_ucsi snd_rn_pci_acp3x ecc watchdog realtek snd_acp_config snd_timer crc16 agpgart iosm k10temp typec i2c_algo_bit ipmi_devintf snd_soc_acpi mdio_devres syscopyarea snd sysfillrect video snd_pci_acp3x libphy sysimgblt wwan 8250_pci ipmi_msghandler rfkill i2c_piix4 ac soundcore roles thermal battery tiny_power_button serial_multi_instantiate evdev i2c_scmi i2c_designware_platform wmi acpi_cpufreq mac_hid button i2c_designware_core serio_raw sch_cake ctr loop xt_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter veth tun tap macvlan bridge stp llc kvm_amd ccp kvm irqbypass tcp_bbr i2c_dev drm fuse backlight i2c_core deflate
>> [Sa Jun 17 20:10:09 2023]  efi_pstore configfs efivarfs dmi_sysfs ip_tables x_tables dm_crypt cbc encrypted_keys trusted asn1_encoder tee hid_generic usbhid hid mmc_block dm_mod dax btrfs rtsx_pci_sdmmc nvme mmc_core nvme_core input_leds led_class xhci_pci atkbd tpm_crb xhci_pci_renesas t10_pi libps2 vivaldi_fmap xhci_hcd sha512_ssse3 ehci_pci crc64_rocksoft ehci_hcd sha512_generic crc64 blake2b_generic crc_t10dif aesni_intel rtsx_pci xor usbcore libaes libcrc32c tpm_tis crct10dif_generic crypto_simd tpm_tis_core cryptd crct10dif_pclmul crc32c_generic crc32c_intel tpm mfd_core crct10dif_common usb_common i8042 rng_core rtc_cmos serio raid6_pq autofs4
>> [Sa Jun 17 20:10:09 2023] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G        W          6.3.0 #1-NixOS
>> [Sa Jun 17 20:10:09 2023] Hardware name: LENOVO 20UF000LGE/20UF000LGE, BIOS R1CET72W(1.41 ) 06/27/2022
>> [Sa Jun 17 20:10:09 2023] RIP: 0010:ipc_mux_ul_adb_finish+0x17e/0x290 [iosm]
>> [Sa Jun 17 20:10:09 2023] Code: 00 00 0f 85 44 ff ff ff b9 08 00 00 00 48 c7 c2 a8 1d 20 c1 48 89 ee 48 c7 c7 e0 1c 20 c1 c6 05 e8 e9 00 00 01 e8 92 65 ea eb <0f> 0b e9 1b ff ff ff 48 8b 83 b4 02 00 00 c7 00 00 00 00 00 0f b7
>> [Sa Jun 17 20:10:09 2023] RSP: 0018:ffff9b9b80424ef0 EFLAGS: 00010282
>> [Sa Jun 17 20:10:09 2023] RAX: 0000000000000000 RBX: ffff8d1bbe562000 RCX: 0000000000000027
>> [Sa Jun 17 20:10:09 2023] RDX: ffff8d1e212e14c8 RSI: 0000000000000001 RDI: ffff8d1e212e14c0
>> [Sa Jun 17 20:10:09 2023] RBP: 0000000000000010 R08: 0000000000000000 R09: ffff9b9b80424d98
>> [Sa Jun 17 20:10:09 2023] R10: 0000000000000003 R11: ffffffffae938888 R12: 0000000000000000
>> [Sa Jun 17 20:10:09 2023] R13: 00000000000000d8 R14: ffff8d1bbe5622e4 R15: ffff8d1ba1c40108
>> [Sa Jun 17 20:10:09 2023] FS:  0000000000000000(0000) GS:ffff8d1e212c0000(0000) knlGS:0000000000000000
>> [Sa Jun 17 20:10:09 2023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [Sa Jun 17 20:10:09 2023] CR2: 000026180d354000 CR3: 0000000033b0c000 CR4: 0000000000350ee0
>> [Sa Jun 17 20:10:09 2023] Call Trace:
>> [Sa Jun 17 20:10:09 2023]  <IRQ>
>> [Sa Jun 17 20:10:09 2023]  ipc_imem_tq_adb_timer_cb+0x12/0x20 [iosm]
>> [Sa Jun 17 20:10:09 2023]  ipc_task_queue_handler+0xa1/0x100 [iosm]
>> [Sa Jun 17 20:10:09 2023]  tasklet_action_common.constprop.0+0x132/0x140
>> [Sa Jun 17 20:10:09 2023]  __do_softirq+0xca/0x2ae
>> [Sa Jun 17 20:10:09 2023]  __irq_exit_rcu+0xab/0xe0
>> [Sa Jun 17 20:10:09 2023]  sysvec_apic_timer_interrupt+0x72/0x90
>> [Sa Jun 17 20:10:09 2023]  </IRQ>
>> [Sa Jun 17 20:10:09 2023]  <TASK>
>> [Sa Jun 17 20:10:09 2023]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [Sa Jun 17 20:10:09 2023] RIP: 0010:cpuidle_enter_state+0xcc/0x440
>> [Sa Jun 17 20:10:09 2023] Code: 2a d8 66 ff e8 25 f2 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 a3 eb 65 ff 45 84 ff 0f 85 57 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
>> [Sa Jun 17 20:10:09 2023] RSP: 0018:ffff9b9b801d7e90 EFLAGS: 00000246
>> [Sa Jun 17 20:10:09 2023] RAX: ffff8d1e212f2780 RBX: ffff8d1b83198c00 RCX: 0000000000000000
>> [Sa Jun 17 20:10:09 2023] RDX: 000000000000000b RSI: 0000000cb4e6e5b9 RDI: 0000000000000000
>> [Sa Jun 17 20:10:09 2023] RBP: 0000000000000002 R08: 0000000000000004 R09: 000000003d113146
>> [Sa Jun 17 20:10:09 2023] R10: 0000000000000018 R11: 000000000000055e R12: ffffffffae9b3860
>> [Sa Jun 17 20:10:09 2023] R13: 0000052a93e6f49a R14: 0000000000000002 R15: 0000000000000000
>> [Sa Jun 17 20:10:09 2023]  cpuidle_enter+0x2d/0x40
>> [Sa Jun 17 20:10:09 2023]  do_idle+0x1bf/0x220
>> [Sa Jun 17 20:10:09 2023]  cpu_startup_entry+0x1d/0x20
>> [Sa Jun 17 20:10:09 2023]  start_secondary+0x115/0x140
>> [Sa Jun 17 20:10:09 2023]  secondary_startup_64_no_verify+0xe5/0xeb
>> [Sa Jun 17 20:10:09 2023]  </TASK>
>> [Sa Jun 17 20:10:09 2023] ---[ end trace 0000000000000000 ]---
>> ```
>>
>> `drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852` was introduced in 1f52d7b622854b8bd7a1be3de095ca2e1f77098e ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> 
> 
> See Bugzilla for the full thread.
> 
> M Chetan Kumar: Can you take a look on this issue please?
> 
> Anyway, to be sure this issue doesn't fall through the cracks unnoticed,
> I'm adding it to regzbot:
> 
> #regzbot introduced: 1f52d7b622854b https://bugzilla.kernel.org/show_bug.cgi?id=217569
> #regzbot title: field-spanning write (memcpy) detected on Intel XMM7360
> #regzbot link: https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/612
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217569
