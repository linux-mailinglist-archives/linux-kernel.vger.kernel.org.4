Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87F265C92C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjACWHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbjACWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:07:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB22F008;
        Tue,  3 Jan 2023 14:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMMmVzKWFg5GMBI2k9cfPAJcUTWFOYSjuFIgWhCY3tI7iBx+aWzEz4sG/jVwA3+Zr994tOp/3eg0wEzAzsK4M46I0nXr2Kq+wbv6VY3F9vBpEp4axD4h7ity36GfMvhCSz7zDf2Wcgq4f4lIqR5KM80sA3zRHei2B557p9qrSUwI7eFAKIrjKHwPakBJMDWYnFMG0coBoU3IpAZizyacWjXqeRK7AmBg9O1cNoW4txFNzjj9ssT07WqKj5ppGAS0B+I66ZHBkrD8or+Txv0+DIhI50zl0nCzT9ypYGLqCFedsNNiLgzk4gv9MD1LHEAlCI/CY6/FqPVyxMGSXQXUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGoGdo5+YBuE6uAlKVq9zY0tvuT7OvAW/M2XeRWX/o4=;
 b=lXeja4ARC1lKpvjELpKgSRHm+OvkOWTQaP/VhpR9Rsq8gKG+PfXOW5AEyquB0T0QeAvrUP+fipgrDxeuAXGnxCV884MYf1TDvlLvfHv+YdJBSOCsIl7A93tzlObKhf6mPZTm2KpeyCLh0hT+66XB4F/+6OT7NxQw0/0gvR+fqincH3CuOloXt/Ea28vvU7zqD7V0hiC8xbEpmRoKe1HJbnbDMdn5KTZUzLuufDYDBHdVsIE+C2JJZAjiBvmwxNL3KyZasKeLx/6ySPTgR6GSuKp0nTO6KsAX8zgvXYayyA+xP3backtOlszgtiwhWxCOnZ7CsgS1EskV+c3ga0seDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGoGdo5+YBuE6uAlKVq9zY0tvuT7OvAW/M2XeRWX/o4=;
 b=C/Ql8vcBnZRD8McJbNqOBK7B06Ruf7mfOUSgv6Kcx3T/voqP4+vtJbHxL0borjGhnDnjrx86qwyUWwfBgv2RbgGSF1sTvplnYxlY6e3cQrDxpqMJ+JpfAwwLVo/3hyuhcoaA4Clqb7DgmtkBJjD17+QgSis0QXzTMPqdb9t/6Lw=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 22:06:37 +0000
Received: from DS1PEPF0000E645.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::33) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 22:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E645.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 22:06:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:06:35 -0600
Subject: [RFC PATCH 1/3] x86/resctrl: Add multiple tasks to the resctrl group
 at once
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Tue, 3 Jan 2023 16:06:35 -0600
Message-ID: <167278359522.34228.17439739885350817510.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E645:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f26d17-a2b6-4a1a-74d1-08daedd6c8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZEsVfrM5HH8l6khSVSPNVOEpBNxdThYo4HMJ0ox01fJy0G5sfvpc0PhW0izXucLFZeWKt0/OL4cGMpx3zsH18rWJpSaWyIMATRGqoulafIQQOfc7vzfRTVKuyhWNHMHGu4rer03VFRHAtFmN+tTJk/I3J8jlbvoTuGpMTey1qRNs0YApOpQ3Di/uZt2/gJjdWU9PktsuVRYFzVQOM7YYK8ansQjbn+H6nvHNvpC4Eg0LTDWONONuorjkkJp6LlAXhumikjQisnZIdeml66bGXCVMGd7c+LZkDwTh+apv8/S9XVA8uGhzYu0JVsLGU1bWD9rMAoUQqvc5mRPNcVn7o+eNPK1SkY7ggZjV3K79wcXlVkiHWieMcdFnXTfDfMLjGTiCbJsrWEvWutC0bo31lniO3O0jM9iiUDWw/fOfMJKETvsdHMsI1pOALuQ6uD+v9ahhRQ9krXzGXYfx3ErxRBHzfn5/EHHjutuu7n2gyW48hJlI8Ksa6nGJBY2FKSpsWtNIgRb4OENnAkqCqA9BmnOMc9fV7sY6fWgex7Cokfr8XfF1/YVgoZqDrmJDWoHQNUqc+0QQmqcSd0puszxb/N0OzH4JUWPy0dUWWJyPpP4H4iE4Otn+XbcYadUCJH36n88D0wKU7Wl8CwRDCDgAgjH/UvnDyHH6T/bp8rR4KH0wSAa72PCCGPzPyyaS+4PcjsVqh8MszY1nICftthypubZz6Gr0Z2vDtjWWxatUjpA92NVxJIB0hNeQ96achT6qwjbv3H0OZSMhLDgY513WWtyZKT6WEjdULF4TKj4Y/8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(7416002)(44832011)(8936002)(8676002)(41300700001)(4326008)(66899015)(16576012)(316002)(70206006)(70586007)(54906003)(110136005)(478600001)(9686003)(33716001)(82310400005)(336012)(26005)(16526019)(40480700001)(186003)(426003)(83380400001)(47076005)(103116003)(82740400003)(356005)(81166007)(86362001)(40460700003)(36860700001)(22166009)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:06:37.2798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f26d17-a2b6-4a1a-74d1-08daedd6c8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E645.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the resctrl task assignment for the MONITOR or CONTROL group=0A=
needs to be one at a time. For example:=0A=
  $mount -t resctrl resctrl /sys/fs/resctrl/=0A=
  $mkdir /sys/fs/resctrl/clos1=0A=
  $echo 123 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 456 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
This is not user-friendly when dealing with hundreds of tasks.=0A=
=0A=
Improve the user experience by supporting the multiple task assignment=0A=
in one command with tasks separated by commas. For example:=0A=
  $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |   13 ++++++------=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   35 ++++++++++++++++++++++++++--=
----=0A=
 2 files changed, 35 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..f26e16412bcb 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -208,12 +208,13 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
-	whichever previous CTRL_MON group owned the task and also from=0A=
-	any MON group that owned the task. If the group is a MON group,=0A=
-	then the task must already belong to the CTRL_MON parent of this=0A=
-	group. The task is removed from any previous MON group.=0A=
-=0A=
+	group. Multiple tasks can be assigned at once with each task=0A=
+	separated by commas. If the group is a CTRL_MON group the task=0A=
+	is removed from whichever previous CTRL_MON group owned the task=0A=
+	and also from any MON group that owned the task. If the group is=0A=
+	a MON group, then the task must already belong to the CTRL_MON=0A=
+	parent of this group. The task is removed from any previous MON=0A=
+	group.=0A=
 =0A=
 "cpus":=0A=
 	Reading this file shows a bitmask of the logical CPUs owned by=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e5a48f05e787..344607853f4c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -686,28 +686,49 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
n_file *of,=0A=
 				    char *buf, size_t nbytes, loff_t off)=0A=
 {=0A=
 	struct rdtgroup *rdtgrp;=0A=
+	char *pid_str;=0A=
 	int ret =3D 0;=0A=
 	pid_t pid;=0A=
 =0A=
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
 		return -EINVAL;=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	cpus_read_lock();=0A=
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
 	if (!rdtgrp) {=0A=
-		rdtgroup_kn_unlock(of->kn);=0A=
-		return -ENOENT;=0A=
+		ret =3D -ENOENT;=0A=
+		goto exit;=0A=
+	}=0A=
+=0A=
+next:=0A=
+	if (!buf || buf[0] =3D=3D '\0')=0A=
+		goto exit;=0A=
+=0A=
+	pid_str =3D strim(strsep(&buf, ","));=0A=
+=0A=
+	if (kstrtoint(pid_str, 0, &pid) || pid < 0) {=0A=
+		ret =3D -EINVAL;=0A=
+		goto exit;=0A=
 	}=0A=
+=0A=
 	rdt_last_cmd_clear();=0A=
 =0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||=0A=
-	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {=0A=
-		ret =3D -EINVAL;=0A=
+			rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {=0A=
 		rdt_last_cmd_puts("Pseudo-locking in progress\n");=0A=
-		goto unlock;=0A=
+		ret =3D -EINVAL;=0A=
+		goto exit;=0A=
 	}=0A=
 =0A=
 	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
 =0A=
-unlock:=0A=
+	goto next;=0A=
+=0A=
+exit:=0A=
+	cpus_read_unlock();=0A=
 	rdtgroup_kn_unlock(of->kn);=0A=
 =0A=
 	return ret ?: nbytes;=0A=
=0A=

