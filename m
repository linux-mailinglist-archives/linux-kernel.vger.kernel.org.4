Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1D5F11AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiI3SfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiI3Se5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:34:57 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A8D2FFE7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2VtQcB2XG2i9Txed8ao+OeEmXaUyCsQE19g5+aIy9/9mjhf4mHHn3xTMbIT5q9sfcxnWME8i6J2SNcPBDP6FIWdih2DSqkZ/E7gkINFA2PlLbkcip3Qtv196AWZqiChNmXuGsoZiyZHzRzoNLNBoT3qpPCAACfbr0cDQDYhi4Ulk5D06IKuv4QPHBU+Y7ATxQ4ViMUU2ClzqZAD2qoykbI3Derys8AYazFn26vnLJxNOIrL3Lx+j9I9mQwA3jh9HMkPaN469ztMG/W2AFcjR3OJdyDcbo+LIfWISn8DwKveX2xmH9UlxI7NnvPFBwJk1HfCFKmb1yavN03LzI364g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRGCmL7svgLtTi15LuCOeYhYS4lfJyuO9bg67BtNFIM=;
 b=GtHsTvgtY8ASrdVo/nNxhQYUSYCWQGNuZeOjtlaG2HYPN1xoruKU3GgzkPM1J9YpUGjby9uSWu3+MR5wIh9McBIA9T2hgO+7ckgb+YsSiEh0OBwLmFDdcxa0rZGjAti7lPyvYcI5vzZapHgSH0gqim+Bh4FrURYSxvngAry3frF8qAf+EVnNWkQqv26L/ldTRzPo388rRF0VysJ3vgrCcFJjvc9YB019XOuPeeX/ctFHmqE2ZvCVuBUPBb98ImFKCN0WMbGAFqzfRGUwLHL581HPPy2S1ZFZ5bRgPhpN0bau678AAZ0GoRyNOndsKPv6kFeNdMC0Z66+/tnVFCGa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRGCmL7svgLtTi15LuCOeYhYS4lfJyuO9bg67BtNFIM=;
 b=nXm117RMO/I36ViHhBtZLFekRtRJNKi5HOvbiJC6o7uETLlSGHt3+rdsio6e4ekxxt/IMPYWoT/Ec/swSg8q0RHH0sYneEmQDyQ5DITyahn7G96uZoPaBCNTiN9Ia5bMyiU1neU7MGsdI7OaKmuFe56hzlPN2SIv1vj+T2kSBUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 18:34:52 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::4d5d:40ae:e0c0:63a3%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 18:34:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] firmware: imx: scu-pd: add missed USB_1_PHY pd
Date:   Fri, 30 Sep 2022 13:34:24 -0500
Message-Id: <20220930183426.1130641-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf1cab0-b92b-4364-64e4-08daa3127650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyTQ2H04XI2nEX6VErpWmLug2Eqdg6YC9CRoJzHOYo4gqTNNNEL4qQuyhNc4XnV7GnOaYQlvDsVwSM64aSq+Ze6KUA7Qv588YZqbuHNskFH4naOQHUlCRkh20UDt7nUL4Egd4PvEab4eKJoa/UPe/k2kcJrcW83KP0NaRqA06L3muLmXDMVPwObR21f0P6FJbkDfhxSmDGLraF19VZAoG6GaL/A9Vl4DLSCzj4FOyvcVB64D2kkFB/KWi4tgFrQY6QdI+aj7P51m7HGNZvOiv1zecsc6X8dipe8nFJVCpHv5HxHOpgQYD5FZNplNE9dNLwxIIqI8ODi5Np5HTR8cvEppRXvttRbysPgXQ3nQq+QM4gsBBj0zYoW2+BP3vR4unV4y2ImW4G9ifDml52SV9jffXyPvoBW+QTkqFQj90YdVeUgKxCP+iwDayYEf8W3emo6f8BfJxqG8tyDZV9hWl39r0DmjO14mA9/43LeD5ZkVLz6Xni/Aw9duumhGnD25R2DmqzKtw7GVAyl/eR/DHaRPR3agpgy8Y5Kp34yDiuO5HXsT87IpikiKxwskGSdFpv9dIqWtLZAQXT29AsiizPt6x22AR/eFExWkTg1Iar7X4v26jaXNamJ6SUCyDl0rtRr3t+N4vgldTfRRsDWeblHMX9xYUAQCJ82NIaOjD8QEe8H7CzQFtCnPuJ2kN7bTjx2Mlx9m/ZRmZ4B78ZLFr/Fe3aLVEqhPgRnVGyrXF/TJOdVytDRf8Cf17QV+h8Y+mC4Jmt4Lfi8MxMrKJm7xWhU+Fe6xqsqkd53iBtf20Yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(2616005)(478600001)(921005)(6486002)(2906002)(110136005)(316002)(5660300002)(86362001)(38350700002)(38100700002)(8936002)(26005)(66476007)(4744005)(6666004)(66946007)(186003)(41300700001)(6512007)(52116002)(36756003)(6506007)(1076003)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8Ogjk3e3oFvMd68X98bYn/hwXKViGS7flSfLGkDJHr4/4R/wWZ0jQIkDl/X?=
 =?us-ascii?Q?eqb1SA4G5t6N3IoSw2AKlxLevx80ntP9vb6lKsxlG3CCgo3SIY18ftEeShFk?=
 =?us-ascii?Q?N07H95FpmolHGZ8bGjxX9dsuz0tBnS1cScE1q+zdrGd1kHW3rTAaKyGHZia0?=
 =?us-ascii?Q?Xiyip/42A5/EIlfiu88od7HOJuqcnhWa0qLKhlG6DyAnAYROFFcj7mD7JCqc?=
 =?us-ascii?Q?SR+NrGVmZbP6hSgB9N6dRCqLG5OxnkujZ7Qk2kKUJhFBj9hUSFGb0PMxmq2s?=
 =?us-ascii?Q?kuBDHaAOmfa8AZUw6Q0DkJDbWtoxLNXJ/LrblEaU3rLSPmp9NVW9eYQE0ubW?=
 =?us-ascii?Q?AlpoU40LG0rppg4n2nyUoDjt0ys9REqOzqFJ4tJmxLFp1YqC011tXCkXWlkT?=
 =?us-ascii?Q?JwhQWwNDm5KchJDAxDthGj+EdtSD+A5IgbLbGt6oFnffIVxMUScqNVtq5XlC?=
 =?us-ascii?Q?bAPljNdoeBwixk4B1zXbq/8NY0ZNDLhAis2xWtrwV4cMMhIZbbfO13Hl0QJb?=
 =?us-ascii?Q?wCpkZGCxVvBZ7XRY7BKr3mDJdtuQnkY+vcfkt/GUEjYmH06GuqOxylrtrVpd?=
 =?us-ascii?Q?/xhhJpoDC7HZm6I/CWL+VE9pRQG0MCwYhblXPM0bKl2yPKTC1bPJzrTBXt+O?=
 =?us-ascii?Q?yl3RDLK2aAP9rzmSJN0bTg/a9YN2QSZKarQ/B5rBZrK7uSdDDctZ9wqeLBEA?=
 =?us-ascii?Q?BYMqN2zAsfZZg3HnQZ7WgMcFIgCqJxqaTdrsiv+9SezDAI6jExt+8asPZ6Qx?=
 =?us-ascii?Q?PyB37eBv9XKgpy8lGl3v8TGmxKIGLbHKIb7fT76L0KW7p57PJw6hAoYG7ZMr?=
 =?us-ascii?Q?WykZtGwbxwS/zsaH0GFUB9KmOJrlYelJ2oFVBNYjyMuwWgo6slWeGgcpkigp?=
 =?us-ascii?Q?Ww4toOAsvyv8C2WoIBhdAZaFYcXY4XQLAUsfLEFTaoBSI+DRSGRH8jOqEJns?=
 =?us-ascii?Q?7S7rzgS9HWbLnV7r59HkilfBZPqXPjPGUKnLJ8dhXglnrPjL7mf7NMpVQMJy?=
 =?us-ascii?Q?Z9cs7990Wwzz8nQOxXu3E/oFzx9jKTbNPmTVmv5bskR5V4LuGYrQkEZsPGjg?=
 =?us-ascii?Q?FPCsuZnD30HvVaAyUqmsEen0isCMYC4WV91Xwp4crJEuAGajzN2fE9vZlzbB?=
 =?us-ascii?Q?9qulUjn8Kw5qlGaikkdwG1AFk+J8EKKngIEY+PcAW3CBzqYsyN8jobTd79ZC?=
 =?us-ascii?Q?XvAEdMYWrmpSfpIJdF+JYq/4PwJlNMk7fN0CdvYAZ0a56LTGQfPg1TZS58cA?=
 =?us-ascii?Q?mjcMXwqpEDNc33esXbrICJrQtuwmH9zrVvvdD2ye2bDe1wOfuhiWuZhXlU/i?=
 =?us-ascii?Q?/Ko+A1z5jxsM4cpftRx9HzzmWCvXl5Z9v3ZiY5TYzFZ2G3czhqrA7ltK1Meu?=
 =?us-ascii?Q?fI1nq/gdrHQj0/6yoioVlWVNlS2v3qeYAt8pGmXRJDYX2GFM0tLU/CCtczqI?=
 =?us-ascii?Q?NJyLa6eVAhqZ8qzwHfaD8fMwyqiMfZ4pQf40u6Yo2EQ4CVrBhPv+kmP4GCsI?=
 =?us-ascii?Q?0gtzxdy3/4TSe7huuEHFCPPIMDQYCIfrKAOfObsrgUePJIY0jMYqQLDYUrHj?=
 =?us-ascii?Q?JvpuED/tgMVlXl4ZMRZDLLCsteWX/HJcNnbuHh9z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf1cab0-b92b-4364-64e4-08daa3127650
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 18:34:51.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgDjTIelqD7Ffp67SSTKuT32lEDmv2BC6xp/gV8P4L6Hh7PNeSbqEuP0P2o6Q8BUWCt+PBr1HIHoPoZozSJuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB_1_PHY is not defined in pd driver on 8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index af3d057e64217..2a4f07423365a 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -108,6 +108,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* CONN SS */
 	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
 	{ "usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
+	{ "usb1phy", IMX_SC_R_USB_1_PHY, 1, false, 0},
 	{ "usb2", IMX_SC_R_USB_2, 1, false, 0 },
 	{ "usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
 	{ "sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
-- 
2.35.1

