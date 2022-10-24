Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC74609881
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJXDMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJXDMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:33 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E46B145;
        Sun, 23 Oct 2022 20:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syb5Yh0vvL80+RA9l6MNVM5p/wz+LHHypFIhvq69OWQ1zONYRiFsvVXDzmnG9Sl+aTBdL5riSUERjBezFq+XMgt610efMqFrqxr63PzUKWK1EjIHJd9JJBJlywL6kBJssNkJkR0eA+L7Ycqs4gxYjObWc1rHgTqCl0aOdHVuywxx8ysVbLczPbB4ybCbAgVayqabGLygN41q7PAtVLranzLC4E36WLQxDEWeG9oEHoyk9GNUiNRrZDF5G11+GmPqqeOklpK7HgLaYiU7CnA6xlxjE5HpVmalk8xxs216cohb6rL3n97xrvLqUim5eirvPPZ6qripwibnYrSGq9RZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY0Rx4VByFGan/YiKtlgFzqM94uUgJEZrzhUq19v7so=;
 b=OmlcCxkKqbT1JjhLbEhdFaUmQJ8UtYkdtw2NFkH3Uog8vjmkKs8twfTXqzK5G5T0YeLoTpjot9hIMQV3PdbgQrLHqLKYvDF3Jvkrk8kvTO+KAw3pLk1aKZv161R8TpOm0DyP8+WAO7MXFotbRgu8zP1tEyeL7PNMOvnHsaWa4TjprTFuSPId65wouYrkUa5ngd+uTLfeip7WMeLEQPPeKI4eKTnE+DTwuWj3TM3hi4w4AEcubBgyoyvDKk0YdQRt6RTrSN2zhjiO8MecKFLZFOonCh+e/uPNXBqi1HmK27mb52cFcblHicr0tsOa3imAlVGL4P43r2gd6qWGijTHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY0Rx4VByFGan/YiKtlgFzqM94uUgJEZrzhUq19v7so=;
 b=DO4JFfKCAAkjUfTpUv9lmD3yj1TgZR3K1Jc9p+B9RmEca8BP9hKPy3JtQBf4JDKMyEhnLWVusVAxKgvK+vVhPcJu092eoRjuH4ehslimGR68jgvzn9xWxAKBbEifdN4Bl8AnsRA9BJ6xrC1aeL3NaZul1qFOgqnkFbQ74g/Oxl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:29 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 02/15] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Mon, 24 Oct 2022 11:13:38 +0800
Message-Id: <20221024031351.4135651-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8b2b05-79f6-4717-46b8-08dab56d9541
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01WQKFCqIXX2vbW0MJKZbrTuxjRZkgeJdZFzf7KZZllh1pwfFVVj8IZ+vcPChiuYcZQalcFRAtMIVUi7I18xURuIqYWHhQZWkzfH1xwfwVM1zrUXolvWwkJFslVnwfcDL5weXWYRXplamopQKRcOLb712IuoJ7eMH/5X6/X2QoYW+RxgzQdJifTasmfzilGYVpdGQZnwLPUsL6LqsYgrgjrZxM5g2FilqLmQIaqrVI+LlbqW6VzRJbqF45hutLVc2DlwebJjgAn94cbGjHX0jB7LakkrsrOj5XulXCjuXlP2oKXUKEmTyrKz1QxKbWRlFUH3mnyqqzmhI6wPFId9nVDUPiPB6sLOelja+wmTI7pvPhtPlVoGTFXfCkEzgu0/XTuInpXh3whPI+DosV3tLinOi/h2MFTwP7lS4SzeIwPs+CDgz5b8k4Katw9n3LofkEI2PYY+d7ktyeZq9PNp3C9sNZf56Asqf+6brYJlba4spKbXT7qKzApqbaTuz4DPZqFBiDSgNn6yXHTWLa/MYyT9O5VLMttVfL475csGJpZdwiUfAoRZMLsLkrZfqdlkhP3WbWebo4C7NmwHfq9nK/vEW31zLtmXudcNBfJaGtbY3zSJCHZnOXCmQJWjhgVV2wXebCmx+dMih3OeaLPGtfME/XVa/71QTuK18kSDqoS90M71G/vFjWIr4OAsTlBLEGDSw+1TNk98dezatd+BU/XJlSyOrQQGGY5rGniCdyAosjKtV8DboyW+4hXs0PPi7sgDghWRJ9sIEucAvxATM99yklCQF9l7b6f80FH39F0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Si9Zotm6dydV/cCwxwAlfOVRlOiZaHNp+hM2FJg7Xeoei/sM3c3YfkJ/q9ly?=
 =?us-ascii?Q?8a7f3PUu0XDBzVUL8hG2KIyIYLASyli4gYsTumePFfl7OfDvI8UkHz49LGjy?=
 =?us-ascii?Q?P4FyMSfUarq9YVn2fSzzKrAj9JGvdA3s/G07RokD4knUwXr1D6ytiWr4FhnM?=
 =?us-ascii?Q?w8oxc61Rj9P4ylrr532YyEUQLlJwTlK1DYJHTuDP7ZFZM11Lr/c86nL/UQlY?=
 =?us-ascii?Q?0BqTdCF34CK6kB+iZl5I6KruulWwRde434ts+WjWWGP5XuxLVx+wW+pXdhjL?=
 =?us-ascii?Q?Wl5cMIA15nMBmlcYGLkZbiOuvsiLW8pzatjpEEDIvMgkO/a4q3e5vUZVQPGo?=
 =?us-ascii?Q?aYOnNjzGlB/XSmFBNlNVxe2C0pIYl0Dk4EOZqPdW9xTlC17Xs9wnataTD1Vc?=
 =?us-ascii?Q?w6iuuCm6y0fLMxWhOKEGOWCrlGECDWYOrVwB3MdmuERUI52IKqxfuvrBO08O?=
 =?us-ascii?Q?/Mtt68d7jpM5vleexsJonFijBgVWTSHgwUJhkhNJn3T0yVcrCX+HaHYo/NtR?=
 =?us-ascii?Q?qKhE1KhKP11k6loKQqdwntQEb79zF8NNsT7D/uhP+TrLaf3O/YvJPSBcBYmo?=
 =?us-ascii?Q?p6v2GcT6RPNRA8V8I79Gg90sqdKFwkoAV0n/JGG/2q/76DfJXroHlos7YzgG?=
 =?us-ascii?Q?6Wml6FH46ZVwgwRwGzY9JeB62A2fAm9u6dVt6yQlLUN4zfzaAVKiSPlRkXQ3?=
 =?us-ascii?Q?cajtx9B9li7u04g4yK1PmBt68aTvt+jVOqV+jIWrpo9vdRcG0DAqjGrBFmaJ?=
 =?us-ascii?Q?BwhQ8kjSu7siyKgumYsZsnJGAY35JkC/VELHGpmoLIotrTE1RwAFHW9OonH6?=
 =?us-ascii?Q?eeQkpXwU3ebklT6hTWONT8MKkeuknWGK1qEnLYwUeGSzOjfp/IiD86wIbUyX?=
 =?us-ascii?Q?q6PV2ntoCd0SZRMrFnApyJUWYTGChfkBeEK90e6u7lZJXg8fb/xqWic6jhKZ?=
 =?us-ascii?Q?5pBijUMMc1rKovufcHlhYFeX8UkmElnOTZBDL6NXCcaMQR6n1iGuBaMhLjfa?=
 =?us-ascii?Q?RGbSOpp8D7gpNAgBwc1nTtOigWMg+3ANAN4dSt6JfyBMX4Da+kPCJYyboWLM?=
 =?us-ascii?Q?+bb48WtFXeLSnWuAtvWF2JucHzryHMFzvcK2Ms6fFEZhe32BX9ZKL+0dWFtc?=
 =?us-ascii?Q?vaec97c7R44rZJ0EYsIuZiikJdI3ctkEb8JhqSjyRJqKhSMfArE24rzE17ta?=
 =?us-ascii?Q?coXKhHjgegh5Kr0FQUBPmV9oNASwXvw1NDQpRyE6FHQiyeddFmvk/aLDQh14?=
 =?us-ascii?Q?jvs/l8HTvlZLHfF2jIuk+iyEKDLjfNGz4jjtxNkBfcZ5eJOUvCTDRvifTo4r?=
 =?us-ascii?Q?OJrSkQ/TkZranlmw3EOC1WXMD8694I3VlGbJONQHIq1LEiqoprMOvebKuWuF?=
 =?us-ascii?Q?EsnsHr1pbyEGdR+FkcOE8WT3PVgr3JlY2nbHB4GSbZKV2fHXYYnS7B3oBfPe?=
 =?us-ascii?Q?K3ifrtfDLW4cgFH79igkqyQN/RCykJak9FzLF2hBaphbUyEqar78jW9HW3aK?=
 =?us-ascii?Q?6UlDGH6K2s3LSPs2hLR4Msq0bxrRmqe1lIQJ9JCdHIMvk3G6bGV5OkEDemRl?=
 =?us-ascii?Q?VA3xco6vd4nrzaoxfTWOaT4XqJCDot7Dg5ZYkHp/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b2b05-79f6-4717-46b8-08dab56d9541
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:28.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwVIg6HzIz4RkiJW3WMFH8wP6Am7GbJIWhs+owxNS1mePOx7xcpGcPKrSGIXwxcJPX8Y+pxm1Ihc8KaAHVdnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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

