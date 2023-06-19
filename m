Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE5735DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFSTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFSTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:06:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B8E65;
        Mon, 19 Jun 2023 12:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUuzT1DCh3iaRxUOr4ytvTeTAwDrPy+luTh3+FcgE+96/uOEN+7P1KMeOQuKbMz58X16oUc2PHWhgdskkP5B/Outlv1iUqsM9M1pub4WI+vKluzZhZpN43HMbGRQtf0UfLm70hJNZRiHJyiN07RgTUPXV7M9kwOjswA2xIlrk0RNtrGH687gst7KnuUZPyj9Isch0Ee9ZaurRzKix83zE/PohZuLn9wrhNALkzXuK4E9kcESjtLAcNOB4YrG4Ro1PtS+n2F13mhJkcRQ9OvxiH7kqfZqzMLQUcUMHGGXcUgptMWOkt5LyECllP2ZhirTvHvSreIZOi8UDsqj6JUXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQlqZYlreNSY3LyI7KoCib8kaJACbv3iuZxvQEl5aYM=;
 b=j/2xnWaxSdgFQUBRrC6Rk0PLD7ELtZXwm2Egr+NplBGvSjC9Es2g9NP+ozHaG9tKyK83d01hHmgSzNbZ7ZB7xXGX8MgMtR/4FtYLOENwt827Ja770HWpkUV+8hJTgXLEdtx+FNybfmq78XGS5mzXUSmayVs57tP+tgPqTNz/GaqCu78W4/MWQmpiE89KKS6szEQkckp04hwABXPE2GC5JVEjHe4I2vQ+z02yG2vt3QBsa4Oi+MBHQ7SU+kyCrXJM9cFKKnU+eCx2+9J1lsVSRaUCqDsomyXnahEOOE/IIT7sr5nd0shXVMJH0lTBfCm4iKWBCx0W95yGBYQGH6wvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQlqZYlreNSY3LyI7KoCib8kaJACbv3iuZxvQEl5aYM=;
 b=0ZgYgcujxJfH4/xPl+bgfWoMd2mlXeT3C/VyuHzrg3QOPHg/4gSQZzqO4B6SeLTdAgGQSZvHmyKcw7ulsk2BAldx8zXC3sST10SXq6vbj5YiqpcDX+/YNBAWLGyXMqNoac1zZKOJoWDcj3h0vT60VSbYL8GWw+neUfXgqc9IleE=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 19:06:08 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1e) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 19:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 19:06:07 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:06:04 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/5] cpupower: Add is_valid_path API
Date:   Mon, 19 Jun 2023 19:05:00 +0000
Message-ID: <20230619190503.4061-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619190503.4061-1-wyes.karny@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 42badac2-b557-4164-44d2-08db70f83cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DNQltl/dMjhRtYixeqAwHYVMTLH6MT+U98NHxZAIQHqdk+99WkX0Ybnjxe5XVFQoMaNIn4Eihyz2RwB8wXNJoASyRAVQxhkbSPiUA7e9LcNQ5i2HGsabTfgZwENiiLg2qQb6si46v5EsajbD9TCnYLUGdF/M1Mnvl9MiEnlFuyjJjit9as+0Ojz3nSIuNYKMX1BHE8Ee6pWIIHC/VjQ9J7LRHwfnwZdFzN/TB0+9havEJtTy6wAUF2thQUikomaTu/ITrXfk62Zkw2IF5BVMsQ7n9uOayKNPllyqEA0vuaifCgXcV1wH403Ow6d5Bz3sFpANOEjaMvoF7yzEBkI12DzTxkEPC5ARkPkpnBeOWzs3RUHtGOpIbG2O3M0Q4hihrbbLiDxvn4v+iokxIVDj8Dw/Zho8M5DYKs+oJA0Wqtw2RiSoBZgnOXfZdD+El67gQD8CNfIl1Kljg4IDW+DpmSl4enRVw7DENna/khQ7urz/LFYHomYOF2Sd4mNUAiN51kU1iu/gZgJ1VHDY07wpibe4i5HeYqspnW+9dpuZr86bzHR2DNJFl/E2MqLf6kWbrvKoLZsamz1c36WwbsmhbLjQV4LvTj7TzL4FRCrN6P3D8qKeDf5xdnfPcgyimn0oVuETIyrihLMwXZWFVp3cuJgxEZ++pK1E9GjYEwSHYw3Jt4hPXf5pgGgVj8+DSCphlr7R7CuSSgD/n4T511Itij+U912uIx36YBVGCKM9Wa8GsO5PPgb4coE/MEwkeOeiaXkTdFCYUMtcRRcG9gdxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(70206006)(70586007)(36756003)(8676002)(4326008)(41300700001)(81166007)(47076005)(356005)(40480700001)(2616005)(426003)(83380400001)(336012)(82310400005)(44832011)(86362001)(7696005)(5660300002)(6666004)(2906002)(110136005)(54906003)(316002)(8936002)(1076003)(26005)(186003)(16526019)(40460700003)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:06:07.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42badac2-b557-4164-44d2-08db70f83cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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

