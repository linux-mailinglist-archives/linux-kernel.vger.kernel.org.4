Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CF65CAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjADAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbjADAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:55 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB817076;
        Tue,  3 Jan 2023 16:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9sHYtbdL0q/aoiZIyiKz9Yng1du/vfJSrBpz5sAUDe221LuK7VHJUU5I+Fa/1hCOblf3dtfG4lQymOC5OxsGHNDLBLogoAZvPIOOLGB3OoeJt3QxCxKcEdZcmaNI0hj/E+DB3NLmIwTQJ3lDHlY4DgeWpWLnV9nMkjL9u5ko8YCJ9hT7L+hBsCtiW6OJ/J3Nlsf7bXAXZxzOsNd5AWo+k8MbhVm4UttV/32dU+8EI1MoLYQrmk5jXEsFQ7fHu1VUCMdLHQFXy+NXajlS1G63N9IY/fl2+bZdwwWLwEXiFZSyi4WNdoND++1hqI0BEnMbAnVdMYuCEWyTUs+vIwsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGAf2JaAuagCANo5Clm+P0wF1A9UCKT4wOYyEOtyAD8=;
 b=Qgc0M2ivxxEhtBYsKbhKzMFLbaLeuaAzXMK5wnx2yOxSozeBkhKzcTIMBx9dwWUG0wXavTGN8e2VwPgVNdsZyXeBLlANoYgFZFdFUYrz3IOueBrHW6xx1GlI6KfSTyVOgHWnQvX9BWIGB+H65PKq5vJ4txmk8UadbvisRyWiFP25A/aPot0HQg/20Kvq6bJNL9d7nY3Zqf7ZtNrcqtv+xRSlwxYRxXzjY6H7SIbICBVMPUSvYu9UdgavGDbA0IP5b6VXZORrjDmlBYPyQAFyRrATMp1kvO+46MTefUI3uAX4WFs1cnJBeujTEg8uYhMuFZUX9V2WOreO0rQhIn32Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGAf2JaAuagCANo5Clm+P0wF1A9UCKT4wOYyEOtyAD8=;
 b=ZmLlKoKAvrASSKoOcBDDHeatxvOpsOoNpf7ebdOu2qMQnjr2RdF0Jc/D4cfEchEzjkD2jL1vTeuXMjqxKVp079yBlPwi8JZ4enATdbodH5Alevcj+aUK3zVlu7gh/dbjf5pGC1w9/bU/T6BKdZ9ppLvr+0HWiROKjF+2Epni3Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V2 5/5] arm64: dts: imx8mp: use syscon for iomuxc-gpr
Date:   Wed,  4 Jan 2023 08:25:45 +0800
Message-Id: <20230104002545.3473598-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1431df-d9bf-4f9e-565f-08daedea171d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V59iwOJDwvxvOYxCCFdRigwOaM7ZK6gbdLi9ZkWLtBhZswd98Ke4TmU9XmK5MpKpJG/53tkZJ7LcExfNve5Sa8a7StgM9FVLObhhNkKoihcqLyl6fIVCgqOsuNV/VR64zO++NEcp/ywhOka3L9lAorA7B8MqAgfaZR79xBo86In9L693uCnATg1ZWFpEijeiUVW+NxWchEBCtsLA4LOxCxpB12Cx5qBHhCc4RL/ata1F9vU3o6g7lPZrSFcDw3pDCjcM+ZamHrCTUSsWISCXw5dwI6+DzVMFUymH7BaCwva+whyvwaxtsbeL3CQYnLU53X4PtKEKorhwrSzsSXIXnxF+csXqQGB620QJew2BZDo6Zfl536dgYAUY8K9yR1pjLQLxv4xISYTqRSn9y0JGJzH65WSMNjzPaRelIrb90mOkdv2Q76ioxSBP+5xIEU4KxKGK+/sOSrF2/PYiyk0hi4PkamWf9Are+VJCICTO/HQUrZ5XXNmH4+IjVZhH+5+n977jzDXmPR3wOkGJ8zTlpKpp9L8IpJfJ7QPLzKl67sIpzIAS21Lj2qzc82XO/CyQQoIY6PxODh9gN2VPA27Xxk3ULmqzWYNCRD1aASLpZA1y+FWevcSMBTGn+Aql/wH8jsSNth+fV30bnzwdUyOXY9M26KyVqNYYYLCgkRlQ1eZCeb44MGfhGw25zDLmXr5a2epN2wQFkUoIHty2lroY4NrQOSiZjeN6xOScpwRxJFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(83380400001)(1076003)(2616005)(86362001)(38100700002)(38350700002)(54906003)(2906002)(316002)(4326008)(66946007)(41300700001)(4744005)(8936002)(5660300002)(7416002)(8676002)(66476007)(6666004)(478600001)(66556008)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSJP19cBBfTy/fTHxEJSusfrd0AmBzDxB5hnx4sFa+M+gonIjzSg0/WpDY0h?=
 =?us-ascii?Q?s3bsPzhKFCsacSMEs7+nB7wr5RlWjCnk7CSyv/FgSYRLUC4ss/J9UP7soVeu?=
 =?us-ascii?Q?45JLA3UESXR2Upw3LluK2cD9TrfGnmkpAOlLcORltmy/dQ4yyzMpUB7vmNuH?=
 =?us-ascii?Q?HX6iNGCcqcTPEAi8yHOBXH9rRxyZmd0enYkTti3QF+SpaCt1qGCRAyXOrw6p?=
 =?us-ascii?Q?0UEz2A4G+I1c1GiseuHDGfLzCpS+rjxYIzaQI0zmwg+WnhZYXWrt1U48O2Wg?=
 =?us-ascii?Q?Id5ICPoR4g7Reuog9+NP+qoTIQvtwqlaoLpgWsHgyAs9mBRp0H0HzSpT9EQT?=
 =?us-ascii?Q?7Z+QV+rTgYaZh8kpHgRdIXzRNYszW/Z9BJfPfBorSkG8e1i5FI4XdajMunsC?=
 =?us-ascii?Q?roiDRXaqz4nzAjzwgKhJDryJdiDBHDy9wmEw8SBQuOHePlXU2X794RT9kTdW?=
 =?us-ascii?Q?KcyunsY/cNZKreTDf759JSHsHE/Z5eALEdAMb0cDkCgmC2FTFXNDFXvOAY0x?=
 =?us-ascii?Q?rLv5E7M91pQ7XGEF4G1pMfCmgosEnWsSrtcolIFZzA1HS87yJpwR8W+SWYrr?=
 =?us-ascii?Q?NUeaHSkkIHnxP6Wc/lSmOQG0qsQMOg7D9ddVpkO3x/zJGrhK+b8Z9TdnaPmy?=
 =?us-ascii?Q?VWTJwmqi+RldRFx+zWUB/lbb8ETbhGmKBxegrqNKyacAFNlFyk0R51Jh4x+m?=
 =?us-ascii?Q?F6VILV4QSRJKjD86GprJcshOxqRj2y+7XGBeDkkGK1mIw5mBYtBPhLX+A+Pc?=
 =?us-ascii?Q?7+PS4qD+SUbt2CET+06OcJs5ZkxCzmm9J/VlLqWkttH50UOddvklOdSrGNoK?=
 =?us-ascii?Q?kFf5OPtiR9qtINj+lBVCkpmywzoljsTnmnFJWDYY4AFrDY0DNeGSPOZ9gXz9?=
 =?us-ascii?Q?OtIKJinTMhkCI8Svf/ZeBQe4Qbd8uNuGAX4Ganjflr4csenTL+eo93y4971H?=
 =?us-ascii?Q?d5U1yOz3XKyCsMhR/90eQdoWpQYMaKN7H4ThURcnJpmEjGafm7qn1TYQRVPi?=
 =?us-ascii?Q?suK4Z0XXqPCCQxx8YMDgstm9wlG19ZyJSDx3/tYxF07rrk6IecIa+8KXR4Jf?=
 =?us-ascii?Q?y4TeH31KvF/R8afgpyneuDtetQtxsJKY9HXbJr8WWVicPoN7Zm3QGbylU/Tr?=
 =?us-ascii?Q?isI6yKbJdrv5iHTsONx4IklNJ8FS81cO2kUXGDia61IsOAACLvy4ScSIGK+O?=
 =?us-ascii?Q?m9sVlx+qxQW3/1Fu6LpQbKOCA+w8MeX3SXFtKCnpEXBWkybnvZl4n+yz6w/A?=
 =?us-ascii?Q?R/ZkUtRUqIpiXGArHZHVdTdZF2rJaBmOCbJkBUa9oRXnyIirvXCJgifaMini?=
 =?us-ascii?Q?5UFfux+mBRzsi9T2q3ZvNL2nmgtEivKvLltUcZtL3FvF1+Lx6mIsUK+wvmeQ?=
 =?us-ascii?Q?cZmzTp6IV0i5P9BFQgu1CAlm3Sq5LoISVnfv1lww+Rqz9dJrwD7lRnwqxeJb?=
 =?us-ascii?Q?XnjZIKzVrBVpOwQkIPoiU7cLKKw6RHd117DF2xXm79tvWAxEjvTD2LPLd9D6?=
 =?us-ascii?Q?KbTFqe2HCxO05XLHFeBPYnrp4wt6F6Ny7LTtJZldoBvX+YApWKlhYwAYHOBq?=
 =?us-ascii?Q?pOJ0hgk+dMrvjUGO7VoheGva8t+cHno2soy0yHS4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1431df-d9bf-4f9e-565f-08daedea171d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:49.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IByGQ/tzGj1i8Oz5a0MvLIj56f4l6jx3P9/HsdeFnjTS0hzrF4z6rfaJwdgzsT7ech1CzhU4xTsANYncuEBeTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is preferred to use syscon per bindind doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7a6e6221f421..9e5260721931 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -412,7 +412,7 @@ iomuxc: pinctrl@30330000 {
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
+			gpr: syscon@30340000 {
 				compatible = "fsl,imx8mp-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
-- 
2.37.1

