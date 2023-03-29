Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63EB6CCFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjC2BwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2BwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:52:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A92E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE1W+1Yn4e1GuhToKTgyqqQkSt4+1nf9pHRzq/K8aayY0TJbPJS0et8BsoHq1HG1W03UY3GakTiWe3U5A9E4tvwD2LCujtjswNxdtsJLhIjkRyDr1/KPL19g7Wbn3gJzoZS/jy5JSjLT5t0T1v0XHzVOSWmQ0SFN+rDVs2LTC4W7w2XCc60wPyK7BC0DIU9zhP0azqzXf5KDGfBPAhLwdwoKahoV2mCceshQ03OxAfezseBrpxWzOWxXO7iiOqexidINe+G/uQq9Tvw80dcUxxcJ1gsn6I/mYfTjkyEW2R4UfSTWHT62M6L5VLKqPsbwApWNSJk/9ZkRRBwZ5na8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpPRzCVoU8SBia0TGgRHF/JJ9H0otrGk+VZwN8hLMXk=;
 b=KRgYRppkUKFnsx+n+hctGeHSkFOUE7uU9CIb8JQvx2wJBguzEHLCmoT5dgIIN47yFOwp81Yx1LJU5+FbXqylrYvPa+lAw0pFTPw2IWJedW2+NR/J5rRm7YGKbyuERXG3nhzZ33oDetKQbDdysMV0iY8yHnzMS8sk5S8f7AtOH0q55oD5oI4AY39ZdAaQacs8UO8txGD6pR7jLtK03GNmc/BVca3Q/FVEpNgEUdYHj3Z8lBeA5FA4cQAR3cQw8TMute61U2kh6zY0pPkTO2YszRGHp4IzVQ9D3CfUVakCy84htLrHoqdJN3sjJdODQF5ID8hUMwmF9DlTuT6S8HQs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpPRzCVoU8SBia0TGgRHF/JJ9H0otrGk+VZwN8hLMXk=;
 b=gUOrB8TbLJi8mGzf2ZQ55hT+vglwjbXZurXTtNRT/W5rqAg0XtMiiUBpTjwMH1tqn2SQPzTTJSbGjkDKL0uWt/JqCDS44N6WcG5UfMYBQj47XEkIpGz/pfbrjvdH9prIUIEh+jHg+RTnlHpUZLD8N5XVqSb9qq6ktRjhH5NiQqM=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 29 Mar
 2023 01:52:00 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ca) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 01:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 01:51:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 20:51:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 18:51:58 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 20:51:54 -0500
From:   Wenyou Yang <WenYou.Yang@amd.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <evan.quan@amd.com>,
        <mario.limonciello@amd.com>, <bp@suse.de>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <kim.phillips@amd.com>, <tglx@linutronix.de>
CC:     <weiyuan2@amd.com>, <richardqi.liang@amd.com>, <ying.li@amd.com>,
        <kunliu13@amd.com>, <gpiccoli@igalia.com>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Wenyou Yang <WenYou.Yang@amd.com>
Subject: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Date:   Wed, 29 Mar 2023 09:51:48 +0800
Message-ID: <20230329015149.870132-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329015149.870132-1-WenYou.Yang@amd.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: e5581fd5-11a5-47fd-72d9-08db2ff82f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tklSoLZxpcSdaRow6cPs65gwtZnDOycajN8akLuB/0CW9wdwRlkXZ/DL18h+edTpj4Xf9WdtTIjcugeYkgXLu+eRfiOK47TVmfmcy3vIgQpQtXgkMl8YkMrCmhWWzCX6L8amPoHz0tR2tEJ1nDuZKFo2Ef0m7Vb6HqloA5BwKbXyHVMD4npLM420K3eJrd/wiOSo1tRP8onfGPCYUpHygo7+FJczvDDy1iU75+5YuQi9ZrQ9RtDjCqI68md4porJrdGwmpd/KBp1vfHcnuDfWJzarll6TipGypHiHPbDZV8W6hpPBIZGEhQ/6hrf+tkbRfA1XM5USLA8q92PID93Bsq/2J877Y2gv7GmDvWGXqds9UOv78QAt/Zx7W0bora4RdJrFp+oO1qoJTlQ56ZhuEcdeDZD+hg+c5SUwM+Uff77/911nYcRWXsrj7YwTu/7/zNQZE7KSa3kouESc0wT8thfhLxZVvRvNaSDXoCFkvJajYVzs+Ue5WPAa6JmPeo96YmzlkBsrMy1e0hV/zPgplVdX/Mo4u6O83o3k66BInCvqfgPu/hhDuB5Nek7neQQGqkKTOrJJX2duReSfON8YQdQ/MWNl/7Lx6kppaDn/2kW8a7BvL7pDnvUrWC+6P3VAaVj4tBBmsDBKGIsfp9Zq3GQgzVVgd6ZSgDLviH6ooqqvKJVe39kuUyQs29p8Ci3CwA91GZs5wyVYl1V4CivMceWACY81CESE3Ywbur5dPdtpJ+OuhB67vCp9NvNOvtl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(336012)(36860700001)(70586007)(2906002)(921005)(40480700001)(356005)(54906003)(1076003)(316002)(4326008)(86362001)(41300700001)(5660300002)(110136005)(6666004)(81166007)(8936002)(40460700003)(47076005)(426003)(8676002)(7696005)(82310400005)(70206006)(82740400003)(478600001)(26005)(2616005)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 01:51:59.7683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5581fd5-11a5-47fd-72d9-08db2ff82f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the notifier chain to notify the cpu SMT status changes

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 include/linux/cpu.h |  5 +++++
 kernel/cpu.c        | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9d..9a842317fe2d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -213,6 +213,11 @@ enum cpuhp_smt_control {
 	CPU_SMT_NOT_IMPLEMENTED,
 };
 
+enum cpuhp_smt_status {
+	SMT_ENABLED,
+	SMT_DISABLED,
+};
+
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..1af66a3ffd99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -89,6 +89,9 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 cpumask_t cpus_booted_once_mask;
 #endif
 
+RAW_NOTIFIER_HEAD(smt_notifier_head);
+EXPORT_SYMBOL(smt_notifier_head);
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -2281,8 +2284,10 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		cpuhp_offline_cpu_device(cpu);
 	}
-	if (!ret)
+	if (!ret) {
 		cpu_smt_control = ctrlval;
+		raw_notifier_call_chain(&smt_notifier_head, SMT_DISABLED, NULL);
+	}
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2303,6 +2308,9 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	if (!ret)
+		raw_notifier_call_chain(&smt_notifier_head, SMT_ENABLED, NULL);
+
 	cpu_maps_update_done();
 	return ret;
 }
-- 
2.39.2

