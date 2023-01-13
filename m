Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4F669CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjAMPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjAMPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253B7BCE3;
        Fri, 13 Jan 2023 07:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMjJ98GcQajoLAEsxuKYG8djQ/r8RXZ+oZCMzheBW9lq2X78WY2C6q5ZeSM1xX7mJ411/1tBbpGmfjLQ0O4GIRZ5MIWMCMyDDHuC2vhVP6MIKBU3gQ/4z38Mza1Lf6DHZQaFpFGld5R4/6HBJacNzZXW8PiasmunasQ+gGZ53tdUzBxc/xw6rGVQB7yDnjBezkU9M/IGhZ80P0g/rFVE4mve206Rmt70PF7w8uAPa9Etu9QVtf/+b0jfXhKTGMs7um3rHPEugf6S9YbUPlCjhQpdwzmq+erR3basqiZ2RoEe+79BC91UGnGM4gHjxgS1Pj+WSIbFzXYuQLP1YO9kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWsoBoY4ZjUGfX1NS4utLuWqwyMK3nBVSacNNs4Ti6k=;
 b=L0XEpLJt0ABXeQKkvM+zI7STNPTW5GkCNU/M6WAqh5ej7urJEYiWtSfpCtZKH38Kafgd/M5SOn9kQ1WbfYUVRdTT0er8zfQEk66k5fctzT0KtLnfDO70lWLe/hM7Q3ygg0dh95D7JnZnTbFZs5HtGunmJ4i4C9eKrKI0/p5DvXVyRAvYhSQHj5uJHFy5LVUNJ5ADeaXf2b3SUnXtxHuBIF83Moddpxhoy0eOBFpzp1RA2MAjctX+1TRarXoXBiSoN2GJjhjB3KLlor6lb3pPyrHlttpzg7gbxrHPjFHpufcWbDF2tpsUuXVgoN5xpMJJqm2pF5CMA7v/aHLkcjP4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWsoBoY4ZjUGfX1NS4utLuWqwyMK3nBVSacNNs4Ti6k=;
 b=IpJwVqGmUcl19TGPLqCZoZNH8zaYIMTdET7ItYOQwoRWtxTENJKHHnJAVoV41SyMOK88Ub+vCEU2SSoNwinB3NkLVu9v5lGSvhM2tH9DdbFJh5Gr7oTus7lNccQpkvPAkxWcIgUe6Bbv8YeO1b2/R6hQfpbImzw52CeEpeDm6sU=
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 15:42:48 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::70) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:07 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v12 07/13] x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()
Date:   Fri, 13 Jan 2023 09:20:33 -0600
Message-ID: <20230113152039.770054-8-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b28ed0b-cce5-4c3f-42f5-08daf57cd201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpoD+stBsPuYQFlAlhtdKbW1HTXT4l4cJRZx7tFvDovVhyyrEbUlVYkoiQTNHsERcwdtzKc6VoDGK6h+DgLlOUDWO0WHOoMJGhAWO7FWtBrs7D7cRwkMRAJavMf/zokWOxRlcSlHPtS3K0pXhKGsHWbzZBP6ztzkOafYUoROdD058rNI1QfmCc8NcqRXPN0WnEK6wGf9PKwP2sBCaZkc8FlqjJFtZOwt/m3yQNjhx7LAB+iyZQsXEgcQ+57EFE1XmaKWNZB2E6AkSlzoSSTWHa6rVp1ZK70FCxSY+r4pdEnunMBUfmt6zRgKZtByS7RRQJZF4csBtEpJo/+iW0oPW5Pp7HfF1G4rlPOHZwX2pnkJ+S9e5pOI7pePcay/MX5qNntUhrvswsoaymHfwDrAGnGhgonLdLztKJ1QlRNtcRQPpbJAb74fhkqXpqn7/l6+T8zXjB1hAw/VbShMYDyJZVwnGy42yZobcJ1Nf1gEmfCOPgW+if/pH1dZhSB8g26XbXDqc+SngeerFZdlruA7kcHXeQGf85NYmOeiqVJi2BUMNrAPiDxtnweKURlKyGL98u+ule+LAoIXbveeVAQbd4Tjxp6SV8batpRop8EwlqMH7MLuWW8+iY+r+OxYB9g/Uu8+PY8vlzgebEFFo8czyK7VNN8WYGbLjKVpIMWLJoQ1juAgzWZmYk7ZdCWF4ICBqYimWfWk2J6OyX6W9DWb/cAAEiFFzPuYG5spPfR9HgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(426003)(83380400001)(82740400003)(47076005)(36860700001)(81166007)(86362001)(356005)(2906002)(44832011)(40480700001)(41300700001)(7416002)(7406005)(5660300002)(8936002)(82310400005)(40460700003)(6666004)(478600001)(2616005)(336012)(1076003)(16526019)(186003)(26005)(316002)(8676002)(4326008)(70586007)(70206006)(7696005)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:47.3769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b28ed0b-cce5-4c3f-42f5-08daf57cd201
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an upcoming change rdt_get_mon_l3_config() needs to call
rdt_cpu_has() to query the monitor related features. It cannot be
called right now because rdt_cpu_has() has the __init attribute but
rdt_get_mon_l3_config() doesn't.

Add the __init attribute to rdt_get_mon_l3_config() that is only called
by get_rdt_mon_resources() that already has the __init attribute. Also
make rdt_cpu_has() available to by rdt_get_mon_l3_config() via
the internal header file.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4fc851f6489..030d3b409768 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-static bool __init rdt_cpu_has(int flag)
+bool __init rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index fdbbf66312ec..f16b8bc5448c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -512,6 +512,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 77538abeb72a..5665ab9725ce 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -763,7 +763,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
-int rdt_get_mon_l3_config(struct rdt_resource *r)
+int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-- 
2.34.1

