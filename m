Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08297663904
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjAJGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjAJGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080544371;
        Mon,  9 Jan 2023 21:59:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoPHXjyuz/Oe7pkaVt4c1zga9AC/eW9951JhaehuPlGbJ50KIDlA5ww95yR9tpp8iKAWioYoT4d9MLtb9Nk/oeZN+6ocyOV6/GooRgsGmpHm0/Zuy17Hx3fMN2o6Dp26Rgy1EOEskIGy2lvAJ5EvNDzBot5tbRaIblf/b7t6WD5me6oqyo/e0DFErcMZmsNu/BXzUB8VD64GoTF9vIf88C0jdiMbE4XM1HPj79IbmDXTKFfEJMzlvYsQP708fS3blzb09oozWJeeB39w19mr/vOgL8h0RuxwIrXjKgQG8hIY8Gadx1iwYsYmVoJWzq0z7LBvAintbqcqhIaAptnXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lplkz+lAazHD+3sif5dUaHrCRNmix/vE8XcjyeC5p1I=;
 b=HtKz5t+PkzUklAnhDK0eX0vKGfOhcAo2zgdxiTQeucdV9wjKu17/jwAqnWpfM14+wl28caFezRxN1csGjQ241OOUQXuuhvt6nHdlQR7V3sRoCpcBsoXT/TfzVJGXnfJhJXlfHoRYJM1fOSnIwAws2K0Nelk0w0/xCwkOGO2vE1vSiKXFeMpu7fdhGTDCMThFH9SxKjUJaOE6BdgRoyGN4jJhOA+eZjKI659SyD8WNIYhF0E89yjS97ZtJl/djbVXNRORGu8xDRM4KCjabUqCWWFRgCVGtVDer+4Je1hKtQHvKRDcR2QP4WfhQin7Pv+rhwJJF7nPQCAYmMNsmTM6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lplkz+lAazHD+3sif5dUaHrCRNmix/vE8XcjyeC5p1I=;
 b=Dm6Fc98FdZeWA9A4fHGH3NGMBag2xp2A3/vvROK4GbzCAoMrFCsMjMl7m26bQYVQJ3O47FRZBmnSjd6hM8VJnFYKxb/RAqkK5CTbb+HjsP75DNxW4b8H/eq5+XQ+uk3nsDvD/UXxhJwBbH7thnetmh3nFimOY9F1nVUJhcrYIk8=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:59:46 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9b) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 05:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 05:59:45 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 23:59:38 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <kan.liang@linux.intel.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <james.clark@arm.com>,
        <german.gomez@arm.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <alexey.v.bayduraev@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RFC 3/4] perf tool: Introduce PERF_RECORD_KMOD_SEC_MAP
Date:   Tue, 10 Jan 2023 11:28:58 +0530
Message-ID: <20230110055859.685-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110055859.685-1-ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca15c03-a4b2-4e60-e073-08daf2cfe014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXGSnpwzGj9HsYf7hDWryyFVrpTskmoeI87Gu1Pu0Sg2XqgYg9DoAAee8+kjLNPbZQ0agP2/9670qLJwRBvRoE3IlC8TDlGXPYt3ja73wKgFN4QaHF/jrCtEQwaWFrsz+NjnpzQnNY6c1ITl43ZvTd4ZYUHBlDWRGgQPdAR8mMzASK0KQ3bbczBbn/mAUqQlZCyZ3zpptNnHhifY89plPFNKF7d8BsVOYCPofTgdzkAtnqq3zETmHpna1JMlkoLQt+hZdnRHIy+DXR7vGq0rfaMH6j69RvhfpQeZtTJai/xvf7MxdKK2VPTpCONrkSlbseuOEwi+9lJWvkfkbtbmzoJT6qaNmVoufgrT0KZcmCGctMkuBeO9cb9+VcssIHWf8TweMVHyow8oillJy4E8SSZO24N/SfdYFrXm3DbAjIn9WNnv3oKG3EMft1WRtIJlSoGPu+8LEZ98LQ7AjzQLVvvRcPolXnd0bZdz2tUR9e+HqwIfLaXqLa+q3rc57b8/HwakVkDzpktFUsiaY0xBo/LSUol2nSA/8BPjihIiOWpjcrfcoA/Toih0TTukFiEvOTCvwB88n+cPmNaQK9Qf3t8GzU/MbVE+7OO6MXIjnqOMkZXSLfG+BBD7ispFxrdr5JotYkV4bNvO0nJGFq0w3eEuCgeULi/c+X3g6DZyzFcPCi8fqEbR2g3RDkP6FWm8xswiZOO+YcdUHvHJfxmLa8SKvViKl0l+FvxaDNiGK2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(70586007)(6916009)(316002)(4326008)(7696005)(70206006)(54906003)(356005)(44832011)(2906002)(5660300002)(40460700003)(8936002)(47076005)(81166007)(7416002)(426003)(41300700001)(36756003)(83380400001)(36860700001)(6666004)(478600001)(1076003)(40480700001)(336012)(2616005)(16526019)(82740400003)(26005)(86362001)(186003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 05:59:45.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca15c03-a4b2-4e60-e073-08daf2cfe014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce, perf tool only, synthetic event type PERF_RECORD_KMOD_SEC_MAP.
Also add stub code for it. This event will be used to save/restore kernel
module section maps to/from perf.data file. This is needed because kernel
module elfs does not contain program header table and thus there is no
easy way to find out how kernel would have loaded module sections in the
memory.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/include/perf/event.h      | 25 ++++++++++++++++++++++++
 tools/perf/util/event.c                  |  1 +
 tools/perf/util/session.c                | 12 ++++++++++++
 tools/perf/util/tool.h                   |  3 ++-
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index a8f1a237931b..b62730b84cc5 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -211,6 +211,7 @@ SYNOPSIS
   struct perf_record_time_conv;
   struct perf_record_header_feature;
   struct perf_record_compressed;
+  struct perf_record_kmod_sec_maps;
 --
 
 DESCRIPTION
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ad47d7b31046..404b23b6902b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -438,6 +438,29 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+/* Kernel module elf section maps */
+struct perf_record_kmod_sec_map {
+	struct perf_event_header header;
+	/* Machine id. Same as synthesized PERF_RECORD_MMAP */
+	__u32			 pid;
+	/* Section start ip address */
+	__u64			 start;
+	/* Section length */
+	__u64			 len;
+	/* Section page offset in kernel module elf file */
+	__u64			 pgoff;
+	/* Section name length, including '\0' */
+	__u16			 sec_name_len;
+	/* Kernel module filename(path) length, including '\0' */
+	__u16			 filename_len;
+	/*
+	 * Section name and filename stored as: "sec_name\0filename\0". i.e:
+	 * data[0]: Section name
+	 * data[sec_name_len + 1]: File name
+	 */
+	char			 data[];
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -459,6 +482,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_HEADER_FEATURE		= 80,
 	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_FINISHED_INIT		= 82,
+	PERF_RECORD_KMOD_SEC_MAP		= 83,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -499,6 +523,7 @@ union perf_event {
 	struct perf_record_time_conv		time_conv;
 	struct perf_record_header_feature	feat;
 	struct perf_record_compressed		pack;
+	struct perf_record_kmod_sec_map		kmod_sec_map;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1fa14598b916..1b03061440bc 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -77,6 +77,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
+	[PERF_RECORD_KMOD_SEC_MAP]		= "KMOD_SEC_MAP",
 };
 
 const char *perf_event__name(unsigned int id)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7c021c6cedb9..4f5165cd58de 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -563,6 +563,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->compressed = perf_session__process_compressed_event;
 	if (tool->finished_init == NULL)
 		tool->finished_init = process_event_op2_stub;
+	if (tool->kmod_sec_map == NULL)
+		tool->kmod_sec_map = process_event_stub;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -997,6 +999,12 @@ static void perf_event__time_conv_swap(union perf_event *event,
 	}
 }
 
+static void perf_event_kmod_sec_map_swap(union perf_event *event __maybe_unused,
+					  bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -1035,6 +1043,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_KMOD_SEC_MAP]	  = perf_event_kmod_sec_map_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
@@ -1727,6 +1736,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return err;
 	case PERF_RECORD_FINISHED_INIT:
 		return tool->finished_init(session, event);
+	case PERF_RECORD_KMOD_SEC_MAP:
+		/* Currently PERF_RECORD_KMOD_SEC_MAP is supported only for host */
+		return tool->kmod_sec_map(tool, event, &sample, &session->machines.host);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index c957fb849ac6..8ea7fb85c196 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -60,7 +60,8 @@ struct perf_tool {
 			unthrottle,
 			ksymbol,
 			bpf,
-			text_poke;
+			text_poke,
+			kmod_sec_map;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.39.0

