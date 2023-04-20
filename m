Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF86E8DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjDTJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjDTJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:08:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57D4C2C;
        Thu, 20 Apr 2023 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681981620; x=1713517620;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=RWCg+Vm/E7sx4BQ4IQktJkOiVlN5+DQ5Cu6M0fv/OkQ=;
  b=eXxRxRE2jAQeIGt3rGh9SunyrEAu/wegbqFjSUuWnj4KocfzOzCdNFTH
   VOrgrC2i4+YkynLWNBCDSwM0yWMZUj3PP1E0/xcQa9LblY9JHiNDk59jV
   WcZqrj1cnVxzMouObMBfMTR6bpWSvatEIbpbpSR9b1xM/mtqwHDfHUWTm
   Uq7u/+HJZToYhBl0stliyl+xiS7u7QtEWcbEh7CPn3O5w0W64DcRh/OOl
   KAK5sehixAQSImw/qEg6DZGVOKBb+MSmLona4T8ZgeQ9Mv1NAE/Y/FQ2j
   xaIUgel1RQPGgzFfNAQwW4uVlJcd8lf1mWTb//oO5fxM71o5HSH+DfK9Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345684092"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345684092"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="694405602"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="694405602"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.236.160])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:06:58 -0700
Message-ID: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
Subject: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com, sakari.ailus@iki.fi
Date:   Thu, 20 Apr 2023 12:06:55 +0300
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel RealSense UVC Depth cameras produce metadata in a
vendor-specific format that is already supported by the uvcvideo driver.
Enable handling of this metadata for 7 additional RealSense devices.

Co-developed-by: Yu MENG <yu1.meng@intel.com>
Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc=
_driver.c
index 7aefa76a42b3..f69573e2de96 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3014,6 +3014,33 @@ static const struct usb_device_id uvc_ids[] =3D {
 	  .bInterfaceSubClass	=3D 1,
 	  .bInterfaceProtocol	=3D 0,
 	  .driver_info		=3D (kernel_ulong_t)&uvc_ctrl_power_line_limited },
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
 	/* Intel RealSense D4M */
 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
@@ -3023,6 +3050,42 @@ static const struct usb_device_id uvc_ids[] =3D {
 	  .bInterfaceSubClass	=3D 1,
 	  .bInterfaceProtocol	=3D 0,
 	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
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

