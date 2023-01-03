Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705465C92D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbjACWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjACWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:07:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B2E026;
        Tue,  3 Jan 2023 14:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXDhfEPUP+BTDEHaj997Dv7PHhX2Jk1EwY+uwHVESX0f63Wb2rcDewiLRhYQCk1B+JqBr9dyfCB7l5PLhe6CKWaeYTn1cQNMPdZzTpe2ZnV1UCEfbm/egmDiZDp/oOXx2madVL24RDRm0qEdS3IcyV8hbI1QK5ITrydwGPFOK6JxSfT4mXYIkrAlMUJe9Y1M20Z1u1gU/PhLajWhkgKj5BinO2AA6YJaci8Y3rpw7upZudEe4xuz/kV+ANw4hcrYZtKcb/VTxg8UducCNmPwHNaxWrLAPv0U7GcW06jqtzdCrebikX0ji3DxXdftGi7mIunSVVKgxfdYnWdYgcb9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf+NVcrXEfYCXvA+xTtaovDfj4mw15ywKxmSHmquV6I=;
 b=eeiaDtouvPxoTRXC8wpgzh8mxz3EEvggA7qPJpennZzScwcP5NJ4bMtRvHLhyDvCQuGFF5pRMPI4+rumSF1/UWl4tebp1mr4GwGQBlzs1o45PPyuNPqnovNQJeaysGzNNgoE1cL0LlMAvijp+M5FgnfYgF7a5ArbePywmsdXWpt6CSr2zyI+sgq2XfJ9AIrlly9mMchBgrRrIsi4oMDprVDsaqGwH38Ntbe6VkCU/StULetWELfReGkQU97LFnLlCsyG6UaR81kFXJxscPdLeOl8mMBUOHWpt5Pgc2d41ZfYDnToY9pw2+bUQ6/pdIl75uMcSGgt7jiS+QQmDAORwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf+NVcrXEfYCXvA+xTtaovDfj4mw15ywKxmSHmquV6I=;
 b=2xjTjSoe7K2BKPoo4dbGfJkotpD8mtS0ePy6xlqxXYDrR+zC6zlRSSHt1Oa4ayqeSwdKjen1+iDDuoBLDKKsP91UmqtMcFQLGlbV47DIitGXDoT9xKgOz0GU9BY3UIeqGjSAKwbpIWEuyffA76lgNr2Omu5BHRnNGcX633yxVws=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:06:48 +0000
Received: from DS1PEPF0000E63E.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::a1) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 22:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63E.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 22:06:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:06:47 -0600
Subject: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the group
 automatically
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Tue, 3 Jan 2023 16:06:41 -0600
Message-ID: <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
In-Reply-To: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1389525f-b800-487b-26ad-08daedd6cf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRx0cpDZTUwfL9QtUuVAoDVfah3WwFZTL22E4WX/leA+h17Dt+fPlRXzIxpmZD+qojfl2XlfUnqaYqNQVRsY8WwOfhlmRkXNOa/D+R4SzFzvDHNbm1lSJ2AK9OUxqCWz6CqCiZz0XvOKHYbmXJumSACiTNl/b6rObTTlgJkTnRTjjiKn4ewmvA2kqcAZk9FbN6egJnuLdYEi6HFOaccgI8E53ybKIl/3xBH6IL/SgW8+ukkADjhf7tKeehAKy+KCl4DPeANY3kEbD+YJlolMe1KxLFGS0KqD3L4suPhU3as91kTVUJkOvLOgibJNSn//Y0W5LLLYdI5qbK2ErMiecXHbAQDEgt60iG/rjHYkMaxTCQl/wdeJfmsC8ygKkfhTvdpeXnpEcP46v13/RkE8EPl0oqAnjK5YetNl9EUlfetJ11bdOnnoITDZJbdXLv3TI8SzXT2jfru3ikUR8FLYFn/arCXBE39/Y1anFKRJAbOUqm/WrXiKhwAKFawPy7XMp6CG0LMOBkv3cFlIgbw5oP0wiAhS/SNtW7A8cEMzdTMVBjkfg3Ztt/K/mDtyqI78tXp9VFz+6uGX5HocI6y3v8biAWnUuSGAWEw707gA/SQmpeMsQvQFn7mrPlX6FuEmp2A14jZQuYUm4yP8sJwB6V+SbwzhVoF7TVLq9PD41RCNZdsQY5ckMV217Q4XSEuYSYx9wCJrLZqZ+avURUjcwzVayj/c5J8UND97U7THhTGES0F5VGgA+Teh5y+HDDsgR5UGcPArclbO+x5hMX4wmENE/MTs6AI1CFQSTFRz7zU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(103116003)(86362001)(70206006)(70586007)(8676002)(54906003)(4326008)(110136005)(41300700001)(82310400005)(426003)(40460700003)(7416002)(16526019)(40480700001)(2906002)(5660300002)(316002)(8936002)(16576012)(9686003)(336012)(47076005)(44832011)(83380400001)(33716001)(478600001)(26005)(186003)(36860700001)(6666004)(66899015)(22166009)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:06:48.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1389525f-b800-487b-26ad-08daedd6cf90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some micro benchmarks run multiple threads when started. Monitoring=0A=
(or controlling) the benchmark using the task id is bit tricky. Users=0A=
need to track all the threads and assign them individually to monitor=0A=
or control. For example:=0A=
  $stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32=0A=
  -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1=0A=
=0A=
  $pidof stream_lowOverhead=0A=
  6793=0A=
=0A=
This benchmark actually runs multiple threads underneath on the cores=0A=
listed above. It can be seen with the command:=0A=
  $ps -T -p 6793=0A=
   PID   SPID TTY          TIME CMD=0A=
  6793   6793 pts/2    00:00:00 stream_lowOverh=0A=
  6793   6802 pts/2    00:01:25 stream_lowOverh=0A=
  6793   6803 pts/2    00:01:25 stream_lowOverh=0A=
  6793   6804 pts/2    00:01:25 stream_lowOverh=0A=
  6793   6805 pts/2    00:01:25 stream_lowOverh=0A=
=0A=
Users need to assign these threads individually to the resctrl group for=0A=
monitoring or controlling.=0A=
=0A=
  $echo 6793 > /sys/fs/restrl/clos1/tasks=0A=
  $echo 6802 > /sys/fs/restrl/clos1/tasks=0A=
  $echo 6803 > /sys/fs/restrl/clos1/tasks=0A=
  $echo 6804 > /sys/fs/restrl/clos1/tasks=0A=
  $echo 6805 > /sys/fs/restrl/clos1/tasks=0A=
=0A=
That is not easy when dealing with numerous threads.=0A=
=0A=
Detect the task's threads automatically and assign them to the resctrl=0A=
group when parent task is assigned. For example:=0A=
  $echo 6793 > /sys/fs/restrl/clos1/tasks=0A=
=0A=
All the threads will be assigned to the group automatically.=0A=
  $cat /sys/fs/restrl/clos1/tasks=0A=
  6793=0A=
  6793=0A=
  6802=0A=
  6803=0A=
  6804=0A=
  6805=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 ++++++++-=0A=
 1 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 344607853f4c..0d71ed22cfa9 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -685,6 +685,7 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgrou=
p *rdtgrp,=0A=
 static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,=0A=
 				    char *buf, size_t nbytes, loff_t off)=0A=
 {=0A=
+	struct task_struct *task, *thread;=0A=
 	struct rdtgroup *rdtgrp;=0A=
 	char *pid_str;=0A=
 	int ret =3D 0;=0A=
@@ -723,7 +724,13 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open=
_file *of,=0A=
 		goto exit;=0A=
 	}=0A=
 =0A=
-	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+	task =3D find_task_by_vpid(pid);=0A=
+	thread =3D task;=0A=
+	do {=0A=
+		ret =3D rdtgroup_move_task(thread->pid, rdtgrp, of);=0A=
+		if (ret)=0A=
+			goto exit;=0A=
+	} while_each_thread(task, thread);=0A=
 =0A=
 	goto next;=0A=
 =0A=
=0A=

