Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73825610DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJ1JxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJ1Jwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0851C8D5C;
        Fri, 28 Oct 2022 02:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8PkL5wJ7FHB3KMoQCaP8yT8VA+afnsPoXeA0szeJdCTWq9aC1yHt9CNKvZflD4RD14ZILbNjw3++Z4TT91AQ9/7HVzYDOlvly7P6Z6i6+kZQ821/ugYYrVO+5IvbACnCgoIb31fH//+z8peCzRC5D+VVvjVdgSLXhjLYhY90sVujCdkhCok0Dl6EIMVXJNcUjnHGuC6eirqSjbekia9rm5Xz6GcEYv+L8nTdMBW7kDd6bE8fUObRJqFTVMLsqt2LBJaYKAC5Ct6QGjSkrcX9YslMdkXLrV7QsXN4eCCYMRfi0m99ySR/OH90ZBkgJALTNSmJ3hAWfS75L/u2JoS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8bclElul4B6CENXZljmyYYupBA6dEYdtz1HxiqWmsE=;
 b=KJagec1GXdFxvqwa4ql/gAX/clscY8T9zUErGv5woLwzef0Tu4Pzo95QlkMWjVo+AWp42izQYNRzRgmbTj6d4+UakvDn5Ac+6zO0EMGbqAgGDeBT5p5ZM5IwuFXY+eLJWF5daAFzoXjQUcMXWvjlrDuiTJ/ktVxR+XkgaNLrY9yLn9P3L8nFXJvs44IAwJxya65QXj1xXtJ+edhHASr7AiCSFvfCOddS93xG6RuWpZfVhUnL4EG98e61AFxxoQd2oT/QkHCqtmvbbDq00altYz9UHdsflryITTdDd7rHxaLB5yDJljaRJ0VvepMkfl/+B52YBHbg58ybtw9Np80RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8bclElul4B6CENXZljmyYYupBA6dEYdtz1HxiqWmsE=;
 b=kOyvgKyA9J0DQPZkvYHbLxxWDR5alM+F4MFAKajP/FKlXpjT2vgYFWo76S4ZgnhnmXd4kbjtTI8TF211T0hc5OKD87bEHoEI6sbqghESNyECiibsybMN49WclZcsJl1AfTc/a/yT81ko1IarxGucwDNtvlzgpuGc1nYzsc0daxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:51:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:51:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/6] clk: imx93: keep sys ctr clock always on
Date:   Fri, 28 Oct 2022 17:52:11 +0800
Message-Id: <20221028095211.2598312-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd79d59-2081-4ad4-89bf-08dab8c9f667
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sd7+UAdDCtbIWWkuRF9CiqsvCSs9sr/Yknnf2PFX2/wuYbM2tMnkmar3qQY9CcpHc7KCE4KsKJ4svxbQrUDtdoRCvixoASjetAoQ45SpSAy3z42rPq5x5kjt5diGp3REzruR5ornTl/acFM5kwp/Q1pg4KMv2dCxIjeD5MT+O+b7z9nTy7NigJN8+3veMVK9CmNe+gzdvkvEvjm0aDGdzOmVm1MivLhn4gkWvrsDww+hYhxRYGWcUdsyLzM9392/YAVSizlUDUZavuxBgGU+4vm+YxKdf/N+V/L1Zh3GMbR+a5X8AzxsKFiWwii9DZKMbh94gZmRW0ajDgHg8hF3DbltKo3QzXP87IgiSL3Rwyz3rUZdADtbeX9H/PpGeoBDbxddRXZSIywHs8g2V54hQdNGRm7KXcDOzXM3K/AYev3OokvFofy0zmv9mSmqe+v3XEme0DWVw1Op9onI+HKsdLjSsADG9TfZt6mPM6r4rCDkp6bljZk7TpKHvWwnXwX2qs6M6YXuXVJKxJgXelqGhBBKw/PGrJ7qrWDk7qrsLtu3Gq4kDWC+jPjNIKRTjGiG+UjDz8aV4Q+f3nMqFkKqZtpc6ZRCi9rbo1vBxZ0SngUbHn+H44sTDqaKbTygJpjnS5vUzfnyyD1GIDo4q4pvN6ITbpYqKG0XVD1Ck+ffHD6ZRBKaQfm2Rn1nanJSjrrNheejsxQOneCzP/ngtVFDMOLd2NmRuexYcsKEmfj/dIsFVM78KKoCr8nA1hJ5ndtdOEvOswAvsXxqY/24UKnsbY+gRRePC5b6pfD2W5bklKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(52116002)(2616005)(6506007)(26005)(6512007)(478600001)(186003)(6666004)(1076003)(83380400001)(8936002)(2906002)(316002)(54906003)(6486002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(38100700002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxlVRX+VofZFciCdHmq1b2iYCoz7J1EJeoe0jsSR0rtdEQcocx6z+la8AbRH?=
 =?us-ascii?Q?MQbasTRpbxavGQraxpZindN7A/D4QECgXBMxf6oEOt8nJ18Ou/zxCMcRRYqg?=
 =?us-ascii?Q?nMbsYZKx2GbjuJh7uxnbKieqhgb+73oFAm51X2bpQ0NS/0hpOVeJ8Fom+2NS?=
 =?us-ascii?Q?uIGrtoph79cQc+VkSJVzPY/brjTQN9NaKj3OtiSPtzGCjIExLswef0xl68qZ?=
 =?us-ascii?Q?Xj5YHEEeXZVuInB+mijEr/mEozFdQ7RnSEDYbN1E2XNMeZuwCLeHOqcdzYrR?=
 =?us-ascii?Q?9btqjeSLUeXy24xOEKFh2PXffDl8XQ+ZNfeMoSfvki2yiTvtu+fnuLKMJWJe?=
 =?us-ascii?Q?fgvU1xiIs3QWbt7RKD0shCFoQk9GnzUZ8/oAHBNWGWDNSEy6YOKzQbu9A7Xv?=
 =?us-ascii?Q?2C4vnWtC19I59V01MhsrEKrgNr3SR1D1D2i3qNubJDPSba4QBgZyht+JBYgg?=
 =?us-ascii?Q?6O1sKGgR1wqD8JWYJynPJlIxqpqjxNabBHQPQKy3PVsvyGeLDnrheInJMWvj?=
 =?us-ascii?Q?7w2Ex/RZMsKFHuBpwBG+5Mlam3lu1oIPEKd/zRSf3l+tyjofU2g7UHM+Omfm?=
 =?us-ascii?Q?oPDM06O1LOxoBIovaV2jsi3+cQkkugIYyLC5JJu8jz4svLQlm2PDJZOQoiOH?=
 =?us-ascii?Q?8nQOss8U2ufXYcBuDEY+PCfBJI4ZRA31yLAzz9ZdwCcmkWaNb2HqrcPP/sv8?=
 =?us-ascii?Q?zT+8K/HTvd8mphP0IrdADgbYUW0dmjUxYU0SRDCyebtnxzYiz1Ybqvs+p0tH?=
 =?us-ascii?Q?AHjcV2KfrbRPtrYMh4C9wU/vJnSoN0pAUkZJEhSP+0nCqFweycwkQIEI8lVB?=
 =?us-ascii?Q?AGvcs+KFDuGZinlputDMYnO8t1UBzzVg7Ai1TSju+x2eR87BxZQtgqW4J9Xk?=
 =?us-ascii?Q?M3R1sZLbf5y5+H/u2o/fdeV2L2vOT/99b1Bxql628Uuo20l2zT88YvJwhAAC?=
 =?us-ascii?Q?3nxApHE2BSofrVBnKoP1ieDjqcDAqvJDcfLlKRz6wPmTuBfV2hga+sEt0dOS?=
 =?us-ascii?Q?Bzyr4gxs1tBFrGzZAAdIVGBHTNTfRsaSJXsmv9zDZRKjeeTiSvoM+K/XSebd?=
 =?us-ascii?Q?jl6JaetVIS0rFLptLaDYd4fVnXgAygvxltqnrZ+nkYYy+9yxfCCQW7zjQHVd?=
 =?us-ascii?Q?qwNV7F65oioJXf5g9Q4x0OCMI2WpSzcpp7to5gTk+StR2lZdRRIghzaIP5vM?=
 =?us-ascii?Q?0kLBU5vN4BUxMxX6upeS6N6CGwpuyNj+WmKk6CezZi8S1/QwD4Wb0Zk4MCLz?=
 =?us-ascii?Q?ckfDgpdMx2jm8vVrRMSj+g4ml49UBglzeyVlsOP6bykKbLOSrzEyazwZ/VhX?=
 =?us-ascii?Q?GHh6R4/2dKiIs6QYF9aeA7qysUAeOMZoHV8MCuBssPJzML7dv696E7qtH/JD?=
 =?us-ascii?Q?Aj/5rL/3gCg5ipdk1jr/CnYhONAo7hX3HrdD/eGbS1l0BxnI20ix7oFHtDpb?=
 =?us-ascii?Q?Eizkq2xTQxyVM795WcizdUbgsAeGtxME9v80XOuVJPIr2EK2EClkgZFmiXR9?=
 =?us-ascii?Q?+4llcCWe5BtvWZB+GbmEMdcmwk8Z3ilrE/8vKXIfqiiyLXoZBn5xYX69P/CZ?=
 =?us-ascii?Q?QW8CQbMY3qdXT9hBfo5KcuHGZw4sK1j/eC+FIN11?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd79d59-2081-4ad4-89bf-08dab8c9f667
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:51:19.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWNDizbAXWf3tDbpwV+tvLk9u3bGOBJZoIDp72HoNtVAC9QoqiOmo50tHUGS1qfRHajkxaRaPnXNXtjpG+YnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Keep sys ctr clock always on to make sure its register
can be accessed for cpuidle.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 7dace96f36df..b42a877ecca1 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -242,7 +242,8 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
 	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
 	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
-	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
+	/* Critical because clk accessed during CPU idle */
+	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
 	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
 	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
-- 
2.37.1

