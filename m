Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6438172C5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjFLNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjFLNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:18:04 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D8BB;
        Mon, 12 Jun 2023 06:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+4RFm8g6CsOcri2M82MemxFGt19pcf1mLRIy9XSg0OU7HhpqrhQXJDXkE7A+8DU33uaqAAkRzEeqK+9cv0Wtytr1nNPrbE7Ghr9dXFvRBcjsT1VxrzZwDJtSB9Dy8kk6zRQy+XSOsS7KReM/tlGNCMU1dI02YqtWxicmPIA3/4M+M7zlZ4R66xMe1cXKaoAQwYGf8Vvqfc2I9YK/Ewd3mhqX1LbMAXEyERDkMCSM9bf7Qf5MZ91Xok7Ks3yi0aF8A631Pr9Nuo1AVw8+Wrg8+Ifk2V3vT1imUpitFKrJkB/swdi+EipsOik//1JL3jCY5BsCEa+e1nRGEiI2QI6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Oc6a/kAS1xJETLHQ3LlS4yRRF6PjNqIuoH/HtoSq5g=;
 b=gvWRbm2REMvDAOrVopDwoVZloEuTEQL7dxLEY2KZTQ8oDOXTF2kvK58lMdkCzckfB5C0L7PqWb/d+NhCDFQ828hxvB5JVaxRivMMIvrMbqrcC1w2GFafMPVUxIUARfA+1A9L8UezGFOAGFShur/A/YPITeHzuiEZs7747fQCdKG2i8phUAqOfkwzeF1apZEQcw4rN618jUa4Ogq1/4eVhDNFBT6d15mo6u4VLQtzwog5tWQOx09+suxfUebkxm0muxQeOarAMafwrLNK/ST7j1taZYBGawtB2J7v8uJ9zE8RWHH61jsocD1sggvWI6fVMr9qWNyzTS3yUAaqa1drcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Oc6a/kAS1xJETLHQ3LlS4yRRF6PjNqIuoH/HtoSq5g=;
 b=rK1d2rWC+hSLm89H2+D6YFC+Qpb6IOSjzRsBiZcncgJrCgqFDZHzurYqhQnZ7MAgjU7nFCFxHlFFIndcAws5VVJMbCKZWuI0dJ0TgjFPbu+emBYxPHZQOb6epg1b8FRqaRVpfOTHJlQJhkNA1QqWhCpQnPZ6j2krimxztgrciNk=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:17:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::2a) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 13:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 13:17:58 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 08:17:54 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v1.1 3/6] cpupower: Add is_valid_path API
Date:   Mon, 12 Jun 2023 13:17:33 +0000
Message-ID: <20230612131733.205795-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612113615.205353-4-wyes.karny@amd.com>
References: <20230612113615.205353-4-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c56cd6-475e-4b99-c240-08db6b477102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JL1q0fppW9WZNOTiRV7fjjZaHOPzcwQLeshLC2rOYgVrzPp60Dl1nmDrSiyn5bFpvxvSqupOF3XpPXUP33ZaaDagFfvjtf9adxkVcvN4Tiy+dvdE7cWyRjzBq0q6UbJhvCP1tGQo9id/ToxDt8jyslYveldA0djz0pHpDFy2md/ec00TJrb3eYipXu/OY2FTIB/zWNM4GK2S8KwLSKtJRUYyDIOqa8Pp3i8JogL2L0baOSQJJXK0TrxKXzYSNOjAQ4nGHqZFCTp1yRRfPAROSrOYmtIpWi4TXgGvZdNObQr2MkVpFTA+Br4iZ4couGJ2NfFTIybihmqLM8ftGkdLZhFl5DrikTVMSGL0akfkYQawz7yNRVYh7fkw+fjvn07KBHlwfwFKLAd90SakUj3YVgRyEVoyDcOmIy7muuJQsXBwNY5Ckv/eMldLLE7n45f54Qchp2/EDAbrQJ3ysmzn2bXUFs74rpSeoEy/B4+nqBsRDg4jIE3Ef/C80Fy2s8ZXeI1iEKt1eINYdp8GjyEWWTkQzssaNL1fM4d0JFvZ/OPJRFXVXPIIO4ZjMgxMSpNAMDLRteIcryWZ3yVEfqn3eI5nH8Kr2cOGln6IDAL5c4QrWfj/+BMiTvkS3FPB1CX6sjTEXxIIGIPZdVtigkN4gVBTIadPmn/6E4jlvsrYhfpshT8Mk3VT0A4IvK67412Rh4Ja1BLK8WAu7qRSnfY2agk90jfMig55PGaRn0kFc5WDtyVZMcP91nGIHXd8ylFFyuodYc4wdbv+ijDJaHFvMVKkZq703hZfK4rvU96W+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(4326008)(44832011)(316002)(70586007)(41300700001)(70206006)(186003)(16526019)(110136005)(2906002)(54906003)(478600001)(8676002)(8936002)(5660300002)(6666004)(40460700003)(7696005)(1076003)(82740400003)(81166007)(40480700001)(36860700001)(356005)(26005)(83380400001)(426003)(336012)(47076005)(36756003)(82310400005)(86362001)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:17:58.4975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c56cd6-475e-4b99-c240-08db6b477102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add is_valid_path API to check whether the sysfs file is present or not.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
v1 -> v1.1
- s/is_sysfs_present/is_valid_path

 tools/power/cpupower/lib/cpupower.c        | 7 +++++++
 tools/power/cpupower/lib/cpupower_intern.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 3f7d0c0c5067..7a2ef691b20e 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -14,6 +14,13 @@
 #include "cpupower.h"
 #include "cpupower_intern.h"
 
+int is_valid_path(const char *path)
+{
+	if (access(path, F_OK) == -1)
+		return 0;
+	return 1;
+}
+
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
 	ssize_t numread;
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index ac1112b956ec..5fdb8620d41b 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -7,5 +7,6 @@
 
 #define SYSFS_PATH_MAX 255
 
+int is_valid_path(const char *path);
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
 unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
-- 
2.34.1

