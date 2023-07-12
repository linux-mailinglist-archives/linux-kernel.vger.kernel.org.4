Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B6750A27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjGLN40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGLN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:56:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A0E74;
        Wed, 12 Jul 2023 06:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFSMDgMPnw0iZLYnlBBk2vSSO8G7TBpyMFrEayYlS6hm5q/0vrben5twI7Wu4ya6Mqp6kluVQDFb+KfyIwvbG0tHytikepJO7B9yoUPTtPj4d29qralE/3T6TvZ9JT1hCAuQR6fpjJKGo/ug49ShalWAALTKQUhmk1izoLn5EBccuiiCrwsYdDG4eC9ofBvj80TvbLrpMY2Q5HzQoEOGndBNfrXnWIlRbfing9FyzqVUdcIOOx8jIeLTWAu7nceVZefJBO207jRlU9vuPjr6Lqs94/RAnXXlqw3M/yVUQlnKPOJtIl858xxcSQUHyRhgrp/nr04H74eKCCVxke3zPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlYdk8/p6mziXf1V7PfmgrZT2H3lLeIUfQQm6xZNAAA=;
 b=nljQy7opcQS4fiUo9kW2UKLwVEl3D74cXaUEHKAisgR5u+5eqSiCy6O3qtqdgAccQV+UPHqjc4uv2nGdP6bkKY5Il4T4Q3sFfdE4c+BIZcTBkgwPN0yc6dJ1Ch0zXncyshkpKmJqAHlGhbvJHLOv8yHRiUkNTuR99hA8Mpp3Mf31FneQXnK0NsGL87DkHlBa0yYExPVaa162WVhv/UOjJMMAKNTaAubt6NLlheEnpyC92lXIoxJPPz69NptDbqDGZtUHNyyt6ScXRHkr1xURYrM9MLAT9cNPQzmgJOqDIwH6190TdJs64vWrasvP/So0uJBqVqf3RYtxo+uqt/TtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlYdk8/p6mziXf1V7PfmgrZT2H3lLeIUfQQm6xZNAAA=;
 b=c6l9QIIQGEc41+2M35RFsEaTZ3YIUfSWOiOHLNBfRpJYGcXY3BlHlSSpy9uMH8SdFYI8GykjOtqediW6TNOkh6Luv9vfCsecCqJ/z5CDh4hmuCM0SQfo09meFqa89jkI0UFhhkElUZZAupnuLkkeJXJlND9M+d8tWAJOVVGSlJvXC/y0S3rr6rHq0Qk9oD2DgYQ3hucAOnxt8RkygZL946/Mcf4AjEU2GdYXTSnix+5zofsFILerxmKSpxpsukONaWwEZMd5YmTslNTkfFRQ4y/FkXNI5DoeL6jAL6RLJVNOczDNMdWS7ojt0eEqWzMFnbKXLfKTpGWlzGOOIcyZIA==
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 13:56:13 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::33) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 13:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 13:56:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 06:55:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 06:55:58 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 06:55:56 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>
Subject: [PATCH] pinctrl: tegra: Add support to display pin function
Date:   Wed, 12 Jul 2023 19:25:53 +0530
Message-ID: <20230712135553.25162-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce5320b-b3c2-409f-09b6-08db82dfc141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLpzmVxLNMAQ482nGg1RukQYzkRC36BWTsBfWeitTasCO5hqREDBtfZwnJeStuV+A9mSJ9YVB1g1tG2+L/3Qmb/yPBiynrgb/UliTQ8LoeqRnQIWqO2sasrPvbkbY5Uk1qizJBWn1792cDMfqU267oRaGv6hFDxqJbXH/daRN8RzLjRRwl0crmqnDDHdWNVEVa+6JJDCVz7/cD5y4HJoCAVlkaaWmBhfYdCr+tElYHTt8l99xRqQhedu2Dgs4Vk8nYP8jAEBSo6qxGm+ZT4z3kttVAp3pUL9IRxBu+WTxgBngx0MjH4dm6F6EWWDIgt0qia8N6yPDHUKkWBqRuNm4E3jjHY35mePCu9Ukoi7XmTmgva/kUWomSOcGORUY7gQ1qEcmcxwrdbxiLPzOfoev8nsG8W61cXbAb2P5UO3xObtDGU9xpPHhcj18LCNuG259fxKcTKLBFQjD6xpbTwDlIxJqlP/oekfvbz0UgTUd3WK+/GbF6Pu9FU5dlL8xwKdvIm1kANY5FOEdN1T7hegGpq+Z1ZvMQd8anu+E8nd96gIOj8EUG390GtXWPOspIoSL9yfEtXhuzZP9BV42nc1svBWIvYncryOuOuxAr7In9hxfTHBLTx2su7lz/dslO5Rt19vx1WOnQLqJQ1A2yspjXNYCOCAk9pqsvfTf5SMHiZFPS4uV1Yr7CCFb54hxhMNV4Owfw7gmKJxCRYN1S7s57Qo0s4XwVl2g6JbmxwuYSSOdHGRBlG0WQHQTG8F+vxf
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(40460700003)(478600001)(110136005)(356005)(7636003)(82740400003)(8936002)(8676002)(36756003)(2906002)(5660300002)(86362001)(82310400005)(4326008)(40480700001)(316002)(70206006)(70586007)(41300700001)(107886003)(1076003)(26005)(36860700001)(336012)(426003)(47076005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:56:13.3233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce5320b-b3c2-409f-09b6-08db82dfc141
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current function for a given pin is not displayed via the debugfs.
Add support to display the current function that is set for each pin.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
 drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 4547cf66d03b..2752c914f628 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -96,6 +96,7 @@ static const struct cfg_param {
 	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
 	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
 	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
+	{"nvidia,func",			TEGRA_PINCONF_PARAM_FUNCTION},
 };
 
 static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
@@ -470,6 +471,12 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 		*bit = g->drvtype_bit;
 		*width = 2;
 		break;
+	case TEGRA_PINCONF_PARAM_FUNCTION:
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
+		*bit = g->mux_bit;
+		*width = 2;
+		break;
 	default:
 		dev_err(pmx->dev, "Invalid config param %04x\n", param);
 		return -ENOTSUPP;
@@ -620,6 +627,7 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 	s8 bank, bit, width;
 	s32 reg;
 	u32 val;
+	u8 idx;
 
 	g = &pmx->soc->groups[group];
 
@@ -633,8 +641,15 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 		val >>= bit;
 		val &= (1 << width) - 1;
 
-		seq_printf(s, "\n\t%s=%u",
-			   strip_prefix(cfg_params[i].property), val);
+		if (cfg_params[i].param == TEGRA_PINCONF_PARAM_FUNCTION) {
+			idx = pmx->soc->groups[group].funcs[val];
+			seq_printf(s, "\n\t%s=%s",
+				   strip_prefix(cfg_params[i].property),
+					 pmx->functions[idx].name);
+		} else {
+			seq_printf(s, "\n\t%s=%u",
+				   strip_prefix(cfg_params[i].property), val);
+		}
 	}
 }
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index b3289bdf727d..e728efeaa4de 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -54,6 +54,8 @@ enum tegra_pinconf_param {
 	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING,
 	/* argument: Integer, range is HW-dependant */
 	TEGRA_PINCONF_PARAM_DRIVE_TYPE,
+	/* argument: pinmux settings */
+	TEGRA_PINCONF_PARAM_FUNCTION,
 };
 
 enum tegra_pinconf_pull {
-- 
2.17.1

