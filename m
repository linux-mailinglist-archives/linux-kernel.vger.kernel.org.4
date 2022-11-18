Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8E62EBDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKRCX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRCXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:23:22 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6674AAA;
        Thu, 17 Nov 2022 18:23:17 -0800 (PST)
X-UUID: 01a59f0de35b4581b34eda7dfd5bef7b-20221118
X-CPASD-INFO: 113bc3333ceb49adbfea8f3b96d65fcb@eoFtgpBlYWNfg6eug3ysnoKXlZFoklO
        xe3CEZmOWj4KVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3gHNtgpNhYw==
X-CLOUD-ID: 113bc3333ceb49adbfea8f3b96d65fcb
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:161.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:189.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:5,DUF:8679,ACD:144,DCD:144,SL:0,EISP:0,AG:0,CFC:0.526,CFSR:0.029,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 01a59f0de35b4581b34eda7dfd5bef7b-20221118
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 01a59f0de35b4581b34eda7dfd5bef7b-20221118
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 748414521; Fri, 18 Nov 2022 10:23:36 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        ribalda@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v3] media: uvcvideo: Fix bandwidth error for Alcor camera
Date:   Fri, 18 Nov 2022 10:23:02 +0800
Message-Id: <20221118022302.112121-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to
output compressed video data, and it return a wrong
dwMaxPayloadTransferSize fields. This is a fireware issue,
but the manufacturer cannot provide a const return fields
by the fireware. For some device, device requested 2752512
 B/frame bandwidth. For some device, device requested 3072
 B/frame bandwidth. so we check the dwMaxPayloadTransferSize
 fields,if it large than 0x1000, reset dwMaxPayloadTransferSize
to 1024, and the camera preview normally.

Signed-off-by: Ai Chao <aichao@kylinos.cn>

---
change for v3
- Add VID/PID 2017:0011

change for v2
- Used usb_match_one_id to check VID and PID
---
---
 drivers/media/usb/uvc/uvc_video.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..1260800ef8bd 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -135,6 +135,10 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 	static const struct usb_device_id elgato_cam_link_4k = {
 		USB_DEVICE(0x0fd9, 0x0066)
 	};
+	static const struct usb_device_id alcor_corp_slave_cam = {
+		USB_DEVICE(0x1b17, 0x6684),
+		USB_DEVICE(0x2017, 0x0011),
+	};
 	struct uvc_format *format = NULL;
 	struct uvc_frame *frame = NULL;
 	unsigned int i;
@@ -234,6 +238,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 
 		ctrl->dwMaxPayloadTransferSize = bandwidth;
 	}
+
+	/* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
+	if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
+	    (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
+	     usb_match_one_id(stream->dev->intf, &alcor_corp_slave_cam)) {
+		ctrl->dwMaxPayloadTransferSize = 1024;
+	}
 }
 
 static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
-- 
2.25.1

