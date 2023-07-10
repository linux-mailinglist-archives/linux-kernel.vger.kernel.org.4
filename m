Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8C74CC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGJFe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:34:57 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B674A8;
        Sun,  9 Jul 2023 22:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWMI7MVYc1I0/0nB5CWF/mSrL5BLvhyMLdT3X605QKRFdpfNNfODcryGtU2Hb/E/71WeHfXEfSizwfJ8mSQXv2LwqyRV8qQnwEEOKR48Ti5e7iQn9rpZkB+gQhCSPjHnSTeJeDP+tYvrHxQI1d3t4HY8YPFtvPnT+h1mmKxyTuCAaFdb5sOUQhn6kPbwzS7keyUtwjf5IVd8Fx/eZGfRALadHlDCa2w4k78YoxLohMpCtfVoJOE9qPjUeWXJ8DpZKFhUXlAynVFbYxYnaXisKWP5vYCjvz8iJCQhI9qZnpPhe0U5nKEkcKehUXPBiWsh+wBzTSnma8tkCh+p8+z5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iEU6tyA4drtGGT4Z942kOgqWrJg084bNRnPG8/ZI+8=;
 b=i1gGh5aEgDEKkIFBC+3lsuxuC8tX2tUFepBAdrNaUSR9D58ldT6rV7qqaapUki/5qZhuH1a1E/4gEsyYvZnuMBHGyRLnbQLsneS5U+6c6EtxyR3T4VN/K4REPXHrO0FaKVXziSB5fO2lipD0kkeSPRg8pVcaJ5XYE83q5CrCOu/u+6uHKXVmThONLGPFHZMQ0kVMPdpvpPevBvNt+Wf/4DwbtAEE9tOXlrjJjTh4sH3gtXynEeJneKBXOd8T1pWRnoZxL/tS5TuOwVhhCDm6vEhMkQ2alQAY+f5ruV2fUqv+uMh0tTNjgO6PA/xJHU71+q6Jkd0GBLSlDS6NxyiCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iEU6tyA4drtGGT4Z942kOgqWrJg084bNRnPG8/ZI+8=;
 b=AkW10ZRmdMA3acbwzt9Uy1OFJxlvpm1e1Rznj55GvouhfdtVFax2NVGaz632lv6b3pdU0tCMj6WDxUcX6k0Ld8xyeX89gZlQ8RrXDXSAXJNf4egyl99/mFBjyfUil6jp3u4X2jX+ZcXAd5PXUTE/r5kRp07KcvBSPTi0uYYSs6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 05:34:50 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Mon, 10 Jul 2023
 05:34:50 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     =?UTF-8?q?Horia=20Geant=C3=84?= <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH] caam: init-clk based on caam-page0-access
Date:   Mon, 10 Jul 2023 11:04:18 +0530
Message-Id: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PAXPR04MB8638.eurprd04.prod.outlook.com
 (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e45c6b-31cd-46ae-d932-08db81076151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlCyjf+l4XtFs7eWYX+cZyMfHU3JFw6K88ENSBd9LHFj3J9fko9AyU8aHS+zfiZGONxxxwEACz2xIVC+2iVPt8xcBN8EGyfNfezACs39fe3v/lk3gcrQsDc0SIAXwaGkQARiBDsjV94Raud8ubQs67m17iWSz74jNe8HNIeoaKMk/TC7Euk6D51bn1ws3zexOHMPucBJ9A/MWTk0TgmoNWOi1i8I5r7v0Wh21vdMmhYokzCUJ0Qg4bcIJ0A+X/4J3Od5ef1dCQt0JS+UGoWMfrMpj0r8qFDaz6X0iCaz0pG7+jBX90FJg/yVzlEYr0ImM1FzIDCC8E+CO2wvKjxeq/dadx4C/FKv7Wg5v7LDqnxIOg94PdQWpKwAfCatYCIw7+r7Aal7rgGyrZcXTIcVB3eX64UDfj54C0f29tlRDSn/FELrj1Vb9j/qD9mHvsxnTjK8OTlobYs2uJz9/ye+rkDBp4GIeVY3rp/Il4yMqFyG3E+M/T6C/r/ZSyr2qMoUmv9WtJ+HavQY0r53DSrR0WCLOCKgdWiuelpi8uL1mdXlcwC3V4H5aW0nxDm41nV6h4GJQJl1X4ITF4Uci/gg0CogNblI4/aA3Toi5KlISTBnpwomdoAx3nxqTFXtz2PtMbNStBLG8kvJNngvJILTWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(186003)(26005)(1076003)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4326008)(6636002)(2906002)(66556008)(316002)(44832011)(5660300002)(8676002)(8936002)(66476007)(66946007)(478600001)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38100700002)(38350700002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DZkZumCud9o7U/BMA6OZr2o6hkmjTMaIvJWVZhedCgKzurI55YbWWWk2JCQ?=
 =?us-ascii?Q?iUWiOB8gAlj92rKHvptYfv0djndaEs5oiQ6x6Y7dbnXtgb7OBsSgcZeCEgGD?=
 =?us-ascii?Q?yb/0XacoEtyM3pBMMdh+CkiZGbkkAlo0XB2GN8NDLxUHcEetmhjN21Nyc1Fk?=
 =?us-ascii?Q?hg8ftm6pU6WpPLEaKvqM9HwDvCyxOWKNwB75S6GvjNd7nlIqGodjT9zARZ9d?=
 =?us-ascii?Q?zbASf/3C3LKpsR042zTbsRr9YnBb9msfxJ4KwpBs+bbKDyqqXYG6Df9HLyCN?=
 =?us-ascii?Q?r2/s9DouMBzY7YigjO4koG/9m7N1aoQUOt1iymjdWCuH5HD8RQUgf4SzHXi1?=
 =?us-ascii?Q?HffU7SA/di7Z94xtMalM1/xnDhDW0EeL9ZKy6WK9UrwFLX5lvXgM1uVOjC/o?=
 =?us-ascii?Q?1RXuGYbn3p7bN/y0B4a35CURXezZkfr+8166yyXGqd+KqRUuB5g2GPq9qHwg?=
 =?us-ascii?Q?80jeUvEU4NuJRuhJW8BdlmStbQ3FXrXPzvR0PBAKltqkvUeie6wDxHxaes82?=
 =?us-ascii?Q?Itb07voUZ1asXGrnNX6cIFTJLSEoz4r1gDXHgshf8swBqePVZTpLfmCCi8//?=
 =?us-ascii?Q?qbmbmTe9zsYo7dTLVtb+IqpOPSwSeRbsUwCMA8ZFnRgY4mEGhb4RhJTpJmAM?=
 =?us-ascii?Q?IprMisV2J1A9fPE6hoty0bUNOF4DLz4K4/9jxHLNhztjvtwxYYsPxytEuWlT?=
 =?us-ascii?Q?t3vZTagOoI6gv+RTinLd6bTVmEY4zQMNj9fbWxsQ+vZD4TsKPiT/nd054UEx?=
 =?us-ascii?Q?UHrNhADajywa5FDebeCY5PR46dDQUkRPb1dpEerLizPeFS5h8hznu4g9EhoM?=
 =?us-ascii?Q?yLOCLeEwX7eKT6uUCEyA7WlecOqtcxASGjccg9cf4TODyVJgr0Wzb1Q2/tTm?=
 =?us-ascii?Q?PmcRAzoYNSJLy6PLbWGoI+DIgAs9mxRTwT+frlNwQxRyTlTKINPJDVyAoc8E?=
 =?us-ascii?Q?o5qC19ftYNLFX4mvCyYZGRZ7cW7qoBEVLa1wtFqYRAMLEU0SZrRh0oEyxySX?=
 =?us-ascii?Q?UwD2SnrmK9NZC74tEw3wvZI5s5T1Sbx8O1aX7X8aLSxNnwsJhBfIOlqZ7RsT?=
 =?us-ascii?Q?G8aWfc3qHyDyTr25BgWEs2hUUII2hSffy0NgoXNwcAP+uP3qunqGZgAF9xHt?=
 =?us-ascii?Q?1IoW2BcmxOn9iBCRSwOgC7uU/MHeFVYiPXQfj21uzsm2aBIitos2YBBjuoFw?=
 =?us-ascii?Q?PXo32glldtEhvaD5pbiZ4PZE1BISI67R76eOHDb5cc7hzrHMqHSGq2bM2L/3?=
 =?us-ascii?Q?bjroel+N4s0cI2RdisfUs1ywqYuKhgvNoFJggz+nTZ44ZSOs8WBxsED7KTIs?=
 =?us-ascii?Q?59AcjEL53uxzcOzU3tX95ph5Rw4bJJjNx+zus8nw5DaTArGIJftTnixH1WuD?=
 =?us-ascii?Q?M1HoKLqzEFuUQqk8dY8YNiu4EAZS84fgyW+cvsSma0cTYoTp5LAmX6f8zx+3?=
 =?us-ascii?Q?Z2C0VoFiImFw1aruSnMoy7PST2ObXFSWRNS2Sw+M34yHrCLDwrVy+S/0EmRC?=
 =?us-ascii?Q?aFdmIr03m0b+H+LdxzuCwtB9OQJXdiHi7QIxLBde2PxiOl8hDzSEZt00Yq5c?=
 =?us-ascii?Q?KVvLU2Hq0Kw2csK35Prs/PZWN6pNyHk1F5m46QZB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e45c6b-31cd-46ae-d932-08db81076151
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 05:34:50.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0K72kjvd6WXP6xPpaYS1n2AgLXUXplpmna5i2SGFKYWpQ5vr1otY51m7ntOPCPvDdzws43zyX9tQrG9KSWkSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAAM clock initialization to be done based on, soc specific
info stored in struct caam_imx_data:
- caam-page0-access flag
- num_clks

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ff9ddbbca377..74d0b7541d54 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -511,6 +511,7 @@ static const struct of_device_id caam_match[] = {
 MODULE_DEVICE_TABLE(of, caam_match);
 
 struct caam_imx_data {
+	bool page0_access;
 	const struct clk_bulk_data *clks;
 	int num_clks;
 };
@@ -523,6 +524,7 @@ static const struct clk_bulk_data caam_imx6_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6_data = {
+	.page0_access = true,
 	.clks = caam_imx6_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6_clks),
 };
@@ -533,6 +535,7 @@ static const struct clk_bulk_data caam_imx7_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx7_data = {
+	.page0_access = true,
 	.clks = caam_imx7_clks,
 	.num_clks = ARRAY_SIZE(caam_imx7_clks),
 };
@@ -544,6 +547,7 @@ static const struct clk_bulk_data caam_imx6ul_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6ul_data = {
+	.page0_access = true,
 	.clks = caam_imx6ul_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6ul_clks),
 };
@@ -553,15 +557,23 @@ static const struct clk_bulk_data caam_vf610_clks[] = {
 };
 
 static const struct caam_imx_data caam_vf610_data = {
+	.page0_access = true,
 	.clks = caam_vf610_clks,
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
 
+static const struct caam_imx_data caam_imx8ulp_data = {
+	.page0_access = false,
+	.clks = NULL,
+	.num_clks = 0,
+};
+
 static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },
 	{ .soc_id = "VF*",     .data = &caam_vf610_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
@@ -756,6 +768,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool reg_access = true;
+	const struct caam_imx_data *imx_soc_data;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -772,6 +785,15 @@ static int caam_probe(struct platform_device *pdev)
 	caam_imx = (bool)imx_soc_match;
 
 	if (imx_soc_match) {
+		if (imx_soc_match->data) {
+			imx_soc_data = imx_soc_match->data;
+			reg_access = imx_soc_data->page0_access;
+			/*
+			 * CAAM clocks cannot be controlled from kernel.
+			 */
+			if (!imx_soc_data->num_clks)
+				goto iomap_ctrl;
+		}
 		/*
 		 * Until Layerscape and i.MX OP-TEE get in sync,
 		 * only i.MX OP-TEE use cases disallow access to
@@ -781,7 +803,7 @@ static int caam_probe(struct platform_device *pdev)
 		ctrlpriv->optee_en = !!np;
 		of_node_put(np);
 
-		reg_access = !ctrlpriv->optee_en;
+		reg_access = reg_access && !ctrlpriv->optee_en;
 
 		if (!imx_soc_match->data) {
 			dev_err(dev, "No clock data provided for i.MX SoC");
@@ -793,7 +815,7 @@ static int caam_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-
+iomap_ctrl:
 	/* Get configuration properties from device tree */
 	/* First, get register page */
 	ctrl = devm_of_iomap(dev, nprop, 0, NULL);
-- 
2.34.1

