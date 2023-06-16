Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70C473379E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbjFPRrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:47:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607B297D;
        Fri, 16 Jun 2023 10:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnDvZl7DCpeK0s9TldeCCIOI48PWAuzorPXlYRFHl12DV+i5EeRrzbfxFoPVqmE+ea541a3iLxXb/5JUy1us49pGVdroZ1T1s3B/kERrFb+S0/JjTgmoG7U5Cdl3KgvABpRrigFDD19virENRPG5uGzfiHtJH0b3sSa02KfZNeaoswSixPezHx8ICoViWbkc9G2z3Zply69Gdel/EPFHEh9C0vCwZRmxNms4HEDFZDMeYYivOEnQ4xqX4Ae2if2j/GzOYPxpylM9Trb0AUrxTjauPs1mIw7td8nb1c4aTVCZrnOitPLl46SF8Hpht2wD55uWO8M5f9P/d9qLPfoOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOBDyRU7FXl54Bh6aYCkmiR2MSIbk2NYbLe4RbQLkwQ=;
 b=MhLC0faxNcV2LXtt6uvGvXi0iPCYqj7zUY0tS9C+qlmSL0s2BXViPCwYNKDC1dGkQm/AMa+UALTwNDkW3ksrc4m12cf4uvC2sjvlK+YC/5u8p5qo0ClfE68D99yfcljiHu0qQgbqbvl/aAI4cnTCBnO2HQsYbmCYpMn/WsH4/qMlAeMzqopvriSEgwJrvhPV8j4KvnwH2n4wfogA/srWP9EReTckWrrhQMUvVDvM1yBnFzzqPNvG/sax4jGCrXAF5ydLfiCB6oAGpS8QLgZxt9yDBFreBagXvd1NQAKlchL8yA5ZoEAgNQFQHPvSGyYBAYU9kkKCkC68w1Hd6E0p+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOBDyRU7FXl54Bh6aYCkmiR2MSIbk2NYbLe4RbQLkwQ=;
 b=TfbTondQ6HcF495fIPzsa/eMEJ/yWoddTcKYNvr3xqjsubMZvjfZYOE//4TIdA5buun7UESWT9hHfOINFIN5WJpsw7z31V4ih0K56PPTvsCDRCXKhq+jGKlxYoqMP0+PAlfbplrwGCW4rDuEBmUyHdL+7zc5qfv5OeDjHSTVD/k=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 17:47:41 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e0) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 17:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 17:47:41 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 12:47:37 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Ray.Huang@amd.com>, <Perry.Yuan@amd.com>,
        Wyes Karny <wyes.karny@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] amd-pstate: Make amd-pstate epp driver name hyphenated
Date:   Fri, 16 Jun 2023 17:47:23 +0000
Message-ID: <20230616174723.148532-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5564c6-382d-4477-578d-08db6e91c85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tOcNC3yP1qJbRRFIdctYXfInu2Lhn4OzFgVB31O88sR8O5j4jnplthw9p2FqXUsRQLrg03Ky1G+ZH1HhP/3bmqnYL8xEOM+Kb/wHJ6ERdJavAEwzvpgMFq/U8XVMFXxrjSUXnvwggs1QE1KQJJXR9gRL1CyfkZmLUYl7vP/cQBAdebWU4KxWfLrKKRwJk02lQB4Azxv3abYL7YraFb2MWWa7F1VQhETAFVpMPypov8BtuGyoSDXju2fWfnfrI2J0thyzh0BLup4HpN3Gsy1ql1g+x/Fi6eFHIk2TxwyH5FyTSsydF7AWweqDKRQYyLkc9Xr5YbqxEfpPtFMXTKYMbNxiUEH4zLXiUdGFRXqIubCJEoz8+DwjHcSuyIXvQ+4D7tgiMC1NC9JW2rNDwHIBc1R8McGRaifNR+D3Zd9r/IQmQ9aO08Papl0QLFt41DS551nKtjxDZaJslJxX8XLduuZ3rgEucY0WJrgy18BsncfoRx+KdaZZO7TwPnpEO6T9cJLsu8ywQFluG8k2D1m2v2H2CLHV52wD2KLsHCFB2ixG5Eg4SO7mQ6lJyfUfMnKbbb2Uby/XVCwC3fyMQgHEHzBhvz/+aJuslIl6D6o9ccuTTXJe11XuF6ACe3Tnr9cUX/NYKl1lK7agqOIcpflHBlPnM5iayU9meDgf63T7Dwmb74TwR0xbX7Ht32p+Eb3mInscaUeRRlYmPiNQTe4j179ff2BmoKXWAG1At/8Z65bVF/4Hl+o/7EzGGyJBdpXL+QW15YTzk3EtITtyzgyPUamC7IBEwNE6/cObu9OeA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(36756003)(478600001)(16526019)(26005)(186003)(6666004)(40480700001)(40460700003)(7696005)(2906002)(4744005)(8936002)(336012)(316002)(41300700001)(8676002)(44832011)(86362001)(81166007)(356005)(82310400005)(5660300002)(82740400003)(54906003)(47076005)(83380400001)(2616005)(110136005)(70586007)(70206006)(4326008)(426003)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 17:47:41.2328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5564c6-382d-4477-578d-08db6e91c85a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate passive mode driver is hyphenated. So make amd-pstate active
mode driver consistent with that rename "amd_pstate_epp" to
"amd-pstate-epp".

Cc: stable@vger.kernel.org
Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ddd346a239e0..a5764946434c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
-	.name		= "amd_pstate_epp",
+	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
 
-- 
2.34.1

