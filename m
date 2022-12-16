Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C564ECC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiLPOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:17:56 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5813554F7;
        Fri, 16 Dec 2022 06:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jad59vSgw8RdWufMPCukvTQBBVcyB3wL7C4tGLE0Vzdbi2xtRaHNc9xcZr2qRd3m0QsBx/CDJuYL70l7W58zQljiJcTNfCXq1NSlCK+27uPBOtB6nebsfr5M4oHO+5hmZlr/9Egq1cyFOWFEoeHm37rJCZSgXzwjloH/IgAsG+2qsmXANGNc3BM5ORexrifYsSYUe6arSO2nisXrWAdpBaK63kekMhVKJaGwJo9badI4a7si+wyvp301e7ma8FxJhUxHlhhqS2NUVIgKH/MvBL1DhFPk282+ZxVnrf8M41Le3AWueJKrsfv1WovsTQl8rQupbPagH89RPvXGPBrA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WU9wTRpXPdlHgmqrv65FsIBvWY3Z/hmv473ItmiG6o=;
 b=lu7RPHZFTkBAywGzDxUk0VKZFs9qTiGpAFqMJDDE5PSi8vQqxnJCqpAGL5OU8V992Tg4wscXzb2NFEGM6IaWoQscaLgG+d917pM9l2rtUFy3MZRDYa8Mb1HDZuyhK71EUTGPW9P4zMEdj+1Z6GDzuJCQBHX49JgZ8t6C/nHJ5F+LEf5zySf1rIRrNZ/t0h4e5kq1ya31SIjLgmjudWpHTrkPZb/wMJHuB9UNO11n6sgPFn+QlVIx4dm1RGIkZ10kNF7xARZKJFSQBr2KclooMEFVASQLg/ewhzZWDyXhn72WNubbOCfh7qY93MVzua8QNPwbNeLG7PND1ljOrLVyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WU9wTRpXPdlHgmqrv65FsIBvWY3Z/hmv473ItmiG6o=;
 b=a9JGxOS38HHV8p9Hx9Nvi+Hyv7Wn1jk4rue73rruQLzZMV4K8YqcfWyzozhFsVIaH38aAAQKVJY9hladwuc/TpE2Rkk/pmRUuY5/QwmHHhCeo/ZPkASwdRUZSmMRF7VRjGjmZmHeYFucSdPYyzy8KstdMg376+Y2sf5qMZjVOew=
Received: from AM5PR0201CA0007.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::17) by PA4PR01MB7262.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:fb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 14:17:48 +0000
Received: from VE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::df) by AM5PR0201CA0007.outlook.office365.com
 (2603:10a6:203:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Fri, 16 Dec 2022 14:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 VE1EUR01FT027.mail.protection.outlook.com (10.152.2.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 14:17:47 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Fri, 16 Dec 2022 15:17:46 +0100
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
Subject: [PATCH v1] usb: core: hub: disable autosuspend for TI TUSB8041
Date:   Fri, 16 Dec 2022 15:17:17 +0100
Message-Id: <20221216141717.2728340-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Dec 2022 14:17:46.0812 (UTC) FILETIME=[2BC347C0:01D91159]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT027:EE_|PA4PR01MB7262:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4102f323-9f70-4251-1ee9-08dadf704ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHXiV7Gz4MCmQPz7oLLA7HnlRl99acZRVnur7tYYbiIfSmfNcDkVISR28ZQeK6eeNT6i8EofE2iKcLTTAbVJ1I+ZN0+8fOUG6/nYlZ+xXwY4TbY7ug050lT4XczI1ilCBVlKDiy2IIKtpvJdcrPFrWDXWGKCfvBixUFAuAAvWfyChDvIEJ+B3/fDZkwyQvaFNOjiJ8kayVwYsVilK2OlG3Ngi3XOP7HdkNpv2XoYVShDYa/9Ileu4snZoF0Kld5u7aIbzmuqSYvpHUfMKn7r47vcN2LRjrQbj9sO+I6tq0YiKa0b6uoyjvkNUPUzT36U73g6jymw52CFIL4zXdC7ABjNoMWjTQFus2vMWR7+tTyaAQlp1l4b+X3ZJmrlDILEB1xmWezM/xb6qF3ntnP4Q2I3+NuXKqWXN1jAW0v+u9Q/2JHB4seQm6NBQEFCJgTRCgeL/2UHbo7kPo+VuTl/PWLFlxYMXv5yQBI95Jzq/t5Fgfdi4BgoIYsAN1OyUp1q7kEui5LUMpEXBrsIvgnlSGnNchHnnuj31Pe0iRBtHgqIrDtEEv2W75LmZlue0mAGwx2MzmuehZswmY3GpOOuJAD6i9cNfzLg3SVmSRlqUJLBxP5sUvlL1Fgn00qIXqAuwBoriIkQ94TkYLyX+NXgpZAxCemj/bIK9IstDSXY9HufdNsk2bHMV5lD9hy/sc66bsxFK//Xk2Tj/vpfIa/MtQ==
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(39850400004)(396003)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(1076003)(2616005)(47076005)(336012)(478600001)(316002)(186003)(110136005)(26005)(36756003)(2906002)(107886003)(86362001)(40480700001)(82740400003)(6666004)(36860700001)(41300700001)(82310400005)(5660300002)(70586007)(83380400001)(70206006)(8676002)(450100002)(356005)(4326008)(8936002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 14:17:47.4159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4102f323-9f70-4251-1ee9-08dadf704ea7
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7262
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
 drivers/usb/core/hub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 77e73fc8d673..b64be35e203f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -44,6 +44,10 @@
 #define USB_PRODUCT_USB5534B			0x5534
 #define USB_VENDOR_CYPRESS			0x04b4
 #define USB_PRODUCT_CY7C65632			0x6570
+#define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
+#define USB_PRODUCT_TUSB8041_USB3		0x8140
+#define USB_PRODUCT_TUSB8041_USB2		\
+	(USB_PRODUCT_TUSB8041_USB3 | ((USB_PRODUCT_TUSB8041_USB3 & 0x00FF) ^ 0x02))
 #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
 #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
 
@@ -5854,6 +5858,16 @@ static const struct usb_device_id hub_id_table[] = {
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

