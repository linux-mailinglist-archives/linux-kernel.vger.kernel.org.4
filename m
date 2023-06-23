Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1373B1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFWHnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFWHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:43:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0C2957;
        Fri, 23 Jun 2023 00:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJhVrSYzaHfA96/i7kDBDxhmANcXP1N6YaKoAt6kko+vlPauzLm2xnjf0FkqEPpMLwImBvHjzOq7I1zU9/YO4c5KzJKjf1KRWukXFUQ78uGUna2ovymOHjFpVvgIfOUtBTCYFO97lgzQGDS/FV1s9T4TA+FQR9CRaCTgiFSiL5NkrSKewF3cMWmwFF5vBBL8rAnTACKn+98dcIEaSS4+0MwphZZewL63Jof/X7kdcUn4xsu3jXdhbArsqvMfdaKF+FzncTM6LaGxOe4ttuH8Xd7FhbKEHAl2zH1N2aTxU5kGyuqY5MLxhEPqJoven5Hr4UiYaYQLfegbAMYAhJzTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=jw/qDvIcYyb9zQ9dp31QKoLPfcGJYbmj9+10IpR/e2DvrrYhx7ryNzTzvgb7f9ZJKKm7AjU4+7DlH5Q8shbBH6DTHHIr47sagR+btVUutX3hWzxM69INS9xDdqSB+VjImW1TK0grJ1vDrMJFwvxkNlYKu5Lyc335q2wBadSXVV+DsIVbqE8XX9pyFlYbkuWaF3E6P4JdwTO5frhzrVyWQqDpfnAfWEjJCl6JqG36pzUViTSxMg+Rh5XlxnVqwvkYCuOuYrRK7xoN43Nas9dSRFP+PRz9KEJpM+j+rVdAc8iqJb2Ta17suqJpjHkDqJ5vG/+ezbpUIj5KtUBqWZLVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=Sm9MfLXgt4rww8Kt01sdF2v2TnNTdxlRJeSotQrJxSj3x6ltd+cZNuPUcqt5OSJHTvezIbxm1wEB5Zz9hfu1hIeWhcflDBW5jYgVd7KfwZwoP9gOttlc6PI5zTgC0O2ZA+QMYrYyrGZivdzWrhD/+nNwytRThzvt9JBlHGV7GBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 12/13] net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
Date:   Fri, 23 Jun 2023 10:41:22 +0300
Message-Id: <20230623074123.152931-13-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b118e9-431e-4d8d-acfb-08db73bd4e02
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7HtIr0dCUNcYSB8nHJxlmBuKWikWs8SjdQNNgJeq2U+jsqNA1bTc63QsuQt4v3Xkvbhlo7Jg1P/7UbigkdK+MdJNggCE9GX3Q3LGgZQ/uo9JFyg2yDobaVnKttIEj+lebMoFbWZmQDAhLORUKdmXNvPiewk8yWHUzPgpyKQBIDlKnVc1VCxTgb5wgsOzM03uedy7BSM/a1oTvzHWCqMHsF5wiP10OTPXY/BDw/GV/AdKoertPODcevj3jLni3OkTBiwpO/DhlPSNlQ1Ue3JKYG/pjj++lV6i8uPLyma2/YWZ9ZsizN56vurvyDEdNGb50jW/3tCZdP6+JVxc8ziwF8lh4Q0EDNfY47GCojUdVOjFvAsM0q+Km0XbSn9ER5yArD2XJ6my/QErYxzzQJbjKCq2R7q1HL8akxUrQC7HsY296QtdodclgXAghJh57/FDVdQawojJ+RAWUoXCEMz3mGzE2Ev2/aAmW2l1ae0u7GhxyHBDZyawge4A0RzgnIB3bf+uVzNzWX2ZXoqYffX9wn6tTYnD9oB6quVb8+gPf7MeGXJT62BZRfSnyIyTM0tN3HR8DkZv6UQjzJK9hyAEytOuwOY8wTGPut5VKQ/aZ9Q1dribyaeBX15prt+IQtU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQr8ZZ0t7efjyfNhWxgdinIsth/PMeqc8erqre7pehLP8Xo2le9h+RV2QkVf?=
 =?us-ascii?Q?YxTw5Z5hYQGkqStz9gViEqDaygJh3uBLJftx8NhgQhgxQI6t6DUiX73elmut?=
 =?us-ascii?Q?1fS+OqhE0Ag4Mzjn0E4wRx2WKM4uqKTExpZ/dpdmPB+j24Y0DNQj3p2wNppp?=
 =?us-ascii?Q?47dI8Ft/cdY0Dkh6l1xIDrUxro12xhuD3Ith8CAxXGlAgrOSO3LOmLUhYXWF?=
 =?us-ascii?Q?wQKyio2Lahl4nSw6k1MxNGnAwQSlBH0/6tXQl5nQ/wcD5J07uFkWtiQWO3Su?=
 =?us-ascii?Q?VUeU+BGy5c1VEs9kwbFv5WHfZaVhp3kfn7DYWHNtJ24USnoqRVkJES0h3DnA?=
 =?us-ascii?Q?lfkZB5y7UqrSF8BtrwanpWkXWceETlGdOZChoOQ8oYN+m9Zq7qmuY1z5iGY8?=
 =?us-ascii?Q?zmVLnvfRNJhsowfJ5lCC/tkhh8EDojDeK//OczDeLC/vkTDL9vslAEM1YiXV?=
 =?us-ascii?Q?Et4KEEDBzdJCdqbDhSsOIYK/NCxvs7Rw6vYldl1incqlqWqjmNKs2ZTHq/qb?=
 =?us-ascii?Q?eSA9m1hSV6tkcl2eCDMMRbvu4Vo6DsUJblQNvnkXqzda+L4DXvWHMUun6S5i?=
 =?us-ascii?Q?j8/B3Req8KQv4WzvoyQMQPDtpYBDzNjuKgXLEU3G14r7K4pYfmPmFIJCWDtM?=
 =?us-ascii?Q?z/jIueIZd+wjgClhN14Z46V2R6KQjqVw/D6hfNGh15cfZHCf7Tk98rqvwtth?=
 =?us-ascii?Q?170zOe3Wh7VIn5hw+kV0gRGTMIL2bmr3SYgiPENxjzKo8+6zLCpxA2WqPg6k?=
 =?us-ascii?Q?pgi42r2Fz5npo+FRg5RvIqtrsY5i+1+VywQ+l7+LC/OFKrIMTqaN9KMyMhkb?=
 =?us-ascii?Q?ogRYE0EhT/QN96qYj/J9a6jt153SzbZde0x5IhazSyvsGDnwpJqIXWWx5RgC?=
 =?us-ascii?Q?fuYhIJwSnp/005SrlhWPdZnWxhugIDzzzGZ3zcJnIoeW+oPaG7ePj6LYqOtD?=
 =?us-ascii?Q?JaO/AvDlrWSJBdkUZtt96Q97TUNNMM0K9PL7ZEPuEQt8xHLCdADUm9+6sVEN?=
 =?us-ascii?Q?ASbAiDzAb5lAahIEN3Th2KII5g5i4N704u0zPQE7vNWaX7gPiZO/yzX3MpGN?=
 =?us-ascii?Q?eXqfvOs3IRy7JLFhm4FrpL72rYj+OjtMMz2WabGvr8jL2rkT5KAtYgOQayOF?=
 =?us-ascii?Q?t7UBolZu9df4IUMfzN4ptsfJlEylGl2wL7GHBkvaVnlN/FUpf3TssjCWZ0va?=
 =?us-ascii?Q?gp/sNwZii7AFQY+0msLVMGnU3+ShANdq3ntBN15c/iXPgzh4ID3uEzEvUT5M?=
 =?us-ascii?Q?D/0k8KvXjiE5FJcr1YSvLXLiESQOTOkZewD15jdS5ox1Kv8aD15n9hqMxkrD?=
 =?us-ascii?Q?ZXcB6VJA90Q2Fian+kpyYS55wy/S/GrjD6xYrowZhww0o3aTa17vj9+pJO8o?=
 =?us-ascii?Q?wv1zLLc+54N1KxUeB/OLIM2j+XRBD+hkTBDmACD5/T621ttB8pX8cBCopF6y?=
 =?us-ascii?Q?XjGABLh3vEV4SEbJh6i+ebvK8VcSVN25+3ihNB/2t8PEpqTzgbe186wzd+/W?=
 =?us-ascii?Q?Dn7efc8gCevLOQpTsqMQkYXoLNYnqSl1dBmJ2PkSgCMJ5DrywBPIXVjT5c/l?=
 =?us-ascii?Q?FwG+Cffkajy7/OEPm9ov0rWW5FYuAdlgWpVv20e8sarWykfZ29TI7daMNf7y?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b118e9-431e-4d8d-acfb-08db73bd4e02
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:49.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re8ShPbB/SKg9PP3z7TiWxYHrIprgtqvu4Z9ZPX73em07c9GRHLx3O1OCZfzCYRuEx/1mZBF1hqtbqLNWid+JbY0GiXLRsqCi5joPp/Qqbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TJA1120, the external trigger timestamp now has a VALID bit. This
changes the logic and we can't use the TJA1103 procedure.

For TJA1103, we can always read a valid timestamp from the registers,
compare the new timestamp with the old timestamp and, if they are not the
same, an event occurred. This logic cannot be applied for TJA1120 because
the timestamp is 0 if the VALID bit is not set.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 64 ++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 8097ac8d6962..c21c6aefc705 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -34,6 +34,8 @@
 #define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
 #define TJA1120_DEV_BOOT_DONE		BIT(1)
 
+#define TJA1120_VEND1_PTP_TRIG_DATA_S	0x1070
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -269,6 +271,7 @@ struct nxp_c45_phy_data {
 	void (*counters_enable)(struct phy_device *phydev);
 	bool (*get_egressts)(struct nxp_c45_phy *priv,
 			     struct nxp_c45_hwts *hwts);
+	bool (*get_extts)(struct nxp_c45_phy *priv, struct timespec64 *extts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
 	void (*nmi_handler)(struct phy_device *phydev,
@@ -509,7 +512,7 @@ static bool nxp_c45_match_ts(struct ptp_header *header,
 	       header->domain_number  == hwts->domain_number;
 }
 
-static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
+static bool nxp_c45_get_extts(struct nxp_c45_phy *priv,
 			      struct timespec64 *extts)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
@@ -524,6 +527,53 @@ static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 				      regmap->vend1_ext_trg_data_3) << 16;
 	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
 		      regmap->vend1_ext_trg_ctrl, RING_DONE);
+
+	return true;
+}
+
+static bool tja1120_extts_is_valid(struct phy_device *phydev)
+{
+	bool valid;
+	int reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_VEND1_PTP_TRIG_DATA_S);
+	valid = !!(reg & TJA1120_TS_VALID);
+
+	return valid;
+}
+
+static bool tja1120_get_extts(struct nxp_c45_phy *priv,
+			      struct timespec64 *extts)
+{
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+	struct phy_device *phydev = priv->phydev;
+	bool more_ts;
+	bool valid;
+	u16 reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   regmap->vend1_ext_trg_ctrl);
+	more_ts = !!(reg & TJA1120_MORE_TS);
+
+	valid = tja1120_extts_is_valid(phydev);
+	if (!valid) {
+		if (!more_ts)
+			goto tja1120_get_extts_out;
+
+		/* Bug workaround for TJA1120 engineering samples: move the new
+		 * timestamp from the FIFO to the buffer.
+		 */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      regmap->vend1_ext_trg_ctrl, RING_DONE);
+		valid = tja1120_extts_is_valid(phydev);
+		if (!valid)
+			goto tja1120_get_extts_out;
+	}
+
+	nxp_c45_get_extts(priv, extts);
+tja1120_get_extts_out:
+	return valid;
 }
 
 static void nxp_c45_read_egress_ts(struct nxp_c45_phy *priv,
@@ -656,12 +706,12 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	bool reschedule = false;
 	struct timespec64 ts;
 	struct sk_buff *skb;
-	bool txts_valid;
+	bool ts_valid;
 	u32 ts_raw;
 
 	while (!skb_queue_empty_lockless(&priv->tx_queue) && poll_txts) {
-		txts_valid = data->get_egressts(priv, &hwts);
-		if (unlikely(!txts_valid)) {
+		ts_valid = data->get_egressts(priv, &hwts);
+		if (unlikely(!ts_valid)) {
 			/* Still more skbs in the queue */
 			reschedule = true;
 			break;
@@ -683,8 +733,8 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	}
 
 	if (priv->extts) {
-		nxp_c45_get_extts(priv, &ts);
-		if (timespec64_compare(&ts, &priv->extts_ts) != 0) {
+		ts_valid = data->get_extts(priv, &ts);
+		if (ts_valid && timespec64_compare(&ts, &priv->extts_ts) != 0) {
 			priv->extts_ts = ts;
 			event.index = priv->extts_index;
 			event.type = PTP_CLOCK_EXTTS;
@@ -1724,6 +1774,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ack_ptp_irq = false,
 	.counters_enable = tja1103_counters_enable,
 	.get_egressts = nxp_c45_get_hwtxts,
+	.get_extts = nxp_c45_get_extts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
 	.nmi_handler = tja1103_nmi_handler,
@@ -1838,6 +1889,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.ack_ptp_irq = true,
 	.counters_enable = tja1120_counters_enable,
 	.get_egressts = tja1120_get_hwtxts,
+	.get_extts = tja1120_get_extts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
 	.nmi_handler = tja1120_nmi_handler,
-- 
2.34.1

