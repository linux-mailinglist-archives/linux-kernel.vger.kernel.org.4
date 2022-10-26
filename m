Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0C60E8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiJZTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiJZTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:09:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECB13226B;
        Wed, 26 Oct 2022 12:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr8dk5m87NMUFTKHqMAx4SnnPedTSCBpA/tv6bpUIB2mwb84TZTc1YjedfQdU61kipGJahSELKoobfgYUpSB/UGcqwge1Hunv/Uk8s9lnbyv7K/jgr80LzVqLr87ghtCB8eQ5tQHXbp9VzvEVV4TDvr0riwxBAfRV1PgN0F+1nRBkSCxSgsv4ir6G71fzCJgVZM7nnfRP4Jx0XiaXQ+p8g2+cxdHxQFKCF+JX1uoEeSqS1dRtdpdkpghO7qT/VkKf2VMWbH+GKRuyP5n7Xa6MbpGFsOmrtxSjVEnjEigFHGXONp1OhCM0O2iUMMIpTrae/kHQty2cq7utzl7Q65+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PnyM+bNN2HZDUhcTiA4+/bUNHeU/hPn9nUbU41n8hM=;
 b=k3L/Uh1HGE3wCUZ9WXVUw5jsJ3iSVseB7s2RivKI+EQpzKw/jODf30RcEl1JN9Dpl4gDVCWN218JvFyNWfisg3Ml0QsUFb5gjIZbDbRKv5Rpo0ogDqAHKzE3ejl7ToUywlNl9J00Mmjv3elYvy1kSlxEv2qsPdkprepfhFD1gitb5f2JSULzoOvdwtNqURU1+JWM7rMdP+v+BT1TK5eP50BiRc/so406aHZR62QBMvkghjhJEHIRCdRuizYxeqVY0nhbf9xYqCdneth+PvDdNQVI7vXKT4KZmUiXucIe3lbgmzfyWMzfNqz26QJ5X1zR0qCA+fn0xIsAXrgkiG31yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PnyM+bNN2HZDUhcTiA4+/bUNHeU/hPn9nUbU41n8hM=;
 b=cQo4KWq0aBe8L2IwcbOSkF4vQYoK8PpU9qXQZkMF1I4GwXSDEND8AUz/tX99jiFt5rK72vTn/yFwLSJOvaNANlTk4bmduyyilncDgtmcwyKSw/g9XnumylRairE5PsemBhSAyC7YXSXaNBAw2LMGBqdOf+4C+7SD8qM6jZJ5FTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 19:08:08 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.023; Wed, 26 Oct
 2022 19:08:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     jun.li@nxp.com, frank.li@nxp.com
Cc:     a-govindraju@ti.com, gregkh@linuxfoundation.org,
        hzpeterchen@gmail.com, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pawell@cadence.com, peter.chen@kernel.org, rogerq@kernel.org,
        stable@kernel.org
Subject: [PATCH v2 1/1] usb: cdns3: host: fix endless superspeed hub port reset
Date:   Wed, 26 Oct 2022 15:07:49 -0400
Message-Id: <20221026190749.2280367-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 06321447-2993-496f-2d09-08dab7856b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4YJoFjb0rTKXYnUusus5rQgh8YrbtyU10BKHWirXmx/X8pXiJrfKA54tLd90TcrAbvKci0Dazj1gkr5fkBVWRfX4FhIXK8fqgjC5g+EaoVQkg/0OE2+bkW1ubtKMLzIWK66sZTG/rFbDxyAzzt72EIYIz8EndPfecLEnLyikG+yGAc8U/XfgBfMM6xtaIV5PkEPPA+UL4Ea90L3c0m4+S2fUygEApPUb6SaVQ8xCQZgoPdwHXDkK6BzdjdbfIT+VBfZr6NXk/XmN3XvqJx7xZ2lKWYpdvYE5joAp3akEzFdD5l4Z/TOzcI7oeaCyBLRMhEkUJMabNRsKsFuB0Nugi87QgUMC6yDGHi58FXd2wk1ktWnw/ulNJD0XzwrbNCo7D0iTZmvScABHkoBIncyEb2bbLdDAjlFnGPUohcBfELUe1We2/xvPY8u9osshdb6xMBMhhn7RTSSs5cdXs7I1olkMAl24C1gjefkynqLNyavlhevvyKhTSZj0a6WM77YCEC0t2lTPbs0FwuubmrzP2rpJ9qNJB/lF1/qrd4EiRw3cCXInqEw8vbN9avSTQb7u87YhsKXTegW3Zh7MXUGFaJs8UP/KxpeH0COvSheNwi9coltV9odjwP78fEa/SK1RZzbTGyhCSJk4aHwaNtuWmHueh4FaUwLxYA8YPMMbWlmgBoR3KgvDE/HHbfCOpbpFZSg1DRAKGzcUs4mpAcdLykGX14nIrOyOnqGrfBdQ2IV284hFIB+cFn4kuidFY2+RdqEMQHeJEOExlZlcIrkRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(7416002)(83380400001)(86362001)(2616005)(8676002)(66946007)(66476007)(66556008)(36756003)(4326008)(6506007)(38350700002)(38100700002)(8936002)(1076003)(41300700001)(186003)(5660300002)(6486002)(478600001)(6512007)(26005)(316002)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWH82Tr573hqa1kIqyEmOd/2g0EgK8584Pwk3Jb7qC0dXzDejPloEYwcH08u?=
 =?us-ascii?Q?KX7oYoTJe2sKFHUu2eAupVON0XmTsc/0WXnlyr+7wDBH/1L/dpZccek60P+v?=
 =?us-ascii?Q?13ZcWF5NubMV02HjKP+/l/9iPubreW8U5ycy6kTFOvosTTOaZyMjvy7Gav0O?=
 =?us-ascii?Q?KKhLC+zYEaWIlVJFlYXbtoqLoRyYNM1iFKEIW/GnEderKykwXIlFRWaT3A+q?=
 =?us-ascii?Q?IVv8oAPwEmLIIQa1czMrvaGVnvCN8svNebIrKMDiTdLU/3ByZ/W+lgUd8K6d?=
 =?us-ascii?Q?LPioQF/UjNSfn4JNcrX7KOOEvNifo1RvMYDOznSh51edX1xgELouq5C5k2/o?=
 =?us-ascii?Q?jh/vCsdjU6AUqg9sAiBFJJHGFXG7FHsQE2UNoUwzmfEvWzrE7cNXJW3FXXjQ?=
 =?us-ascii?Q?f3JIcPi9TYvndYboguL76TofHXE/F7CsGGTpy50MRirtAwfENTUwK/BH6Q0a?=
 =?us-ascii?Q?JZvueTeO2eukJUM3iJT2rqw3eqznvprY4hYaKMuYfuo/bRk5XckJv6nNViu+?=
 =?us-ascii?Q?0u0I2GOebtgajDAj/eVuX6JvUT0b6rkjfMRldD+XFdHV+12YOranVKcvn2RX?=
 =?us-ascii?Q?96cLhHOS2DNewiq6emOk4deTglI4Jvx8bk+6lQk6ItRz9iRuRyN0R3QL9S87?=
 =?us-ascii?Q?NLrQh5VwKkZgyPqEQE9H0w+Wo/kAHQbPoXZj2q5AO/ZKzShjgd3uKTJRZgUi?=
 =?us-ascii?Q?smbQ4wHWarTuqpVfz7RyFjsIv7X9qzR84cbzX/BT6MocnoMndWvCCgln5Acn?=
 =?us-ascii?Q?HVFkv+7PX9COaXYJHRDnqAD7mBmHdl7pyjW6lYSEg70FY48d9sVncXDqzvVx?=
 =?us-ascii?Q?F9mwZAVDQIwFQ4CWpvmRImESrPQWwnO6s+tDucswDmZkOXBM0fpeBfSTQ7MM?=
 =?us-ascii?Q?KuoOzclH8oscH99GuBfKBnkPNr+Pkkbad2xBNh/QtcTh4F2/94r4di4peJLn?=
 =?us-ascii?Q?hYJi7XFuxqzSJqT1Pjq+4Ub2L8gL+AGUBbcao9puCturVDUHMM8zl9pWe4Jh?=
 =?us-ascii?Q?P0B+9Qessv1paut/miZdFIG+abZDUjzLjTXvrsEEdjGscJk0bqm550VCj9Iz?=
 =?us-ascii?Q?HleIZ7eB/4zV0kVF+uitheOTHHSmdSvdrs2OxFNJTKoOsRkpTQZNQ1+DqQWX?=
 =?us-ascii?Q?k8a5ClsSFzrjyet4peyFCTBEkARh/MIiE15yo7qP/8+xe1vFsJNYy5fLC1z6?=
 =?us-ascii?Q?nVJx56ixiG4HQ9UT+4rcxPX4qSBL6Mh1CTyePfrYLBTZyxs+DvpdVkAV1qSt?=
 =?us-ascii?Q?7uXA6CEhOHn8md6qg41pE91ia04pmCIF2ijvpGzwd0xTICs74lS6zq4UN2F+?=
 =?us-ascii?Q?YLvf+4gqY6gTbMDTIK0yoTwkej2RulVr45IgNzPFRfChr2o6UkzC3k2lkxuz?=
 =?us-ascii?Q?0pHkGsxYSJ99QygXAtC5QoXRzyXsY+WUPQuYEFT5KraKV8L9+q01I9rFR0Al?=
 =?us-ascii?Q?wRu1Y5hd67YfVghgRV6tSrjue8YEwE/QmrMNitvY7uC952AZQoQIl7M7JJk/?=
 =?us-ascii?Q?XRKsQ66yJUveA0yRxdfu98skPK5e8h5UJlv+ULuBBsG6KP1IhvACdcrZm2Y/?=
 =?us-ascii?Q?IAm+1eHN9VC/e02bc7qq9/OC5OSx/f12MwhkM4RQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06321447-2993-496f-2d09-08dab7856b11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:08:08.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ef8Ww19xJP4JP4R9s07ZaMzFjDQ7LGiZ5Jx8hs8XaEDdGy0DYYU4GGguZG0G+Vnfkl9a81DKZzGU8n+DooUSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

When usb 3.0 hub connect with one USB 2.0 device and NO USB 3.0 device,
some usb hub reports endless port reset message.

[  190.324169] usb 2-1: new SuperSpeed USB device number 88 using xhci-hcd
[  190.352834] hub 2-1:1.0: USB hub found
[  190.356995] hub 2-1:1.0: 4 ports detected
[  190.700056] usb 2-1: USB disconnect, device number 88
[  192.472139] usb 2-1: new SuperSpeed USB device number 89 using xhci-hcd
[  192.500820] hub 2-1:1.0: USB hub found
[  192.504977] hub 2-1:1.0: 4 ports detected
[  192.852066] usb 2-1: USB disconnect, device number 89

The reason is the runtime pm state of USB2.0 port is active and
USB 3.0 port is suspend, so parent device is active state.

 cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb2/power/runtime_status

 suspended

 cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb1/power/runtime_status

 active

 cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/power/runtime_status

 active

 cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/power/runtime_status

 active

So xhci_cdns3_suspend_quirk() have not called. U3 configure is not applied.

move U3 configure into host start. Reinit again in resume function in case
controller power lost during suspend.

Cc: stable@vger.kernel.org 5.10
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Change from V1 to V2. 
 - call xhci_cdns3_plat_start() in xhci_cdns3_resume_quirk
in case power lost during suspend

 drivers/usb/cdns3/host.c | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 9643b905e2d8..6164fc4c96a4 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -24,11 +24,37 @@
 #define CFG_RXDET_P3_EN		BIT(15)
 #define LPM_2_STB_SWITCH_EN	BIT(25)
 
-static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd);
+static void xhci_cdns3_plat_start(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	u32 value;
+
+	/* set usbcmd.EU3S */
+	value = readl(&xhci->op_regs->command);
+	value |= CMD_PM_INDEX;
+	writel(value, &xhci->op_regs->command);
+
+	if (hcd->regs) {
+		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
+		value |= CFG_RXDET_P3_EN;
+		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
+
+		value = readl(hcd->regs + XECP_PORT_CAP_REG);
+		value |= LPM_2_STB_SWITCH_EN;
+		writel(value, hcd->regs + XECP_PORT_CAP_REG);
+	}
+}
+
+static int xhci_cdns3_resume_quirk(struct usb_hcd *hcd)
+{
+	xhci_cdns3_plat_start(hcd);
+	return 0;
+}
 
 static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.quirks = XHCI_SKIP_PHY_INIT | XHCI_AVOID_BEI,
-	.suspend_quirk = xhci_cdns3_suspend_quirk,
+	.plat_start = xhci_cdns3_plat_start,
+	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
 static int __cdns_host_init(struct cdns *cdns)
@@ -90,32 +116,6 @@ static int __cdns_host_init(struct cdns *cdns)
 	return ret;
 }
 
-static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
-{
-	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-	u32 value;
-
-	if (pm_runtime_status_suspended(hcd->self.controller))
-		return 0;
-
-	/* set usbcmd.EU3S */
-	value = readl(&xhci->op_regs->command);
-	value |= CMD_PM_INDEX;
-	writel(value, &xhci->op_regs->command);
-
-	if (hcd->regs) {
-		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
-		value |= CFG_RXDET_P3_EN;
-		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
-
-		value = readl(hcd->regs + XECP_PORT_CAP_REG);
-		value |= LPM_2_STB_SWITCH_EN;
-		writel(value, hcd->regs + XECP_PORT_CAP_REG);
-	}
-
-	return 0;
-}
-
 static void cdns_host_exit(struct cdns *cdns)
 {
 	kfree(cdns->xhci_plat_data);
-- 
2.34.1

