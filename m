Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DE67FF73
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjA2Nn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjA2Nn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:43:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92441F905;
        Sun, 29 Jan 2023 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674999834; x=1706535834;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=IvXmT10hHiA0X2ce3w2g38OlhPIqHmnyw3DcFPNVzco=;
  b=O5xNT0r5VtKmILbn/Ma/CAF4kr8dR89AsjiZm/Vrdj0W1B86tl1a8gG5
   /49/qPwq/9TmxjadpKX6FOIlCgSvEilM62alFPuN75kAJ6aJZBeiZTH8W
   /cO89qwyHsQIeIohvjxLxwFCETG2gliY1yeiudvXVFlgBuecLR4WQ2ZOu
   6sde45q8H2sgG9LK/yoGrCmZyaJ4NcYZgVE9nfpys4JAos82dK/DSwi7q
   koTRSDjju4FlVRtZcxy+jK7wa0vAdXETKxnhmFc80Mu4dEkXedetSd5fM
   pBUVofrIqw2aHFWJQkFBnWstl7RAhpIA53d2D1Dk/NUREbQWBp8O+PY7G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="354711078"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="354711078"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 05:43:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="657154421"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="657154421"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.201.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 05:43:50 -0800
Message-ID: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
Subject: [PATCH] uvc: Intel PID enabling UVC Metadata attributes
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com
Date:   Sun, 29 Jan 2023 15:43:38 +0200
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel RealSense UVC cameras Metadata support.

Co-developed-by: Yu MENG <yu1.meng@intel.com>
Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc=
_driver.c
index e4bcb5011360..955f67d9a993 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] =3D {
 	  .bInterfaceSubClass	=3D 1,
 	  .bInterfaceProtocol	=3D 0,
 	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D410/ASR depth camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0ad2,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D415/ASRC depth camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0ad3,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D430/AWG depth camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0ad4,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel Fallback USB2 Descriptor */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0ad6,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D435/AWGC depth camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0b07,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D435i depth camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0b3a,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D405 Depth Camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0b5b,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Intel D455 Depth Camera */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x8086,
+	  .idProduct		=3D 0x0b5c,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
 	/* Generic USB Video Class */
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
-- =

2.25.1


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

