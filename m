Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5704F5ED9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiI1KDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiI1KCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:31 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F82E0FF;
        Wed, 28 Sep 2022 03:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzhLfVQKwaimjcWxHEjCeVifAouwU7hQc+q88dCgUWuoFfwqhP7Sz0Q9oBFdtqpVYSiC/yvj9r6/osngQZieKsYvcerF7zpl9BISarmZnukx1a2GkWIhACT8vAf/LyXX9IbPc2uEh7i3qkfN6fnWSM/LBWhaTNvPn8DHNN1atwtU+e2KyBj5LpfdarPYgO7gLWOLYWoSKcQB2ZX6+qe+Uy1Ydlph445anZRoQrT85RdybfUL4DhbaC/lEQYf0Y8an4UFDXvPJdkmss4VcrWAzesN9q50+jsLsu5uQGtrgwcZcUjyXQZ+91zHfW6bHBg3z0FdT3+eXhR6V+KMxdAENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmb2G5QcfFQboEDm+KWl1a3s9i88sviuKad2xKyukj8=;
 b=VgiUti9f/UxhnTKjqr2psTVFzmRa5JkDQKUeVcfWlrHExRBAgeQmHSFbG3Qnsspq8WEyIyShxPw4SZojI4N+/GYasNP9vgAgoNO1IvBuzGchjdAFwf1gVtCN447fXFrCNIlhIcnLBmL/fnjmfG5vD7maBKhflePaC2GFbKktZeRzl0wEmjt7tJ9IWM5k0ojTeVoCPpuZj9DjinRRmqoQTFh43Di9QsgUxPjH+YBtlEA7BGZ2Hf8j1Et4K4e/EuPcd8cXFmqPlImbAu8Iwekmp3w7P1Z4oo6B/R21WnhJm7hZLYekdGK1Z5dQQhGrM9V+p9geamLKNDarmY16rIsibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmb2G5QcfFQboEDm+KWl1a3s9i88sviuKad2xKyukj8=;
 b=RbEOwauFVCx7SaTVaFQxjprftsqRanTTfPKoI/mtnqeV4EriHPiXnOzrhx5y1Tt+UY4xJkUDA09ZSuYZOLeM5C02tcJiYfmVsQiqJu1RNsVZ5AJOBRn9v/j4AGvmRM4ConZnw+viVa2+msoBibmkKs8pJv4naL1XNI8V9e8StYU=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:02:17 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::ce) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Wed, 28 Sep 2022 10:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:02:17 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:02:08 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
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
Subject: [PATCH v3 15/15] perf script: Add missing fields in usage hint
Date:   Wed, 28 Sep 2022 15:28:05 +0530
Message-ID: <20220928095805.596-16-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|BL1PR12MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7f4755-4820-4dbc-47d8-08daa13886a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AK8Gz8N+sspoqzkdsKgpeLCDG/X9FlBnmr0/6BrKP2VhTM5DIlT/J0nipszMn4YhHNaePiLC2oQVflvof3OxpngO82sFp2WzNwT6bV3ok4BSKf6tBNCNxsl233Llqv/BTHD4cevlW366ks8/EnaxJkaHGzbM6qER6ILxpYNmoS152Qyd2w91CDANnrSo7JVCy9FsWMj2uLI7JFXiFyoziz97vxVIAjmuIuQiN7lXCjuCkQe/gsIUNkbfJQIdue4kaPkgdZToeqAtqz6HxrpaWlLlSIIc/jxcleXEYE4Dw0N4NRB5le3uAyJPriJX2fizAIl+sTgdzl9Tni/wYoz3zs+N8drc1+OpTvVXQoduQycdEoYX4sFD2W3FZST3xrgFwcRDGPZTKkkJ7IEs091QcIrnf5m/B/QXr9U0MKqKAa0lNzmq39TiLlyBwxMjyi82GWvKOvOK5/DKdJXC925TYDI7rgqt4wf4u1M9amXCQKZyGe/tELP4u0GQpddk21ySpvXJGGQWUeK+PdXZ8trPLXh9TbGTOzRXkXgJ3NF5rHgHsqOVc7IO7IPYyzgm0qWASFII/30Rvm9R5JqQqK63slBwHSFFcFqSrNtUmxrHd+Bxe7vrXlqgBAti6QAZhQg3SnlE6VRDsmFQIM+f+k/m19Id+qpJXQhqkSKSdN0NMW6lJHQGC8jDXC3erL36eMXvAkmBrZLhB6h3ijAIHAxmKFRLNfzzoAO8LXd4F9pPIqIpAEMblqjYQohAzD5V14x395n6I7i8BCuZlV7oMQf2svUowrQFdUA4oA+JveZLn4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(82310400005)(7696005)(6666004)(186003)(1076003)(16526019)(110136005)(316002)(2616005)(336012)(2906002)(26005)(70586007)(54906003)(426003)(83380400001)(47076005)(41300700001)(36756003)(40480700001)(8676002)(70206006)(4326008)(36860700001)(81166007)(40460700003)(44832011)(8936002)(82740400003)(7416002)(5660300002)(86362001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:02:17.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7f4755-4820-4dbc-47d8-08daa13886a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
index 13580a9c50b8..b2bb3395e775 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3844,9 +3844,10 @@ int cmd_script(int argc, const char **argv)
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
2.31.1

