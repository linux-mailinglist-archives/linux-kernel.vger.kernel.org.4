Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62567DC59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjA0Crq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjA0Cro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:47:44 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891C2CFC3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:47:41 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A86FB2C05E7;
        Fri, 27 Jan 2023 15:47:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1674787656;
        bh=QyC5brkWOEg2sGCBNL5g61P1BXRxZYyIv/BCYwztIz0=;
        h=From:To:Cc:Subject:Date:From;
        b=gc7pHncOBDsVCo+PXjsGrakOPehtcFNHQ0c3+/KXuqQ2XmN12KwYDsx6iyZbvFQXP
         riAgekRRLCj4lEj8Km6hU3kegONuUO6yL1BNYpYfkQN3JaTis1Z9VA923oU2qy9QOA
         mAQ5KQ9XsMjLLCRyYIN8fWA6zg67e+xEDSk6HDy70f8cKaYi/PRrS5fPaK6vxZok+Q
         ueY0xApMIINPh6WAPemP4JWFflZj2+xRdUwv+Aqy37H47vuwzynX7pUo2eEM8yxNqa
         fghE22ydgMfAugP+U0nUnxP32MNh/Q0rdMdJkT2Y9bCaz8F0/rmtFjufTuIP1JY5Ds
         oVk9YdO9431wA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63d33b480000>; Fri, 27 Jan 2023 15:47:36 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by pat.atlnz.lc (Postfix) with ESMTP id 81B1D13ED8D;
        Fri, 27 Jan 2023 15:47:36 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 7DDB433F3EE; Fri, 27 Jan 2023 15:47:36 +1300 (NZDT)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] USB: MAX3421: Handle USB NAK correctly
Date:   Fri, 27 Jan 2023 15:47:34 +1300
Message-Id: <20230127024734.8777-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=a6lOCnaF c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=RvmDmJFTN0MA:10 a=dCw1JWjCaN3HBHM-yk0A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A USB peripheral can respond with a NAK if it is not yet ready to
send/receive data. In this case, the transaction should be retried. The
MAX3421 driver did do this, and switched to a different type of retry
after a number of 'fast' retries. On at least some USB flash devices,
this second type of retry never succeeds. This patch changes the
behaviour so that 'fast' retries continue.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/usb/host/max3421-hcd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hc=
d.c
index 352e3ac2b377..9a87056fc738 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -72,12 +72,6 @@
 #define USB_MAX_FRAME_NUMBER	0x7ff
 #define USB_MAX_RETRIES		3 /* # of retries before error is reported */
=20
-/*
- * Max. # of times we're willing to retransmit a request immediately in
- * resposne to a NAK.  Afterwards, we fall back on trying once a frame.
- */
-#define NAK_MAX_FAST_RETRANSMITS	2
-
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
=20
 /* Port-change mask: */
@@ -924,11 +918,8 @@ max3421_handle_error(struct usb_hcd *hcd, u8 hrsl)
 		 * Device wasn't ready for data or has no data
 		 * available: retry the packet again.
 		 */
-		if (max3421_ep->naks++ < NAK_MAX_FAST_RETRANSMITS) {
-			max3421_next_transfer(hcd, 1);
-			switch_sndfifo =3D 0;
-		} else
-			max3421_slow_retransmit(hcd);
+		max3421_next_transfer(hcd, 1);
+		switch_sndfifo =3D 0;
 		break;
 	}
 	if (switch_sndfifo)
--=20
2.39.1

