Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D373B292
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjFWIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjFWIVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:21:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE12100;
        Fri, 23 Jun 2023 01:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBCfy1cYWFCLGH8RcgZWHuWz/GlzPne33MZvxWRe60YElb0eZrGYayPRqXalyXPymS5rwndjxtZ8myB/Af2B+1/dYjxyq1WQTWYtN1RKXDN1c0L7yS7pfcp0iLr4y+ah6z3ceMsoZx2XK6yBbQMkRTv/JRJV/coO7DavIZE8hzJNWHgfwcu7oNZnm6FdjYsxZHnHbJnK/MdYDY0RU4KEJY3gd4264fNIhAMS1lvQFVYiT/zbC0QubzlYltxkJIlnqF6CfxP29w94Vz8LdZ6wT0Moy1xO6gSbVQr9DzeIWZyvybxx1oB7oqHWQPGLt9dtfGPc2veQyIO0qRRJpH4iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWdvAvv8KtkRvYnreynR/sav7M2UccGUtJPrd8T5Fq4=;
 b=YEE7rWM78FFI8c/zQwtPG8UsKeB7UAkEBP8cRVXfqKwEUoRvDJFZ1kherWPqZddcwmi2VjQZOxm6pAMra+xoC8MBse1zUfxFYlSTYugwSHj0jWC/5lIkLSmKhXGHt9T6EVHD+IzvnZ/AgtC6Z/gewBq9RXuKxw0895S7O4Ed3vbMsKygp8Mfm5pMFlkZoWRfV4dt8fZxrBd4CsMsUnUzfyHZc9xaF42npZi4/th50qtqESCSyw7MRYud3TeCuLlFOsitRgR154ydMkNrYaEJoqOsvJIUO7DWMCQ8dyvVLNpHCpmczPFcetpeLwC48qdnAEVW27/4kW7MTjM93yZhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWdvAvv8KtkRvYnreynR/sav7M2UccGUtJPrd8T5Fq4=;
 b=dY6dPz/TiK7afNNZq7K9ezE/I38WmRy9sHe41aMkKvkgOT8TKex4FqOW2jsosv7XzFazfP4WLbk4yMwDQf0EIETUS3utPi2j7t3BKRJFteldsOh/Lm0QUW/ZBcD9mb/KM1kwT42sbvi/fDwjhQxZ4hBvV1tRcUVJaxK/nAPasXk=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 08:21:00 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::f1) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 08:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Fri, 23 Jun 2023 08:20:59 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 03:20:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <peterz@infradead.org>,
        <adrian.hunter@intel.com>, <kan.liang@intel.com>,
        <eranian@google.com>, <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RFC] perf record: Use PERF_RECORD_LOST for synthesizing samples from read_format->lost
Date:   Fri, 23 Jun 2023 13:50:31 +0530
Message-ID: <20230623082031.1402-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac2e01a-324f-43a8-0c21-08db73c2c6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TflVzXw3O4JUAjsNFyF5QHQOykEHD0ntM8p7siMVAQLUkM4FTqwXZY75eaTSpiTHaYC432CEjHnuF7jWOXee1cvl881kwC91ITK3Sz8mA7+l951JdzjFckSdRHup/vXxHLSVyxjiooIteaPSwoCBca3RFRHQ0VEs2g0c5ko40W8cWGcCEyfJObpju/B4OYgATj6iJhNW5I4TSM78IQ9qNe5b3g1+DXldGs6EpQdHbyXSvTWWRWUx0vL3FPrGFW39G4A4xI05H/QN1pM7dqKwyPOjcZzk21kiXC8lrOz3Hk3SgMFYKchGiR38lkITBrJc9xmwVOE6NzytH0JzsShm6QQ8PhZXf18znYuVJjaYPHkBCTGRZetYfU8owVvv5Wdubm4lckv4lBHrrZoIgHs+mlCuVaYy1a6v8VSu0UoRWOfWZ9KYx9M6R99B5GPtLCjF7PXWYQ8Dv2iFmkanvw2vHE/v9NvncS8RUjLvjac6hj/rtPBeNRleB97myOInxNhitQbhFOzeBxl6722p6pVJTfakffQ93J85S92DMxR9njFd361yVjMoclGw3p9Ri+DZYN4cnLOTR73yL4Q7dQh8N6VE52kin6FBFJnk2KyM59IZzOLnuK5SUVZfKWpN3jnXR7gpFVeLP9OUo4WKD92V7dOpvadUOdodq7bhWwOpvyyi8Ue46oLvr7pfsKnW0jkDxMRTRwS7NgKfymg2aIUvTXvjce+WWL1uf6lhy46L9h9WhJbPdV9gQJrgaoy2KefslKfBxQGlm189/si1JthUBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(36756003)(6666004)(2616005)(54906003)(316002)(70586007)(81166007)(82740400003)(70206006)(83380400001)(7416002)(36860700001)(47076005)(44832011)(1076003)(426003)(86362001)(2906002)(7696005)(5660300002)(8676002)(8936002)(26005)(40460700003)(186003)(16526019)(336012)(41300700001)(40480700001)(356005)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 08:20:59.7454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac2e01a-324f-43a8-0c21-08db73c2c6b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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

Currently perf synthesizes PERF_RECORD_LOST_SAMPLES samples for values
returned by read_format->lost. IIUC, PERF_RECORD_LOST_SAMPLES is used
only when hw provides corrupted samples and thus kernel has to drop
those. OTOH, PERF_RECORD_LOST is used when kernel has valid samples but
it fails to push them to ring-buffer because ring-buffer is already full.

So I feel PERF_RECORD_LOST is more appropriate for synthesizing samples
from read_format->lost.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
Notes:
 - Posting this as RFC to get feedback. I haven't tested it well.
 - There is one more minor issue: Aggregated Stats shows count of LOST/
   LOST_SAMPLES records instead of actual number of lost events/samples:
     ```
     $ sudo ./perf report -D | tail -20
     Warning:
     Processed 78923 events and lost 1153 chunks!
     Warning:
     Processed 47427 samples and lost 28.30%!
     ...
     Aggregated stats:
               LOST events:       1153  ( 1.5%)
       LOST_SAMPLES events:        132  ( 0.2%)
     ```
   Not sure if this is intentional.

 tools/perf/builtin-record.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index efa03e4ac2c9..5baed42437b2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1858,7 +1858,7 @@ record__switch_output(struct record *rec, bool at_exit)
 }
 
 static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
-					struct perf_record_lost_samples *lost,
+					struct perf_record_lost *lost,
 					int cpu_idx, int thread_idx, u64 lost_count,
 					u16 misc_flag)
 {
@@ -1871,6 +1871,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 		sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
 		sample.id = sid->id;
 	}
+	lost->id = sid->id;
 
 	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
 						       evsel->core.attr.sample_type, &sample);
@@ -1882,7 +1883,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost;
+	struct perf_record_lost *lost;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
@@ -1895,7 +1896,7 @@ static void record__read_lost_samples(struct record *rec)
 		return;
 	}
 
-	lost->header.type = PERF_RECORD_LOST_SAMPLES;
+	lost->header.type = PERF_RECORD_LOST;
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
-- 
2.41.0

