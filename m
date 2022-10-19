Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0A604B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiJSPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiJSPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:30:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057B17A948;
        Wed, 19 Oct 2022 08:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWxcLLeG8TX6fL94/7waQCHYgznVb5o1/3EJZb47i1W+FdbP9GZIAicunywKBy7myrhEiTE+OyDtBTzR9lakQQEvWWmWQ/Vjr5rCtGUu8qBuVuLmyGdvKgZVsC/bnx0peaq/XLRdAHmOOfkX9fmNIadA0Mi6weeFXChJzQVCKAVlYEZbVoLBJ+tPqOWp9rBLM8HIFFNiaBGaR8EAH8V5RjgO+PqylyZNZmIgQUwdt4m05Hw4QZ8ThzWHPU7bbI0Wuan3Dn2PjA1AM/uI8E9kqPWZkXTfJO1vdhoYe+v5ZRmpgcQjLmRMIbmJmXSD60Wu1Xl7aLS4KWhmssCuFW414g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqwmPvmjfx9TZs1DDXcuMqUijArWZB61F6oy3F+HNOI=;
 b=gskSC37nTH1N4tTEKmqJk0JhwFx1eKYqPqoCA3RmI2esUmIJELa3EpCBf7iKn30duQhRg90/GKhJVesX3xX77ucqg7Qnx8+LYyozU1Kiohq9uOZ05eRCZVemMPwQZ8176IYf/8N2L8J/cWJIV1JwDzGKXJufzSQUgswlMbAb3Jp5Bdx58p+ikqHxHYt8/r+GjwLlaO1SauQG1WKZq0JGp+XWLoDH4UjPMU44DNwGLA0CRBskgjdSrhLna1sDwofDbRS9NIacBlwBbejUiqlwQ74SJZvtvs0NjCR2jtSUMGDj7KIzBiU9HpAXo88UgCdd4seA5NrB3hPfI2rzywahMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqwmPvmjfx9TZs1DDXcuMqUijArWZB61F6oy3F+HNOI=;
 b=EYBAq4nMN0VnBTAlIQ6hzuwt/eU7EykK5jStTxPxcLtdK02nsZk2PLps06WNafjT1EqtYSp2E2UN994PneOXPUjcpKNBAcPVYyPx5YDwZA8Zlpja7f4By2Z5K9cA4wtmxOez3z3iYeg/vvNxYWtzEYsO6WGjozzivQtpNcb6lMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB7911.eurprd04.prod.outlook.com (2603:10a6:20b:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 15:21:40 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 15:21:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USBSSP DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     stable@kernel.org
Subject: [PATCH 1/1] usb: cdns3: host: fix endless superspeed hub port reset
Date:   Wed, 19 Oct 2022 11:21:17 -0400
Message-Id: <20221019152117.1234968-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cfe50a-0f81-40f7-8f3e-08dab1e59f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGpgjzb0+paAocGrPEwiEBHm73ov81KWJB7kGQAWaxRPt+hjZ0iGhWHEWG8HNFQnMtBqhmla3QyygX1y9IZ9CoS+LYSjTASncUZ++F1+3q24WZ/rKzO6UF5n/YEXNaXdfBnonxbO9D7Oz3JJXeqdt4wtco6RegHu4QsMfCVwiWopnffeHvQBsdAlsdifQpHQYrDpc3gvcnqbwuN61TJm6FziXvvKIGsl72p2bflvEgdI78IFC9RLHv9QG7oYWWntd8zgCoeWjIFDV2Ygsy2XBuhme14r3VtWuvDd8O3Id+qH0jH/CXvggNqhhe49zaAU1fNMljQPyXU0WwqM7OIdC2jlfOjGeusPvX1N2dtBLX9n33ug2QDa6p8mvoITlBviqPe+tsmTepeNFJAPh1k0geSfbNTCgl/nLqJVjKKpQsjyl2dsY3xS2ZenjVMlazsFKNjcRwvfBz8ffzaic0D0WQ/ExxluwCs5eaMbrhII/2OkeCo4a8sOzsangUiAXnV3vHoLP4V69OWNOASEhuJaexi5FzCSd3jcNt+oJAWe3WwyLQB1H+YGMYkZ14T0Fch31gpCb7aJbtlAqatlb490KWgI2qOkmTXZbijzg/Ab6pB0yQUDvQEJuyV8Ssfrh1T6Fwx6XB3BF0SnO9Z1O0whDJPhr5uoOINh1uxo9JhtOjup3XDPMZsftOiJkzkrtFLk7RhypvmVOUuDbePA3WjsCR9DVW2aBbhhHl6WT73RdBdYztwin3tF37L2tf8CwRgSRCG6Xji0FPe1ozLxsfFYyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(1076003)(186003)(6666004)(2616005)(26005)(52116002)(6506007)(2906002)(5660300002)(6512007)(316002)(110136005)(83380400001)(478600001)(6486002)(41300700001)(8936002)(4326008)(66946007)(8676002)(66476007)(66556008)(86362001)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqvCZUJW0JLfblxvJv8Gv9ZccTyMzAuWill7xu9nZtEguyuYCtGHy+iZ1QwB?=
 =?us-ascii?Q?7Oh/WavY94NpQqJQK8fcaab8y/jOYwWKT4IIbdCIEeV34znS3YGYTEnuZ787?=
 =?us-ascii?Q?4PxSH8hD0Vysr4KobpLunmByNOlEO2+bGr9MoJnXSH/c8nY4ZoxFYq9WBsjn?=
 =?us-ascii?Q?RnpyVXYu0AG8GI+YkrEfR7Aog99zltOyCzpq3Z/dVC1honcAhQfcf2CXmWhX?=
 =?us-ascii?Q?7vHw2VKVbZoeVzNA0cp985PD94+mMJhJwp9zMhZb/6x9XmIAg2YOcn6C1tIq?=
 =?us-ascii?Q?USoXP6uJ8k+0siuSO780bgo2NL16e1UVqx7zmR/wu+mDmW67Unp1asJxK7rw?=
 =?us-ascii?Q?DcFdV17S6fJ/g0KV6dePUq017575Ds3TD+1q0IYyME9yxb5AQp6GlcI8peWF?=
 =?us-ascii?Q?OXyfsuvRhBqpC3UGDSAeRQ7SYjo+ec0S36XdAjj2lBRMoyMLg/3WQLr1b5Zj?=
 =?us-ascii?Q?rJVK84tkCV3h/N+Bnk9JYLNFBESAfUIQSDf9UQxBZpg1h9a+7fEBNWwDSwm1?=
 =?us-ascii?Q?AKBEgklMXKjb3RGspPLDU2C1pTKQwSfJfMtt1e80r4Kw/PMQH+9SD2xFjZGo?=
 =?us-ascii?Q?l+m1w2NilGGh+iC8roHYIQ21R7Cl+oFImav9nBruteWDoGO4vIQ46QwX3OBz?=
 =?us-ascii?Q?UPLiUO2ZNdKYmSg2noIB3UVQYrXXl9SiTQnPnBK6kwYxiWg3e1Rf3bkf6Hkx?=
 =?us-ascii?Q?QdFNS9j9QytR0yGuLakC/dbuKg3a2336hW37ov5TRbczdXd+N9UwhYixgZtB?=
 =?us-ascii?Q?af7QA109abtDpDs4QE4jDujD0R5Yv0GeTcfVaENQvxhxGCns9jlhRe/jqQRo?=
 =?us-ascii?Q?5bJPqSMPZ70JubZQzyY/iRB2AkcD8dntpoj0+3Hv0mUmZI/uE5V6XyqiSvlK?=
 =?us-ascii?Q?BtoSc0Vdng99I+3VlmEhxepBwA7VoGo8lhFzYf+uyd1QvQzHvAIq8nogU70L?=
 =?us-ascii?Q?xSLQOI7RzmxAKne/dh//58L2RnwBk5770P/LfPpv+SpelqKLtgsyJdi7n5MH?=
 =?us-ascii?Q?J+Kizk/NNGlt1C9g5rTmtrxt40MruaqX2HB3LnLJxdCDNeoQj8geHIfjZAat?=
 =?us-ascii?Q?c6jkh11dREkddqDiP3BLwlRf3QJRTD532ccgivJRY4Zpg3WLt6diPGgZILWQ?=
 =?us-ascii?Q?g3VJcPI8GboZ4t3UuYh499MxDf53GKi6wzwac8+eRHfcFbAkNb6wa5y0dzBf?=
 =?us-ascii?Q?2HG0O66JdsZZKiO5R9qmhJSyO2LzKiHmaPZuNlfIxX8cpQ4nkkMLZUu2N4M2?=
 =?us-ascii?Q?nwInj24thHiQPNNs3FVDJ/1aq0mGk2XLM5yTVUBueMWML5sU1dSpiynNU5xv?=
 =?us-ascii?Q?hP2rZkKJVmyWXzAEItbubkt0iiNPv7tbWLKxewrclk311qakL9p/5UdRpPw1?=
 =?us-ascii?Q?S7I0NXUJEFJccSZ8aGbJMzbKaFl/rNvrJDDDFEC9np0kFmIW+6bK70yet/02?=
 =?us-ascii?Q?SY2IA9DDw2BVyf8r7rLX5l7x5UVLhchsAPIoCP9XTi5a1J1zmYE6bcJYmRXI?=
 =?us-ascii?Q?5zY6h8EZkqSc8tqDdThbCFBZfExo8pewMz/UShPQSdZbHHyDEunJGU+SVOD5?=
 =?us-ascii?Q?buaio6bG390r4EmOOQIjKPpmkCYjmP48Vh+M4Qf2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cfe50a-0f81-40f7-8f3e-08dab1e59f14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 15:21:40.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZNXwpjeyMTbS96ZkM4+qlkU/vCS/9GiCpWTL6iIOcYXCs2NKl4nb1x2eou2IRJzQ7hADPD1OvJ4hROBsgBX3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

move U3 configure into host start

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/host.c | 58 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 9643b905e2d8..9092b6f4d7c4 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -24,11 +24,41 @@
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
+static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
+{
+	if (pm_runtime_status_suspended(hcd->self.controller))
+		return 0;
+
+	xhci_cdns3_plat_start(hcd);
+
+	return 0;
+}
 
 static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.quirks = XHCI_SKIP_PHY_INIT | XHCI_AVOID_BEI,
 	.suspend_quirk = xhci_cdns3_suspend_quirk,
+	.plat_start = xhci_cdns3_plat_start,
 };
 
 static int __cdns_host_init(struct cdns *cdns)
@@ -90,32 +120,6 @@ static int __cdns_host_init(struct cdns *cdns)
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

