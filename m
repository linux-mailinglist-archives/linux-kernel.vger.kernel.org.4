Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3D6AD8E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCGIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCGIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:13:56 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679F2917A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5UQ3N55156BuzrIWhT4m3kHb+qYjDIZ3xuJLR2E7/Wc=;
  b=YHnoV+Cvvj/V1yn3OBSdKmZfwK6GhYVqEo4CD74ZwIwNXjCHZrjuFL9P
   1iqeRdhLr5FfUi+jUVb/XgDNGTovaGyIqD9xOq3hGWUJyUuW+jk5JTsdT
   p4cTdIX9wpN8Dj7O3A8YPgBJFLAhgo5kI38P7lrOF+LDBZkobL8cc0/38
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="49413079"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:13:50 +0100
Date:   Tue, 7 Mar 2023 09:13:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Khadija <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
In-Reply-To: <CACcTnM4OHFiGrEez6dMzd4jO4YuQZzqpUK86UBMzhd+nFDWezA@mail.gmail.com>
Message-ID: <e06f57e6-2a3a-7fde-742d-9d5dd8dd49b0@inria.fr>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine> <alpine.DEB.2.22.394.2303062202500.3050@hadrien> <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com> <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
 <CACcTnM4OHFiGrEez6dMzd4jO4YuQZzqpUK86UBMzhd+nFDWezA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was curious to see if there are other strange argument layouts.  So I
searched for cases where there are adjacent arguments on consecutive lines
where the second of the arguments is to the right of the first one.

There are a number of cases like this.  Some are as good as they can be.
Others are truly strange, like one case that has a , at the beginning of a
line.  Some violate another kernel style guideline, which is that strings
(and least when the parts don't end in a newline) should not be separated
over multiple lines (ie "abc" "def").

There are actually two similar issues in axis-fifo.c.  You could fix them
both at once.

In the following, a - at the beginning of the line is not a suggestion to
remove the line.  It's just a way to get a path output that includes the
line of interest and some of its context.

julia

diff -u -p /home/julia/linux/drivers/staging/fbtft/fb_ssd1325.c /tmp/nothing/fbtft/fb_ssd1325.c
--- /home/julia/linux/drivers/staging/fbtft/fb_ssd1325.c
+++ /tmp/nothing/fbtft/fb_ssd1325.c
@@ -114,8 +114,6 @@ static int set_gamma(struct fbtft_par *p
 	for (i = 0; i < GAMMA_LEN; i++) {
 		if (i > 0 && curves[i] < 1) {
 			dev_err(par->info->device,
-				"Illegal value in Grayscale Lookup Table at index %d.\n"
-				"Must be greater than 0\n", i);
 			return -EINVAL;
 		}
 		if (curves[i] > 7) {
diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_ioctl.c /tmp/nothing/media/atomisp/pci/atomisp_ioctl.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ /tmp/nothing/media/atomisp/pci/atomisp_ioctl.c
@@ -1714,8 +1714,6 @@ static int atomisp_s_ctrl(struct file *f
 	case V4L2_CID_TEST_PATTERN_COLOR_GB:
 	case V4L2_CID_TEST_PATTERN_COLOR_B:
 		return v4l2_s_ctrl(NULL,
-				   isp->inputs[asd->input_curr].camera->
-				   ctrl_handler, control);
 	case V4L2_CID_COLORFX:
 		ret = atomisp_color_effect(asd, 1, &control->value);
 		break;
@@ -1936,8 +1934,6 @@ static int atomisp_camera_s_ext_ctrls(st
 		case V4L2_CID_TEST_PATTERN_COLOR_GB:
 		case V4L2_CID_TEST_PATTERN_COLOR_B:
 			ret = v4l2_s_ctrl(NULL,
-					  isp->inputs[asd->input_curr].camera->
-					  ctrl_handler, &ctrl);
 			break;
 		case V4L2_CID_FOCUS_ABSOLUTE:
 		case V4L2_CID_FOCUS_RELATIVE:
@@ -1948,8 +1944,6 @@ static int atomisp_camera_s_ext_ctrls(st
 						  &ctrl);
 			else
 				ret = v4l2_s_ctrl(NULL,
-						  isp->inputs[asd->input_curr].
-						  camera->ctrl_handler, &ctrl);
 			break;
 		case V4L2_CID_FLASH_STATUS:
 		case V4L2_CID_FLASH_INTENSITY:
diff -u -p /home/julia/linux/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c /tmp/nothing/media/deprecated/atmel/atmel-sama7g5-isc.c
--- /home/julia/linux/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
+++ /tmp/nothing/media/deprecated/atmel/atmel-sama7g5-isc.c
@@ -287,8 +287,6 @@ static void isc_sama7g5_config_rlp(struc
 	u32 rlp_mode = isc->config.rlp_cfg_mode;

 	regmap_update_bits(regmap, ISC_RLP_CFG + isc->offsets.rlp,
-			   ISC_RLP_CFG_MODE_MASK | ISC_RLP_CFG_LSH |
-			   ISC_RLP_CFG_YMODE_MASK, rlp_mode);
 }

 static void isc_sama7g5_adapt_pipeline(struct isc_device *isc)
diff -u -p /home/julia/linux/drivers/staging/media/ipu3/ipu3-css.c /tmp/nothing/media/ipu3/ipu3-css.c
--- /home/julia/linux/drivers/staging/media/ipu3/ipu3-css.c
+++ /tmp/nothing/media/ipu3/ipu3-css.c
@@ -1193,14 +1193,10 @@ static int imgu_css_binary_preallocate(s

 	for (i = 0; i < IPU3_CSS_AUX_FRAMES; i++)
 		if (!imgu_dmamap_alloc(imgu,
-				       &css_pipe->aux_frames[IPU3_CSS_AUX_FRAME_REF].
-				       mem[i], CSS_BDS_SIZE))
 			goto out_of_memory;

 	for (i = 0; i < IPU3_CSS_AUX_FRAMES; i++)
 		if (!imgu_dmamap_alloc(imgu,
-				       &css_pipe->aux_frames[IPU3_CSS_AUX_FRAME_TNR].
-				       mem[i], CSS_GDC_SIZE))
 			goto out_of_memory;

 	return 0;
@@ -1816,7 +1812,6 @@ int imgu_css_fmt_try(struct imgu_css *cs
 			*rects[i] = r[i];

 	dev_dbg(css->dev,
-		"in(%u,%u) if(%u,%u) ds(%u,%u) gdc(%u,%u) out(%u,%u) vf(%u,%u)",
 		 in->width, in->height, eff->width, eff->height,
 		 bds->width, bds->height, gdc->width, gdc->height,
 		 out->width, out->height, vf->width, vf->height);
diff -u -p /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c /tmp/nothing/rtl8192u/ieee80211/ieee80211_rx.c
--- /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ /tmp/nothing/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1565,8 +1565,6 @@ int ieee80211_parse_info_param(struct ie
 			for (i = 0; i < network->rates_len; i++) {
 				network->rates[i] = info_element->data[i];
 #ifdef CONFIG_IEEE80211_DEBUG
-				p += scnprintf(p, sizeof(rates_str) -
-					      (p - rates_str), "%02X ",
 					      network->rates[i]);
 #endif
 				if (ieee80211_is_ofdm_rate
@@ -1592,8 +1590,6 @@ int ieee80211_parse_info_param(struct ie
 			for (i = 0; i < network->rates_ex_len; i++) {
 				network->rates_ex[i] = info_element->data[i];
 #ifdef CONFIG_IEEE80211_DEBUG
-				p += scnprintf(p, sizeof(rates_str) -
-					      (p - rates_str), "%02X ",
 					      network->rates_ex[i]);
 #endif
 				if (ieee80211_is_ofdm_rate
diff -u -p /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c /tmp/nothing/rtl8192u/ieee80211/ieee80211_tx.c
--- /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ /tmp/nothing/rtl8192u/ieee80211/ieee80211_tx.c
@@ -180,8 +180,6 @@ int ieee80211_encrypt_fragment(
 			struct rtl_80211_hdr_3addrqos *header;

 			header = (struct rtl_80211_hdr_3addrqos *)frag->data;
-			netdev_dbg(ieee->dev, "TKIP countermeasures: dropped "
-			       "TX packet to %pM\n", header->addr1);
 		}
 		return -1;
 	}
diff -u -p /home/julia/linux/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c /tmp/nothing/vc04_services/interface/vchiq_arm/vchiq_core.c
--- /home/julia/linux/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ /tmp/nothing/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3583,9 +3583,6 @@ int vchiq_dump_service_state(void *dump_
 		len = scnprintf(buf, sizeof(buf),
 				"  Bulk: tx_pending=%d (size %d), rx_pending=%d (size %d)",
 				tx_pending,
-				tx_pending ?
-				service->bulk_tx.bulks[BULK_INDEX(service->bulk_tx.remove)].size :
-				0, rx_pending, rx_pending ?
 				service->bulk_rx.bulks[BULK_INDEX(service->bulk_rx.remove)].size :
 				0);

diff -u -p /home/julia/linux/drivers/staging/wlan-ng/p80211conv.c /tmp/nothing/wlan-ng/p80211conv.c
--- /home/julia/linux/drivers/staging/wlan-ng/p80211conv.c
+++ /tmp/nothing/wlan-ng/p80211conv.c
@@ -430,9 +430,6 @@ int skb_p80211_to_ether(struct wlandevic
 			/* A bogus length ethfrm has been sent. */
 			/* Is someone trying an oflow attack? */
 			netdev_err(netdev, "DIXII frame too large (%ld > %d)\n",
-				   (long)(payload_length -
-				   sizeof(struct wlan_llc) -
-				   sizeof(struct wlan_snap)), netdev->mtu);
 			return 1;
 		}

diff -u -p /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c /tmp/nothing/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
--- /home/julia/linux/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ /tmp/nothing/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -356,15 +356,11 @@ static int ieee80211_tkip_decrypt(struct
 	keyidx = pos[3];
 	if (!(keyidx & BIT(5))) {
 		if (net_ratelimit()) {
-			netdev_dbg(skb->dev, "TKIP: received packet without ExtIV"
-			       " flag from %pM\n", hdr->addr2);
 		}
 		return -2;
 	}
 	keyidx >>= 6;
 	if (tkey->key_idx != keyidx) {
-		netdev_dbg(skb->dev, "TKIP: RX tkey->key_idx=%d frame "
-		       "keyidx=%d priv=%p\n", tkey->key_idx, keyidx, priv);
 		return -6;
 	}
 	if (!tkey->key_set) {
diff -u -p /home/julia/linux/drivers/staging/qlge/qlge_main.c /tmp/nothing/qlge/qlge_main.c
--- /home/julia/linux/drivers/staging/qlge/qlge_main.c
+++ /tmp/nothing/qlge/qlge_main.c
@@ -1217,8 +1217,6 @@ static void qlge_unmap_send(struct qlge_
 			dma_unmap_page(&qdev->pdev->dev,
 				       dma_unmap_addr(&tx_ring_desc->map[i],
 						      mapaddr),
-				       dma_unmap_len(&tx_ring_desc->map[i],
-						     maplen), DMA_TO_DEVICE);
 		}
 	}
 }
diff -u -p /home/julia/linux/drivers/staging/greybus/camera.c /tmp/nothing/greybus/camera.c
--- /home/julia/linux/drivers/staging/greybus/camera.c
+++ /tmp/nothing/greybus/camera.c
@@ -315,8 +315,6 @@ static int gb_camera_set_intf_power_mode
 						 GB_SVC_SMALL_AMPLITUDE,
 						 GB_SVC_NO_DE_EMPHASIS,
 						 GB_SVC_UNIPRO_FAST_MODE, 2, 2,
-						 GB_SVC_PWRM_RXTERMINATION |
-						 GB_SVC_PWRM_TXTERMINATION, 0,
 						 NULL, NULL);
 	else
 		ret = gb_svc_intf_set_power_mode(svc, intf_id,
diff -u -p /home/julia/linux/drivers/staging/rtl8712/rtl871x_cmd.c /tmp/nothing/rtl8712/rtl871x_cmd.c
--- /home/julia/linux/drivers/staging/rtl8712/rtl871x_cmd.c
+++ /tmp/nothing/rtl8712/rtl871x_cmd.c
@@ -549,8 +549,6 @@ void r8712_setstakey_cmd(struct _adapter
 		memcpy(&psetstakey_para->key, &sta->x_UncstKey, 16);
 	else
 		memcpy(&psetstakey_para->key,
-			&psecuritypriv->XGrpKey[
-			psecuritypriv->XGrpKeyid - 1]. skey, 16);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }

diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_cmd.c /tmp/nothing/media/atomisp/pci/atomisp_cmd.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ /tmp/nothing/media/atomisp/pci/atomisp_cmd.c
@@ -5088,18 +5088,12 @@ int atomisp_set_fmt(struct video_device
 		if (source_pad == ATOMISP_SUBDEV_PAD_SOURCE_PREVIEW) {
 			atomisp_css_video_configure_viewfinder(asd,
 							       f->fmt.pix.width, f->fmt.pix.height,
-							       format_bridge->planar ? f->fmt.pix.bytesperline
-							       : f->fmt.pix.bytesperline * 8
-							       / format_bridge->depth,	format_bridge->sh_fmt);
 			atomisp_css_video_get_viewfinder_frame_info(asd,
 				&output_info);
 			asd->copy_mode = false;
 		} else {
 			atomisp_css_capture_configure_viewfinder(asd,
 				f->fmt.pix.width, f->fmt.pix.height,
-				format_bridge->planar ? f->fmt.pix.bytesperline
-				: f->fmt.pix.bytesperline * 8
-				/ format_bridge->depth,	format_bridge->sh_fmt);
 			atomisp_css_capture_get_viewfinder_frame_info(asd,
 				&output_info);
 			asd->copy_mode = false;
diff -u -p /home/julia/linux/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c /tmp/nothing/vc04_services/interface/vchiq_arm/vchiq_dev.c
--- /home/julia/linux/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ /tmp/nothing/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -584,8 +584,6 @@ vchiq_ioctl(struct file *file, unsigned

 	vchiq_log_trace(vchiq_arm_log_level,
 			"%s - instance %pK, cmd %s, arg %lx", __func__, instance,
-			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-			ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);

 	switch (cmd) {
 	case VCHIQ_IOC_SHUTDOWN:
@@ -871,13 +869,9 @@ vchiq_ioctl(struct file *file, unsigned
 	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
 			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
-			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-			       ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 	else
 		vchiq_log_trace(vchiq_arm_log_level,
 				"  ioctl instance %pK, cmd %s -> status %d, %ld",
-				instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);

 	return ret;
 }
diff -u -p /home/julia/linux/drivers/staging/r8188eu/core/rtw_mlme_ext.c /tmp/nothing/r8188eu/core/rtw_mlme_ext.c
--- /home/julia/linux/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ /tmp/nothing/r8188eu/core/rtw_mlme_ext.c
@@ -1497,8 +1497,6 @@ static void OnAction_back(struct adapter
 		preorder_ctrl->indicate_seq = 0xffff;
 		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
 		issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP,
-				pmlmeinfo->bAcceptAddbaReq ?
-					WLAN_STATUS_SUCCESS : WLAN_STATUS_REQUEST_DECLINED, mgmt);
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
 		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_resp.capab),
diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c /tmp/nothing/media/atomisp/pci/hmm/hmm_bo.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
+++ /tmp/nothing/media/atomisp/pci/hmm/hmm_bo.c
@@ -856,9 +856,6 @@ void hmm_bo_unbind(struct hmm_buffer_obj
 	mutex_lock(&bo->mutex);

 	check_bo_status_yes_goto(bo,
-				 HMM_BO_PAGE_ALLOCED |
-				 HMM_BO_ALLOCED |
-				 HMM_BO_BINDED, status_err);

 	bdev = bo->bdev;

diff -u -p /home/julia/linux/drivers/staging/rtl8192e/rtllib_rx.c /tmp/nothing/rtl8192e/rtllib_rx.c
--- /home/julia/linux/drivers/staging/rtl8192e/rtllib_rx.c
+++ /tmp/nothing/rtl8192e/rtllib_rx.c
@@ -2070,8 +2070,6 @@ int rtllib_parse_info_param(struct rtlli
 						 MAX_RATES_LENGTH);
 			for (i = 0; i < network->rates_len; i++) {
 				network->rates[i] = info_element->data[i];
-				p += scnprintf(p, sizeof(rates_str) -
-					      (p - rates_str), "%02X ",
 					      network->rates[i]);
 				if (rtllib_is_ofdm_rate
 				    (info_element->data[i])) {
@@ -2098,8 +2096,6 @@ int rtllib_parse_info_param(struct rtlli
 						    MAX_RATES_EX_LENGTH);
 			for (i = 0; i < network->rates_ex_len; i++) {
 				network->rates_ex[i] = info_element->data[i];
-				p += scnprintf(p, sizeof(rates_str) -
-					      (p - rates_str), "%02X ",
 					      network->rates_ex[i]);
 				if (rtllib_is_ofdm_rate
 				    (info_element->data[i])) {
diff -u -p /home/julia/linux/drivers/staging/rts5208/sd.c /tmp/nothing/rts5208/sd.c
--- /home/julia/linux/drivers/staging/rts5208/sd.c
+++ /tmp/nothing/rts5208/sd.c
@@ -3064,8 +3064,6 @@ int reset_sd_card(struct rtsx_chip *chip
 				return STATUS_FAIL;
 		} else {
 			retval = rtsx_write_register(chip, FPGA_PULL_CTL,
-						     FPGA_SD_PULL_CTL_BIT |
-						     0x20, 0);
 			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
 		}
diff -u -p /home/julia/linux/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h /tmp/nothing/vc04_services/bcm2835-camera/bcm2835-camera.h
--- /home/julia/linux/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
+++ /tmp/nothing/vc04_services/bcm2835-camera/bcm2835-camera.h
@@ -120,7 +120,6 @@ int set_framerate_params(struct bcm2835_
 #define v4l2_dump_pix_format(level, debug, dev, pix_fmt, desc)	\
 {	\
 	v4l2_dbg(level, debug, dev,	\
-"%s: w %u h %u field %u pfmt 0x%x bpl %u sz_img %u colorspace 0x%x priv %u\n", \
 		desc,	\
 		(pix_fmt)->width, (pix_fmt)->height, (pix_fmt)->field,	\
 		(pix_fmt)->pixelformat, (pix_fmt)->bytesperline,	\
@@ -130,8 +129,6 @@ int set_framerate_params(struct bcm2835_
 #define v4l2_dump_win_format(level, debug, dev, win_fmt, desc)	\
 {	\
 	v4l2_dbg(level, debug, dev,	\
-"%s: w %u h %u l %u t %u  field %u chromakey %06X clip %p " \
-"clipcount %u bitmap %p\n", \
 		desc,	\
 		(win_fmt)->w.width, (win_fmt)->w.height, \
 		(win_fmt)->w.left, (win_fmt)->w.top, \
diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fifo_monitor.c /tmp/nothing/media/atomisp/pci/hive_isp_css_common/host/fifo_monitor.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fifo_monitor.c
+++ /tmp/nothing/media/atomisp/pci/hive_isp_css_common/host/fifo_monitor.c
@@ -248,7 +248,6 @@ void fifo_channel_get_state(
 		state->sink_accept = !_hrt_get_bit(value, 0);
 	}
 	state->src_valid   = fifo_monitor_status_valid(ID,
-			     HIVE_GP_REGS_ISP_STREAM_STAT_IDX,
 				     ISP_STR_MON_PORT_RCV_GPD); /* ISP_STR_MON_PORT_FA2ISP */
 	state->fifo_accept = fifo_monitor_status_accept(ID,
 			     HIVE_GP_REGS_ISP_STREAM_STAT_IDX,
@@ -443,7 +442,6 @@ void fifo_channel_get_state(
 		state->sink_accept = !_hrt_get_bit(value, 0);
 	}
 	state->src_valid   = fifo_monitor_status_valid(ID,
-			     HIVE_GP_REGS_SP_STREAM_STAT_IDX,
 				     SP_STR_MON_PORT_RCV_GPD); /* SP_STR_MON_PORT_FA2SP */
 	state->fifo_accept = fifo_monitor_status_accept(ID,
 			     HIVE_GP_REGS_SP_STREAM_STAT_IDX,
diff -u -p /home/julia/linux/drivers/staging/fbtft/fb_ssd1351.c /tmp/nothing/fbtft/fb_ssd1351.c
--- /home/julia/linux/drivers/staging/fbtft/fb_ssd1351.c
+++ /tmp/nothing/fbtft/fb_ssd1351.c
@@ -71,7 +71,6 @@ static int set_var(struct fbtft_par *par
 	if (par->fbtftops.init_display != init_display) {
 		/* don't risk messing up register A0h */
 		fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-			      "%s: skipping since custom init_display() is used\n",
 			       __func__);
 		return 0;
 	}
diff -u -p /home/julia/linux/drivers/staging/qlge/qlge_dbg.c /tmp/nothing/qlge/qlge_dbg.c
--- /home/julia/linux/drivers/staging/qlge/qlge_dbg.c
+++ /tmp/nothing/qlge/qlge_dbg.c
@@ -746,24 +746,16 @@ int qlge_core_dump(struct qlge_adapter *
 	/* Get generic NIC reg dump */
 	qlge_build_coredump_seg_header(&mpi_coredump->nic_regs_seg_hdr,
 				       NIC1_CONTROL_SEG_NUM,
-				       sizeof(struct mpi_coredump_segment_header) +
-				       sizeof(mpi_coredump->nic_regs), "NIC1 Registers");

 	qlge_build_coredump_seg_header(&mpi_coredump->nic2_regs_seg_hdr,
 				       NIC2_CONTROL_SEG_NUM,
-				       sizeof(struct mpi_coredump_segment_header) +
-				       sizeof(mpi_coredump->nic2_regs), "NIC2 Registers");

 	/* Get XGMac registers. (Segment 18, Rev C. step 21) */
 	qlge_build_coredump_seg_header(&mpi_coredump->xgmac1_seg_hdr,
 				       NIC1_XGMAC_SEG_NUM,
-				       sizeof(struct mpi_coredump_segment_header) +
-				       sizeof(mpi_coredump->xgmac1), "NIC1 XGMac Registers");

 	qlge_build_coredump_seg_header(&mpi_coredump->xgmac2_seg_hdr,
 				       NIC2_XGMAC_SEG_NUM,
-				       sizeof(struct mpi_coredump_segment_header) +
-				       sizeof(mpi_coredump->xgmac2), "NIC2 XGMac Registers");

 	if (qdev->func & 1) {
 		/* Odd means our function is NIC 2 */
@@ -1144,8 +1136,6 @@ int qlge_core_dump(struct qlge_adapter *
 	/* Get the semaphore registers for all 5 functions */
 	qlge_build_coredump_seg_header(&mpi_coredump->sem_regs_seg_hdr,
 				       SEM_REGS_SEG_NUM,
-				       sizeof(struct mpi_coredump_segment_header) +
-				       sizeof(mpi_coredump->sem_regs),	"Sem Registers");

 	qlge_get_sem_registers(qdev, &mpi_coredump->sem_regs[0]);

diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c /tmp/nothing/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
+++ /tmp/nothing/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
@@ -2731,7 +2731,6 @@ ia_css_debug_pipe_graph_dump_stage(
 				while (ei[p] != ',')
 					p--;
 				/* Last comma found, copy till that comma */
-				strscpy(enable_info1, ei,
                                         p > sizeof(enable_info1) ? sizeof(enable_info1) : p);

 				ei += p + 1;
diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_subdev.c /tmp/nothing/media/atomisp/pci/atomisp_subdev.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/atomisp_subdev.c
+++ /tmp/nothing/media/atomisp/pci/atomisp_subdev.c
@@ -388,8 +388,6 @@ int atomisp_subdev_set_selection(struct
 		atomisp_pad_str(pad), target == V4L2_SEL_TGT_CROP
 		? "V4L2_SEL_TGT_CROP" : "V4L2_SEL_TGT_COMPOSE",
 		r->left, r->top, r->width, r->height,
-		which == V4L2_SUBDEV_FORMAT_TRY ? "V4L2_SUBDEV_FORMAT_TRY"
-		: "V4L2_SUBDEV_FORMAT_ACTIVE", flags);

 	r->width = rounddown(r->width, ATOM_ISP_STEP_WIDTH);
 	r->height = rounddown(r->height, ATOM_ISP_STEP_HEIGHT);
@@ -1154,8 +1152,6 @@ int atomisp_create_pads_links(struct ato
 			return ret;
 		ret = media_create_pad_link(&asd->subdev.entity,
 					    ATOMISP_SUBDEV_PAD_SOURCE_VIDEO,
-					    &asd->video_out_video_capture.vdev.
-					    entity, 0, 0);
 		if (ret < 0)
 			return ret;
 	}
diff -u -p /home/julia/linux/drivers/staging/media/atomisp/pci/sh_css.c /tmp/nothing/media/atomisp/pci/sh_css.c
--- /home/julia/linux/drivers/staging/media/atomisp/pci/sh_css.c
+++ /tmp/nothing/media/atomisp/pci/sh_css.c
@@ -1272,7 +1272,6 @@ static void start_pipe(
 				copy_ovrd,
 				input_mode,
 				&me->stream->config.metadata_config,
-				&me->stream->info.metadata_info
 				, (input_mode == IA_CSS_INPUT_MODE_MEMORY) ?
 				(enum mipi_port_id)0 :
 				me->stream->config.source.port.port);
diff -u -p /home/julia/linux/drivers/staging/media/omap4iss/iss_ipipeif.c /tmp/nothing/media/omap4iss/iss_ipipeif.c
--- /home/julia/linux/drivers/staging/media/omap4iss/iss_ipipeif.c
+++ /tmp/nothing/media/omap4iss/iss_ipipeif.c
@@ -175,8 +175,6 @@ cont_raw:
 			    IPIPEIF_CFG2_YUV16);

 		iss_reg_update(iss, OMAP4_ISS_MEM_ISP_ISIF, ISIF_MODESET,
-			       ISIF_MODESET_CCDMD | ISIF_MODESET_INPMOD_MASK |
-			       ISIF_MODESET_CCDW_MASK, ISIF_MODESET_INPMOD_RAW |
 			       ISIF_MODESET_CCDW_2BIT);

 		info = omap4iss_video_format_info(format->code);
diff -u -p /home/julia/linux/drivers/staging/vc04_services/bcm2835-camera/controls.c /tmp/nothing/vc04_services/bcm2835-camera/controls.c
--- /home/julia/linux/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ /tmp/nothing/vc04_services/bcm2835-camera/controls.c
@@ -548,7 +548,6 @@ static int ctrl_set_image_effect(struct

 exit:
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-		 "mmal_ctrl:%p ctrl id:0x%x ctrl val:%d imagefx:0x%x color_effect:%s u:%d v:%d ret %d(%d)\n",
 				mmal_ctrl, ctrl->id, ctrl->val, imagefx.effect,
 				dev->colourfx.enable ? "true" : "false",
 				dev->colourfx.u, dev->colourfx.v,
diff -u -p /home/julia/linux/drivers/staging/axis-fifo/axis-fifo.c /tmp/nothing/axis-fifo/axis-fifo.c
--- /home/julia/linux/drivers/staging/axis-fifo/axis-fifo.c
+++ /tmp/nothing/axis-fifo/axis-fifo.c
@@ -383,7 +383,6 @@ static ssize_t axis_fifo_read(struct fil
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
 				 (read_timeout >= 0) ?
 				  msecs_to_jiffies(read_timeout) :
 				  MAX_SCHEDULE_TIMEOUT);
@@ -526,8 +525,6 @@ static ssize_t axis_fifo_write(struct fi
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
 				 (write_timeout >= 0) ?
 				  msecs_to_jiffies(write_timeout) :
 				  MAX_SCHEDULE_TIMEOUT);
