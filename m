Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF45629415
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiKOJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKOJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:15:53 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DB71FFBA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5g2upwP1M0uZ0O1SicC/UREzuQy+kAS4/+CAMX9il9LQbeeok9I8N5LcYWfXHSxpckpe2mTKEWBqC8F8BE4pCwgMt0MFmLUFy8I8tEYJBKkK8XrYy1iZbMB5rC/FhJrTTdGPC5foel4mUonCqkB+2QaxTkS9i/0hKPLCeh3R6EMaeY3/vHI8a7B4anBLyU6uyBY9nXKauCaUPhtbvrp+N0hu7KEbpo68GB2gf1NAsJSGDsvp4gn+7CISX2JdTUxSZijfVo3cvX0eYAIjgIHkJqGYdUHIzErdDw7ZyJh+T7B3a31EC5nTMGX1RPkh51PxmeKj9pLWzaGkYpts6woNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=By3wlw0Lktwx3ubKHBQ5hxZv3f+1obx7BwLbO12cGAs1Yu+pEbsIgmAcyOSzyVrg3rHeWmIZ9wDEGweYq3pW0uAXBglthlcHPYEehIyLuSn5fvuzGVZtqZhfwVCiep15ozkoxDDkS9ZSCEOeUVP45L28xoocbB1r/luWH2V4Ruaw4FsAFWEuXjdj6Nof6vyQYyT9gD/68r6EyY4OHN7ENRxvhe4pJdmXBuGEoakARZwQmCg78mlHE5Z0yOcB6N5EVB1KJFM400+eWUwBCrlVQhDJg4sZsbXqpsRdU8ey3z08E7h9ygS3dgsnJl9bDJp46tgc1eMM36woZIIao0PD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=a3+9l47bMpUjm+64OBApyskg7Ab+uanldlEWr9CnRKW7VFHjbjP+KQKmbLm2VBRw70CxDZ/EoLEQ5SWAVIZs1hMlF2G8bVRRfHAvOf5MZ2ohS+YEmdXgmIW0WWmYmOdfISHQM+cHVmtkXIq+LNCSchssCSIWIi0PSoE7sFTUNWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:15:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:15:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 02/12] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Tue, 15 Nov 2022 17:16:59 +0800
Message-Id: <20221115091709.2865997-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad3011b-0360-4295-3c7e-08dac6e9fc83
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1ilfdWOMGOXvZ3vCthYh9avzi4XTc1nesCCvIsfdnrzf44kmDTulovp7Ri/2h6LJeI9Y8jIKP+Yb6O9IbTt1Tlxftj+a8//EvzE06F2GKYIDGkE920z/DzlH/nrDg94pq5lWHMX9FEErb0SU+sp7EYiUU1G4WrmhxmZyUIkI+MgSuj3ONsweDVJffMPRmZbojed5rupUdP+Sc+lYJWMPxpvn5wMxyLXdxcooNwhF9oY6GCGnP1HMjT4ZWNRd+eJkVilHOf3WdWUAp5LF3P+6iu1j+nx7HU9FADJZFbcRUZYkjpOF9DAyUrEWQ4ctCcXk9ex7nZhY0Rx7MQA6qj8ruPWyLCv8gzuGK67qvnzmHTX1U8vVFe6GNjfjODqWPkCeaA6KBvwRlrONY06tx7ETvlMmLNh5fk7VUfKgRevmNUTFVAfiBp/oxfxewQ0wUOQajNUKA8tC4Emk21STyQS5NuwkFoPLjMgz8WH8iRIjZrhsC73kzKKTR5jvewzzg3u1cDhTNcLYtCTBPbwdoxRgmBysmTi4JnJdZWA3pOhPxGyacTRSZv0iTBKOC1BFvWZfLSz5h1ri1N4jBYm/AFdJtWv+BWvy/UjUMokRZjUgjpRsYQkk9duPMK/EV+AYaLC1G35Umx9Q0Kc75EKR5QtVwb6wHrjgQ6ARAwrmqc6wYsem6+c0n5W3+8kkR25jYCKD1l0IzdYdsc3B/FlE652jjM+9UI1JHCM+Sw/6Mbpx7EK4Lr6NkY3H4bQMrbP+EZ4imXChWYJxZu0gxJ1GXj45O7DvW2WJOEKi+YDZVM6qDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(6666004)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOw8gUoAARquBKM/P5MqJdVZXeb+RvzMmaVdjaEgKtZeFTZVEGoy7WRgp7uh?=
 =?us-ascii?Q?Am9Q9QposSu8aW+PylC3X4p56BOA5LB6+vZzptdDZ43Ku5p2Gauvea5+tPlF?=
 =?us-ascii?Q?O2016JoCrt+GuFJJBRdx9GsK+EPSxhupsA1mCOd3/Tkgkv35yUb2n6Q412BS?=
 =?us-ascii?Q?duZNyF0WBexVVfra9acyqPLb5nbXj6un8oqFd9oR1/DbSgtqELCb4pN41Fxv?=
 =?us-ascii?Q?cbPcQJgpB5wmHCWD7+DY7DdVT6I8O6iVbz1VtD9JKHFZJK/OzwzZ1ppaxsFf?=
 =?us-ascii?Q?mQHq1kYaKMxNty6vFkWhhy/dxZFWhm9QUV3zSeqBCUjK5p5GMeBY3x0m33ps?=
 =?us-ascii?Q?+C9L+0fsMVcM4nymSpdDz5Z5/jS9ZQfEsWCzPRpdqNEUVgerAZepGgPAXp1n?=
 =?us-ascii?Q?3BTjDKJvpIIn2B/OUwGW2czgxFVnYJ1r9GBXosCyz9B4nI7f6eTWyHYwYSdR?=
 =?us-ascii?Q?LIH/k3ZPtNdCSwhEE+Q5iXbNFup/zP96IVjzdPNmf1CHYdtIVRgooXwqbifP?=
 =?us-ascii?Q?hRDJPqJDqGN0qqkVaV67Ya3hrfUfIT/s3xWBV9KV0GlWMj+3IW+Rlr2kbG5S?=
 =?us-ascii?Q?OcnB0EMk8AiPb8NGedL84UuVD5zIPRvuxFzp4XJ3HWL/M9uvCiZvjmlROn7q?=
 =?us-ascii?Q?2GipCiprdBEdv//5us74UJKN999b8j0uYsKEUoJgnh/VaC9gQclNiKBl/DcZ?=
 =?us-ascii?Q?MOkOGRi6qmo1KNdgZRsbjUGTqH8LP/EexLe/isT+iAvFsVOky314GKmQqUNL?=
 =?us-ascii?Q?/txtgIIYm+Nw9joEZ5cigThZWvQng5Um6OA/CJrZhGwqFqD5sx53b/kMtCKB?=
 =?us-ascii?Q?eaiUWx4CHMbSSePHKJ8RjDHWLp1LGtyartnDoV/hOOtnvQmSp+hZflS3yOKH?=
 =?us-ascii?Q?lEDFpMHvkvEk+FWcrgkMXH5h3OR6RnHz/FEBffl8Ghma0G/yFLV8aspm3Ytu?=
 =?us-ascii?Q?pOoRZJc1nkh00JdlF3VnsdCv8apxFb3ytYG6rmU/OGqSXe6dVqOOhIHoaor/?=
 =?us-ascii?Q?VffBwqtUft1b47QLdDwHIDE7GZk2/urEtfrEvLKV88mhDhfnqQwpMM8KPYX5?=
 =?us-ascii?Q?X/yBO4OcbknABfiimZnNEngQ/WRILk3FsXfO7YPD/wWwF/RFqSiMWI/rkfFN?=
 =?us-ascii?Q?fm3tii18321ukQhtUMhq9CdzJDjxv/sccF4CGHfJA9N1dUjujX7dYUWrqx6m?=
 =?us-ascii?Q?CIZAcqAwYTLFlzW6HVRpXmPYDHB2KMSfiJxej43QkMC/RWWmhN8iBnvzaxF4?=
 =?us-ascii?Q?3gjmQM5pPCDiI54CDMT8TRggD/t+OfhcKnkmo7rhIoskIOhDQoZNyxJsBcaS?=
 =?us-ascii?Q?4HnEyDBqKHZIf5QyaOnVpTHTgLooyRhejFnYaqqam8x1E1Fv3wzVf6K78yRe?=
 =?us-ascii?Q?+YmvoKUWDzFEMZxRuuIjTGxUC9wU8b5nkXPkpL+X0kp2Jc52lqj7r3OfKB9a?=
 =?us-ascii?Q?+5dbzjzoDcK2bVB7aD17km0Uode1AqUbttybPsZJ2wtKhJPPYrwmam8u7UEY?=
 =?us-ascii?Q?7KJ5ef3VvxUe5Cn3XZuD0UvvgqGP89A893nEWlbsBn1HgBrJZaG+F9rVPhi+?=
 =?us-ascii?Q?psVKrPHIUo3Q7ZFFLDrQaL1s0U1nS1pfRFAcnjS4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad3011b-0360-4295-3c7e-08dac6e9fc83
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:15:49.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwLBsp7cX9zfED4poUsNmO1VPmIcrXvmC+bjbWLGlM9ft342RzqUAsPTWMPEnsibdMkbBhn6CO7MIymSMmFLuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
  PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9f1469db554d..b4c1ef2559f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -544,14 +544,14 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 
 	pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
 		>;
 	};
 
 	pinctrl_pcie0_reg: pcie0reggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
 		>;
 	};
 
-- 
2.37.1

