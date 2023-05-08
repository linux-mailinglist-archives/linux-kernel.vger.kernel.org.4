Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663BF6FAF98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjEHMDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEHMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:02:51 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802424A97
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMuQS2XrKxTo20F+JeJBicmz1isrXx7+nzE9fVI7GFfm15ifL4TwEpdGiwCKqUh6wk5dsIyKwsWW5Py1eIL16XxWdMLX8A7rCAba0yreF9SNcknm/D1wncW/WvVf0VTlg2GEOeA5czKGOl6fkRIM5ukJ1qWOweJP4q+fvsrtaIpzawRUIF7wLkz5lypECi3ScgBcxMZZ9DUK6e+sMkvAPrZzXm2MFEbuYHGMhP/sV5n1vXeu+weTZDAApxfjdQ+/NRjjtUQEallV2snnohzmYQggvrXhXNd2O0YClsUMQJeT5zPq6P55KxUqq9euEj73AX3J/KTg+Xb/hT7hb51yKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3/6E8Kq0C4NM0xHdyw4KH2K0l0dBvUvOm74BoPD2mc=;
 b=DOMc69pC0hdiBnYehMncGDTBAlFS2qzaVr5170I+EGgblAm0/Fp3P7JEv791wgoYVNVcS8oBXd/kZHIlKdtcH079pWBak5VxRYqQnUMqBbz8qqotyd7JvxMqzFMLX2plnYsSw8y6amd5Vw1vOiqvYr7No+joz8CsxWmpf9aLAktoTkqxtkYF3KrRJj8FAaSE0OIQCuLVPqVFKF+/RJ0muCtVjzZmIg7r6E8d8QJN6HI4rQbIGJ/J0RwzWGgAmeDZxtcBJnt+iVSAKbWIuEtmaR2l2NqYiSTsBmmoi9iIWEsgGm3JDr1ImVC6+6nbRD6jH4tJFOvL8arjlBcqJNg+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3/6E8Kq0C4NM0xHdyw4KH2K0l0dBvUvOm74BoPD2mc=;
 b=Y38hMvUeJWyOT5eHrx/kWP+1y5/QDhJ5EZ+oabyB/l8Ob8QxMfd2KFFOfQHgEEC4sfWn7ctg8v5llgC5pIEJyt4SyBOQb0oTMxJVym6JVvbuZ4s1U+vAdFlY5Q9taBP/EuTZ4IZ4ar9X0CS1q2aOxKQXyYzJ3gZMOGIf5rEshBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8986.eurprd04.prod.outlook.com (2603:10a6:20b:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:00:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 12:00:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: support i.MX93 soc device
Date:   Mon,  8 May 2023 20:05:14 +0800
Message-Id: <20230508120514.1534445-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c489ed-79e1-4301-3b8d-08db4fbbca59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDLxSWlp/cGw/vhU6rDPhBhVDZKsSNY1YnNgHW4aV0nvFs5dQi3Y+mumGxSLdT/+O+PlbukHkZxM24qe85GPkWG84EUBE7h0/hTVTFGM7622xc5mlbu8SJDQi6cM+PQ6weLWhv7k4ZfidLkdFur0W101T1PRDkz/Lkwqmz14/5NIDMBn+qilqbZmG1wcCT1wPL1e/BjmPg/cCp5bKh8mKUL+8kjDnCidSD3JroGY2ZxRD1qpZKt8WfQFRvQPR7vVDYrBorih2VMT9ViL5tWBHpQ/bikRqXkzy5FgMHJkBCM3fjkoMzVADzPvMPEuDcbnwRjgjdCxGgZ3aNpMokcoz2AD9Kmlpb5qBKPufOO46k9PfnYO+V6j6RwdZYgMrJ3Ek53gd9T5mX1GG0plw3OWuVSixzWI0WFJvDgTKa8AOEtAYmNBd50WKxet2saluBtb9PRDz5AUTxiGj7kc+45l+A2XFBMNuOiXDTV5Mq3l2JOUlah9L7ugQhwasZFMYeLU9h0fEeumipVI1ANtoV2c5LHfBFMiVUUb+iQua1owLabl3IQdz/78Kp8SaE43aRTdoscOaKFe1j1BLUuQkiqaYwrgYHD1Vu9dT46pMCk3HUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(6506007)(1076003)(6512007)(26005)(52116002)(6486002)(966005)(83380400001)(2616005)(38100700002)(38350700002)(86362001)(186003)(5660300002)(4326008)(66476007)(66946007)(2906002)(478600001)(8676002)(8936002)(66556008)(41300700001)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FWJeEdrOaro0yTsQLWy+q5bDUxgojmz6QrN5eAbC+axMtgOlbrOWxbUPDL2y?=
 =?us-ascii?Q?t2GwdxvEFD/YQFXo/od3QfVdNxA8e5cp+q2qHKQhDek/CiPqfaMohR1/sKQE?=
 =?us-ascii?Q?U5i2LIgGoNASvEy+jqueNs6htcno6WxrmAhIJ6jDPUQxNE9cD/Ruo2Wwzex8?=
 =?us-ascii?Q?jCjMXZN2ayeOCa24ap8KFM3ngrclZdBAwdwoc2/27p2utwk4lggHPYl2y3rg?=
 =?us-ascii?Q?pMqLqdEuB5fvaJPwV7NesbyrG+zZFcC/HQG6RhsPJ6pZUdZMUJ2xxXJaRdlJ?=
 =?us-ascii?Q?hqKfnga2cs1gDR0fsCgwRV89hfxsWyt5o/Vm2U+7ldrLxF7sor+5QakdEc5K?=
 =?us-ascii?Q?x8e5oLC4Wk2MW3cBHKUzmMK14yk4msglwa6CA++4sAxIU9u/9OojdeAB8fYA?=
 =?us-ascii?Q?fjjrTuq9D7hRNhrH9ezCJ/4BjCVCQONtxTxG+/HxSp7Yb3z9/NNxDUISGrRw?=
 =?us-ascii?Q?cVbQvqnsaWUXAQvKc322kc6yAEBW+pbsQYAjPymybOTEYfrsJxQzevaHrazV?=
 =?us-ascii?Q?vjeEhvKANigQ1I/iTPnv/dMNjvIO1Z4UEDw7SZ+Pf4TSQy3w7p3X+6XaDlE2?=
 =?us-ascii?Q?U32ESbjjs9fL5gAiXkJWzGUZoI4LlkEqb/XrpdehT+/CL/edso3bcAUerA8d?=
 =?us-ascii?Q?PbluFJrmNNMvMXqmiTVT1A3g6Bsm3nus8LotwQuGOK//6q2cAPbJ9gpSa7tQ?=
 =?us-ascii?Q?oi8Po87reNhH+2xAuSd6XUCw/n58rhKFBwbOwFg1FKsbfhWdhNewinhILmG8?=
 =?us-ascii?Q?s2JllLovadwgC1JnUM70PzSs9X1CTJ98j2LDP5fdiexEaqxMpdScd9zoDfH2?=
 =?us-ascii?Q?9wO7SXHaBaGnVX+/1/2FJpBZleTcPpKn9QslH77mxELukBU6kTFpWLdfWJEG?=
 =?us-ascii?Q?NTBf39oZnaI2Jqgl3O1VYCsebY7IeQx7KRd8D7bPvOUyyKTNYVGHNHCvQNgz?=
 =?us-ascii?Q?3zCLfiTmpYg/NBCcyrlx18oaFOa9SiaG9HIEThLlZ8VTiOfDibFsEMd3D9oi?=
 =?us-ascii?Q?xPHb3Q5WvpY+WOj3lpRtEOa8JlpTkfQh1JckSes5p3K3YnnO2BGK+SyCEa0Y?=
 =?us-ascii?Q?JLeQDvs/LZvwBXm+0nhfXsR+gpR/xbXN//UvTBCR3pobrLj56DjJzR7YP/0z?=
 =?us-ascii?Q?FPNuZPeBIbo3TgSZw3SmPQGo5AInF3mPro9d5ttST2a/xCnAp0IwQFlf4noC?=
 =?us-ascii?Q?QKPkMFifpWrPTbHiYzgFJ2IXvfnuH2m326oSc8DIb06Zk3E4V4TKgfDNqotR?=
 =?us-ascii?Q?s5D+rsdW2//8UMI6J0Nl5hMgvauPXClOCsBKReFRh9HUMfebqtaOoN8GySpR?=
 =?us-ascii?Q?TrAvhtwvQbaSvkHaI+yRBEeMBvZuZ0L2SmJytv/Ldsiqcxabbk0WpkVdN9AN?=
 =?us-ascii?Q?LUBPkbQmFuJdleyJVu1U2mNs+nDpzWkCcW3NkOBdYZMwfwnz0Wth3+orKWdX?=
 =?us-ascii?Q?zSrGatVKSqA5bk0hNMTxOCR+PZeY3CLYv9hnqaRyKtaxYsn0f+yssdKnU3ni?=
 =?us-ascii?Q?dNSyOfWqSpiTP6TCF63FpObdJO1BVz5wHSYE6Sy1R885nmm9CGU1iAJlkp0A?=
 =?us-ascii?Q?LR0iqB+Rh6EVd/jIXb5jHjUkLruZCVfdhu7vjCmg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c489ed-79e1-4301-3b8d-08db4fbbca59
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:00:17.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tifuBRzUBxH4OEI8vr92GSuHEzxFZkaJ7mmt5mRwzll19lhCfbtNjxm7H4gxq7eZ7OFgT0Z0dZG3fFCgTxQPVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8M, add i.MX93 soc device support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Depends on the binding doc, then this driver could use the compatible
 https://lore.kernel.org/all/20230508114639.1525521-1-peng.fan@oss.nxp.com/

 drivers/soc/imx/Makefile    |  2 +-
 drivers/soc/imx/soc-imx8m.c | 70 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..83aff181ae51 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += soc-imx8m.o imx93-src.o imx93-pd.o
 obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 1dcd243df567..7359c870e7f8 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -25,15 +25,20 @@
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
 
+#define IMX93_OCOTP_UID_OFFSET		0x80c0
+
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
+#define ANADIG_DIGPROG_IMX93	0x800
 
 struct imx8_soc_data {
 	char *name;
 	u32 (*soc_revision)(void);
+	int uid_length;
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -141,24 +146,81 @@ static u32 __init imx8mm_soc_revision(void)
 	return rev;
 }
 
+static void __init imx93_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	soc_uid = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x8);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0xC);
+
+	soc_uid_h = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x0);
+	soc_uid_h <<= 32;
+	soc_uid_h |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x4);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
+static u32 __init imx93_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *anatop_base;
+	u32 rev;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	if (!np)
+		return 0;
+
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+
+	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
+
+	iounmap(anatop_base);
+	of_node_put(np);
+
+	imx93_soc_uid();
+
+	return rev;
+}
+
 static const struct imx8_soc_data imx8mq_soc_data = {
 	.name = "i.MX8MQ",
 	.soc_revision = imx8mq_soc_revision,
+	.uid_length = SZ_8,
 };
 
 static const struct imx8_soc_data imx8mm_soc_data = {
 	.name = "i.MX8MM",
 	.soc_revision = imx8mm_soc_revision,
+	.uid_length = SZ_8,
 };
 
 static const struct imx8_soc_data imx8mn_soc_data = {
 	.name = "i.MX8MN",
 	.soc_revision = imx8mm_soc_revision,
+	.uid_length = SZ_8,
 };
 
 static const struct imx8_soc_data imx8mp_soc_data = {
 	.name = "i.MX8MP",
 	.soc_revision = imx8mm_soc_revision,
+	.uid_length = SZ_8,
+};
+
+static const struct imx8_soc_data imx93_soc_data = {
+	.name = "i.MX93",
+	.soc_revision = imx93_soc_revision,
+	.uid_length = SZ_16,
 };
 
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
@@ -166,6 +228,7 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
 	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
+	{ .compatible = "fsl,imx93", .data = &imx93_soc_data, },
 	{ }
 };
 
@@ -212,7 +275,12 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (soc_uid_h) {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	} else {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	}
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

