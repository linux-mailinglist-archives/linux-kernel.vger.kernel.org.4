Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D675FA1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJJQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJJQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:23:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5B753A8;
        Mon, 10 Oct 2022 09:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6n8bCcHVqlTp9FOBNz0vy2Hgc+/zFKe4L5+0lJfxJcsvYQPTEDEn4LYFKtEjM20aj7bcAJwcQWEaaYA3q81RV6l6QPdBv+Z1lsvaWoM/AvOs6q59YvDw4c4BbZs+KbGp/Af9QXA5awot1S8ci3g3+uXSxcujZZRbxJ4h55jdufvHY/Y7//tDaOdyzeLmy3iX85yGlpYOC4F9WpHdI4xa/OaY7wBbyTaku6hQhrH6Bg+uzXAdzSkDvE/L0uKip8+7HoKhgOfXd8a+sZvr8xWb6Q0lQupJf6hVUgoF27opI+phl5TkRJkVdWZKRU22vJjiJnNkI2oYWL36SbFf1RquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btPwwPHv+BWB3mpjbjX83dVXxe6qjvTS7bl+4/fSJm4=;
 b=f058W9TzCPVR0ezaWw3kmweDVQw+OenHiuCM8RPHQCeAsPhKnPh+aLEChJ7JPte2YKLYVjOgJbty0jG+Fy91UgK7nLB1j7DnZLQ3K3drD+xpOt3fKV1Dt/fer2NldVWof/H4kky3/FztuvCdCRnavpaIZcT1RV8uEqbc3RQQABbP6VWdviAIhiwFWfwlimt8E1Ds5wxDyfw44LjsrQpXegOqL2EfCnf4nQJponCsBK9RM7VEbwMxQwRWaUU3mraYyODKICV1AuOyULqjYhjWttxJmho3K2U23xm+QXn8H7GtyEL39AGxUjGeKvtIfZBPzXADI4Qk7LGntNbH4QbaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btPwwPHv+BWB3mpjbjX83dVXxe6qjvTS7bl+4/fSJm4=;
 b=2zmHJPoFpRAUWXr9YpQf0tI1chp9dB8sldQPGNJtmEvKCtZwmLkHFJHE2jsGLBILRzzlw3yTgjkfKYZuYwH5lggcyP5OJiWs1SVYWArQcRx20xuRxZ+zy6b5IUzsXqCYBzOgZjjodSHU9ZtKssXsus4rbr/JnQQr7wNDXKtGZV4=
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:23:22 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::c8) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:21 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:18 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 3/9] cpufreq: cpufreq: export cpufreq cpu release and acquire
Date:   Tue, 11 Oct 2022 00:22:42 +0800
Message-ID: <20221010162248.348141-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b7ef82-f299-440f-cf53-08daaadbbfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58TY2e5asdT3Q88UEWZ0u646OanqNrjJktUPiaSXe2E4oxmO9j6N68MExnMu4xI4bwRISeu8yi19sqpJB2DoWsfKWuK+MRx/7G5OK30Sw1OTdCODkvCbwfelkRQ2QZsdJm9lt6sBBbBI3Ua8B1aIfBNVjJ+AuftdVDkm+e4w3TLrFW/CwChxcwjVFU5oIypWbocEjjDYzDlWWjufQFNUcn6Seyhlwi24N8kCEvmwxafNBubljHVfLuqW26lN3mazQpjrsx6iE7HLjkFQ8ZBOY+ziUBpGyzcK3eSIygZOwkA633is5hiTVlq/cLR1PmCqsJrQSgwxHFCtjCxIQndcgsO7cXUYf7NA9NsFh52hImnsJLhMbRUsZ8ZfmxKGzm117yz7kxDjAtz77CSLKf9KoY8T9pPntPyuQckZWGFLd1F1eprOmV7ynwe/TxWcLzots+mFBRKyudrLd8MiNJIAFGO1o+ohalyoI4uXxc0h7hF2S4hAZTtombdSBoPmv+fflydPsI3qW/AULvwCgmG+pMYnFh8b6zSrkSXvBlrZx2eo1kwLZUoHjOTsZdE1poxtQtA3N8UinOl1F570vlpTGVajOXZrWZtkkWEdWfqrDEFnT97EZ3Z9WcPbtnMelHaPMSjQR6tyiMHY6iyI5MY/Z3H3zz5yN6OtmK3xKBQKpX2Vb8x0NM7K2ypEteqC0HyNl8+vThZNxB5h8Xz5MPTM6O0X8sM2EQ8/ZvVZbqS/TRGsdmXpt3bchdIg1k/BUmddpELG/2aK5pxrVYIZQqfkeZH0o9xLTDdoYFN5k5LLaYxQq+woKKdK/YXaC2lb5xgY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(26005)(478600001)(7696005)(6666004)(186003)(1076003)(16526019)(2616005)(336012)(83380400001)(426003)(4744005)(40480700001)(2906002)(40460700003)(70586007)(82310400005)(316002)(110136005)(54906003)(47076005)(5660300002)(41300700001)(4326008)(70206006)(8936002)(8676002)(356005)(86362001)(81166007)(36756003)(82740400003)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:21.7693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b7ef82-f299-440f-cf53-08daaadbbfc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
drivers/cpufreq/cpufreq.c currently.
Export them so that other drivers such as the AMD P-state driver can use them as well.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..a491fea4985e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -262,6 +262,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy)
 
 	cpufreq_cpu_put(policy);
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_release);
 
 /**
  * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
@@ -291,6 +292,7 @@ struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
 
 	return policy;
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_acquire);
 
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
-- 
2.34.1

