Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F1688926
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjBBVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBVrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E971A2E0D0;
        Thu,  2 Feb 2023 13:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLEL++sS1OoSpsWl2yJXG5lL1eZ3NqynSltY3QgbU6QwyxzxfZT2uLhu6HwcbGtXMS8LwtfM6R8pQEShts+sBDVRqarIvB8odNNXByRsiBpoTIA9qX5FKK9KqIIFrUrrSswbJoKPMOmmhUtSjB7uf3op87jWWOuFzvADRhkEGV6LtPmieRf3F6pHcqYq6+k3j3cAgHQ+zHU6wKnAnOXkAdT88FgNU63PDcS0x495eo4CrPvqfy7OwSmlf7MFqUA+mnlimcL4gUQImX8BN2z2J1KQPta2H4ybsWBpKaajJymMe18D5HUuffrR4oRGRUu3XkFvBz2TWTDbIiBlb3Wyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR4r95AImEpVKDY27H8FWcKXZoDuUBWDqDRBgxdMk0w=;
 b=e3TItXas0ebGvbYQGUu76R2C28Ztirx228QlzOMTboXlWJzCEZSKOfpzn0mgUbgNr+vXSniGyZT8emYraCpf6eKPtWRFUB9zWHS4/OH6mHwpumGGZEPPPhg93KaVLmN3DQS3FCAol5njbRApw5G91fbOYkVdp8E8CS0UDMqVH7erZ9KkT5OWEBBt6prVwlcNTFKnDVW0acmbxD0DPdTmq/+KtW9nTUEYkuokqTUXfVXVIxxVX+bWcP74YZX1AVG+G3PxzTSgwEwG/hihviAx7//yZcVo166IiX7PxwTiBlCnYGRP15J6rwiDlgRDy0dYw8mb4YwqlIbGrZiTkGJqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR4r95AImEpVKDY27H8FWcKXZoDuUBWDqDRBgxdMk0w=;
 b=2loNNyYGMEzYL98NH+BIMgruMWbiV5tLdaXDNsQRsfRxMs4VXNCOoYM5af8YA87XXrCJL62iAm/gcLN7PU8Ncx+4Lpmu+Feh4OjF8UQ1qTnNZHirOsZxVmd0hAhUA+rEwhw8AQ9Fxx+O9t9aArRfJm6+TeNBcSxlHM7geq4WS3o=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 21:46:56 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::c3) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 21:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.20 via Frontend Transport; Thu, 2 Feb 2023 21:46:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:46:54 -0600
Subject: [RFC v2 PATCH 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:46:54 -0600
Message-ID: <167537441417.647488.18261538242584692230.stgit@bmoger-ubuntu>
In-Reply-To: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: a13a78c9-2064-438e-ec87-08db05670159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Q9bxvvJiXKj5uED9s/g9jIFYc5b/XXpXiXN9mJGHN9wOjfpkAlhpUT4Bpwx1+G8CAzKMVpKej2j2qDFUXvMaHTKBtJsC+7y7q7tUsPVapTLRIWUUGgu/Rhj8l7dZalKoeRz7hI3CRzCzeyjExO/YU9SDXAFXn/LlD9RuEmxWx8H8XMHW1ooEBr0hwJZnJq+NR2+Lfl5pgZp0t66TFGIBR1a9z8kbFVPNIsZ0v1SiNCgkg7vhp858EVKpCSx/DEAlFRSbSZB2vIY64mjxZMYpKOdSs+P3GmdxNPK5Jsw99THWOt4V7AgCVzMCJcIxNn/uvg+wX0Bg4F2AcF7vLTzs6eHwNb4iNyXu3A66cHTR8GCcR082vHNuOSZ9vu1VgKjBn/CdNteXJIIZZ34Z1LgONsCHVkrEzrRrq0dnxMUPPMHXpC0M9qfE5mEls2ZvucryglF5PqFzGwxianeffQxihYkbAe7aqBrVcOSp3hTDN6rB1FPVXadKQykq/lM57ddH8E4blxvlZPKl5MLE74MWZAgFkEQG9+6IPyZ7A6OSDMMPDZehlEjdBpLM1DDfGLfd5Wwly6fxrRn2FG4fcjvFyRqpDbWiV/C3KIYY3ov6WC2QXsLXb8e9w9OiXD3CmKAGLofaq9PnnWkbAWEgc99wZAE6RNgr0Xq5gmiVovEYnhtSYFmgyF0nuEr0KnKx211xUbZHrpagQiYCnbiozeimpAMGeBJ3pya9DleWIKtSIaLM3GlWtuV0gA9ftBQ0Xjx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(66899018)(5660300002)(86362001)(81166007)(356005)(70586007)(70206006)(40480700001)(103116003)(44832011)(7416002)(2906002)(8936002)(426003)(41300700001)(478600001)(33716001)(36860700001)(40460700003)(82740400003)(8676002)(83380400001)(336012)(26005)(9686003)(316002)(110136005)(16526019)(186003)(54906003)(16576012)(82310400005)(47076005)(4326008)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:46:56.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13a78c9-2064-438e-ec87-08db05670159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for MONITOR or CONTROL group needs to be=0A=
done one at a time. For example:=0A=
=0A=
  $mount -t resctrl resctrl /sys/fs/resctrl/=0A=
  $mkdir /sys/fs/resctrl/clos1=0A=
  $echo 123 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 456 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
This is not user-friendly when dealing with hundreds of tasks.=0A=
=0A=
Improve the user experience by supporting the multiple task assignment=0A=
in one command with the tasks separated by commas. For example:=0A=
=0A=
  $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |    9 +++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   24 +++++++++++++++++++++++-=0A=
 2 files changed, 30 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 058257dc56c8..58b76fc75cb7 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -292,13 +292,18 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
+	group. Multiple tasks can be assigned together in one command by=0A=
+	inputting the tasks separated by commas. Tasks will be assigned=0A=
+	sequentially in the order it is provided. Failure while assigning=0A=
+	the tasks will be aborted immediately and tasks next in the=0A=
+	sequence will not be assigned. Users may need to retry them again.=0A=
+=0A=
+	If the group is a CTRL_MON group the task is removed from=0A=
 	whichever previous CTRL_MON group owned the task and also from=0A=
 	any MON group that owned the task. If the group is a MON group,=0A=
 	then the task must already belong to the CTRL_MON parent of this=0A=
 	group. The task is removed from any previous MON group.=0A=
 =0A=
-=0A=
 "cpus":=0A=
 	Reading this file shows a bitmask of the logical CPUs owned by=0A=
 	this group. Writing a mask to this file will add and remove=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e2c1599d1b37..13b7c5f3a27c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
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
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
 	if (!rdtgrp) {=0A=
 		rdtgroup_kn_unlock(of->kn);=0A=
 		return -ENOENT;=0A=
 	}=0A=
+=0A=
+next:=0A=
+	if (!buf || buf[0] =3D=3D '\0')=0A=
+		goto unlock;=0A=
+=0A=
+	pid_str =3D strim(strsep(&buf, ","));=0A=
+=0A=
+	if (kstrtoint(pid_str, 0, &pid) || pid < 0) {=0A=
+		rdt_last_cmd_puts("Invalid pid value\n");=0A=
+		ret =3D -EINVAL;=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
 	rdt_last_cmd_clear();=0A=
 =0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||=0A=
@@ -703,6 +721,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open=
_file *of,=0A=
 	}=0A=
 =0A=
 	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+	if (ret)=0A=
+		goto unlock;=0A=
+	else=0A=
+		goto next;=0A=
 =0A=
 unlock:=0A=
 	rdtgroup_kn_unlock(of->kn);=0A=
=0A=

