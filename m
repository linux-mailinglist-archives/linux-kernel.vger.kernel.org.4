Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E16A65D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCACzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCACzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:55:52 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61B1A49A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:55:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlgbb/Tj9VTdxpuS68F33ELn3MRxkiuQaPzt3SuqeiZQKPRNKf4Buoy1W5e1a09LGfM5L8EOIZi9XP6GuqD2+XFYk+hrABbp2r2APW9s5aoMSd2NuqJ5oFqCEVu2cX/40CMw6IJJbpFz1ijnx4/D55r4cBfafXPKh9Ty3Baz33kfVnNRUzr3bwweqkQHPjlhD7uN/zUF3qAlQmwuOrE8cagLDcU+yFo98NAUbWTMB5iwVFTaDPztiZePBJ0R7y1mKpGeJuTiqp4Nc6oeeWAEeGipI/x+kkNnhgPymDfbDHf40MYO52vgY6eljnn+n1VbvCbsQorGlKCbJPCLwPCgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmIchIKeaW2a8mkqisf2nLzrgSIxKIR3O1EXAMPnFG0=;
 b=gNojNCye+g4snoQnJTTqMK3Y72DhV+7ZdOJvkCzSTYCUVj77cs5LppgGkSCiIB5kM1mWhnUxrF6TceL9wAlN9OmOTE2gwbSRiGZR8cJiJCYhixnyodNFmT+zvDHMxre4o7hN4xYoAMO3rwyi3/CcWz4no0cH0Y7tSk1Zgs/ZyJsgze3WH5IlyjbSNaty4F+zbPtBTHd1ulCkh1lsvU1UFDKa1tC+FgwiFLHzOb8OPmrJZT+mkZnSp/b4OZD6cSl0j9KA/86CkSYeFrhx+yGyUjRlDoq9QIUhL0BmN6fvH3Oxyg3mq+Ih7bL7Hh0kbsut2WsoBAxwWAHQyDbEqXI5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmIchIKeaW2a8mkqisf2nLzrgSIxKIR3O1EXAMPnFG0=;
 b=fcx2odRMNx5EDTr93mv+vYBDGwWSnbkZTY+WEGOwUaKxUFlBHMOQSDGA7o9h1WzZtKHGk6aDyD2dpTglbdDkRMNSDBByhoL7KbUtk9RY2KFjTbSiOr+WGZyAB03v1kV1HE59tBGaizwrD5qU3c6AsQPcW/yco6cEmPsgC1LTxEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:37 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:37 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 7/7] soc: imx8m: Support building imx8m soc driver as module
Date:   Wed,  1 Mar 2023 11:00:42 +0800
Message-Id: <20230301030042.2357706-8-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e757a2-b6b9-494a-acbb-08db1a004b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLb9EAW4ViA2OWFsQJg8fRPNLCEKRW7ikSaR+G4wRoL+ZCqUASRBAJR2ihrZy26x8CB1jxEvKPl71woBGT0nMZ1V0IsfgAc/+Del/N4gOLQ8bkmNUO6qqGkpJq2//NuCBY1VcTMWfE7gzs6TwocELoW2BThw/J3AadtA7tLmm9FoemAMP09n2PDBJNqpvdnxQcTY40JJYDQjr3Xs5FR9McBU4nZ5nxLseTNJ+oa1DpSt8F5r7MUtK/sjBWG6teHoc+hv2Cm5L8awkHYDy1EEc5Bw1/74zBq6MjgUEDRiYq8p3XrXeouO4hW2LxBTaeSitaWgabvpPz1veIvEIGLHQh3UuI3Ua6PjF66dTfYYcBmpt2OHO+KptqQNlT5OVPY9znqcC09SnYVFRUNX+p9urP2inYy0FpBPLpc3bhLQl9YTsKe9fAofaZ/Oea2ZZ1pFBmMDl5tpQaNiSuhQ0RxgX4v2vvdCrCQHx39PyawHMqJ9sOM6l6PAnRVxdw4xW2yvNiNhMl0FcqMSc2QRDSWtxU6eXWahsewQ7Tnyix7t3yPymtfaZOM43oyW40SOMiD6Y0EnNOriMmwQRHAsjtQQenZ4wce+IOgq+q7fWZI4cIiYxOYHeqd/S2XBXtZQQFUhQepw6sYSNYjnIzQkBAgxSW7Gmdv4KO9J9ihTyqqqBzQIzgFBZ4nL9qPNe2m1T2ATSeT/nn10KEQjfrZiWvymg0Hs1CdnxLRP7wTuPW/0x/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36756003)(83380400001)(478600001)(316002)(4326008)(38350700002)(8676002)(38100700002)(66476007)(6506007)(1076003)(6512007)(2616005)(186003)(26005)(52116002)(6666004)(6486002)(5660300002)(66946007)(66556008)(44832011)(4744005)(8936002)(86362001)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?exp+brr38gTDepTXw2UCgk47y0sAGbzOYoLTGrnpXlOhEmbvTuF+wx5WYG+4?=
 =?us-ascii?Q?yLwy06FbzgkKd0pb1eQ+P+vFiB1QGXW754isjzCwaIoRyFTbHLtgLQTyT++1?=
 =?us-ascii?Q?4qyeLIm29B/71ll9HoVmj4xY8e1GbfvyM9mOEya98g4ricp4H91Cn1NvhhRs?=
 =?us-ascii?Q?KhUOO/0Dt4rASJgu5fHsX4dhk5OvpZIsLiKjmZz+rm+h2q7p744bY2178D6s?=
 =?us-ascii?Q?/W8H6Rxt/nMRXxtaKdbo6zTiHJtqa0Enp3A/9gt9xexTCrot/Ea4z11wa0tJ?=
 =?us-ascii?Q?se4YHHAzIHTTdK6gmK6Kldp2L0UXWkF0kj4Lrju3/4/22xwMjiLM5VoY7Jch?=
 =?us-ascii?Q?jJaGqUHyCY2ZTx94/xQ33GYEQPJO3g/JFEAXCZsHIKUOtwFx0Qf5CV9S+qzp?=
 =?us-ascii?Q?eadogOjsq8x/fAZfH9JyuwIzKo/0rN20yjORI0pJSzrrFMhs8k/QYQIQodmm?=
 =?us-ascii?Q?JaWOW5sXINRfKpFgMdvqTBkPkJZZ06l5aFOcAjxhZe5d81Z8pfiLONHTlP9I?=
 =?us-ascii?Q?bQKrq/FphjXxbDY0WOiFe1OLC9Q/tafp6xV1OM+pxS1je+hCIFKJojKeNf0C?=
 =?us-ascii?Q?rEcI5sKaFdChDWv/08wbcqoq5egZalm3Qk7GdrnK+xl43N7tZZxKbNQjHcUW?=
 =?us-ascii?Q?P4py3y5neOq8sZOklwH+8M5qQ7wtrZE+G4EdWg0sPLY908GVCvIMOdLKuF8T?=
 =?us-ascii?Q?OUtrD4ZR/zu9svmhd49Y+0K3rBWPQ7eH5M562Tv8tA+xA4BcYy/3knLRVfs+?=
 =?us-ascii?Q?eer/C12K7g+IYAfpH+8s4Lv92ZAwlz0m0DTndWlObUTxD92YeLx+PiUT1PA8?=
 =?us-ascii?Q?/cqDflT1IAnMvxgtBIIqWDWLAJV7bTpmGtwQfIa92e5xKH1YJ8uFNVBD/FDG?=
 =?us-ascii?Q?d0azamIci2PNIsCfzVszIRRqDFRCQ0a/9LM4TbC2bb3ZwE2m9tGDozbOtSIu?=
 =?us-ascii?Q?z9guy/dBGzjhiWiy+NnWLH9D4qgZMx6xQDA66EWkUH2dqu4/ce7AnUgqBNVu?=
 =?us-ascii?Q?3sAfRJyyDFG0Ep/TC2LBcUl60tb2Ef5n6xKS2aRv3yKXNRfRsjf984KEJyJz?=
 =?us-ascii?Q?Sj4RY5CyByr/Jd7+VN5hRh8xupfastRCPsdXaNbod1ig+LNcZIU4+Tsl6dRZ?=
 =?us-ascii?Q?EV8qobOSyZilsFFVL17+P3LAS/X2AVvvLKvc42ORtTcfc4ET0CNAqtUyHCJ+?=
 =?us-ascii?Q?dbig2eZEdZ7eRld+IKn8LCnxQk+PVOSGgw/9/VNmjkzVZNwQLZiRZPpufPCI?=
 =?us-ascii?Q?HY2qUyg7Koded+XUK2rya2AFOKzZiAVwO3RwjcgWrTN0X16DVhsBcREyIU8L?=
 =?us-ascii?Q?JbsviRl+YhZg98WaTBvVHHY8IG8Thi4emF6aTBexSNLf6Kaj5DRa5iyHAGO5?=
 =?us-ascii?Q?ipXRNVMSP1elMWKIhBLoc8xwu4hbgw5PtRu2MU3Hz6/GB50WsoXbq06me1LN?=
 =?us-ascii?Q?0X9Kak3YxK9V5BImnBBi/oZiznPlv8JCn+sewj1Q+o1g0GvFVSUpk8Cl7K8G?=
 =?us-ascii?Q?vJx8OWkHeBYPEqU6p2inh5PtIL85zqxDB1Do7lQkQcZMdvljEtLpVjswnr5h?=
 =?us-ascii?Q?uZTXEeTn6LmSd8TIvalcVKHCUnJGCTcJpm44ZCmi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e757a2-b6b9-494a-acbb-08db1a004b96
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:37.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PqlZsiUf+cq9wLLyHZvBar3klxicC+H8/VK+TpcS99CYTwfmatjQ7+7xJE3om3f3qfgKGv2YwE66ReKGAjWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the imx8m soc driver as tristate so that it can be built as loadable
module, module names are:
soc-imx8m.ko, imx8m-blk-ctrl.ko and imx8mp-blk-ctrl.ko

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a8742fc58f01..76a4593baf0a 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config SOC_IMX8M
-	bool "i.MX8M SoC family support"
+	tristate "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
 	select SOC_BUS
-- 
2.36.0

