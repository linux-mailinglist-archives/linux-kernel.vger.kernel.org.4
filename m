Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB880706DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEQQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjEQQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3DA26F;
        Wed, 17 May 2023 09:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxesHcjRr+cXf+8zvao5RwiZLexP4R6ZaC5b4Jjf00OMhApYHXxLDR1byU1IJ1qT/28YQ/8iodumG2tVqZ4yqv7/D/Criq/tZ7nfatEwUT4vP/RroS+X0h18rfH4adIP4te8QtOosXj5O1hHgUA3yKDvSdABP5oD4xlIEbTa7MLKBydJG/Pzhth8dGgt+yDXrL2aRVpiYXOsgXA55/+SqcZAzPTwINYjKfEOBh0j1UEWN7cUsuBfc6ABUWXw6NS50ITtF/E2UzCrTgCfiyf2o64j7j2aeVzlsnlWOo11hEZjTpwFmN1auXLRaiPxnYYMmEQbOT/91qrAyT1fWZ8iqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVm17g7uRevK5sYQoI5+K/wE4ULpyAFhfUnYx0zKro4=;
 b=SdFOJerBc2/L86LAH0lZbVJnqQ/i7GCW8vPfGqAierlSDdCkuHjuKwPNM/gxKGTLPqMvJdYexoCdWKmwE5AfP9V8K8qmywsWCpD7ZRfemSdDh5fdzN8GZa0VXMatSW0Vbz7TlhyRm6NLtUIHlkyZ2CRhDDjaTQmiuUjuYm0SMXTDLa07CCXfLyJTJ8EcmhDwSK0r/ds5xyJIpBztnicqGNwrOi9G2r6iQdgAd/TRCJ1QT8/tnkxhuKAKnjEb4PcgphE0jBzHi9DurmTTSOBM0FPhPsrNCZuVs7/FS8TCwSVbkQoJX6xz1ihaNALP5sTSC3EDmGIjxfkXCseWUiv9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVm17g7uRevK5sYQoI5+K/wE4ULpyAFhfUnYx0zKro4=;
 b=pddG+D9E3cJDmKT+XQv7FQ7siC/sxns3VHPMZii60s0BGAmZX+P7A3a8Ec0MxncXeu4fBzdomZJynGQU534C5QqMHNvC3LlAbhwiBzK6G2RYQYUYRSmOR5GlIi2360m42PZa1FuG0hn+Cf6NrcKE4IXP8d6brh8Muitm+aLZ6io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 4/6] phy: cadence: salvo: add .set_mode API
Date:   Wed, 17 May 2023 12:16:44 -0400
Message-Id: <20230517161646.3418250-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5d3c4282-611e-446f-1e31-08db56f23197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nXpxxbrCPSb8jYD+3QJQa+6KkyJJOk6dMdvj1bP4K2o0J5Codbo9MjUBAx274Tt6zGs+/jjyIzgmJ/i6M7K0bLTnXj86Gq/A6C03Ql8XkpT0kZBvJIR7GVTHhKnEFg6R8MeK35hLEiU831hrwH3ZLWb/AkjxIWyodUTmNBLIJuVAKjrdJFxTjXR3MIl+fIpuKOjgaQAFycpZUiTwlXD2sbt7pHda4h9JUvwnyun+Gd+O7jXN/w3JN69Qjk9fNDxtdYc8Oh6mQKGFdXPZiVBdWM6akc12zlzgTjsg7jKPI5KfG9RpnwJ9tlLYRambP2meaFDadNKwArd98TGXoIFtCGUR8O8Jz21ITaXTP//whrWI8FpBImBdxqYYGdW9K6fNzOwmCStstWdznoqDLpBTdX+iGSaG71vEEyH6zljELpgEcrpjffXPIxM7dNwOFltDuH1DQM7GzM9OHR4/w4YFRmSyngSFMjl7rFjk7I8P97/GL7EcZocAJeWMZJn9lDqkctGgM02xxn99VBEgbjYTXKKUmbzApudwiY3HCzSJMUJEfBOlcxTrrUoO3WCeVhQFtZhGkcmoSKJhx9PChv+5E8a9xNQVB7fPwxDjBgnH6qICtvN0c4p+S83G5EkKbSV62QRH3BYX7U5MyUqu4xquw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(36756003)(38350700002)(38100700002)(86362001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0voyrvW7DhPOtKJ4SmCzN4/nqWu+TPVtBVFnSmy4c3lVyME/z+UVyPoNGXf?=
 =?us-ascii?Q?zBiVDr1D8aSNr6dzY5YL0WWM/COFf7NwX2SIg8LO8SO9FERvQMQj7iTsj8A/?=
 =?us-ascii?Q?SP28gaJ6BPhsr0cZ5WigX1YAcCA6APGweyOQlhMqo3/gS9ZbAHykN1iI5IND?=
 =?us-ascii?Q?GgA0f+E6N2m37+U7Sk8l6Aqmt+yxqf2vfsZ8g/Ctkp9Tpd+YcW8KbZehuU9N?=
 =?us-ascii?Q?De5DLH9qfFQMMlaFs2n9iwFtymYmo7o/BMRgaa+jDbzYL+vY5fgGg8BLzRx1?=
 =?us-ascii?Q?lfTIb1YOHolvcNrmalFeLN37BxZTCz/5bKJL8hYzttlT+DNsr6BMpJ58SMY6?=
 =?us-ascii?Q?rMoDGtIn7ebV0heLjIWWRBtyRnNkG9sy7u3aBZGFc9Q9sZhZXappiRiesnx0?=
 =?us-ascii?Q?dKneWE15nBifRhTiHGDKiboEvMcT14jMfM3A54Wuq4mQJMJnYE4SXhOmjZUS?=
 =?us-ascii?Q?NFAVIqJorLs0+RBepBNUqcZoKRkaRKzeaqHeWoafhVS55imVh0oOJm4vKdBz?=
 =?us-ascii?Q?cOhOStRBJV4jl6pQRav16w9OWuAAKul38kzLa1aEX72IfudCePWslYeUwCrc?=
 =?us-ascii?Q?/ymNR6GslKAJscI8JLhrA87nPNiSmWtGmax3FWPRUfTdwETHcfY3XuzwEfUF?=
 =?us-ascii?Q?JSeWHOiBG2GtK0mpZXFHDHZXpUc0BV9ybrZ4d+2hDAn5TsUiknNi7KLEBsyg?=
 =?us-ascii?Q?UtjrRbGVzyUL4X/g0xlSDhZeRzw1SjYSXIU/CFAAfvrWyaHGbmPfTdPJt17h?=
 =?us-ascii?Q?/yvJWMZfqLJ2OsQ8JSbWt11ACw4V3o9dYNhdlVep6qfk641lwNPjSDyCoaeC?=
 =?us-ascii?Q?jnzzA17G6Sb1W0N1q3izFyRJ3jP5ybc7PkhUaEwjxSih+pZi6+DAqaU+g9ZU?=
 =?us-ascii?Q?8Pdt6zszgqocw5Mt+iW2bj8Xl5woIg9nY8GojDeqJyp4y2y454+GEWIJ4nek?=
 =?us-ascii?Q?SaSkWfp2jymaiI9Zcc7xyccP1E4n8ZyNu0vcCxq8BidF/66KPaXSKTzYp6jf?=
 =?us-ascii?Q?FuzUwImMCAM8X3KzucRENgBsFqguUMu/K+pQv+mLK0Hc6LBu6qfw0OzLn/bY?=
 =?us-ascii?Q?eQ0QnkEA7Q4r0E0i8wVW73STq0PWVhzCCG8enARmWfhvjNUxc86pHYMn6eMc?=
 =?us-ascii?Q?Ee7zLxcZQNPQjwyfUY1ip17HW/zrj7uOFPm5cJNzUy85v6Y5VpfhlIwlQS6n?=
 =?us-ascii?Q?XCGozxKB0JAbumK/CvqyXh+Z/5LMdKOqNzEbrvljML5g1YpjR0FzzOcKI2AR?=
 =?us-ascii?Q?pSd9smvj29G0E85T8rG3OQ3Sq3D+S4G2ic2350CeA4t1G2+ewfAICHF+x7pl?=
 =?us-ascii?Q?aQxgpKBXddaIshRc1jc8nQV31j82jE4E7WWvzDJOPrQgTCDiweC1nafP3LIp?=
 =?us-ascii?Q?IU0ofY/f3FUqN8NWGA7s9MXWf+1DVMUrqkbYyNnTczP18+ECM8PsokRR83z9?=
 =?us-ascii?Q?39R/1m4ft+l87FnIjsfITZAh1i+Ld+JkQKF7LVRAEmj180AeKXFHRpT7KRpL?=
 =?us-ascii?Q?Cj3qQidfhrPJZ8mJ05badMFZ7edpyz0WxrK0ebV5uiykGjwSFKfxvEgP/d1V?=
 =?us-ascii?Q?V6pvOSBI8OPC82DktPI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3c4282-611e-446f-1e31-08db56f23197
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:21.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCAMZtbsDM0nFNgHls9PU8FiIaHxq64t+J7ZqrDkhAodZZBbob/xPO1GKjh1je9TefMXp4NZ/M2zkaaYUWr5Kg==
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

For NXP platform design, the PHY can't know VBUS well, it causes the FSM
in controller seeing the disconnection at L1 use case. With .set_mode API
introduced, the controller driver could force PHY seeing B Session VALID
when it is at the device mode (VBUS is there), and keep FSM working well.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 5633fd21ae7d..083de7190819 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -92,6 +92,7 @@
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
 #define UTMI_AFE_RX_REG5			0x12
+#define UTMI_AFE_BC_REG4			0x29
 
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
@@ -105,6 +106,9 @@
 /* 0us, txvalid is ready just after HS/FS transmitters have powered up */
 #define TXVALID_GATE_THRESHOLD_HS_0US		(BIT(4) | BIT(5))
 
+#define SET_B_SESSION_VALID			(BIT(6) | BIT(5))
+#define CLR_B_SESSION_VALID			(BIT(6))
+
 struct cdns_reg_pairs {
 	u16 val;
 	u32 off;
@@ -124,6 +128,13 @@ struct cdns_salvo_phy {
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
+static const struct cdns_salvo_data cdns_nxp_salvo_data;
+
+static bool cdns_is_nxp_phy(struct cdns_salvo_phy *salvo_phy)
+{
+	return salvo_phy->data == &cdns_nxp_salvo_data;
+}
+
 static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 offset, u32 reg)
 {
 	return (u16)readl(salvo_phy->base + offset +
@@ -272,11 +283,29 @@ static int cdns_salvo_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int cdns_salvo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct cdns_salvo_phy *salvo_phy = phy_get_drvdata(phy);
+
+	if (!cdns_is_nxp_phy(salvo_phy))
+		return 0;
+
+	if (mode == PHY_MODE_USB_DEVICE)
+		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
+			 SET_B_SESSION_VALID);
+	else
+		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
+			 CLR_B_SESSION_VALID);
+
+	return 0;
+}
+
 static const struct phy_ops cdns_salvo_phy_ops = {
 	.init		= cdns_salvo_phy_init,
 	.power_on	= cdns_salvo_phy_power_on,
 	.power_off	= cdns_salvo_phy_power_off,
 	.owner		= THIS_MODULE,
+	.set_mode	= cdns_salvo_set_mode,
 };
 
 static int cdns_salvo_phy_probe(struct platform_device *pdev)
-- 
2.34.1

