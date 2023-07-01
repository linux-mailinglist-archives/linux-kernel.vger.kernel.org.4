Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E545744A92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGAQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:39:32 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173C1992;
        Sat,  1 Jul 2023 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688229564;
        bh=6fCq9djsf59ztW/Td6J0/vZaft/6rDmkJSI0wgjlj6o=;
        h=From:To:Cc:Subject:Date;
        b=WIGQhwhx/ycpTHw1CvHqvFSthiNsF71s7Xzu8ZPvxb/hDUNZ+FHxCYrs0gGbIzVgU
         amPb0EyGdtDHXU3D1j4R5eDi2cWP3J63wrUj0PYcumYuEN145RHY+xVcq3vEUcppE2
         p0os9+gYqiyaTg2iI+6TliesHzxzbFNmm0+MOAKs=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 9D61D215; Sun, 02 Jul 2023 00:39:22 +0800
X-QQ-mid: xmsmtpt1688229562t6mvo2mqs
Message-ID: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtDsSJJtgLNyGliCVUmFLSjikOECelzaHrTqMPpoR4jpvGrwR+VN
         uQWKUbnJfszWVVDU3Mbo3u6QIcarYZ9ct/lsMPrEdtwKkbulwNCDsMjzQaYgDrzDQxi/H56QYRbs
         KI26SfxOXj/NthbU22Rpx9/He06BDpgXXH4n7LdQRfzReLGMSw/UTQmm0HsuRWjNv5Aczs73afcP
         IKbWbwyigjYorhhQTMDq2ZLlDM+5lr2U5rHrUEN7cX5/2BtsvqvlCmgrOM6KVdIDi8YsE+Bhca37
         1h7lkaSWeH+fjKxn4fCWSEfCYHLOVHPM3ocMPY4YoFNEs5J3wx4QmxPAiypjcOkfDlwzuv16HvHG
         mgHAckBUKKGvEJx75gCTkLL1N7dxG3bmkxJWWNKZVGBX2cXPr7ThoXGeARkhXNt/5pkhRMBU+SeT
         emUvOHn3qV+iJZgf0BKMplv+GUWewKjBqxVPEBSwrK5oOE2o9h3ZAYz24sKzGIJS3vRFenjC8VrL
         Y1bo4AEJ1l5R+xPz4dlYa/Ta5kARoDyLDXR8oo+fGdESj73h+Qnd3jMTxVTh3ztqYIJCHGPg0tL+
         AEa9Sf+1czkiSVa0bCUTlypaTtObkeYK27zkIuXgOTSHDN6qYV3OC4b0cLUWDEBj1cOm8qzMHNOR
         LRCaSI7wDqqTeqtanmbs8ITAC7Im0xza/7fYINy1X4kacEq26/J2T8pITnQ+tVG4DYvfAeaerJdg
         BMsYHPGQn1PPAMGndJY6ShBJCWvtuhCgG2ZTKDTenKQfbQng6yesfU6LF21DTsY+iwlqgs57fURR
         FBOzvi7I3bsG52mfX4dHcvilHzm14D5Qy4KPrASI7118xDZYYKfW0oQnXPIfv1TCM4Fu9ihIQADa
         k4gkOz/hlQfaSStCbo2Ef6tl1HGYzy3TScd5C7YyFPi27ocQVkT2O1vXfTxGLl3vIKYuU4VcSaVG
         s3omO3u6WRAx2nukxtjrtKAmOO2DYIa0lR0opXB5xYErAYDmNYGyulp+KnScVG9vJuv1UEfBp164
         pc+NRZwg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] usb: r8a66597-hcd: host: fix port index underflow and UBSAN complains
Date:   Sun,  2 Jul 2023 00:39:20 +0800
X-OQ-MSGID: <20230701163920.1089205-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wIndex is 0 (and it often is), these calculations underflow and
UBSAN complains, here resolve this by not decrementing the index when
it is equal to 0.

Similar commit 85e3990bea49 ("USB: EHCI: avoid undefined pointer
arithmetic and placate UBSAN")

The changes in this version:
- fix some compile error

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/host/r8a66597-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 9f4bf8c5f8a5..6c597c668364 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2141,10 +2141,12 @@ static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 {
 	struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
 	int ret;
-	int port = (wIndex & 0x00FF) - 1;
-	struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
 	unsigned long flags;
+	struct r8a66597_root_hub *rh;
+	u32 port = wIndex & 0xFF;
 
+	port -= (port > 0);
+	rh = &r8a66597->root_hub[port];
 	ret = 0;
 
 	spin_lock_irqsave(&r8a66597->lock, flags);
-- 
2.30.2

