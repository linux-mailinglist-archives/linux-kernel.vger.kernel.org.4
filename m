Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7B650C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiLSMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiLSMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:48:10 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC1FCDA;
        Mon, 19 Dec 2022 04:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMgjiT9eBuCjkvYE+8MHRfxtfMpddB8jqpK4E22eQ3lRgwfkdvhqj13G5qoo6PF8oQZQnAa7DPuuR7IFK2PyBFmKFVx62vsE2ba/mVUP4NFjXYNhCILk3SynGIGeP4WrxqvCt4WSz8IICjj/LrZnawYRBBDJW4Lj2BidacUnPylxAl5kPDA++yh0ooJRMv3S0A1mN8wiObiivATaxsskt15FhjJyszsrNaAIYqhuNE55egMRzArzDbkKTJIGwsozpAf6AnYxLrKTynQXj3iWKadi14VeQpNux5ac809bpILjiom0Cj0WZkYJgsyYrdglhRsAQAkFd7voF7dNXY35tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSMUrz40tnYzCvFs+z9VOlAcbvGNC2nyOB5g4XhmXQE=;
 b=QNZmQf6klU6hBk++8vfMRGVwN9oORrE66IO0lBk4ztR5NSjCSVbr1CIvk/dO2RstcUglkMf43doay7kFBNIGjJI3ipWDyEaSgxx0Bu7EFUeV5b5Gc3f22B7JVNMmqH1Jd7ELXGKU8J8zzuM1eKUjBU2db8D2U6YidUwM1CcGNk9e5vsiN+RKGCrmKE2q3snEh+oncujSWRSorfJurxHb49uS0Z3jvAQV6dsOXOf+i7VlUk8l0x54wS6VWRiJcdSwdEt0NtzDOREoC7nNvESs2jDVSfQz3HHO9Ku3D+dlarzzKa6edFwaU9bMrxoYUbtZ4uCKB1Vx1v+YA5PBzeWDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSMUrz40tnYzCvFs+z9VOlAcbvGNC2nyOB5g4XhmXQE=;
 b=KJNVbUi3+E4gjeKUtmRcPkbTLQ3c3wQqSkHyVJyKowwZXpg+NrK9d5TU7aeZ/ruqPkvkvod5priJTs8cBj3leaEHiyi+/FKvC8FAIt8U1KKZO84y3NXlWpC1CeaVyRWPtM8GbRQi3tiFEYzhYara2ERX+ldY1iLzUv1NUiH1i5A=
Received: from GV3PEPF000000E1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:10) by GV1PR01MB8850.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 12:48:01 +0000
Received: from HE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::204) by GV3PEPF000000E1.outlook.office365.com
 (2603:1026:900:3::f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Mon, 19 Dec 2022 12:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 HE1EUR01FT023.mail.protection.outlook.com (10.152.0.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 12:48:01 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Mon, 19 Dec 2022 13:48:00 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ray Chi <raychi@google.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2] usb: core: hub: disable autosuspend for TI TUSB8041
Date:   Mon, 19 Dec 2022 13:47:59 +0100
Message-Id: <20221219124759.3207032-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Dec 2022 12:48:00.0527 (UTC) FILETIME=[2086A9F0:01D913A8]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT023:EE_|GV1PR01MB8850:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7347bfad-3d3d-4bb4-7dcf-08dae1bf4385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOP3WRBspNe3FRjkjHuXJ+hbT7Hrcw7khgF+hC5nJrSvMbUlQkvo6dO02TSLND+wZlvNka4PJUcEqu6IOh2Yq6jnHRoF3QBQnG2naR3j7GxuIqvWnjbqro/o7lAd+p+SJ9gtuB+z7B9n/sRD8WBzZ015/rmNhJLOCDHX81hyRPgrUEAZQY4rcHc5rsjznRn8Q7i7QBF4NcjnquvZbAfwVrlc65URz38W2gPuRof8LKzBNPJt4gB2xLZC7E1DYkZcZrIL24HilsNO4z0mgLsthqgJOKFXpVuKgV/QEtTPEcy/tOqqx7TWZGPBVARpqZVfMlGzzlznvzKRFWh8JFZdxC2N+r7ihulz3Uli2s1/HH6RW2vug8a9oBoyIJpBOpxIM8Nt0ItZVaQ5OX6Ah7ik+KRbMPmYAvikjATdUFUGFtMlT5Xx3hVFSDt2jlecWGIm3henWd2YOwoas4gT/iD/ME429pFh5ruyaYZGcFx1YGiG9v3Lm+58pCrCh7pGwu7kD0FQnE/15bwsgN8z+sRWFBRagVfvmmiTVLJpddQNPch1AuRWlw8B56+K5Z+BQ+FAmgiQu18R/pwlxpcnUH/Lar2KBn4LjGm9+FuOk8OSrPb1cYxpLVNJn9x82uX1wi8TXpQsrkRhDH4yUMKuTpxNDw933uopQ82J2Taksge/UbkGWwhqNGDFWxnepCRcuPQspriYEBLnSkYGfMmIhc5lCw==
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39840400004)(376002)(451199015)(36840700001)(46966006)(356005)(40480700001)(36756003)(86362001)(478600001)(316002)(110136005)(107886003)(2906002)(8936002)(5660300002)(4326008)(8676002)(450100002)(70586007)(70206006)(41300700001)(36860700001)(2616005)(82310400005)(1076003)(26005)(83380400001)(47076005)(186003)(81166007)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 12:48:01.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7347bfad-3d3d-4bb4-7dcf-08dae1bf4385
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR01MB8850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments TUSB8041 has an autosuspend problem at high
temperature.

If there is not USB traffic, after a couple of ms, the device enters in
autosuspend mode. In this condition the external clock stops working, to
save energy. When the USB activity turns on, ther hub exits the
autosuspend state, the clock starts running again and all works fine.

At ambient temperature all works correctly, but at high temperature,
when the USB activity turns on, the external clock doesn't restart and
the hub disappears from the USB bus.

Disabling the autosuspend mode for this hub solves the issue.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v2: set TUSB8041 vendor id directly as hexnumber, instead of a complex formula

 drivers/usb/core/hub.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 77e73fc8d673..9eca403af2a8 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -44,6 +44,9 @@
 #define USB_PRODUCT_USB5534B			0x5534
 #define USB_VENDOR_CYPRESS			0x04b4
 #define USB_PRODUCT_CY7C65632			0x6570
+#define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
+#define USB_PRODUCT_TUSB8041_USB3		0x8140
+#define USB_PRODUCT_TUSB8041_USB2		0x8142
 #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
 #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
 
@@ -5854,6 +5857,16 @@ static const struct usb_device_id hub_id_table[] = {
       .idVendor = USB_VENDOR_GENESYS_LOGIC,
       .bInterfaceClass = USB_CLASS_HUB,
       .driver_info = HUB_QUIRK_CHECK_PORT_AUTOSUSPEND},
+    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+      .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
+      .idProduct = USB_PRODUCT_TUSB8041_USB2,
+      .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
+    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+      .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
+      .idProduct = USB_PRODUCT_TUSB8041_USB3,
+      .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
     { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
       .bDeviceClass = USB_CLASS_HUB},
     { .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS,
-- 
2.25.1

