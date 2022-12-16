Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729064E597
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLPBSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLPBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:18:30 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A804044B;
        Thu, 15 Dec 2022 17:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/hovpWoIXzzHUT35xqloKxZNZBlExdzYH94US5+qZ9jRAGYcQRBLR7zMmfWANwtk+iJUgzXUtf/rygDfbuGo8+1wKhz0dboXTWIAe/ZNXc+a4f++yZn6UqXZAaOf2RvmvAVdMyWdj57WaqjTgOVKTr1LLtLRedxBH6LvRsH30v5Pi6Mr3SKzuazHcYZ9D/gsT8M7lr2LG2KyucLUBKO0FJGOhHKMH414jc49A1RwEbpoGK9knleK1IXlzYAFJo2jRuBsqn9ujlIPtDuGRG7TfzUkdZZm+Knw0dPO0DTX096/2MdGjONuLu6yaVub4iaHdkBU56B4DoJBI+WG5Q7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRZXQ4lErLBNs6bb/vxQN9nM5NgdquVgw+tnFQI0O/0=;
 b=e29sDPVVz/qRhs6a9JLREAJgwxCZDKyODSCaFPwAkSHkDPJONUalUDHpxJzP0KIFAXWIp2tI4+H3qaMYq3K4PlsWpithUtPP0exDnwdRgXpG2BEbr7e/QYBXHw24GsHzvmlykcloBDDFfljlePJpXCqzmJXHWVgdj4jeNb5bIbfKTEtF0ZJARgC0OSmIXpGtDGgixTn8T58Dea4yI1OH1yDsNy5IfsXzI711pikyO2h+zo4vg1AugHPlgwmfp2naBeu/fg4a4pKzo0Ck0RC0JY+SZG2kcOzzbh2YoEeszsHMgEEpaKrJzWEhlzRyUErq+eWvaaEY30v5LfoTfoJ8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRZXQ4lErLBNs6bb/vxQN9nM5NgdquVgw+tnFQI0O/0=;
 b=SQewPG5ry2CPdpc4Uu0ZrbhKnPtcehIWQc1UlF9If9suz6mnGo3Ye4tSn4Pk7tQ+r1GBYfDte9C4MPubVSKtBq2A05+yfQ+wE0kj1OyOsLY8k5LumCR7u4HmvmHK1OFh3nOBlcv2H781TFH6TFjtoxLMbT7FkHdpSYfaJrWxVwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 01:18:26 +0000
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24]) by DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 01:18:26 +0000
From:   wei.fang@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Frank.Li@nxp.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8dxl: Disable hibernation mode of AR8031 for EQOS
Date:   Fri, 16 Dec 2022 09:14:34 +0800
Message-Id: <20221216011434.967813-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DB9PR04MB8106.eurprd04.prod.outlook.com
 (2603:10a6:10:24b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8106:EE_|AS1PR04MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f7bf23-1da6-451d-5a66-08dadf035ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoCW5XylVxxeAAQ6axBPbL/7FxnmsNY/M2rnYrAR2/V3ot98DAQbSz6lh99KeX1hkIZATQJj2O2A5Ls8nGNt0HqNf/Jyh9BvE+SJYVIg+Fjyo+fbhauDCaMZEU+efhir1tsobdSsTJA9b9gNo+jhkeCWka3xUI7kWK9EFEeH86wegMN6TBqj3PpYmGvrLgqOTBarwthcphq4QxGvNed2+Q8Q6uC3MKF64+2qIY2FGrQ5xHWAcDXA9Xvffg7zsZQOz/x5gWBThXdAcw4mpG1xi2ZOlgUprJr/PaCNls8TGNpGoIqkWZ6a1I7n3cK7O3sp1WJNfEXiLkuGW5vB1ENu/3Kgog6Kzwp4B+bU0Zz5A1x6NN3uITBrZxzm9PJrsIywWcAgX5ccPGJyOcIv5G/jhlzuditm61+JWihJptt4B9x5ZCELIKJLWUkssho9reTAZsw4/2rUVbhOBbvnhwPQxF3QSmiJCzFJmT6IcuPRMooiBsIHzhZuz9uklaTi/wdzXVpPfi1BOyvO7k2ze8NA1//xGuKB+8oGHcTLVKVfiKnzgOlWPfDUgSon5mj5ELfhgPW9bT7By0pfEHX3mIausqD6zLkHsLiK6veBjh7i9LOrrzGb8r881QiSWRP1buvl/8QjDw1yoK8DVMkrCGkhgA1jN2o+PAV9kewytGWZNTikEPQftVnot2/+e3q14w/lm7UEbWYgMIQVhMbYTA2XJ0JAShtpYeWMxFhGWLK8hREOR4er/rZiw4ELzPqUOC3HMNMRvKsbLWNHmejcfQ5gSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8106.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(6506007)(52116002)(6512007)(9686003)(26005)(2906002)(478600001)(186003)(6666004)(6486002)(966005)(316002)(38100700002)(66476007)(8676002)(4326008)(2616005)(66556008)(66946007)(38350700002)(8936002)(1076003)(41300700001)(36756003)(921005)(86362001)(5660300002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cnUSIOpYTja33tk96c24Wt2IHdF+J1ANiHP5+vmrzwv+v4DfJI/EFpdGC2q?=
 =?us-ascii?Q?itkAwwDfdufwFuU/FLU6q6+dzbSYTKFzTeRp7c02fOWry7j23fRjo0RIcTJ0?=
 =?us-ascii?Q?30/7PBC/+wza+ZJsv+To3+gIMgkyyl1q3cj5YQqpMPGUgkIJHO661psr+C4K?=
 =?us-ascii?Q?kXs9Lw39r3mwJF2/DlkGi3lHAH8G8ED8LkANlyXiJ+iZhkNzK00UAN3II0r0?=
 =?us-ascii?Q?tQJEaiVnCIsRcX0pR24tPHfURauAEbQI3ZbI5O/eQ37PR1jvB22x8qYc0+bd?=
 =?us-ascii?Q?fsARpFoQdQuJkK9M/ANVjxME0NC9Cj0B852EnePLiOcQOW/8SJyg8hfY7jZN?=
 =?us-ascii?Q?ehbwN2qQVz8ErKFE92gECrS+xvs4ZwOokz8l89YhjjzRLNsGdj+eLjMQW77T?=
 =?us-ascii?Q?Znu+MunnZfkxHLe/D+guu2m8o6lu9z0lsUOkj0mXxZjEQbnUnozrxRMNJZm/?=
 =?us-ascii?Q?hJ57oEHORhRbNo7yXo7uYV2Axti97UTIoyJkR6GZmHmi61yDMutF3FbIXVLW?=
 =?us-ascii?Q?s+BLtPue1Bj2xqa1RDI/ltE/EQbkOnTxjjO7WvFcLH/rnszQ7luG6ts/2fu8?=
 =?us-ascii?Q?cyHZNxbodiIevEvszcLDVYcXwnWvorzwDLPAkdcX6H8JTMmKHLXcczZHq94N?=
 =?us-ascii?Q?La86/y67EpjGVd4wLfxF/8sTcOwpR31UJhHYtYQhjXWmZ6A7S943VVsIDR3D?=
 =?us-ascii?Q?yn0ZX3G/ZHWSAI3PIS0F7TrON+M5tty/R46nn6Nxc0dASxENsf3N08hjoeGZ?=
 =?us-ascii?Q?1hvIyBhTiqSqcQPBceaWzz3khFupUMzULXb2OUPUDCDaDRB08Cao6LAiZVYh?=
 =?us-ascii?Q?Fy6BG5ds1BlrvFwf7HKxcPgkNgBPagZhAsV5RTpHhyeACKliVWJNC+qZuWAn?=
 =?us-ascii?Q?sRwijWu58Fu5XN9W4TPUVKhK9hFFQny+lZwY+9UZ4VEUMg8n/xDJRWcr5fCe?=
 =?us-ascii?Q?ocv1fIHmEyyeOcw5MDtiDqYpyUkb4sdw16cxhctS0HVNRd7ODSVm8gYGi2D3?=
 =?us-ascii?Q?uPBTafKWfeOqJFwSl2EhoQaufAPWyiljxqTyUMfXlJR9xGLnYp/q36YU1OYC?=
 =?us-ascii?Q?DdSpJ2mGkcnq/8n5Y+WjduDY+L2Dzsxwg7JUs/GdzpMWcXDCJ1gcJu0pg/0o?=
 =?us-ascii?Q?vBcXZc/SNy90vhGscyyij6muRClnkkusmi6F66e6zpKgXzjatA6QM6z4Z+Tu?=
 =?us-ascii?Q?TMnK0cRTbgy8Cmfmoe/WYJPCMQZ1qfzjxs1TI5RuoPSYywHoCvP1C4N8/taT?=
 =?us-ascii?Q?eSmRDkXB04zaFl4eKrBKWuK+AArgpypJGOf1xMr1Hz1rdxMk3x57ZHNiivry?=
 =?us-ascii?Q?HamA0YuanoGY80ebX3OuW/HteFVcwbCOOsQxlNTjfikemcclFuCsTdMUWOfP?=
 =?us-ascii?Q?DrkUO+9dsQWhgyk3nl4+9w2ntpRWyj6k9jAChCRwVq8Wp0vjlGfHPHaaoXej?=
 =?us-ascii?Q?gqVCbWoXZUvs6VgVOwBxkXSfwKCNoqxQYOQG6hSCKlsYd1VYuntMkKm9Bb8f?=
 =?us-ascii?Q?CSiXJPg53dBMzLxBZI7ix6Fb76QwIp31nWnDHKnyQtQ4errgMsUud3sb1nuo?=
 =?us-ascii?Q?zCiROJsVuIcht8OC5JDSv7Ybg8s7qNZtXoMRgedr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f7bf23-1da6-451d-5a66-08dadf035ad8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8106.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 01:18:26.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBljxpuhhCT9rfxQS1MSdLEfzzQtMgwp3du+oavVAadpd7zZECn/esdkNNMZMkS6eOsUDP4x50CGGP1vyiCvLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

The hibernation mode of AR8031 PHY defaults to be enabled after hardware
reset. When the cable is unplugged, the PHY will enter hibernation mode
after about 10 senconds and the PHY clocks will be stopped to save
power. However, due to the design of EQOS, the mac needs the RX_CLK of
PHY for software reset to complete. Otherwise the software reset of EQOS
will be failed and do not work correctly. The only way is to disable
hibernation mode of AR8031 PHY for EQOS, the "qca,disable-hibernation-mode"
property is used for this purpose and has already been submitted to the
upstream, for more details please refer to the below link:
https://lore.kernel.org/netdev/20220818030054.1010660-2-wei.fang@nxp.com/

This issue is easy to reproduce, just unplug the cable and "ifconfig eth0
down", after about 10 senconds, then "ifconfig eth0 up", you will see
failure log on the serial port. The log is shown as following:
root@imx8dxlevk:~#
[34.941970] imx-dwmac 5b050000.ethernet eth0: Link is Down
root@imx8dxlevk:~# ifconfig eth0 down
[35.437814] imx-dwmac 5b050000.ethernet eth0: FPE workqueue stop
[35.507913] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[35.518613] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
root@imx8dxlevk:~# ifconfig eth0 up
[71.143044] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[71.215855] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[72.230417] imx-dwmac 5b050000.ethernet: Failed to reset the dma
[72.236512] imx-dwmac 5b050000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
[72.245258] imx-dwmac 5b050000.ethernet eth0: __stmmac_open: Hw setup failed
SIOCSIFFLAGS: Connection timed out

After applying this patch, the software reset of EQOS will be
successful. And the log is shown as below.
root@imx8dxlevk:~# ifconfig eth0 up
[96.114344] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[96.171466] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[96.188883] imx-dwmac 5b050000.ethernet eth0: No Safety Features support found
[96.196221] imx-dwmac 5b050000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[96.204846] imx-dwmac 5b050000.ethernet eth0: registered PTP clock
[96.225558] imx-dwmac 5b050000.ethernet eth0: FPE workqueue start
[96.236858] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
[96.249358] 8021q: adding VLAN 0 to HW filter on device eth0

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2 change:
Remove "net" from the subject.
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 280a9c9d8bd9..1bcf228a22b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -135,6 +135,7 @@ ethphy0: ethernet-phy@0 {
 			reg = <0>;
 			eee-broken-1000t;
 			qca,disable-smarteee;
+			qca,disable-hibernation-mode;
 			vddio-supply = <&vddio0>;
 
 			vddio0: vddio-regulator {
-- 
2.25.1

