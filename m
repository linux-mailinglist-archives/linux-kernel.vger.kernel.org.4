Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014146F2BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjD3X5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjD3Xzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D1EE52;
        Sun, 30 Apr 2023 16:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACF660EA1;
        Sun, 30 Apr 2023 23:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83264C433EF;
        Sun, 30 Apr 2023 23:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682898929;
        bh=dTNM1M0JT0+eGMtaKZE9hf4zA/dExOD/przadxXu2xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCtR0c2Z0uMk7AiX2QC6AMEq6t6u6D4rrpZzwcggL9WFtGny6x9uAP9nKqZFEWR+f
         28JfR5G9yJvjs7Q5WUhKqeWZAduzMLIT2q2j8iyKO/YVoWGSW/7aw8+LaMsEftsoZY
         n0/rng7NMe5o4fbibrLgBY8zegpo8xaVWxElWyCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.3.1
Date:   Mon,  1 May 2023 08:55:27 +0900
Message-Id: <2023050124-plaza-conform-bd27@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050123-resubmit-silica-ac32@gregkh>
References: <2023050123-resubmit-silica-ac32@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f5543eef4f82..340bd45fc8d2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 3
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8def2ba08a82..1b16e0fb7658 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -708,7 +708,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 31ae0adbb295..046ada264889 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1617,6 +1617,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@18",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 1.7.8
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ELAN0415:00@9",
+		},
+	},
 	{
 		/*
 		 * Spurious wakeups from TP_ATTN# pin
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index a39998047f8a..2fe8349be099 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1569,6 +1569,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 65d4799a5658..ff710b0b5071 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -965,6 +965,12 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
 	}
 
+#define CYW_SDIO_DEVICE(dev_id, fw_vend) \
+	{ \
+		SDIO_DEVICE(SDIO_VENDOR_ID_CYPRESS, dev_id), \
+		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
+	}
+
 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43143, WCC),
@@ -979,6 +985,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43439, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
@@ -986,9 +993,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
+	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a9690ec4c850..5a9f713ea703 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6164,6 +6164,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f31cc3c76329..644a55447fd7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e5c963bb873d..af2e153543a5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6d592870400..db63f9da787f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2618,7 +2618,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 7a0e3a84d370..c547ca4eb05a 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -13,6 +13,7 @@
 
 struct block_buffer {
 	u32 filled;
+	bool is_root_hash;
 	u8 *data;
 };
 
@@ -24,6 +25,14 @@ static int hash_one_block(struct inode *inode,
 	struct block_buffer *next = cur + 1;
 	int err;
 
+	/*
+	 * Safety check to prevent a buffer overflow in case of a filesystem bug
+	 * that allows the file size to change despite deny_write_access(), or a
+	 * bug in the Merkle tree logic itself
+	 */
+	if (WARN_ON_ONCE(next->is_root_hash && next->filled != 0))
+		return -EINVAL;
+
 	/* Zero-pad the block if it's shorter than the block size. */
 	memset(&cur->data[cur->filled], 0, params->block_size - cur->filled);
 
@@ -97,6 +106,7 @@ static int build_merkle_tree(struct file *filp,
 		}
 	}
 	buffers[num_levels].data = root_hash;
+	buffers[num_levels].is_root_hash = true;
 
 	BUILD_BUG_ON(sizeof(level_offset) != sizeof(params->level_start));
 	memcpy(level_offset, params->level_start, sizeof(level_offset));
@@ -347,6 +357,13 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	err = file_permission(filp, MAY_WRITE);
 	if (err)
 		return err;
+	/*
+	 * __kernel_read() is used while building the Merkle tree.  So, we can't
+	 * allow file descriptors that were opened for ioctl access only, using
+	 * the special nonstandard access mode 3.  O_RDONLY only, please!
+	 */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
 
 	if (IS_APPEND(inode))
 		return -EPERM;
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0e4ef9c5127a..bf3c95d8eb8a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -74,10 +74,13 @@
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xa9af
+#define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
+#define SDIO_VENDOR_ID_CYPRESS			0x04b4
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
+
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
 #define SDIO_DEVICE_ID_MARVELL_8688_WLAN	0x9104
diff --git a/mm/mmap.c b/mm/mmap.c
index d5475fbf5729..eefa6f0cda28 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-			vma_pgoff = mid->vm_pgoff;
+			vma_pgoff = next->vm_pgoff - pglen;
 			err = 0;
 			if (mid != next) {		/* case 8 */
 				remove = mid;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 06581223238c..f597fe0db9f8 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1003,7 +1003,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	if (hci_sock_gen_cookie(sk)) {
 		struct sk_buff *skb;
 
-		if (capable(CAP_NET_ADMIN))
+		/* Perform careful checks before setting the HCI_SOCK_TRUSTED
+		 * flag. Make sure that not only the current task but also
+		 * the socket opener has the required capability, since
+		 * privileged programs can be tricked into making ioctl calls
+		 * on HCI sockets, and the socket should not be marked as
+		 * trusted simply because the ioctl caller is privileged.
+		 */
+		if (sk_capable(sk, CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */
