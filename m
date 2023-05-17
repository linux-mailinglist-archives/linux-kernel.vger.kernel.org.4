Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27E706DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEQQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEQQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EFDA5F8;
        Wed, 17 May 2023 09:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+qF9u2ZqVtQVjE5mE17iboSu0Q8jz34v/94F1ke7hIxpPG+jb7jMxhC3IzHV86NzTbQ7f95EE8iDgPvveyU70ncZBPeLU5kYt0UHl6eTB+p74deklRE7QAjRnLB9wqdY5VqzxNVkBi6i68fWYLrDoy53OwwW8obfrBHXl55ybMu0I+5i12n/turQ9WevsGs80jRmo5pg8ca2MJEaJ7cjIAkFTSkEY1ci8IdBbpqilk4baQTfYn/CwwmP2pmeGuiOMrM+Vb51aFwI5ZWA9DdM9icR2tI9kCNDZr0wS8bx0D/gOcD+mjI4wAL5XqNVaV16Ie1t3HOWWQPIu8dlWptAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxcKOSTNVVlzK0XZiBKmlLM/0WQRmY1RJtAKhcdVlos=;
 b=XFMkzdnDQgzXrHzUzpXlgEvZ++mvD0A+lvbHc0yKbUqldS8iWpUCsoyjkM8FEPe/NAYUk/t3sdxkjd2d8rdYL/GhlWwgsCiJUbZnuP7H15GXW0aakCZ8BOX9aioUp9kOsS3mol9fhk1+DYVcvYc6xXm9aGDkEANPTKqScJfHUlTIPU2tWf4nMaCi+DCwttBIRiJPWgqev1Jzj0daCOiWV99lZejK+bb9X+30Z8Z7QrfwRzfBFQ+uWnH0ymkyvUJUy8nUF37iHrHv+uTdMoLRtzOTjd4C1PL5D93ThCjavGdjfF+WmB7TXxaKJvq5BU18Cvsrgfrr8y84BIyeA7ImuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxcKOSTNVVlzK0XZiBKmlLM/0WQRmY1RJtAKhcdVlos=;
 b=sX9LDQZsjaWq+QaGffUQnDfbQazHOdouemSi2uqSdDi6oGTEXK/flFFVrOFcBnkF1fKU+W0Y3BKzmjkxMFXekjFmEnyqghnqPYfNr5+adCFYjN7NOm6tISLPVXNdXU5P8rDgHbl+lAaLZRfq4PWZivEpr0FnIgJEfPhpZPaPfq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 3/6] phy: cadence: salvo: add bist fix
Date:   Wed, 17 May 2023 12:16:43 -0400
Message-Id: <20230517161646.3418250-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517161646.3418250-1-Frank.Li@nxp.com>
References: <20230517161646.3418250-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: c08effe1-ab94-4974-f87d-08db56f22f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZD7MUR6D8QDXD0ysz3PDKsIsYlpSCbJ4KHx09cziwM5C0RPz8pGm5Ed2JjR2kVLODgs9WyEJ9xQTB8FL3RvZbe+k6DA6axLSfbSZKqXxjvS+zp+lW3b7voDoEWGwtZo4/sxbGVUgxmsUGHxwJXbhgAyP4uDR1aeNNdABi8n/+BmhixFg1FhCO66UH+414oBqrXHZHgTd09gonugU3FwmBl1jfrFDtGiPSZWlTDxYSPzgT6UJoDRby1t1SscTLJi5iFXBKQS4ef/I8X0x1ffmGIRUGMidGetYFzGDpltoPvzbHjywkBuMY0bnDb21uw/ApZkTgaAizNL0vrvr3hkJ36Nh3EUS01+HxlAdjqEPOpZJZRt/cwLMjy1GAqht3quxf6pz3RKaMp2tbeJaWOnJZncSnv5bCtdmk+4aCTmRwXc4rPpIRTMk0w0DbyRC4yBnE0Y7aPenyvRIEoMFM8LJH1vz4sgodwY4TZq5IHbHecwhs6LEWjqo/SGddz49UJI6KKwgGrUzT25D+1FiMpHWTRcZWtXpeCNhYomuvxmf7bPMmIlZcuemH8Dkp2I9nY5hdIctx5Z5n+l9iwIAo8gq7PF3TveS3HiJOFKkGZcJs2cnkK8vPGv1/o99mTkyZIN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(83380400001)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrQQHXj2KccMcVl3gBzDhafC/XjTNWG7jlUt7DC8ZN9z8KUghD7qjZjTN7Ip?=
 =?us-ascii?Q?kVZB7r4cKwnP0ZEDLDQSVCv0YPcMn3+tMPIOMj0NyHSugX7nnezYlToczh37?=
 =?us-ascii?Q?opo9F1vtvdONA0EacrtbgpkqDekOO81NZnyf1HDHFo9eiw1l2f0EZKfbXbIo?=
 =?us-ascii?Q?FGshdB5jZ4icB5BHmgLInm80ry5TGURGLN7bJBdYzHVQmeu8WaW/1tEi+Dlz?=
 =?us-ascii?Q?5VBL55JoWo4nSYbK+DTgJ938w2wJaWFierKJEVkQHMDjd+k2lrfyGgPWYMUz?=
 =?us-ascii?Q?W+J/Dmt2ewx43KEPEPrjH47WjJeYbB/F/G8yg7pi2UEshckiJPDmZII1NfCJ?=
 =?us-ascii?Q?pg4euOBMebEovq6TRCWqSEtRL+RNhbYTDJIgkpTSp8WPDlsJPU65vu6Jm0Ot?=
 =?us-ascii?Q?GzCM81h5x8MxTNH1B83roAbC4xmyGvMorENXiaRnT+QFmre+TUAWdjlpFyGL?=
 =?us-ascii?Q?pM7WmT34wlZP4/+M8aFGeclUN6LLk9AodeG4QsD2qj/NRrbOz0IbsX8IRy0j?=
 =?us-ascii?Q?U9YJUKdCwrUJZmHUe0gdFRJcoR6PSTwdoeZ/p5R+aWAOdch9q/UuXLYq8QPH?=
 =?us-ascii?Q?ouc9Nysv8s24A+THyWi2e4MxwkzlQOyxyHWGDD/maujIDLG4k8Es17y2lpvd?=
 =?us-ascii?Q?AM34kdLhWs5q+oLASNc7z7Bq++WANPq0HoCFKjpTayY3crA/l60vBNAYNPYA?=
 =?us-ascii?Q?n6TR3geoKmM+Q62Qy30OOCjfDetD/nvx2sKCLh5TR5gX/nEfrLdyzUEDeHRV?=
 =?us-ascii?Q?bRLhwtfjgiLJkVDkQ72GqkDlmIid4JCfEy/S+sTdOkDK2CEfFtQ0NoZ5MI91?=
 =?us-ascii?Q?uOrsbDjwmrhKKqYcg/Mc1YjE4HtuxVUQJCS0591vmeeeD6phxTbOWSAv6U/P?=
 =?us-ascii?Q?5a82/MV8rFSaFAIIWA4Fpunm/NSS2vbqdXfmq+XkMSI9CM22n40jKgndU6TY?=
 =?us-ascii?Q?dipmIbACNlIt/jskgVTTzgByflFuyfuPZjCilzz4hbVNT7y2fZbF899QfFU5?=
 =?us-ascii?Q?Qzc8tz5XmnOpJOQ0HfOCRZEez8EPW7Lu4TzM4ajB+5qifL5/kuGDtKEi5nr3?=
 =?us-ascii?Q?/nnl6manJncN+jt1WafAidoZCxkJEs7rT8jqiMFPKgfvjMRE3gQgiEnCy9qM?=
 =?us-ascii?Q?2/y/G+DLgXK0mw4zbif5mM94QXcpxgiczBo805WIoc/h0z8p83CAv+wqDXKq?=
 =?us-ascii?Q?/G3cO88qYAm4jTWEH+xEsa33VVhmR9Qrnt3K/4iuUcdIcc5+AZz3Eha7RvNK?=
 =?us-ascii?Q?NvHLVQqt7aduZOFkTIOJ+Jlr5NyPI6I2E8c6j2Wp3MSJzlsm0X/mgNojNRTY?=
 =?us-ascii?Q?RQZWysjUMlIX8Pa7U5kCo+SdszewzFeFL5LHVxZUoU40+afO+63CGcb3IalX?=
 =?us-ascii?Q?q1bJ2jcKcIbEzJEkynzpraqmx7XcpWaPC9jG5HhIqVTfcgMSSdvJX+v+FhmL?=
 =?us-ascii?Q?LcGz4DposmqKMGrYeiDtwhlf0YRNmettrjQCsGD1tLM5lfn7LGcwa8WliBKY?=
 =?us-ascii?Q?hANN1Tpw6TRwqquuja4HJthB96sUO0KBjhBzBnZbCVphb5GRADv1wHJ1QwHa?=
 =?us-ascii?Q?yCvQBuF1Z8/SHMt2xDw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08effe1-ab94-4974-f87d-08db56f22f1c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:17.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smIuhAIKjND13W7SrfW3aKjl4OkCA5/gDKLThe4TZYApAV54E/8p//L3wKu8G9FxyeCf7PvVaExo7TWVnZNrKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

Very limited parts may fail to work on full speed mode (both host and
device modes) for USB3 port due to higher threshold in full speed receiver
of USB2.0 PHY.

One example failure symptom is, the enumeration is failed when connecting
full speed USB mouse to USB3 port, especially under high temperature.

The workaround is to configure threshold voltage value of single ended
receiver by setting USB2.0 PHY register AFE_RX_REG5[2:0] to 3'b101.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 2e3d4d8fb8eb..5633fd21ae7d 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -91,6 +91,7 @@
 
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
+#define UTMI_AFE_RX_REG5			0x12
 
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
@@ -247,6 +248,7 @@ static int cdns_salvo_phy_init(struct phy *phy)
 	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_REG15,
 			 value | TXVALID_GATE_THRESHOLD_HS_0US);
 
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5, 0x5);
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
-- 
2.34.1

