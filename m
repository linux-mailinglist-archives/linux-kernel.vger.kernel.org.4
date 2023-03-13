Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E986B6CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCMAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCMAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:44:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264523D8C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 17:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA95E7//qqlxDMT9LQDxrcqaJTOj16yRFKgrpC8EbV50EQpUWj+phkpf/XDtxwHAr619LYlDc4edSL7/m5GoC5zzd4L0OKs4fMTzXYVnmefpdLJDlfPLTWF3gbzlOLOnoGo+XGAseFfQ6Yuc574KNAoM2lhfrWFUDoZ2IkymvmFwANGrOlbYCCCj1Ojt50vVGi+/kOxK40csb9ZM2W6/Ea2v6YSrZQejJS9Kg2lod1jdu09ylMtQ8NYRzItDM3m2jVBQqeOYZe7n5ki4KiwbUHJdAS645H82NIbjcQVW4EZUrCbt9NdlKvmWpZ1eYHBgXF98oL9dpJh5cMpAegsjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yiazyo90lykK5uReHJ1txz5icxWeq8Fdm8xkA6Ua0yc=;
 b=IsYy5L5xzhH25BQ/aRh6FI4bxzkhoq2Kp+BdE/c9mDcIZd3I+jwYtl0bcKOF1/JKZXrUpg0EbGwgAkFLXeD6sE2nro6/JX8XMno64n8VgsqMNqpR35thfsFfZKgoB1fcdN/ZZna0IBMEOAk3HuwenRFr57DpaY8+2GsYIIYRNK5E0AE1OTiEcudbPMYZ6IP1u0yC7ESg3KPyG8OesW4ZWJGedVTxHoJPDTFqRxY7OJoaUppojZ9ZBkxCp7Q4EjMv+AeCZYODxjnKheQmPDwzohOJ8ZdrhaP2J5zFwlaz20twkeU6fPoIkCc6kLR4ZY7p3WVVkfxwr5WMBOl3mF3n0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yiazyo90lykK5uReHJ1txz5icxWeq8Fdm8xkA6Ua0yc=;
 b=Ti/gVRUfQysIX7R65CRWPx7RY4146re/yFTvVIJKfSgVXRH58NCTx+OM3X+uQZGxnKGCugCGw84FCkI1EXy6JVidcNWAnJtVeha5fsSPQ785+NETbzWlN90mRfeiYAidSMm9cXH306RnGebzM3sh7z4Jk/DPAwjSbFosVpGjTHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 00:44:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 00:44:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: reordering the fields
Date:   Mon, 13 Mar 2023 08:49:03 +0800
Message-Id: <20230313004903.1997375-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aadde0e-b862-4066-d98e-08db235c0931
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/+bL7dg57gzxgDc60K4s54a0olVnVjHqFhh7UwaAEhvQ7KV5+tkfdcwK0yo45XwbATkDTUEASnsRz/eLV8VlUiMqxsuFm7uny1Mft8z5bzcQP+mMQYAarFSqbcKuiZkGuy+sX405kZ3RwruQFbv5jKCA9gkfH0JB5umlGKIhCNsCp1NBQ9FvjjojJrF3YccxL1lqj1v+ErQlQdEjSXKOOJ0W3zaglQp42Ov9evouU49iuyCfJJVmNbpEFq1Q7SIJzDMrymJQ6qOA1Mv2yietY1PTgr8Mi5rDDO3jrbXE5GLGd+hiU09YTkhYfJYYmpcHVPY+sMXDZXULgWjEHaXIWnPwEb+AAE81WWEdhibjnLuZ61kGEioeYs67jPQFKpagPLOtPBEn0yASk0QQJRMQcvLVRiQcCYL96jlEdvvNflnC6t4cHnaRqAhcvZJZ6wRSTO8PRe68V8azhyIhsy6bkgtcGy/G0mUNrtQ0QqZJmUu1AzlW26/OeXYm6yKw4IuBkMDUlbFewklwelUwLrJ5OUzt6gjeFzmQlVar3t9BxA9pdjY+y/bhO9sRVOqu9QfqVToPNo93CsLRbQ5G0ThL6Lr0QhgLeIvpXAFirzzo8+VSKe0ksXwAkmA9KiSA6m8Y9AIlxms63o/elDVOacZqPvOqCQhzWdREZsK/3tg6N8HHsOi//4L2tNcgMrGBXJd5IUWYMWchkwG+Fr3HmcblnFVnaUhrY8iurp9Z+imMcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(2906002)(83380400001)(5660300002)(66556008)(66946007)(8676002)(8936002)(41300700001)(66476007)(4326008)(38100700002)(38350700002)(316002)(54906003)(86362001)(478600001)(2616005)(186003)(26005)(6506007)(52116002)(6512007)(1076003)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oMh7BIbAkPUwf5zs8HVfMOecwxy7T7zKDr4nJFhUmGh7gLN+hhCxBBJQ0FAN?=
 =?us-ascii?Q?Ubq7cKNFGCDikmHvFveC+X9BEWJxO4y22Mmd/lXVewdBSFEslUM2cDWrOhfX?=
 =?us-ascii?Q?uy5u9Xe/GL8DLMUvEVh/pDh1J7ABV139ibFMQqvBmAfYvSOs4GqlMPTJQzcQ?=
 =?us-ascii?Q?gJZ81i5L0N+Tk4HZsJPDS7R23aBNGisTMRaIYXShB5sMv5vPK4fk+N7oZSz7?=
 =?us-ascii?Q?fII0ELtyqQ4eVQoESzOqs8LTvUWOYsfodSCqNVFnuHtbwa2wdAsYHEsMOXZK?=
 =?us-ascii?Q?wDAdLs9An84lYoGn3WWYsdJpkZxwYS7rbo/P2iGE9HKdI4kUcWSqmuE0pC7N?=
 =?us-ascii?Q?KvUXpeQ/ACq+Mynnb0Qhvjt0yXkDqRlVwVizd3DucD80LoVSIoRS8UeaVB5g?=
 =?us-ascii?Q?Yejk9e8pIBDqAk3W6WdMX0naohiFB0mlLf4QryuoNOyAPoNrkZYd5rfRPaLG?=
 =?us-ascii?Q?D8IeIBC8jiHaIVygBOAPKtc9gGqcW1Qg2Veva38XJGuB2uLeA1lVjbRAdl2z?=
 =?us-ascii?Q?AAif9Nqjey4479via56nrXSobAXhjioe18gCK7hSDcpREbGk++Niasaxp+/+?=
 =?us-ascii?Q?uw9S8Mt74Ozsd3jA95On79A09ccMxL0JsNydxn6Qq0LBOnY2+X3fuLGZwNe2?=
 =?us-ascii?Q?15vUND0PiaaJrO36sQmoGCynKsFiXec6Cxy6BxeIx3BKSPSWxBS3PWvnFWBW?=
 =?us-ascii?Q?TI7yP6WS6C15hIMtWaBddlZagrM7nW9t8zWZoqccCUPMEKfPFRlWjLpRKJAe?=
 =?us-ascii?Q?vtWOJxiAS4yLU4AHP6l8Z1EpSMclWxw9lWBnNLR+p9+ox61i0kvalvzGXBWC?=
 =?us-ascii?Q?lnJyGmheBN7w/azUKSGd2X+CmesFuiYMG7vMh8oKxktO2iYKvovuLrr2pymf?=
 =?us-ascii?Q?rr/pUMWAtJ3dk7sjPVHKrHTNfWHvN5ao8LShdqQRZycSmDZ+u/NRJCdqqXkH?=
 =?us-ascii?Q?9ojRhhk787+H2PTrb9Z+c8lzndfXRtBoX5e01slFYg3aIGI3FOVmLfTto+4+?=
 =?us-ascii?Q?9SVH7xlkqMe3zsK6k5i2DZKDIJZsRW1KmUaBM9jah5Lky8BlSMmvZoKRT6dV?=
 =?us-ascii?Q?VWNvRfRXh7rKvXqrBrEu21Zi09TothCJrm/mMmlgmHbN6vAgOPvLlkrQDDpv?=
 =?us-ascii?Q?q4EhOUFfdS0adEy5x0OebnyaI9I/g+VabM4RYocN27pAD8V8QTkFxRMjju4W?=
 =?us-ascii?Q?YwIbzEHyVErzn/rp7peQC8SRfhRp8GovqS+9dDhyOxs8sAVDIZdBfuxLQKL3?=
 =?us-ascii?Q?Il4M9WMCf22u3PxrxA1WaNV/IrGtDjEGBftwh4+9K/oba5hYik/5TOdPgwVV?=
 =?us-ascii?Q?0pFGOjmHyedOmpP+4qaNMGrNpfWxo82/YuPo/0ddj/P01tSRpdX5JJeNASkX?=
 =?us-ascii?Q?81XK5zkd2LJFQL//JN3JewrP9oKvMyhAiLs5Pvc3MIElC4hMt26BpxQ+AgLs?=
 =?us-ascii?Q?/u6PKUWKKqhJ1v6mdRTnInkOBecCvXyKosnwc1eWY3LcmkOFgRohS9rEQ1y+?=
 =?us-ascii?Q?RznSISVxH9k9YOjpyOunbi5faGrVAKl9XR6hrXJW9Ry9HNb0DRSa+KBNW6RX?=
 =?us-ascii?Q?KdPwLRTAO2gCzRhB8rAjKsLDjZ0rPRNp1iYEH+kx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadde0e-b862-4066-d98e-08db235c0931
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 00:44:00.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POLkkOuoIfYPOF9kJt0WG1p0OcZULALZ5SfXsOFIqsrMClTuBh/rk1YGyBtlminCwKtHKMUc4kVlj4LhPBLhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clang-analyzer reports:
"Excessive padding in 'struct imx8m_blk_ctrl_domain_data'
(12 padding bytes, where 4 is optimal). Optimal fields order: name,
clk_names, path_names, gpc_name, num_clks, num_paths, rst_mask, clk_mask,
mipi_phy_rst_mask, consider reordering the fields or adding explicit
padding members [clang-analyzer-optin.performance.Padding]
   struct imx8m_blk_ctrl_domain_data {"

So reordering the fields.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 9b0f81dc292b..716e6eb4838f 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -37,10 +37,10 @@ struct imx8m_blk_ctrl {
 struct imx8m_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
-	int num_clks;
 	const char * const *path_names;
-	int num_paths;
 	const char *gpc_name;
+	int num_clks;
+	int num_paths;
 	u32 rst_mask;
 	u32 clk_mask;
 
-- 
2.37.1

