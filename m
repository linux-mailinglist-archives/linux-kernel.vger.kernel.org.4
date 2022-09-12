Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A605B5B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiILNdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:33:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC321AD9E;
        Mon, 12 Sep 2022 06:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxkK1tvaS0GWWW3v5jrWgmm24/PpXwTVTVn8iA9NkT847aVZQmWesQ3Ha8zSEy7/jwl+vVLgX1kd6DndlbZuuLTEn4a3spP8/GUIm0h19/ic1JVRvioVOc+/DOqenppUGui230lp48GV2ySl9626XUG0CRS9CSk6uhym8vnfimqAN3iMyz/Nr97RClYOR0syNuNju8CSsRCSzaehnnLXfL0QpzWjoVzw/S8tkw9zI1Zp38c7qkJ+LA7pv1o6kFsZzwFTdssHs+A7q16+PgI9lleXSp4aJi7g8Q/GrFJQQXVREdnYNeP6SJGLsHH5jnifNcHTRu+BQrekUPA+XaDq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJBj6bhgOX1du0GHd/YQcFnxfU0azOmjN7bnOw89ZYU=;
 b=ftiJXA1qWTlzZ5Ym4Gm7LRWrSo9bt/Vq2EGVxwXKGxm2jHDH+1P/C9hr8Q85sYxOPRSeoruoIPy5tOJ6MjBAxIH1s8ohCkJpEBbEWWzept9txY1chGnj7qruHjlVBaGE6KCbvvJAQEjxPr2ztb8d3ygs88QXqVR8zLh9xet6y5+c+vHIJytUNrqmX3BZQIrLmMIdzVr+k2+HwsMvzRKza0Rioj503RidzkR/bgbVTwnrDAow3p/+QI/ep9mqlTPKKrkOKDSPeYO73uEaiPcyTfZMPs4xgki9j+wYTeGMPTJvx9EdGWU6sWN6Fl9yX/MatS+e20ex268kU8uVm1XchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJBj6bhgOX1du0GHd/YQcFnxfU0azOmjN7bnOw89ZYU=;
 b=hp1jy2TzRqZWsG0EqR8MGeNbRGbhT86t1x6cM3S0T2vBTBuoY4eqOL17EG6HI75chwQm57RQEUTlC+KMw8GsYTRnJ9DilfCzF8YpH6JxnaQwCjbszb15KHAGMQ4q/m3+za8BTsMOFdOzOJAYH1dvo71wuSQg0CxkPtdGfXRw0W700mtqJ/B9JKAMN85hfsNitg31Funa8MiBOKTUdR0VJnSo0pVugzRlfCWTBAqlDoZSqhxmCs3nwtG9kqU3R82s58yEZGSp/MqVaxwiKjw0iZhwATsQaNHVxmphBuTaFrCMQxNDPsdKNUdwIeVj4tpe5vijCYXWV/jf1CUeC0NykA==
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 13:33:15 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::eb) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 13:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 13:33:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 12 Sep 2022 13:33:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 06:33:14 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 06:33:11 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH] gpio: tegra186: Check PMC driver status before any request
Date:   Mon, 12 Sep 2022 19:03:09 +0530
Message-ID: <20220912133309.18506-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bb8bae-42af-42d3-8177-08da94c3589a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKMHoJmyC4uNX+zN2a1OxySpNnFc4wt0DRsvyXjpWncYPwVUh24mPCf2BrMDfWf0YtRJB5AqC6X0LU4Zav+SQbJdFgiU11xJlhn3FH7cUIEmYiNWuRlCz0Kf248+miocYY8BxIKOXPXFMS+bePX7Khgqx/JFJ2gxSznR1FdCOCiy0V15SY/wtcGPuZO6VC8GVUmoHVIcaKpXurkeDwi0XQ5H9DuBfS/pzW2iypuDXTgL1We3Uv/f/PMZlLiiMYstfRKcZUGvZM3pplyvfEQHej272ePo2xIIaQzd8o9LUYcdUfAk9ivHxv1trW0qz4iHi/4hXoz7Vr1mNxJi5wSF4LFltWG1R8A1g9F0uXbk6AQJdkfPnh0TN48QWPL+QxxB7iGS8xK+AVrgmtnsPrHgL0tf3Fvy0hGgGSSxeRgG/uNtB/P5Bw1wcJhxPiMKwc7+2sA5IKcw/6OLjzB9Zm0E7XblaJgkHECIodpK/tMCQHfI7+fTZ+aOgPD/OcIBxiwyzJWkmvEtNeTvTO3Vs83M/85UD3Qi8iEhE2VdK4VQiHvh7Hw57cF82THdmrnZl/ty9pceXySk3sQaaeymKDWmg4k8fK990vhGJzQ0RBLPoSPTxBxLqeMZk/Y8Ku0tx+JkAd9E8Hz4FJ9qE83IG/AyHfCQLcXVRXX5eA1NuOtPUXbxSvSDkHxdnM+A0VS+WLOoVXGTe/mgcxszZWqvApOjRGNuhfJaq2Tq0xXocReh+uovqYKSKUOivRyZW4H6FFqQBPjZ/t2vPB7mokPiesksk7BOKysQv0tQexLrUSUghkeNv0Y3J8QH9lu/ZjcMsXlB
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(26005)(2616005)(41300700001)(107886003)(478600001)(110136005)(40460700003)(316002)(7696005)(86362001)(82310400005)(54906003)(36860700001)(82740400003)(356005)(186003)(81166007)(336012)(1076003)(83380400001)(4744005)(5660300002)(47076005)(36756003)(426003)(8936002)(2906002)(40480700001)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:33:15.1307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bb8bae-42af-42d3-8177-08da94c3589a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue where even if pmc driver
status is disabled still we are invoking pmc driver
to process some request

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..efd508ba07a6 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -895,7 +895,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 		tegra186_gpio_init_route_mapping(gpio);
 
 	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
-	if (np) {
+	if (of_device_is_available(np)) {
 		irq->parent_domain = irq_find_host(np);
 		of_node_put(np);
 
-- 
2.17.1

