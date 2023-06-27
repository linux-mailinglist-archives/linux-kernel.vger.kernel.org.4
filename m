Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F273F56B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjF0HVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjF0HVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:04 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F226A3;
        Tue, 27 Jun 2023 00:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqJoi9IRwBKPsUCMMDMGQOjTmowTr63wnohBODtc3rqeiG11wXRZXS+rl042Td3c13EbHlsKYMmccjNrrSuGT9JjnAyBNvuC6/9D1fNjEtgo2lT9wvAxOT/rsJsQPNY4+hL4rlhSMZjXjlROqUdEHCLuw1ThMeXMMwYiqvfoqKLoRB7cXX0J0rAihokxQxyH5ZHdUwTSkWaNirCQjABeFEFID/nYbZPY7e+2zL2F0ww6dEroGp+PwR9LrGMol6f48Y9uwmZjLv6r968EMTfjX1vSg/cSqDUIHJOqEAO3QwjAh1twX/G+82UWV++CqcZ2+k8npHGNQ1lYnQXQYYYahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jadCoVrujpc89wNC44EvqDY1NodWAxzqixSXEHnIiQ=;
 b=fyijb/lHYBKS4vqKdHFM1zsWOVxGr0kZuN2Og2CagwIT0nwg4MMmpS7yxIomGMvnHAi5Qh7NWQ0rg8WZwXeQxaj6pBkERZd9O9g4oSoAffY4Lr+1w9uygP4yOxdA0gr5s7LXmmmzh7mizrtFBq9IkVAwu8ndsWfJbAaEGg4GJUK0V6Un0RYJpRMbIFICSCRE7VDF6FDNp3WCOf6J6KWF4QPJUc3R7shloKE7SNFJP8wT7vjzs9fw66h4RInmIY0RWEqcXfaV1DWix7rTlSX4Gu7Ax3LVzaR+QpxCpAkweH1lbB24c49yrm4JSyGoKPmgNNJTJMj5GrVJcncKAizAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jadCoVrujpc89wNC44EvqDY1NodWAxzqixSXEHnIiQ=;
 b=SDgG+vaAfpZumVd+OjMLaMe9DBN8C0KnI5P2++ALB8XyTlfbv3RZiIc3spFh/Zu4IsvkOYKPkEj/B5Da2w8IwwsRHmGoGI5JnNK9zVhXds9ZItajmPFrxvaRjKy4l+BIyDHoM6zepPzlqcnCJRLhqKLtzj4wCldIvbj4vrm9a9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:05 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:05 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 12/12] net: phy: nxp-c45-tja11xx: reset PCS if the link goes down
Date:   Tue, 27 Jun 2023 10:18:53 +0300
Message-Id: <20230627071853.106215-13-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: d8663b40-14c1-46e1-e2f3-08db76deedfe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrIGaHrWANnyQYNSS+en4LNyNOJj2CCtAaOZxxKcmLM+NyEBiRNxywfpHx6UPb5P8ePtbyeiwjSMiXyFnLMPI0KnVRXbK6e+tJwd3eotRYv6roiEKOLdb33oMhKU5XNHVX9G62GNcl+ArZtXkzUrgDskv2g/nntPaOPIyrm3PYCMkc5UgkdEQRqMNMhMDVci2TsKLk09BRq0mxWLIj7X/jERZGRkcHbZrDkHrCh72NdXYnNCikOBmPGyuU6T6W5bKkkEBFGEnfeJ+FxUO92//0EJAcDSZRdGbyQDnHOLE3qxCI+7pFKQ5gU1eWdzQIHQSz7DGO3i2eQWgsTgR1GQTXt65F4PRH95t5swSiVYElHBVq5ou5v0sr+l2rOHWyqetl7FxkaEe5nuf60pL7N3KqckCpIpsiLADXsvmIx3lbw01zoQ8f+MyI3asamTJhhTxjwc93DPUKIfU8eHJTOReL9GpFBHqvurjrYqPnHkMSiGIj3KY1A3x+Qjp3fyomSAvROJegW4pwdc7pPcpCGzjjX/ie9xscj6EFU3bQhEuAQYeYo+D3Qyjn8UbiKZkgaLCqoWGjrgz6vBBKOsAGPda/icPWs3KlCqdWxG296qgTQLeii2b9y/XgBv+Cz3GXcO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(38100700002)(38350700002)(83380400001)(86362001)(478600001)(2616005)(6666004)(52116002)(6486002)(66476007)(66556008)(66946007)(4326008)(316002)(8676002)(8936002)(41300700001)(6512007)(26005)(6506007)(186003)(1076003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZ5N69IUOpX1afnGzbyWfeiLqK/gFTVplan64lDrDxjGP4NdedJI3E76ZjK5?=
 =?us-ascii?Q?XRK+EgoN04CnKWiabJPz/StV+/LnLb6I1TvpMjxJ+7NKuZe6ttogKFKNAIlH?=
 =?us-ascii?Q?lahN3yQitkubxbNnuFXMT4N09vWA8jKOjS7BGV4A0PQlkUJivm5/O1l22TGj?=
 =?us-ascii?Q?T/7Bj+ERDxf2+SQTME6DjP08pXBy5mJJyTnmRXDcRaGhvd8Xj44qS1vvuEgU?=
 =?us-ascii?Q?/+YqKFIDc0AySzsdwccHkx+XDWeJE4ZK08U7mvxsoJFyxcwclB2ScyKAx7VA?=
 =?us-ascii?Q?WvHZF0N1+a4320HuKEdO5mtCqywv0tz2e7vAq7zG8wDWvd63mdq1F4Mstr5i?=
 =?us-ascii?Q?E6r8+X/DPhkCt+ZSD1+rsnqyGJpCUPuQugrOkhhFAuW69pxcmBcQ0KhZhCUY?=
 =?us-ascii?Q?zVK1Wo/cKVf1l4nPwW1KJIZsq7RG/GVEmQaAM+57+FmkJc2AZfg1daRhpCrJ?=
 =?us-ascii?Q?RtB44TsDvOtP80p4sVIsdN2nNKNuif3GTe+cz/zU86KuhnR3NfOjoUnzQjhG?=
 =?us-ascii?Q?4lf7+/2BwXaIaCWto/hxQzTysvm5w7kfIveecV042q+Uugi7gXibGkhu59cs?=
 =?us-ascii?Q?YL5TUbr49kxJIjB+LuQzAYCzZg0UbJ8VFTkoyYoUWka7HzY0hdTBing8k15W?=
 =?us-ascii?Q?FU4Gea+Gh4vrD1LQx1SLuP+CSV+SYVjNhEXsGk69LpgUCkAve2oBPGppeDQY?=
 =?us-ascii?Q?eKnwuw6nafaMHEEIHjphtiauiruB0Lql7HF12NCzjz0hyQolpLOIt+9XJlnF?=
 =?us-ascii?Q?fPOrlVSST9TJk2B+av7rauYemIQUe+4zI5g/rz9QD7p+WnkXZjzEiw3Tn5gn?=
 =?us-ascii?Q?XAnoP7hPMeI1MFxm5olk03PdTP3hVuMrcYYVr0emByfjp6P4SwZM5pGbrLPV?=
 =?us-ascii?Q?qGRK+lkv+mKEo1tcCS5hTsTUOH1WTawP/pYBj0JG2X3vlhLHPg71fn2FXMJO?=
 =?us-ascii?Q?KLEukg8urGVpKEYCkgROk+/6m5OtS/d2if3xGqnqq3yMGUDivn3hnddiuwWK?=
 =?us-ascii?Q?8/cA3KSOs2jsJ7I9r9PompUg5tnpR9Ki2HoDt2dC36FwjkgUTV1JBYZD1m6R?=
 =?us-ascii?Q?ATT7n08+AhZG+FN63KCvj2TePn63Lyk/3KUAxUElP39+LnFhOtEC+v8M1Rzx?=
 =?us-ascii?Q?4bs3TzIj0lQxnPsapPN6h9vD2+aIag47O99DgnLwEK+Y+yTBxmhHbbQo8R2Y?=
 =?us-ascii?Q?nnuMb9gMdPTnLNusUlTeTCT9FBkFKwXKC3sHmaNFPwo+vFAgpnWfcTeCcmOo?=
 =?us-ascii?Q?PkUgoVyfKqZXFssMAIhLLwrufEmWLuEoKgsS9nMKSgsAwLxYQLgVRholBVBy?=
 =?us-ascii?Q?kgwVA9/Q5oKaMY+Qg1yWVl+V/nnFOB/ohgbxa6EchUC551ZsiF2ejcxZURDt?=
 =?us-ascii?Q?XZ3F6dOjcZeGacj8j/g4CUPxA3wsm75f3rdWfgoZewKwGJwu5sxlqChk1eel?=
 =?us-ascii?Q?DuIj0ryvz74ArVhj51CXSs0QwBHS540bvRE+k9T85+CvKdP/s4CXcrQqMMB4?=
 =?us-ascii?Q?FqtIYIog9QF3q9lHAsDKpMfrgvAHfAhLbAOi2xxeNtA25JoZhRkU8QfaMTjV?=
 =?us-ascii?Q?qGQcKIlJJ8iTaLd+XMU78Szw6nGvTt9anpGP2AHa2834kkURbIS/1e5LGVQZ?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8663b40-14c1-46e1-e2f3-08db76deedfe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:05.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bld1TNizT/DNsxlx8MDtzcufwPI8oiA2C6AvDezTx1anMwKZl1Gb0Ncy/s2idNzcfwrL8wD7YwhgIsDcIQl9HEaBC4o0x2zAisNrbCwPmf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PTP testing on early TJA1120 engineering samples I observed that
if the link is lost and recovered, the tx timestamps will be randomly
lost. To avoid this HW issue, the PCS should be reseted.

Resetting the PCS will break the link and we should reset the PCS on
LINK UP -> LINK DOWN transition, otherwise we will trigger and infinite
loop of LINK UP -> LINK DOWN events.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index c21c6aefc705..af3951e76a47 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -56,6 +56,9 @@
 #define VEND1_PHY_CONFIG		0x8108
 #define PHY_CONFIG_AUTO			BIT(0)
 
+#define TJA1120_EPHY_RESETS		0x810A
+#define EPHY_PCS_RESET			BIT(3)
+
 #define VEND1_SIGNAL_QUALITY		0x8320
 #define SQI_VALID			BIT(14)
 #define SQI_MASK			GENMASK(2, 0)
@@ -1371,6 +1374,19 @@ static int nxp_c45_get_sqi(struct phy_device *phydev)
 	return reg;
 }
 
+static void tja1120_link_change_notify(struct phy_device *phydev)
+{
+	/* Bug workaround for TJA1120 enegineering samples: fix egress
+	 * timestamps lost after link recovery.
+	 */
+	if (phydev->state == PHY_NOLINK) {
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+	}
+}
+
 static int nxp_c45_get_sqi_max(struct phy_device *phydev)
 {
 	return MAX_SQI;
@@ -1932,6 +1948,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
+		.link_change_notify	= tja1120_link_change_notify,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

