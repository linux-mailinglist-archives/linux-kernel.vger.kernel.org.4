Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A366D8492
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjDERKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDERKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:10:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054A109;
        Wed,  5 Apr 2023 10:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt6KCBmzZMdfI0/Y6Ub1pPMSYN3dHb9Z+1sz6nWNuslNuZYpngJ/hAPjOyzMc2CpYSIcw2oTuIEuBvvKyi1YyWoHdySGzlWru3Q3NdanJMVMX3/1Oc7a2Alv+6VCMdHFDU5/kkstATeq9gXeC/XNYER7+NIr4ZjnOmgn935bO7gjxTQWNuNBeeKp8UFNkHbju9MrjFpu6vgO3/JOkYcOXlM72NGn/VPJ/pZagtEVzLf3dy7Sc7RGHYhNKe/NOsbR33Epr5xNxI1RQdSTcuhRmayoV79o+bq4REFCDHok4G8MbU8rcgOyqY+XZZpCQOGt9/lsKyp/gPONqNSk7PeXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+eSgkQt6IWziQ5+5qJioqEIdig4YON8ybcgPiVaDGI=;
 b=g66qx+Hnx17G0e01iNPKpbiwP3wFFD5yO88auIztvZ6ajuZqoHSDwg14TDJfG/wClJGIhxT4GlCcZHNKyPOKkBQ+OyHBrG8A7QTexUJwQfBBMxWhDIuswEc98+kYG6fsGYpBtYGuwnHUH2pqdMpbhWA1qCZ7pNBhKWNXXTGsRJZvKFw4PvD+u+3vN7mR9Y0rtb7fRKM2m/0VOQOBPtcP72tUEeAgKe9qUvWG8OsygzVa5uWfIH3ex1FtKpEB9uM1r4acGgzKFIzkJUyEXCFcPI9oO2gmtLDBXe8f7q5YATPnPmxNag2ajLCbftC/hHkw7bSK+z2Pz1OqR1Cwqfx1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+eSgkQt6IWziQ5+5qJioqEIdig4YON8ybcgPiVaDGI=;
 b=ncktW3h9GdVw1sXu5+rZdbpbZXBHGKVpqvyLi2vqBNWiwlrBdCIwUdB2nVlfaUMV/cHhNWPoYnv6PW5oUuLvSbLGHHJ0pDuYGhfdp9O0JWaXRnAgrHk9h0HF23r9qntfeBZYNm8aYM3W17YEVoQ4/Inc+dPr+HYxXkhlGo0e+7M=
Received: from BN0PR04CA0133.namprd04.prod.outlook.com (2603:10b6:408:ed::18)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 17:10:16 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7c) by BN0PR04CA0133.outlook.office365.com
 (2603:10b6:408:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Wed, 5 Apr 2023 17:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 17:10:16 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 12:10:09 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v2 2/4] perf: Save cache instance ID when saving cache topology data
Date:   Wed, 5 Apr 2023 22:39:04 +0530
Message-ID: <20230405170906.2510-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405170906.2510-1-kprateek.nayak@amd.com>
References: <20230405170906.2510-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 035eef31-ca66-4dbf-f069-08db35f8a071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3WSiNV2ExOnJkJR0t7ioZ+oVAL1dgpSUpxz3k2htha7QuznKcZoqaFKw6Xi0kRJCYcMmlHmPX7C4f48R9fjE5bgN+P5bVU6EmhqSFgwZJ+mdgyT3pbcOcmQyhyUSK3hAmz2UxzXDFlwmkqrZ/30QuP1Ij/DtnvYGECqQC/tytgapQTbCANQbno/Vs7vz+vmfSNc4V7m5iQVsjEjG5rSu11QrglcVV/OADGQnU/Vyu6IURTAKWoddxjT+ScMfoYuneIsxGgHsYkuFXwMlw7vHsaJ2Cfv6HjT2OopL5gL8sczLJkCA14k4n70w2HZiD14iYZqNpbYb78HZmw7aqd3gEyEGjnAUlhEStDOP4YbrG6g5oLKPO9HBScxGQBPnujQ57vOMoyiVQxBlJCYnLrCmyB/IA4m0NLLV+8dh/aL09bZQb1MuvsfMLYqMqRg4EOvhlHsFRxZ86nTnO4tKPiF37gjVNEHbdOtbS8BfwbiGIhG1b3qGtmbdV2LoBs56wGsh5Tlw8stYtQMNj+8xfF9bWoEKxnN+3R51BGxOVOPNkgg+VOxpY1H6FX/xnzj4PCdOsL18qqF0vimJ169V0pfd9jh1+9PjuIXuinGOKft72ITJ3VK28j4XBk22/LcVM95EfMJA4C0cUFYBoK94sjx9l15An4mC+Y5zeXOh+pbxFVeV+KeIpDb+M1oDQbypTfOQ0NhIGq8OglbqmMYC9ckAAaMxgiXtrx2XONeDkiEpN+A7ey0M0WMO+KqDE5SozRa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(4326008)(356005)(336012)(82740400003)(81166007)(426003)(26005)(2616005)(83380400001)(1076003)(107886003)(16526019)(186003)(40480700001)(47076005)(7416002)(2906002)(5660300002)(8936002)(36756003)(478600001)(41300700001)(7696005)(110136005)(8676002)(54906003)(40460700003)(70206006)(70586007)(86362001)(316002)(6666004)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 17:10:16.2571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035eef31-ca66-4dbf-f069-08db35f8a071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump up the version and save the cache instance ID when saving cache
topology information. When reading the topology information,
conditionally parse the instance ID for newer versions only.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/perf/util/header.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a938738f8775..2daaee5065ef 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1269,7 +1269,7 @@ static int write_cache(struct feat_fd *ff,
 {
 	u32 max_caches = cpu__max_cpu().cpu * MAX_CACHE_LVL;
 	struct cpu_cache_level caches[max_caches];
-	u32 cnt = 0, i, version = 1;
+	u32 cnt = 0, i, version = 2;
 	int ret;
 
 	ret = build_caches(caches, &cnt);
@@ -1295,6 +1295,7 @@ static int write_cache(struct feat_fd *ff,
 				goto out;
 
 		_W(level)
+		_W(id)
 		_W(line_size)
 		_W(sets)
 		_W(ways)
@@ -2886,7 +2887,7 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &version))
 		return -1;
 
-	if (version != 1)
+	if (version != 1 && version != 2)
 		return -1;
 
 	if (do_read_u32(ff, &cnt))
@@ -2904,6 +2905,8 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 				goto out_free_caches;			\
 
 		_R(level)
+		if (version >= 2)
+			_R(id)
 		_R(line_size)
 		_R(sets)
 		_R(ways)
-- 
2.34.1

