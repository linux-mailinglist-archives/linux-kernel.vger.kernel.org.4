Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC7F6A8A28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCBUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCBUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:24:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921AB57D02;
        Thu,  2 Mar 2023 12:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAUI2dNXeTJHU0OjKJOLgrziHF5lXs66q1KrzKGkbokZmOWF07SJxdkW3+lXYToPqkS2N5RP+lSNwXsLYtZjPnM4+K6OpK77PwMr2HwCkI2TG8qV6ysftKOop+osTDKMwANwCz4UnFI+tSUMzBRgLKlWyRc43+SjdTJBApUp6zyMZZGWyU5uT7Vyw+HMunl/lj7rkda1nr7na+450YUZBnhd5aEuQRLkGrhCWxJgI79fnFdZth7GXs4w6MkHv3OvLD3CKnL/KegPEyQNGI7FIUCgfpC//TZks4LB2Oo4z9xFri7V3UoMtEgB8/xW9/sU2ODvb34TA/hS0n5V2s59/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyUD59BITbd8fWMDNt88HkpEY9h0zk2R4AB+rXjAUjE=;
 b=WuK3rxx6ceUQSOt9CuTXoOEOHhD4SunMVSCQEluq2CQCg032XwIItoReuZnlFMfAZO84Jk2mOhqcvNMZpY+nD0rIzxHZpHRcFMloCwfynIJ7rRxHWWWBbFXpmfMsWLxstdr+NbaMq7Uj6v3q4+AA2uVTOdUycf1Xanu3FLHWTCw/YWEdYC77jA4iRqq29y0ACxOqV/eXH3WIdalRjuijq7QPOztUuwL8OlOgSYyh9pNmseqi5HdmprYrKg57GR+49TVR1tlXtsOXH78V7MQK+7i+PPEtXsiVp4iq0nClvWsXK6F2wMTi37lMQ6AABcCzAHDtSNljCfHVXQHJIjNEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyUD59BITbd8fWMDNt88HkpEY9h0zk2R4AB+rXjAUjE=;
 b=i2o51191ny+h21Jww/qy3l0R8I5Z39u45ekCf8+1+PNQmkmmCP49F8yBqsPdSqKCg3o2NjhK9UuS6KKHwPo16lo7TvdFJIdi/V4MgT1U5BqXd1pjxNUAXsgDPTiczHNYc0TIoE0o/MSbptL1XScv/3tXPbAhS5oE4uUm6cAFWQY=
Received: from DM6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:5:bc::24) by
 DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Thu, 2 Mar 2023 20:24:29 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::ee) by DM6PR13CA0011.outlook.office365.com
 (2603:10b6:5:bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:24:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:25 -0600
Subject: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
 at once
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
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Thu, 2 Mar 2023 14:24:25 -0600
Message-ID: <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
In-Reply-To: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: b499b001-eaf1-4c80-63c9-08db1b5c1fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2rqcRKCj2s1GXFex7gOBcHvkM+FlSgqQUO/rZOUTdWr5mKHslbqciOHWyoQnH8+KZKXGJPqUZHY0u/W1CSr0mS7Wx9drv24GXwAPhwk8ciGGshMiUutkpoPEHRMp7WZucq3qpNXdWCoASkF71ZwMtFw6aU1XKssw177Y4W6/0JWWKseeQKwI8SwP2lNjkxvZwX6lNlBL/3gYF2HNmt/i7uCow+9IQ2N8C9HGLv0fO9ycJTJZGjh5VSDaVWjx4DmZVfZlH+ROEJ3w0rKI1DJG8VnXBcYDJwxv1Stix50dTaG+J8FM0iTDua06sdsw4SmlIYqbCpLHxae5TITihXpqpPJ2FQNfN66orH4ButhJuczQgPzHrj8JL9n6U4uEhaes8Teqs6RU7Qx+S5hUvFZwTwSYUZd3u1Gw9EwoPjXeREbrgMfB5B2DAUsFzhCn1AtQTQu3mCMhjxIIFhH/D/NHLi1Yu4cNhMHODhzvNB2lILznVyJiwfW6VkDv4zq5+zuvYL5YY82voD7MLY0K9FMoIEOdvZ7ROuajli0qljjERMfcWfpxwwJUuprayqigawPNJwBmOZVdk5IlHKNXCxuWBsGTs0BNNS5DP5W7+j3TsgtvvTEeSjk6AmLUOtylB+f4r0turFOD+u4eVHiclaQJc4uguMxETUlBJ3Wodalw+A8b5RZMleTEUSmQkhXJ5bGcOAbFlO7zgxD87cOetfI6s62HXeJ34PYbFK3lcDOH2BDVWWKPE/o5+EH5/Q9Eyat
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(70586007)(4326008)(40480700001)(70206006)(8676002)(2906002)(54906003)(16576012)(82310400005)(81166007)(110136005)(316002)(41300700001)(33716001)(36860700001)(44832011)(83380400001)(426003)(47076005)(336012)(82740400003)(26005)(478600001)(86362001)(103116003)(356005)(16526019)(9686003)(186003)(40460700003)(8936002)(7416002)(66899018)(7406005)(5660300002)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:28.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b499b001-eaf1-4c80-63c9-08db1b5c1fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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
This is not user-friendly when dealing with hundreds of tasks. Also,=0A=
there is a syscall overhead for each command executed from user space.=0A=
=0A=
It can be improved by supporting the multiple task assignment in one=0A=
command with the tasks separated by commas. For example:=0A=
=0A=
  $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |   11 +++++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   24 +++++++++++++++++++++++-=0A=
 2 files changed, 32 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 058257dc56c8..25203f20002d 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -292,13 +292,20 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
+	group. Multiple tasks can be assigned together in one command by=0A=
+	inputting the tasks separated by commas. Tasks will be assigned=0A=
+	sequentially in the order it is provided. Failure while assigning=0A=
+	the tasks will be aborted immediately. The tasks before the failure=0A=
+	will be assigned and the tasks next in the sequence will not be=0A=
+	assigned. Users may need to retry them again. The failure details=0A=
+	will be logged in resctrl/info/last_cmd_status file.=0A=
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
index e2c1599d1b37..15ea5b550fe9 100644=0A=
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
+		rdt_last_cmd_printf("Invalid pid %d value\n", pid);=0A=
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

