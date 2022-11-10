Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BB623D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKJINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiKJINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:13:24 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184118B26;
        Thu, 10 Nov 2022 00:13:19 -0800 (PST)
X-UUID: 7eef3482953a4f408d397b9d764f0dcd-20221110
X-CPASD-INFO: 437978b74e51435bbdff1efacb0a72e6@fYNxWWRqkGdghXd9g3aAnIKVlpZhkYa
        wpZxQkWVikVaVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3g3VxWWdmkg==
X-CLOUD-ID: 437978b74e51435bbdff1efacb0a72e6
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:172.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:122.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:3,DUF:7983,ACD:137,DCD:137,SL:0,EISP:0,AG:0,CFC:0.577,CFSR:0.039,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 7eef3482953a4f408d397b9d764f0dcd-20221110
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 7eef3482953a4f408d397b9d764f0dcd-20221110
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 82805009; Thu, 10 Nov 2022 16:13:31 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        aichao@kylinos.cn
Subject: [PATCH] media: uvcvideo: Fix bandwidth error for Alcor camera
Date:   Thu, 10 Nov 2022 16:12:59 +0800
Message-Id: <20221110081259.947269-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Alcor Corp. Slave camera(1b17:6684), it support to
output compressed video data, and it return a wrong
 dwMaxPayloadTransferSize fields. This is a fireware issue,
but the manufacturer cannot provide a const return fields
by the fireware. so we check the dwMaxPayloadTransferSize fields,
if it large than 0x1000, reset dwMaxPayloadTransferSize to 1024.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..49226c3f423c 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -234,6 +234,14 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 
 		ctrl->dwMaxPayloadTransferSize = bandwidth;
 	}
+
+	/*Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize*/
+	if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
+	    (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
+	    (le16_to_cpu(stream->dev->udev->descriptor.idVendor) == 0x1b17) &&
+	    (le16_to_cpu(stream->dev->udev->descriptor.idProduct) == 0x6684)) {
+		ctrl->dwMaxPayloadTransferSize = 1024;
+	}
 }
 
 static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
-- 
2.25.1

