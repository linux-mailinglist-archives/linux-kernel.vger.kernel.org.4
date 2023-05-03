Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4906F4EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECCGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjECCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:06:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4D2700
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1KuHjiTQrqEax+O7Oi6Qf+ny/e8rxUr02tfWKch0+rm2tLgxd40QJVG3Xo1lbjwh25IzXw3GI6MORyDJz1+zgnSLONiPKfle1gEj0iwLjhk/Ot88VpY7aSwPylDcx89xkpW3xh62+Osu0QS7PCqfYVjQKxXb/DOAkUg/Uo0RD6LHfO5i7o8S10JcchcAtS7GZYSBDLx2cOcBmTOAJcFNiNwRdrGjtWUyNJiVPmQEBEESAzAciPSQk1GypjXYC2vfABIoB1huus9UJ3aFc+m3EVAZhulcC8Oss2XfZ9Y4Nk8sg2yTD0LdSB7++KhoNu9y14DJpVHbOcYPEADSujypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NSBlCz8xCMXbjCQo62cKyUj6pVFVaXwQU03xdm2Tgw=;
 b=a+3pb+bhcBSbo6PS9G1eqM2U/+Gg+1phV3cZv/0GaoMOJXUs8c3WM9vV8xUb+wWM0QYkMDS0MUDA9FBVBJzgDUtSHwB7I9I/arrOpjyfkoqZ4L2BMUqWAFX/DMtC79ASPcXhBDRNi9ESPbEt1WAnaU4w9sV3RAjtx3QF6C20Kwa4USVJ69cCeRvqx2zWW7vgZLdGY3Y1ZS1OGpKjswaVp1JKhpiiw9YkQz2EfJTKqSEcypqfSXFtdkCAHj9CMwXn9ZcMmi2IMGylIXR3SnxWRAI32IJmoMjXRQGk6VgdIVP5P9U1/flyHLK7spyApyilugeuA6Lkz5TmhaxITQiBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NSBlCz8xCMXbjCQo62cKyUj6pVFVaXwQU03xdm2Tgw=;
 b=Zy/YQ+9l7CXzGRtV9waTkX3XOILR3EOBYLbbyVNz2WFmOqAcleJErve6IS6VEmFtEEPaMHX87BAlGMOhRPCoPTyjES9BXVBTbwsT8UWo5bqGmeosndfkP0dIRNh9WSVV70XapfpS5ir6ZR4PbHUSHpMu7xLRjzAclXIESadsGkc=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.27; Wed, 3 May
 2023 02:06:41 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::e5) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 02:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Wed, 3 May 2023 02:06:40 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 21:06:36 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 2/2] sched/numa: Introduce per vma numa_scan_seq
Date:   Wed, 3 May 2023 07:35:49 +0530
Message-ID: <d33b897912b91a118006d83dafc29c6ebe548361.1683033105.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683033105.git.raghavendra.kt@amd.com>
References: <cover.1683033105.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 99af254d-92aa-494e-3ffa-08db4b7b091a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hpY/bkoeOJl1NcUKrxEdLPh9lQKx9iqVb2oNVuzDoywOQIZHA+rCjlXhKg3SMeLC3lCKbVze8kmykuUzXAYXwQSZqHQ9Fo5bIsC+JUnWCOfc1XWPhp7MHiVJ8lZmKM1yas2RxUXOjsTAZL4FciCQnmpWmmbnkDrTCPh7WAczWat/kRpZ0ovsNaOQF/TVTQ5hC+nuntpT2Y30q0KMLBt+TCJiIsGAvZCokns9qxtMw8CDqw/iSxrIcWU5ScnWsXh+i0tckJCmTxR2SKjTxKN2fxFS9qdsUHjHl09yQQHifvGtEkGgXWMCRxePvnP08ZWBdUhXUKfQEP1m8IWyK7C/YDsdb+sLoY1WU9zOCOvSbaT8NLrM6uAoqnfEGH8HS2jDGDP6oacBO84cckiCwTmq4YQ3S61e5vIcJ2Uwq2kYo2y1wxeACwOz93yYhgra6CENGidFmjc1HvSsjkGeU6/sOgKuk+9kqwdEY/S0fwaCjaYmXHtSI5YvulSi4voGFFr0C09eNiWSSOCf1s0ectK4L2EE1W9yIfrm6gp2ix3Q5LmBESlDN6rBbEEHz4qVL73Gz/ccI7e72E4Ynnnyrh6mHjYAh4ceAKeOKmS8Nz/9Um5NuEWcs47Z+hFMk8XdXtox3XnJKiZ58c3ujGzQ5wWU8y9OD9S2i3aUSP3lvrf28/Gd7TfjCWAz7W2VfWDiVEO43lcBnHb2XlCBXR6RGvnoESFs38VTOlOE2nGonN8K2jkEJ9jZIKv+E/LFdX+OlLY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(82310400005)(26005)(40460700003)(40480700001)(316002)(7416002)(8936002)(8676002)(16526019)(5660300002)(478600001)(36860700001)(186003)(70206006)(54906003)(70586007)(336012)(47076005)(426003)(83380400001)(41300700001)(110136005)(2616005)(356005)(36756003)(81166007)(2906002)(7696005)(6666004)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 02:06:40.8051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af254d-92aa-494e-3ffa-08db4b7b091a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

 Per vma scan counter was introduced to aid disjoint set vma
scanning in corner cases. But that counter needs reset regularly.

Reset is achieved after full round of mm scanning by per vma
numa_scan_sequence that follows mm->numa_scan_seq.

Result: With this patch series we recover mmtest's
numa01_THREAD_ALLOC performance as below

Base 11-apr-next
        w/numascan      w/o numascan    numascan+patch

real    1m33.579s       1m2.042s        1m11.738s
user    280m46.032s     213m38.647s     231m40.226s
sys     0m18.061s       6m54.963s       4m43.174s

In summary: it adds back some system overhaed of scanning disjoint
vma scanning, But still we are at huge advantage w.r.t base kernel

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f66e6b4e0620..9c0fc83118da 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -479,6 +479,7 @@ struct vma_numab_state {
 	unsigned long next_scan;
 	unsigned long next_pid_reset;
 	unsigned long access_pids[2];
+	unsigned int vma_scan_seq;
 	unsigned int scan_counter;
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c50dc3893eb..dc011a2a31ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2935,6 +2935,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	unsigned long pids;
 	unsigned int windows;
+	unsigned int mm_seq, vma_seq;
 	unsigned int scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
 
 	if (scan_size < MAX_SCAN_WINDOW)
@@ -2945,6 +2946,18 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 
 	windows = max(VMA_DISJOINT_SET_ACCESS_THRESH, windows);
 
+	mm_seq = READ_ONCE(current->mm->numa_scan_seq);
+	vma_seq = READ_ONCE(vma->numab_state->vma_scan_seq);
+
+	if (vma_seq != mm_seq) {
+	/*
+	 * One more round of whole mm scan was done. Reset the vma scan_counter
+	 * and sync per vma numa_scan_seq.
+	 */
+		WRITE_ONCE(vma->numab_state->vma_scan_seq,
+					READ_ONCE(current->mm->numa_scan_seq));
+		WRITE_ONCE(vma->numab_state->scan_counter, 0);
+	}
 	/*
 	 * Make sure to allow scanning of disjoint vma set for the first
 	 * few times.
@@ -2954,8 +2967,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(vma->numab_state->scan_counter) < windows ||
-		READ_ONCE(current->mm->numa_scan_seq) < 2)
+	if (READ_ONCE(vma->numab_state->scan_counter) < windows || mm_seq < 2)
 		return true;
 
 	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
@@ -3078,6 +3090,8 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 
+			WRITE_ONCE(vma->numab_state->vma_scan_seq,
+					READ_ONCE(current->mm->numa_scan_seq));
 			WRITE_ONCE(vma->numab_state->scan_counter, 0);
 		}
 
-- 
2.34.1

