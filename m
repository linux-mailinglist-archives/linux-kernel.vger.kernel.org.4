Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9D700421
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjELJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjELJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:41:48 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41501157E;
        Fri, 12 May 2023 02:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao1mU2ULb4z57JwbHA1OYTIQj0iEilbX7M/PoCmw5QwIr88NIAC2igqdHdjwGL8Y2zPmsMorDtrvlM6DokdjIKzKiPtrjQRtZ2MQtGhed2N8m/Kp43z5JOB/692gbdbmR54ZUQ/2pexyeJvSpvxJnzrk7b2RmezIz0/LBzVf1leRhAwulInYw1BQAAOdOgc1StLLDD1pota6/lJU4GL49LxH490VOiHsSjmOR8f3Sl+JHnKxB0fiJoTXsTicJS1zuq+La3Dh6u/ZtBNTcx3EsNxnCn2AG8ChxrQQTyzkhreDcELoxVkO/EAM25fB4O7yMj+dq5T+Kcj3nPPM5j6Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0wQDLeCIyZc5fEmwGja3rFQf6nbnr75pKLpJLU6flg=;
 b=Na0q2ZsLoobEEQZWLHvxkXbm75JA92/P7KnS7CouwMD1PYWqJisinRbmx+4cnoJGsBkhlKIzMGxHEtKAR8xl3kPYIHBzc62Lt6YDEADtXryqM6L71msxPHb/hPgnOUI2zfoR72VPLes5rzP7vjERgSwYPVL3c0zB/biQNWWAzUMbZnIFBwoUkPY5KZ5L7l1UyI035WAkWHLOwueDtPwYGOdwFLIwBVOGAXj/bS7VM2GtFa+68BNk1tMfOq6WI3iaMoQwnoJHlhhfdwh+c+GqB2oC0ExEL2o5NUENg6ixrQyztauiMrxdn5xBdb/VI8Sx3nOVOUrnzLBBNkxuUpmSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0wQDLeCIyZc5fEmwGja3rFQf6nbnr75pKLpJLU6flg=;
 b=T3SI9yPS5iSkDN7XNfyd02lEvgUL9QkX0aXT6ooa/6+u+MpGB5sapST3Id9TbhMFfded9GJkzRh4Zcf2+v83hF/08W8O3FZPhPZ6vizzhT6mqhEjhBKNKTL6vzB1D/TxEagxQ0nzWfF2EmQaHQaYgNjKnTHQxA+yNBwTWmWU/8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 09:41:21 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%4]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 09:41:21 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Alice Guo <alice.guo@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] caam: imx: fix the built-in caam driver cannot match soc_id
Date:   Fri, 12 May 2023 20:40:33 +0530
Message-Id: <20230512151033.1327643-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 94283075-8bc5-4147-939c-08db52cd0b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JBMDJJ92UpReAL7ieUvB+w3O/9Fii+iqANJKd7pxobXg8pnpnYtGkjr1BQGlppsf3OXwUs9Rzr640z3sWySfPVMCdTvr6gmjdXK/nTTf4MIfReZucc7k6gn75rOfhg22d4D6XCmYBAl6eXFMnHPawc8oJlNrWxv3o6mWR5kTJxm8rhR2nKb2y8359OvWk83FM+cER8XDBWfHGl//qZ8I/G5CqnzrNUovzl6eSjqaz0nYaLjsI/N2d+633LVdpMYBoN/LFGelWrXYqmIutwGShD8R9UlDwIXwPCzTAzPmMqo6ODf1WocEefIsvVcGpqJyA6tblqK9ewjaTOmei4Cg1olDuIYbih9zsnC7W62SC5HWu+JJvmQKEwc5JP1F2LJGT+p2tk7OGquNg0xvq0uyA5HpZDrzf/TXh+bHI/HAsg0cQMtxssR3RafrxIPuHbSQqAMVreftpxrX6hSvG07ic82wmbPuoaoegzFcKNgmoB614I0uhGQxnQ7bnZF4TamPVf0Xv4f0cmgT5tqUJV1cmI9nZMT5A3Hl9VdKBLswTAuIL7aHYv2jmzsh7SxEzqEQbs1yR+JgF7w7OW+JOYLed7og8sn5DktxuoeDNzJDSxokXHiK4LUrXF6gAME8P5a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(2616005)(2906002)(6666004)(6486002)(52116002)(86362001)(83380400001)(186003)(1076003)(26005)(6512007)(6506007)(54906003)(316002)(4326008)(66946007)(478600001)(66556008)(8676002)(8936002)(5660300002)(41300700001)(36756003)(44832011)(38350700002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cikaUN7mHZoDdCyVnqogvawdhFGFDAKWeJ0NLk6Sngn463JWVsB2EfGGOb6K?=
 =?us-ascii?Q?uIe6h18CSJC8DeuRYCRz8gO0GI6SgCzIHlpUzePAos8YkrXxEeihY6DsonOi?=
 =?us-ascii?Q?3Yv8GqX1z757315AHLMxnz2kNiy8nSd9721Q40UWKgMYv1SIR5n+zRKYeZtl?=
 =?us-ascii?Q?pIQ2/jL5ngFBPgQwXXWPjSfVb2oytPd1YLbHYB/F4lfDmnLRI2mlkYatCnYJ?=
 =?us-ascii?Q?q+Oq1xW03vWO7/dvDBFpbtA2980dhG1TLkUgdvcef3YUUlisDJ1AqnCIr1Vd?=
 =?us-ascii?Q?BZh+D3hyBEz8AXMKxFo6KgvI/iYwHEE+8hBzAai8BtpakSOWoyvG04Uh3Qu5?=
 =?us-ascii?Q?pdO+0fo9diW2R4wVdORaeUlC3m4fQlQ/35lwCtQ56j6TP3FvdJmWJvpaZy9c?=
 =?us-ascii?Q?SBUunhyZ7CW/0MlTF0o293CYsJI5nuHBQ/ieNWyv29thnGbNWthn+XZnW0fq?=
 =?us-ascii?Q?Xxtu8CnLr5mRlUVyDyjIcah5uz/QQeuRhVOXHxdE1exeBUmPqngGjGFfEewm?=
 =?us-ascii?Q?fkVRfjwp79Toaw8jlHyvBDjpS6wvwhBNTstz3Yw/djW+qXcx+Xa1ZBzhaR1u?=
 =?us-ascii?Q?ezzgULV5dMbhZG9oNJeU28t8MBvm99z2sDHeHzeRf9E+Enhop9dQitz2oHxy?=
 =?us-ascii?Q?JS6UaKN9Qx4hKXsmaCFF7UwgIUKN14DtyhfxpFIL5Pa+NewsIMGDsblvWJCe?=
 =?us-ascii?Q?dcFCoJ0EMPVzim3brqy6heWOfZNNFmvYEWdeOFi3DeOetzZBP2jDPCZGnbGi?=
 =?us-ascii?Q?JbTLiFMd7TVpQp1QrNXX/dZ3lE0paPDKQ32agYbBDq1wPlg+S6+Qgbe7ca3h?=
 =?us-ascii?Q?qjFfoq7donDihgE8xl+Fn17jCcrNyQAsIxyTrsIF7J7KBqk15ViHOkXWA76R?=
 =?us-ascii?Q?ThmO5s5bQ/bz7Xc8WqfnR0dllsYH/y/hkjGYlW+ZhrgW3/x/CStH1I+cNLpc?=
 =?us-ascii?Q?TKo+Qe3P4zSH0WJhzOXd7tcAbL3Z84ywbsodLCZ/EuPMRxBkNTSCklFzi8lv?=
 =?us-ascii?Q?bObIUML0v2ToXqTLJ1xSkysDgqThw4VG1qSs6+i9BM9opPOIrVZy9L4NPTs7?=
 =?us-ascii?Q?r0W2sU78xI4UosweNu6KnXVbzBh1Gf5khZxmav7fB1q7SZ8CnJTB2NmT5yx5?=
 =?us-ascii?Q?EmrVvWa9g5hgVZPcz7/8BA91pyZAJXVSQyJgjo3lax21mtYLRHmbsZvk24zb?=
 =?us-ascii?Q?6Jggzi7R2ZM8R2HAbzt98ODJADmbbtzHxJpcWs6f4u4rwu4pQJmPbiwBP/1c?=
 =?us-ascii?Q?XjnRlNOJ7tpMuQKBjDpBxQE7rAtTVa7hH8wjNWh7dno5zUsDeZb09R2dj7XS?=
 =?us-ascii?Q?PobdvQKd3sQI2mN7CVCn7nv+A3mSGqM098fUVW9nRALbIiO0gZ5LG+XkuRKM?=
 =?us-ascii?Q?ZUOtrB8rj25bOtTEzZ83gkZNNPNUNbFN1qu03fO69gIXRv3VDKKKraODFs4w?=
 =?us-ascii?Q?AMB8M2dWzg74EBzdF/LXa/YwS1GCm6rHvUXGrGGGTTZbFp8ZKijsGDGa0lDE?=
 =?us-ascii?Q?umyfZicfAlRhdFwTDbOPkAfJRJV2xAKUxMu+XiEmml8E8GhSg69Qt0TadiqF?=
 =?us-ascii?Q?e9PcqxOlyhM0+e96AaObr9a/1p2JLe5kQWPuiw0d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94283075-8bc5-4147-939c-08db52cd0b1a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 09:41:21.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWIIVmhKaPtSnN8U+Q/kNunu9coyn/mYZp6oXwoBFKBAPTp6W63GufKb57FKi6eBPq7xjFfc87mC8oZZMU29fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since, CAAM driver is probed before soc_device_attribute done as part of:
- drivers/soc/imx/soc-imx8m.c   (for i.MX8M)
- drivers/firmware/imx/ele_mu.c (EdgeLock Enclave kernel driver, for i.MX8ULP)

It is needed to return -EPROBE_DEFER, after calling soc_device_match() in
drivers/crypto/caam/ctrl.c.

soc_device_match returns NULL for:
- i.MX8M
- i.MX8ULP,
can be considered that the SoC device has not been probed yet.
Hence, it returns -EPROBE_DEFER directly.

caam: imx: change to use of_match_node in run_descriptor_deco0

Providing imx8m_machine_match to match:
- i.MX8M{Q,M,N,P},
- i.MX8ULP,
so as to start using of_match_node, to simplify the code.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index bedcc2ab3a00..d8c528363f10 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -79,6 +79,15 @@ static void build_deinstantiation_desc(u32 *desc, int handle)
 	append_jump(desc, JUMP_CLASS_CLASS1 | JUMP_TYPE_HALT);
 }
 
+static const struct of_device_id imx8m_machine_match[] = {
+	{ .compatible = "fsl,imx8mm", },
+	{ .compatible = "fsl,imx8mn", },
+	{ .compatible = "fsl,imx8mp", },
+	{ .compatible = "fsl,imx8mq", },
+	{ .compatible = "fsl,imx8ulp", },
+	{ }
+};
+
 /*
  * run_descriptor_deco0 - runs a descriptor on DECO0, under direct control of
  *			  the software (no JR/QI used).
@@ -105,10 +114,7 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 	     * Apparently on i.MX8M{Q,M,N,P} it doesn't matter if virt_en == 1
 	     * and the following steps should be performed regardless
 	     */
-	    of_machine_is_compatible("fsl,imx8mq") ||
-	    of_machine_is_compatible("fsl,imx8mm") ||
-	    of_machine_is_compatible("fsl,imx8mn") ||
-	    of_machine_is_compatible("fsl,imx8mp")) {
+	    of_match_node(imx8m_machine_match, of_root)) {
 		clrsetbits_32(&ctrl->deco_rsr, 0, DECORSR_JR0);
 
 		while (!(rd_reg32(&ctrl->deco_rsr) & DECORSR_VALID) &&
@@ -646,6 +652,9 @@ static int caam_probe(struct platform_device *pdev)
 	nprop = pdev->dev.of_node;
 
 	imx_soc_match = soc_device_match(caam_imx_soc_table);
+	if (!imx_soc_match && of_match_node(imx8m_machine_match, of_root))
+		return -EPROBE_DEFER;
+
 	caam_imx = (bool)imx_soc_match;
 
 	if (imx_soc_match) {
-- 
2.34.1

