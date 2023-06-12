Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5FA72C351
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFLLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjFLLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:44:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488055AF;
        Mon, 12 Jun 2023 04:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9lzk/xEPta2660TynZjS4syXi2AJH8ZGPUXVyrrdw64AA5p5tcEqi82uKjCv1NOkxSreN3WuVouvw1gGxSL2Xt+01unlGos3+xq0y0C6UdYZj0AgWQPVstK7ccHl2bSHG+PBDAV/jOgcyxTUzZU1eBV8B29OYEGZsq92RaGn+b0cZYLKMqP9PgzrS2WQUOnc4O7z1lS/qzf9Nc4ultMi2NALmyFeQZSfz6abPGCdsNSiL2Uf9jsT6L7eFLJHGhAPbyiK/u6xyJZy35msa3QQwcQ4wFIbL5/tsdjUz2p2soh5oBAYe2hWpRBYIP2+BShZSoBpISDnACBrsML+KRWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAQO8W+cZB3/dnu4eAjRqnSdODd5IkUHjNJwXvSLIWg=;
 b=X9xi+qYGoMNAULBfiLJtWsTca7uREvavul8NmOEkGxeBWkG0MKiVdNLByrniLHJAkXcwrmgtXf2OzjJEdR2oUrj2nPAd76LzHd4W/yVy+pbvw0ly9ZVdncHLhLtAJweSJJy6qJdAa9TmxT3UC8jRabcChWZtcqken+8tpfRXdocSqjGySmdMDsxXP1Nm0f1GUFBMGvamToJzukLBjF4CtcEHlTTJYe8h1JcTMAYH3PFYKaDm/rwY6YsDrYazXrhKRRDAqDU+bKdMaMqm4MwLAYcY7J7C3kJsnRXWW7r5k2Q2WLQDln6g3+bMRqwNu9BO5vOdWNOJz2BxckYAaeW0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAQO8W+cZB3/dnu4eAjRqnSdODd5IkUHjNJwXvSLIWg=;
 b=AEp/JvvhCK7vNDkP48mEJfksP5RwYR53qs+T0cytVl6nV/zJRzXIc2mnS/4/m5cc5/9sTGvHd+G9bC5AihB4oCUKReap7yQT2zL1sZSB97NMtByVPW8Txl0iuD+8wq4w8yVsTd0mIprfaAvn+OrFp+SGQ2hAld02VwusdDQ7XkM=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Mon, 12 Jun 2023 11:37:58 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::d0) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 11:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.29 via Frontend Transport; Mon, 12 Jun 2023 11:37:58 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:37:54 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 3/6] cpupower: Add is_sysfs_present API
Date:   Mon, 12 Jun 2023 11:36:12 +0000
Message-ID: <20230612113615.205353-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612113615.205353-1-wyes.karny@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: aa174fa0-fccd-4817-f23d-08db6b39788d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMz7RU3hMbQ4wE6JaWyBf2bibG07kOsoxzuQdG/EBIQkrlCH3FKOCUgpSccfWTKHfcK8o0mk2/L7EtfzRkNfqaWJPhAb8+OAO2fzsnqN6okts+TNiFmj46bKk7g5wKBsHrBwNj5Zd1sYxA1UElVWiqcMaXSn0Pxng+0AbUA+JEm85vJPmNpdZtIDFe13b0ar0eTA4LhaUyoRA7FGFf5m0o4y0M/3gb+YbwzRRR0s2ZhW1/hgudqPprjRI05lkmZsXxkh1ngP5SlibpiZ6dHzwww/3ZFPK+VKf0ORE+AO6yp4p7BxHZj/fbQbKaBc2F0zFBzaQwpP5kWuTS6E/6XeF3iWZHYiv9XEf7aHNJWTfylghMowWYVbE+ufo3L9LI/fzsqqK4rmofJh3YDp4oBP/bubc1/XoEvvUM9N1coIeYfVBf/2S+cj/Hge7O8/VY2Ta5EHbfkTXzE+g1qf8f87+7hW+wwXKnxYCA2Hzf0pTL54JjG4i9bsmmt6MQu2HiM2CmNU4s3f7W3XD+Mgh2pr/eCX0+M50iQjrSj3cCfYfZsHC+Sgb5zd71zde41pHmwMrYL3wfklYzFWIiRbNlHkrXK5dMWpyrku9qLIeYsPlTkzGlS0RmOx6P7vpfupXmS/tH9+btBzJG7h3+tiETfojMx7hzTsXkY2Fnt7FDgblmwC2XS5IfxxygG39AWYvf8IJqyelDqLJnaWcZtuWIOIrT5w1s3BlcsZtHmAwp7nnDA4awLxOfwJMtmnWJrv++0dHupoOoM3eGTauFfDIKmLl5F/I2+J+VPinZaAkru3EqM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(8676002)(36860700001)(8936002)(47076005)(2906002)(426003)(83380400001)(36756003)(336012)(2616005)(81166007)(356005)(82740400003)(82310400005)(86362001)(40480700001)(1076003)(26005)(44832011)(16526019)(186003)(70206006)(70586007)(4326008)(6666004)(478600001)(7696005)(110136005)(316002)(54906003)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:37:58.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa174fa0-fccd-4817-f23d-08db6b39788d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add is_sysfs_present API to check whether the sysfs file is present or not.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
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

