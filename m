Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8408F6D1672
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCaExL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCaExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:53:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B4810407;
        Thu, 30 Mar 2023 21:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvQJkJMbYJRf+1O7/RnpUyKla7HzzXe4v9XnR5sgDx4Z2ovz+CyBG9BYkPCRN0rkpcAjqB4vONTVpYHh9ZNVbJUatFl5tefI64+AJ4CK4126RsfsUXs1OAom4/Lm1RP8J5smdE+XsVeE0bDKDKV4vMjVvYJAnyERUi0Kmrql9lOdYxiI6T6DZxPYhaXAzbz49ofdvuamvlJoyZFrbg9N8JUO/a/i1y96sMO+VqV328HIWFcZzvDtREgri/x7T74FuiU/VZa3pRqmtqJCGSzL/BEw8sXtfTA+nd76m1MnjTSFZxLZuni9H5BgemQ98a+9J1sqoUbB+7XUiWs2oUc3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wvQVTKx/KvlCmmjcjf6Fqws1HsWp9jn4w2skx03imI=;
 b=RhG9BVAxmsVC0fB0r9K77aHg4SCJWEuHveiVWW9/nJ+AflFsM7EQLD6Sic0Q+Svk1lBtWnw+qxmWAMhfJN0V2/IiQcHMBFwATNUTR40BiCkc/wKPIsg3tUN/3vm7n82PcZD/mBvwlvH/DgbBtHgb+YCSivzUxpT+MELXWLbvluLh1c91Jy69+ZdS2nsbbSTZgcBxNf2+VsXbAuUwshfQqNX1iTc8v+gnlJR9wow9CLsjTdg0JMPrLKoy0HT0cj9JtiTiLC65ATKt2B6mmNdBk7+oax4Hq/AqjODyvf0C9peDyuDtU2aAz3OTtf3ARvOSe0v3TcGZKZnOZaWKw0WDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wvQVTKx/KvlCmmjcjf6Fqws1HsWp9jn4w2skx03imI=;
 b=5bE478IBStxpdGh4nsw25zjqNXjAwILURLZsAt+5KYxNUCW/jPakj4MtAeHi2CExmQULRtR1v3RrFdJnfNJ6qrI9kHsWStbC2N04oItRH9O48e8Ksp6bkoULInVY5RnLiZT9sILPwo3OclzqBsgtT93wfvxliJTcf5irpx/6D5g=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:53:00 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::a5) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 04:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 04:53:00 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 23:52:53 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>
Subject: [RFC PATCH 2/4] perf: Save cache instance ID when saving cache topology data
Date:   Fri, 31 Mar 2023 10:21:15 +0530
Message-ID: <20230331045117.1266-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331045117.1266-1-kprateek.nayak@amd.com>
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 082da0d0-3dca-45a5-988c-08db31a3cdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxcwttx2TkImCwRjKSlyv4nSAzp8aSyAfNYFECuyHXPCqcLQs1UjHbOkAWn75CCNjnrf6FH/l3pogwX3KhZMVxKiDsfhEQ0v2qgKmxNtmc64v9HeEH4WWR0W39bWjwizLtKDIHK3xHAqCdogPjRNyN1L7oXBsmmDAVOFo7Njp/YsDstJSkZ+pwVRERmXsHYjY9SO5P6XgovE4CC7sdztXvAQdkevqrhbwRSOTpwUlIC91yF/Z6275xzONrX3gm6PWrzNf8SAX2UVwFPidpAIzINi4J3Dq57T207DeYeEuNSqHRuOWVSeZEXJVkFl5a7yoSQJG+A8CPaBAX0QK4oYK1S6AC8mFHNMKIVJeh1rlQZBQHnD63zqtBRLB0ulmuii9YKAuP8Zf3/JJVmT5wKNAFeC/NMDJNUkRRY5LLwzSVH+3TNbWLBiW5dkK7RX82isuTY6toTyQjrEWeR6TEzzDQKHeL4R/69Pdp1hlxjf6zPgFGJNnruhhkuTqE+CwQrPycK2155Ie/fxE9adi25HklqH29tFaHZgkIFPXxqrk1HR9m+kbNYBYcuuu6+vbhwsNnJhdz/gDIB66oKb/1CNlVICszj5PSDumnc+aGD4reJQ2zLuoqV6v4x47jxVpcKJnMigukNDS3P0QZ6LVbAwBL/djxF2dR7biZrSRhUzNnXPu5imXjyYE+NYdmmbssI2uJN3uf5rEUe9kcv4POvgqBmNzyuyPdBM0mOLsw6igD+BBA0Ly/ZrK9pBOWzyBFJJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(186003)(82310400005)(16526019)(6666004)(1076003)(8936002)(36860700001)(86362001)(7416002)(5660300002)(54906003)(110136005)(316002)(70206006)(70586007)(47076005)(83380400001)(26005)(426003)(336012)(2616005)(41300700001)(40460700003)(2906002)(82740400003)(36756003)(81166007)(356005)(4326008)(7696005)(478600001)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:53:00.2286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082da0d0-3dca-45a5-988c-08db31a3cdb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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
index 5c3f5d260612..50d66092c82b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1262,7 +1262,7 @@ static int write_cache(struct feat_fd *ff,
 {
 	u32 max_caches = cpu__max_cpu().cpu * MAX_CACHE_LVL;
 	struct cpu_cache_level caches[max_caches];
-	u32 cnt = 0, i, version = 1;
+	u32 cnt = 0, i, version = 2;
 	int ret;
 
 	ret = build_caches(caches, &cnt);
@@ -1288,6 +1288,7 @@ static int write_cache(struct feat_fd *ff,
 				goto out;
 
 		_W(level)
+		_W(id)
 		_W(line_size)
 		_W(sets)
 		_W(ways)
@@ -2879,7 +2880,7 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &version))
 		return -1;
 
-	if (version != 1)
+	if (version != 1 && version != 2)
 		return -1;
 
 	if (do_read_u32(ff, &cnt))
@@ -2897,6 +2898,8 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 				goto out_free_caches;			\
 
 		_R(level)
+		if (version >= 2)
+			_R(id)
 		_R(line_size)
 		_R(sets)
 		_R(ways)
-- 
2.34.1

