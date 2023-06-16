Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F67330D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbjFPMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjFPMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:07:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7BB30EC;
        Fri, 16 Jun 2023 05:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk39yDq+8Z9OkyG/lKZULMzr5mA2VRsQRdFHe8Z/2VbNPp0ABTphZHM1u411yTTl6ugs50qO1irWflen7bgd5YPpzwhnrfqA1vHrfm5TETVnm5X3LUSpeNH8dFEIaWEVhRgEvN6wAL8axraDRz4Ap3yZTdoWoQ7xz60tbrWmVdjqmC22MtnSFrWh1njpbEzaWDJGP41w3GDSwzYGj9Buoxr2cfWpX1qQ6S/mv9q+jvJmOK/9Ib7ChQzkt3BB1eKOIloMVNbZhXPJ07OP9HK8L7vQvJmSPMXlTkmi9lDu5pBk95HMkmSquhstEX4WoE19X+73Fnr5SjaUq+g8GxFOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msASNRWEBAp4EC0xUpPcYVisOmGSsjbxZ+7Gs974wLU=;
 b=eu5ig4PZZFuxiWZEXMH4FV2bf6w9sweIy5gbWl/3Ffh2cXVkSNzU8KP8GE91QG4AU2gkfsG+G5h++PImdwoedqQl4MJ9LLanpIBjcKtzKqr4Oss/WTxtzc/R5I9MzjlzhlwrJmD05Py2gLRQQzTvSJAk0Hr5EMe841dHXSiTOlGa5lcrDCzxlwkKH2mufVpvJhyXiMsMhqq6A8Eoc8ciIzcRU909Mjm47fRCYQP82itgCTHZbFLo4cCfqPKOuns4GKrMriX7/GBkgCPpctCPThj4hm9g50BoPJ3FiJ/tZhFYEkFke2GjIb4inoul5TG0bmFPAps/kGozjI56Kr/wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msASNRWEBAp4EC0xUpPcYVisOmGSsjbxZ+7Gs974wLU=;
 b=lIY8nXQ4hbrwg4e7c3ssvJJ6Lj7j6ba999czdCmGTaW1nmt2cJ7lvFwWyvNDy9zNOETdjFoHm9gmaMBGv1x2FnRu8/MlDSbxP8lsEfvJyW7h6Ayi0xQQlw7TcbNJ2JC5yw9udyAPDySXML5Yq0LakH4NT9c9+ZCWKSQKtSSjyDA=
Received: from BYAPR06CA0044.namprd06.prod.outlook.com (2603:10b6:a03:14b::21)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 12:07:51 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:14b:cafe::c2) by BYAPR06CA0044.outlook.office365.com
 (2603:10b6:a03:14b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 12:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 12:07:50 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:07:46 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 2/5] cpupower: Add is_valid_path API
Date:   Fri, 16 Jun 2023 12:06:17 +0000
Message-ID: <20230616120620.147643-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616120620.147643-1-wyes.karny@amd.com>
References: <20230616120620.147643-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9083bc07-6022-4b73-2e1d-08db6e624e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDmh+44y0+VfiFIlE3XnWTU8BKr1Js+OqCJb3rDLCecgTVUsSPeTqAsZYm1m6Q8Gd0Vhjw76SNQxI1+p2UdTT6cxuHx9vYmb18VPLA6vCkYFR0UOeyYvlCCMEiVWj1TatbdTGMsXM19Je4p0pFA7QIRrLTPpFh8+fUZQT7plE0+/D4dKCVC78BlJSpSPxfaGXX7rP9U6HSZzNM2VFxkfV7MMIAPQQ5CKMgJfrH5zNB+W6EHGbLCfEUdiPEUjaHPdwzXyGWFR9aily/9J7KPCZRV5hcGUMSBGzwG/9yklWuj+fSQMYmmGCP0juoonJ753/IZ4lJBRV/EKr2PKzNhjhaf+UZeabBpm2vDzRzghX1wrfxjK2EFlVpAJHtfpU/ERQxh7RedggMK5Qj29P3xASR6qnX/FTVgIVrwCP/7YpUNJx6/HLIFdQkKId7GC92QR1DimV4u+T2D+0u99hdVEf/BTNsQg6NFtXENnN4mvfB5KyOZUWNGPo5HNq3MI8ij+3ll+6fsRuPCGUAvNT2PxY4S3xGfwIGTfYwqoN1KxatjYu1DgCOh6nMpfCyVNbgCJmn/WvRN46ioT8YNafJ5TONHnKRTgIZXzG4JCyHbUFK0uwZAXfPEV3+JwYd7reya5wCbNGMUKQdCGQ0AIUWpmXKkMkW+VEpEeq7aQbrDpH6PDTCH0pNiHTjyBbZbHfGr3M1lC6mlsMBtPd7RmpKL/dAVCPHI8u15Psbk7GoeEU1YWMzwk5rS1LXGkP/Hc48YbyeWpEYSzzeW9PxiO4QWvaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(336012)(426003)(40460700003)(83380400001)(2616005)(2906002)(356005)(82740400003)(81166007)(36860700001)(36756003)(40480700001)(8936002)(8676002)(86362001)(110136005)(54906003)(82310400005)(5660300002)(41300700001)(4326008)(6666004)(70586007)(70206006)(7696005)(316002)(16526019)(186003)(44832011)(478600001)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:07:50.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9083bc07-6022-4b73-2e1d-08db6e624e66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

Add is_valid_path API to check whether the sysfs file is present or not.

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

