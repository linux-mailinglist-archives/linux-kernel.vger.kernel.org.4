Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6D73D2C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFYRqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:46:16 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 10:46:13 PDT
Received: from tsukuyomi.43-1.org (tsukuyomi.43-1.org [IPv6:2a01:4f8:c2c:1632::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E92F1B9;
        Sun, 25 Jun 2023 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=43-1.org;
 i=@43-1.org; q=dns/txt; s=2019; t=1687714697; h=from : to : subject :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding : from;
 bh=Ht3mrnLFhtcsajjzaxhQea5V75sfd1ySAolPtb6D/yc=;
 b=QwXojYZ6C7p4mp2M8GInfmQgCe4w2Ip4HORmetF+fPr9z87xqdc9hIsESXvmcZ+3CfIPy
 DrgbLiA0nTyrPRopwQO6T9F9MOdGXASAJeS9Y4QgBcXCSquJ26x9+WZ0FqXdkDVze0XcmEm
 BImRAh7OwOIIzg588x3nff17Ornlh/+/ZxA5f61X9Ob6C3tgRlRia2cN7lfprdzCcEiOsfK
 9THyHuAtSaC3R+Ndphhgay5rsASua5Fd1fOWG0QLxyciAFE4UzHxb04+bioy6pPxpdr/1cg
 Slx5vYStF5N5lankx3/XGdDqVuL2+C4AEdGBV03u1LcSkOWc2sRP7WB7xkQQ==
From:   Matthias Maier <tamiko@43-1.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Kernel oops with netfilter: nf_tables: incorrect error path
 handling with NFT_MSG_NEWRULE
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Sun, 25 Jun 2023 12:38:08 -0500
Message-ID: <87cz1j5tof.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

  commit 1240eb93f0616b21c675416516ff3d74798fdc97
         aka bdace3b1a51887211d3e49417a18fdbd315a313b (linux-6.3.y)
  netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE

causes a kernel oops on my side when booting my machine; see attached.

Reverting this commit fixes the kernel oops.
Tested on 6.3.9 and 6.4.0-rc7

Best,
Matthias


<3>[   61.206481] list_del corruption. next->prev should be ffff8ceb11b24f6=
0, but was 0000000000000000. (next=3Dffff8ceb11b27ac8)
<4>[   61.206494] ------------[ cut here ]------------
<2>[   61.206495] kernel BUG at lib/list_debug.c:62!
<4>[   61.207649] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
<4>[   61.208812] CPU: 10 PID: 2226 Comm: nft Tainted: P           O    T  =
6.4.0-rc7-x86_64 #1
<4>[   61.210059] Hardware name: LENOVO 20SUS2QV00/20SUS2QV00, BIOS N30ET49=
W (1.32 ) 12/14/2022
<4>[   61.211327] RIP: 0010:__list_del_entry_valid+0xc6/0xd0
<4>[   61.212563] Code: 0b 48 89 fe 48 89 c2 48 c7 c7 a0 ed 85 88 e8 57 4e =
9c ff 0f 0b 48 89 d1 48 c7 c7 f0 ed 85 88 48 89 f2 48 89 c6 e8 40 4e 9c ff =
<0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 65 48 c1 3c 25 10
<4>[   61.214030] RSP: 0018:ffffa4be03647778 EFLAGS: 00010287
<4>[   61.215488] RAX: 000000000000006d RBX: ffff8ceb11b26800 RCX: 00000000=
00000000
<4>[   61.216932] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000=
00000000
<4>[   61.218382] RBP: ffff8ceb11b24f60 R08: 0000000000000000 R09: 00000000=
00000000
<4>[   61.219831] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000001
<4>[   61.221286] R13: ffff8ceb2984d4f8 R14: ffff8ceb2984d4e0 R15: ffff8ceb=
11b24e00
<4>[   61.222761] FS:  00007fd654220740(0000) GS:ffff8d09bc480000(0000) knl=
GS:0000000000000000
<4>[   61.224298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   61.225854] CR2: 00007f27e3a370d8 CR3: 0000000115af0002 CR4: 00000000=
007706e0
<4>[   61.227411] PKRU: 55555554
<4>[   61.227412] Call Trace:
<4>[   61.227414]  <TASK>
<4>[   61.227416]  ? die+0x36/0x90
<4>[   61.232948]  ? do_trap+0xea/0x110
<4>[   61.234503]  ? __list_del_entry_valid+0xc6/0xd0
<4>[   61.234506]  ? do_error_trap+0x6a/0xa0
<4>[   61.236987]  ? __list_del_entry_valid+0xc6/0xd0
<4>[   61.236990]  ? exc_invalid_op+0x50/0x80
<4>[   61.239396]  ? __list_del_entry_valid+0xc6/0xd0
<4>[   61.240955]  ? asm_exc_invalid_op+0x1a/0x20
<4>[   61.242526]  ? __list_del_entry_valid+0xc6/0xd0
<4>[   61.242528]  ? __list_del_entry_valid+0xc6/0xd0
<4>[   61.244998]  nf_tables_deactivate_set+0x39/0x120 [nf_tables]
<4>[   61.246613]  __nf_tables_abort+0x81b/0xce0 [nf_tables]
<4>[   61.248251]  nf_tables_abort+0x39/0x60 [nf_tables]
<4>[   61.249838]  nfnetlink_rcv_batch+0x4f1/0x990 [nfnetlink]
<4>[   61.251517]  nfnetlink_rcv+0x18f/0x1b0 [nfnetlink]
<4>[   61.253170]  netlink_unicast+0x1a9/0x290
<4>[   61.254816]  netlink_sendmsg+0x259/0x4e0
<4>[   61.256433]  sock_sendmsg+0xa8/0xb0
<4>[   61.258024]  ____sys_sendmsg+0x28d/0x320
<4>[   61.259665]  ? copy_msghdr_from_user+0x7d/0xc0
<4>[   61.261320]  ___sys_sendmsg+0x9f/0xf0
<4>[   61.262974]  __sys_sendmsg+0x7f/0xe0
<4>[   61.264565]  do_syscall_64+0x5f/0x90
<4>[   61.266210]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
<4>[   61.267906] RIP: 0033:0x7fd65445e174
<4>[   61.269545] Code: 15 a9 3c 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff =
eb b7 0f 1f 00 f3 0f 1e fa 80 3d 8d c2 0c 00 00 74 13 b8 2e 00 00 00 0f 05 =
<48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
<4>[   61.271387] RSP: 002b:00007ffe8b535ed8 EFLAGS: 00000202 ORIG_RAX: 000=
000000000002e
<4>[   61.273275] RAX: ffffffffffffffda RBX: 00007ffe8b5470e0 RCX: 00007fd6=
5445e174
<4>[   61.275117] RDX: 0000000000000000 RSI: 00007ffe8b546f90 RDI: 00000000=
00000003
<4>[   61.276968] RBP: 00007ffe8b547090 R08: 00007ffe8b535eb4 R09: 00007ffe=
8b535ee0
<4>[   61.278897] R10: 00007fd654662ec0 R11: 0000000000000202 R12: 00000000=
00000001
<4>[   61.280774] R13: 0000000000011c00 R14: 0000000000000003 R15: 00007ffe=
8b535ef0
<4>[   61.282653]  </TASK>
<4>[   61.284505] Modules linked in: nft_log nft_masq nft_reject_inet nf_re=
ject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrac=
k nf_defrag_ipv6 nf_defrag_ipv4 cmac bnep nf_tables nfnetlink vfat fat binf=
mt_misc snd_sof_pci_intel_cnl snd_sof_intel_hda_common snd_soc_hdac_hda sou=
ndwire_intel soundwire_generic_allocation soundwire_cadence snd_sof_intel_h=
da_mlink snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_u=
tils snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match s=
nd_soc_acpi snd_hda_ext_core snd_soc_core snd_ctl_led iwlmvm snd_compress s=
nd_hda_codec_realtek snd_pcm_dmaengine x86_pkg_temp_thermal ac97_bus snd_hd=
a_codec_generic snd_hda_codec_hdmi uvcvideo intel_powerclamp snd_hda_intel =
iTCO_wdt snd_intel_dspcfg uvc rapl mac80211 intel_pmc_bxt videobuf2_vmalloc=
 mei_pxp mei_wdt mei_hdcp intel_rapl_msr intel_cstate ee1004 iTCO_vendor_su=
pport libarc4 btusb videobuf2_memops snd_intel_sdw_acpi videobuf2_v4l2 proc=
essor_thermal_device_pci_legacy btrtl snd_hda_codec
<4>[   61.284566]  videobuf2_common processor_thermal_device btbcm thinkpad=
_acpi intel_uncore btintel processor_thermal_rfim videodev iwlwifi snd_hda_=
core thunderbolt processor_thermal_mbox ledtrig_audio efi_pstore mc intel_w=
mi_thunderbolt wmi_bmof snd_hwdep processor_thermal_rapl mei_me bluetooth p=
latform_profile i2c_i801 intel_rapl_common e1000e ecdh_generic i2c_smbus cf=
g80211 snd_pcm mei idma64 intel_soc_dts_iosf intel_pch_thermal int3403_ther=
mal rfkill int340x_thermal_zone int3400_thermal acpi_thermal_rel joydev acp=
i_pad fuse dm_crypt trusted asn1_encoder nvidia_drm(PO) nvidia_modeset(PO) =
mmc_block nvidia(PO) i915 i2c_algo_bit drm_buddy drm_display_helper drm_kms=
_helper syscopyarea rtsx_pci_sdmmc cec sysfillrect mmc_core sysimgblt ttm u=
csi_acpi crct10dif_pclmul crc32c_intel polyval_clmulni polyval_generic ghas=
h_clmulni_intel sha512_ssse3 typec_ucsi nvme roles rtsx_pci drm nvme_core t=
ypec video wmi pinctrl_cannonlake serio_raw coretemp vhost_net tun tap vhos=
t vhost_iotlb uinput snd_seq snd_timer snd_seq_device snd
<4>[   61.296399]  soundcore kvm_intel kvm irqbypass f2fs crc32_generic crc=
32_pclmul lz4hc_compress lz4_compress
<4>[   61.314164] ---[ end trace 0000000000000000 ]---
