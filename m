Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5B67ABCF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjAYId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjAYIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:33:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550663E08C;
        Wed, 25 Jan 2023 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674635588; x=1706171588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZ25MeoGnL2uaXymFyLU1cTV0Zfr7PXco6b3u6MyroA=;
  b=Ywe4rX7Opz8qJw9KJT1tn2YfdumCU5G7+R4p5byU+z2h3ny3yD56aaXl
   fuz1v6ejzPAH6fFCEcvJhMK+iOusJJhaEHNiCsGDjBgERooS4jBCgl8EM
   g6a2Rff2vWOybfeTY7HD9EXSQKdiNS0AscA6DM+2YnQrK5jkQB6yO71pp
   ivxQHtv1I1WAhT351F8TpJ2byRZ37FmSbEKEBIYlgKeMoKq64Yc9VSokR
   otWVG6eQkZUIhdM2OIqlbEWIneOfHgbCKDhFCkXeoaYqmV1TE+6Vt7HSw
   zLf/3BLmom1BN2zkytMac5j0cvRtE1kTFbM/25TNusbtSHn3ew4fearT8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327761962"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208,223";a="327761962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804925816"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208,223";a="804925816"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2023 00:33:05 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 25 Jan 2023 10:33:04 +0200
Date:   Wed, 25 Jan 2023 10:33:04 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fan Chengwei <fancieux@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: crash after suspending
Message-ID: <Y9DpQGj+9FZglZjo@kuha.fi.intel.com>
References: <SG2PR02MB4090B1F3E5EC0B7FCCC01807D7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XeOJB41DODR5ewEl"
Content-Disposition: inline
In-Reply-To: <SG2PR02MB4090B1F3E5EC0B7FCCC01807D7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XeOJB41DODR5ewEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2023 at 01:23:01PM +0800, Fan Chengwei wrote:
> My laptop crash after suspending due to failure of driver of usb type c.
> 
> This may be a follow-up to
> https://bugzilla.kernel.org/show_bug.cgi?id=216706 and
> https://bugzilla.kernel.org/show_bug.cgi?id=216697. You mentioned a patch in
> BUG 216697 above, which was merged into mainline in 6.2.0-rc5. But I tried
> 6.2.0-rc5 yesterday and it still doesn't work.
> 
> I add a comment here in
> https://bugzilla.kernel.org/show_bug.cgi?id=216697#c11 and there is some
> discussion in https://bbs.archlinux.org/viewtopic.php?id=282999.
> 
> Bisection shows that
> > # first bad commit: [4e3a50293c2b21961f02e1afa2f17d3a1a90c7c8] usb:
> typec: ucsi: acpi: Implement resume callback
> which makes my laptop freezes when resuming from suspend. While in
> https://bugzilla.kernel.org/show_bug.cgi?id=216706, someone reports that the
> same commit causes that USBC resume callback takes far too long.
> 
> That bad commit was merged in mainline in 6.1.0-rc2, which causes my laptop
> to freeze and journalctl can't capture any message. While after the
> archlinux kernel package is upgraded to 6.1.1 and later, the system will not
> be stuck, but a oops will be displayed, I posted it here
> https://bbs.archlinux.org/viewtopic.php?id=282999. And following is the
> dmesg in 6.2.0-rc5:
> > [   29.677975] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   29.677981] CPU: 4 PID: 73 Comm: kworker/4:1 Not tainted
> 6.2.0-rc5-1-mainline #1 9dd3e34c332001c1d20c681d031ef729664f899d
> > [   29.677989] Hardware name: LENOVO 81HX/LNVNB161216, BIOS
> 6UCN53WW(V4.08) 09/26/2018
> > [   29.677992] Workqueue: events_long ucsi_resume_work [typec_ucsi]
> > [   29.678017] RIP: 0010:ucsi_resume_work+0x32/0x80 [typec_ucsi]
> > [   29.678037] Code: 00 55 31 c9 31 d2 53 48 8b b7 a0 00 00 00 48 89 fb 48
> 83 ef 38 48 83 ce 05 e8 5a f6 ff ff 85 c0 0f 88 95 22 00 00 48 8b 5b f8 <48>
> 83 bb 88 00 00 00 00 74 3b 48 8d 6b 10 48 89 ef e8 f8 57 a6 e2
> > [   29.678041] RSP: 0000:ffffb2dac030fe80 EFLAGS: 00010246
> > [   29.678047] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000002
> > [   29.678050] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
> ffff91b009189db8
> > [   29.678053] RBP: ffff91b169f32b00 R08: 0000000000000001 R09:
> 0000000000000000
> > [   29.678056] R10: 0000000000000004 R11: 0000000000000000 R12:
> ffff91b169f38b00
> > [   29.678059] R13: 0000000000000000 R14: ffff91b000f5dc00 R15:
> ffff91b009189d40
> > [   29.678063] FS:  0000000000000000(0000) GS:ffff91b169f00000(0000)
> knlGS:0000000000000000
> > [   29.678067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   29.678071] CR2: 0000000000000088 CR3: 000000005e810001 CR4:
> 00000000003706e0
> > [   29.678075] Call Trace:
> > [   29.678080]  <TASK>
> > [   29.678085]  process_one_work+0x1c5/0x380
> > [   29.678099]  worker_thread+0x51/0x390
> > [   29.678109]  ? __pfx_worker_thread+0x10/0x10
> > [   29.678117]  kthread+0xdb/0x110
> > [   29.678124]  ? __pfx_kthread+0x10/0x10
> > [   29.678130]  ret_from_fork+0x29/0x50
> > [   29.678146]  </TASK>
> > [   29.678148] Modules linked in: nft_chain_nat xt_REDIRECT nf_nat
> nf_conntrack xt_mark nft_compat nf_tables libcrc32c nfnetlink snd_soc_avs
> xt_TPROXY snd_soc_hda_codec nf_tproxy_ipv6 snd_soc_skl nf_tproxy_ipv4
> nf_defrag_ipv6 snd_soc_hdac_hda nf_defrag_ipv4 snd_hda_ext_core
> snd_soc_sst_ipc intel_tcc_cooling snd_soc_sst_dsp x86_pkg_temp_thermal
> snd_soc_acpi_intel_match intel_powerclamp kvm_intel snd_soc_acpi
> snd_soc_core ccm snd_hda_codec_hdmi algif_aead snd_compress
> snd_hda_codec_conexant kvm snd_hda_codec_generic ac97_bus cbc ledtrig_audio
> irqbypass ath10k_pci snd_pcm_dmaengine crct10dif_pclmul crc32_pclmul
> hid_logitech_hidpp polyval_clmulni des_generic snd_hda_intel polyval_generic
> libdes gf128mul snd_intel_dspcfg ath10k_core ecb ghash_clmulni_intel
> snd_intel_sdw_acpi sha512_ssse3 iTCO_wdt snd_hda_codec ath intel_pmc_bxt
> aesni_intel algif_skcipher uvcvideo cmac joydev snd_hda_core serio_raw
> crypto_simd snd_hwdep iTCO_vendor_support mei_hdcp mousedev mei_pxp
> intel_rapl_msr 8021q atkbd
> > [   29.678263]  cryptd hid_logitech_dj garp libps2 md4 btusb
> videobuf2_vmalloc snd_pcm mrp mac80211 rapl vivaldi_fmap algif_hash
> videobuf2_memops processor_thermal_device_pci_legacy btrtl snd_timer r8169
> btbcm stp intel_cstate af_alg llc videobuf2_v4l2 snd coretemp
> processor_thermal_device i2c_i801 libarc4 intel_uncore btintel realtek btmtk
> intel_wmi_thunderbolt wmi_bmof mdio_devres i2c_smbus soundcore ucsi_acpi
> mei_me processor_thermal_rfim cfg80211 bluetooth videodev libphy typec_ucsi
> processor_thermal_mbox intel_lpss_pci vfat i2c_hid_acpi mei
> processor_thermal_rapl intel_lpss fat idma64 typec ecdh_generic
> videobuf2_common i2c_hid intel_xhci_usb_role_switch intel_rapl_common mc
> usbhid intel_soc_dts_iosf intel_pch_thermal roles elan_i2c ideapad_laptop
> sparse_keymap platform_profile int3403_thermal rfkill int340x_thermal_zone
> i8042 serio int3400_thermal soc_button_array acpi_thermal_rel acpi_pad
> mac_hid vmw_vmci pkcs8_key_parser dm_multipath crypto_user fuse bpf_preload
> ip_tables x_tables
> > [   29.678388]  ext4 crc32c_generic crc16 mbcache jbd2 dm_mod nvme
> nvme_core crc32c_intel xhci_pci nvme_common xhci_pci_renesas i915 drm_buddy
> intel_gtt video wmi drm_display_helper cec ttm
> > [   29.678420] CR2: 0000000000000088
> > [   29.678424] ---[ end trace 0000000000000000 ]---
> > [   29.678426] RIP: 0010:ucsi_resume_work+0x32/0x80 [typec_ucsi]
> > [   29.678445] Code: 00 55 31 c9 31 d2 53 48 8b b7 a0 00 00 00 48 89 fb 48
> 83 ef 38 48 83 ce 05 e8 5a f6 ff ff 85 c0 0f 88 95 22 00 00 48 8b 5b f8 <48>
> 83 bb 88 00 00 00 00 74 3b 48 8d 6b 10 48 89 ef e8 f8 57 a6 e2
> > [   29.678449] RSP: 0000:ffffb2dac030fe80 EFLAGS: 00010246
> > [   29.678454] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000002
> > [   29.678457] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
> ffff91b009189db8
> > [   29.678460] RBP: ffff91b169f32b00 R08: 0000000000000001 R09:
> 0000000000000000
> > [   29.678462] R10: 0000000000000004 R11: 0000000000000000 R12:
> ffff91b169f38b00
> > [   29.678465] R13: 0000000000000000 R14: ffff91b000f5dc00 R15:
> ffff91b009189d40
> > [   29.678468] FS:  0000000000000000(0000) GS:ffff91b169f00000(0000)
> knlGS:0000000000000000
> > [   29.678472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   29.678475] CR2: 0000000000000088 CR3: 000000005e810001 CR4:
> 00000000003706e0
> Although you merged a patch in 6.2.0-rc5, nothing seems to have changed.
> 
> I also noticed one more thing, since I started using linux system every time
> I boot there is a message:
> > ucsi_acpi USBC000:00: PPM init failed (-16)
> Its return value sometimes changes, about 70% is -16, 20% is -19, 10% is
> -110, and sporadically -22, -95. On the past system, this will not cause any
> problems. I thought it was completely harmless. But one time when I was
> testing the kernel this error did not appear and the system resumed normally
> from suspending, even though it was a bad kernel. This happens once in about
> 150 boots, I can't reproduce it. Besides, even on a bad kernel, as long as
> after entering the system, `rmmod ucsi_acpi typec_ucsi` and then modprobe
> them. The system can resume normally.
> 
> I'm not an experienced linux user and I don't know much about it, I hope to
> get your help.

The information you just gave is very useful. Thank you!

I'm still not completely sure if I understand the problem, but I'm
attaching a patch. Can you test it?

I'll also attach it to the bug.

thanks,

-- 
heikki

--XeOJB41DODR5ewEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-ucsi-Release-the-connector-array-if-ucsi_i.patch"

From c6a1e65373b97c8aac8b63c8a47047166bfe3dae Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 25 Jan 2023 10:16:28 +0200
Subject: [PATCH] usb: typec: ucsi: Release the connector array if ucsi_init()
 fails

Interim.

If ucsi_init() fails, leaving ucsi->connector with value
NULL. The array that the pointer contains is also freed at
the same time.

This is a test fix for:
https://bugzilla.kernel.org/show_bug.cgi?id=216697

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 308498e871dfb..be517efc403af 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1400,6 +1400,9 @@ static int ucsi_init(struct ucsi *ucsi)
 		con->port = NULL;
 	}
 
+	kfree(ucsi->connector);
+	ucsi->connector = NULL;
+
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
 	ucsi_reset_ppm(ucsi);
@@ -1431,7 +1434,8 @@ static void ucsi_resume_work(struct work_struct *work)
 
 int ucsi_resume(struct ucsi *ucsi)
 {
-	queue_work(system_long_wq, &ucsi->resume_work);
+	if (ucsi->connector)
+		queue_work(system_long_wq, &ucsi->resume_work);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ucsi_resume);
@@ -1551,6 +1555,9 @@ void ucsi_unregister(struct ucsi *ucsi)
 	/* Disable notifications */
 	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 
+	if (!ucsi->connector)
+		return;
+
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
 		ucsi_unregister_partner(&ucsi->connector[i]);
-- 
2.39.0


--XeOJB41DODR5ewEl--
