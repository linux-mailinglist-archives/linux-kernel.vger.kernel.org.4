Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D845F6AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiJFPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiJFPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:46:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94C83F1E;
        Thu,  6 Oct 2022 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7b3gogijzL4fneQyddF1KSQCjd4lqk0wRaUMXoyGPC02PKG+Dcu+DjWKkblT13aOFHs8sFB2zOhfoZNIw/LbDsm4blW4H2hgUwUDo1cr1mdENTJdywAuW/9ZhSuyRUtRFQjnZjaGJ21f1yuqvI3QO0jo0J3O2x30flLYNUgqH80xOpAt9vCHonNVgwFTyvrNOGJc9VO+Gv/blZVbbzj00hBnqZyHr10Po4qhqjZHC3hVy9Ee1XnS/sFhHEeppqqHPFI5nIGv5zn2lvJ7mf+Oxma5QeLREqTskFxVJzln4VsO8ZMS6KgeHi1IQ+mECB2I+3OE5loFb6+cE4+w5wbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9cz1hNI5roAmy9Idx1qYpg3NU473PKqlOrFZsxihnA=;
 b=JZX33NBzcaeUKj7TF6/GSkF4taZ3803UQtsGTLfVEIjOWM9wW03JrfHxejHdStAn8unPK5CJlXPW60NSlgDMc4IJz7icOcVasb5j5/ZZcw28K6jtzw4perMtKmAJd7+rl2PaZiOB1yYS+DXLaRIdBZ++bGzQNS49oe0xnehQ07uPpyHFeE8ltfuRJqJtAovRi9wN+tJqmNtbfLDZ8aXo9ADV7Vh5avbK+9k/C1zOy/Hu/1bDhlUnil54i2hQFDd1Eh/+3JtNX/uNLIxxAX1IU/gdqZKsg9QiDZTqg7MP3RcFcrDIeEHAezinnYFSoJR6s2lqvNylHGxlmvS67wz+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9cz1hNI5roAmy9Idx1qYpg3NU473PKqlOrFZsxihnA=;
 b=gNM39L/5ONPI6QdO4CpGu8Du902DnuxqKahXpKiHJKtjO5ka6m1VWcnP2lg0aXNdAmcPRxgS8nglismMGj94xnXQJGP8PiyokXvCDKebfx9VxhEcDgiT3Fv9w8tjip9yDiYOwIvDfLTE83DQphTVWU5DTgkTtBlLOHNvD4UjkC0=
Received: from MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.31; Thu, 6 Oct 2022 15:46:23 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::36) by MW4PR03CA0338.outlook.office365.com
 (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 15:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:46:23 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:45:54 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 8/8] perf script: Add missing fields in usage hint
Date:   Thu, 6 Oct 2022 21:09:46 +0530
Message-ID: <20221006153946.7816-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006153946.7816-1-ravi.bangoria@amd.com>
References: <20221006153946.7816-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4fc6cc-9301-4535-3650-08daa7b1ebd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gK+NXpsRxvpIP3H9wBdnllcFVWqe2s0HF0FS2XsFZsSPUdQ3DzBEsyKCeYEFKzqmdDNB0BrSu9EWHKWkkI9ey9+YREc9rrpBCaJ/inQA2mWvtjH60Y75fcwMu/h0nCTIoLow6ZBQ3pyOFXmieI7cKQpD0oRhge/xzrwHNEbYCPc/XKi1o64LGFfJF9/lcZUy//26I7Orn4LEUzIUuke+wmzjwr/2nqLiKhT81qpdnzRojkSMXrHhCYHwmFcFGznSxpLdyM/DTzJh/caasmbeZJ9rqm2z9y1N4dO7RDa5Sw08PCVpyZIx3T2hIvLCn0A/H+AChCDuOfbo6hBKnUW8K8sHlHwMSC0rgTlEfT/jln2DLQsYBuAkIFQFw0p1S3ELHUQIrJDIn185PaUmIYYCA4rOFL8VT9xDR/Qf6YhO2oJRIVxUv7GjNC94K1qN1NVzEb31zPQ+eO+RRKz3NQWhRHP30eJEotDr9gtZd91uTn3pXfYS3iiR52LeStxeeylQGO4L1+lEoxqa4bh+tnZPrigmpNIrT95ovmMs5H84ZysKS/W66VUWdvqQ2BHIelIpAIYoK3IWEPP01OPaFOZE/q4SBbxiaJyXcSo05JFr2DUqB/KTZ+CtMj3Ces7uj9BqCZn6Xy5KXyakG+j2rnVOva18tEiOacJrh9wfkecW47EDjFrycnk2zJ38EDlo/szmIzmbd8NFHValNlyi6ySnT7DGy49qsa6R1Uw9V0OUaRSVqesNduyMGh/TzGjRnqsHDYzcMXuul+sJMc+Wu1cTMXt6EL7WnzdLf1Bpof9SSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(336012)(47076005)(16526019)(70586007)(36756003)(426003)(6666004)(81166007)(2906002)(36860700001)(356005)(83380400001)(478600001)(70206006)(2616005)(7416002)(316002)(186003)(8676002)(44832011)(86362001)(4326008)(5660300002)(82740400003)(110136005)(40460700003)(1076003)(7696005)(54906003)(26005)(40480700001)(82310400005)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:46:23.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4fc6cc-9301-4535-3650-08daa7b1ebd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few fields are missing in the usage message printed when wrong
field option is passed. Add them in the list.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7fa467ed91dc..7ca238277d83 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3846,9 +3846,10 @@ int cmd_script(int argc, const char **argv)
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
-		     "brstacksym,flags,bpf-output,brstackinsn,brstackinsnlen,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
-		     "data_page_size,code_page_size,ins_lat",
+		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
+		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
+		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
+		     "code_page_size,ins_lat",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.37.3

