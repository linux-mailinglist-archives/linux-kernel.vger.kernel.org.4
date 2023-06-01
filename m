Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5F71F286
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjFATBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFATBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:01:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3485184;
        Thu,  1 Jun 2023 12:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODfIwWKBvGqiWo2WWAdLUFd0YPpYV1SkAyNj+JCUNnl88Uy7sF/bt9v9zvUQdJOcs4HAmYhgBLncIfNvisljBh175vv3R7EUMym3IqCp7s6d0992EYTuKZgPvYPicO49/7qxeE/sZiZhhC6keVvKFjFiiw5VOtogeAtstPf/H3p1FcsNypQHZbBbCV+ZaA/b9zwG2QOHIPJHP6Pz1/uObIymB8FkuUxZYriTGVkoEgNCq/Mc+5Ug07YpZeUf7WIGoLKtU+lthqYGP3HFhNPQkVwc2NfQjTdOGvOquMW+99NHJRUlz57xczAzef+HXfj1WK24VDKca7V9ftKmHpo1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Ri0OnIn94g0sfsasntb/wfY9Ip1jUmxeT1yDBE54A=;
 b=lME24c35jIEIRRoN9MhjSihb6U8JYPQYdC4hJVNSHuY9as+6GBnXhm2pTRURXqHZRPMeCHpwGLGol0RW54/MpPlzjvTdr2G3j22xMlzU75msR1ky8q902cEPttQ8AeoicmcFaN4GOoN3/uqbbZ3DUasorkeZ28gkCeScd84Jm5pAsuVbXFioJ/ssP1BHrakBEX8jlWgWCXl19lgvMKg8lDs6EO3rLrYRjWQ2uUMuGI0TgBYm0e0QBx7NiPD9abGQHzGlRyyuwy7HQ5NgZU6CSYL3y129a+xpmp5dX8RFCjQoDnCFLONLllbkxC4UL4cBfWXzPjW+coX4VRiwNAR4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+Ri0OnIn94g0sfsasntb/wfY9Ip1jUmxeT1yDBE54A=;
 b=XbYQ4fliniaeKUQY8V98TFNVsOvqAIeBrGY9I1/tvN6AHpMoP3XYXZkvu+TNIscNIThVjU2Vb11pN+Xo3+6x5tDQHjajjBQwo1tDlGai4oKgaxFNF/2NIPml62wmDbELJYSb+w9ornShHOZJ/0+4p/KLAVu0r2vj+vhf5Dd0Q0Y=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 19:00:59 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::54) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 19:00:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:00:56 -0500
Subject: [PATCH v5 1/8] x86/resctrl: Add multiple tasks to the resctrl group
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
Date:   Thu, 1 Jun 2023 14:00:54 -0500
Message-ID: <168564605452.527584.8450496267087240475.stgit@bmoger-ubuntu>
In-Reply-To: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0aee3-8b1c-4b07-660c-08db62d28992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBJ63Ky2+pJhpJHP4+xCnHBhp8jah6s4G/xxTJSJOW2KSOanjfAHBekmHFQxEga8TEavzFQiQ1PGjOwP2C5KFwoA7ovGaOYESfIickPgSrVcL/AZsElSFx/ITsaR4xzbfqRc5jDH9Jd5vMWnm8ryqzn6X6AdkGkFOXN8ZO32CeShH/o+d7dRgoSV2MXYB9czBMtNcuHT5Wk2/Nn5UOnZMyrl8pCnxLnZNEXxI/KfGgox+E/6+PovswxO846sLB/zevbQLdeZjL1SIW1T/c5LL7KtJKqsW4VmCa2eMgMRGirg461FuI0hdngHl7ByZ5hJMckv59ZWVao2tP21nmzpOxQsVdOp1zDN6BWtzEsVye54B41VQt1JnEstE1nNhHApY7oo8XB7TattrSbHyAwX7b97o+Tj3OwI7forMwQ8OB5cqJ00obI1vLS8ObLdr3Jd6KbBOdkhU3Ly3VdDXQblWzbSsnH2KYe+iJw5HD3Sxx+/bn9tnHfzhHU4v2HRQ3/alrxyT11bomXr5OpW2VNqNS4n9xVQKfh9MahM1VRZPQzoJBiNYFwtYwaO99XliTpe6ixp56KfXWTbCg02OnGUt2uLFkTDiZHs2WWvqKef+eLZeHMrhyo0aqPtsv9eSIcQ3NxOgq1C5IUXcjJgxyJZ7AP46yiVtDgqR60mpv/rlIoxcs0dtRHgFOpsth5xOTWS/QPk9nrlAttRnjoQ8wkWGs7NH4G6bCK1vGh2Z1X4R6Z376u32IhHm2Dh6r3bCgUaWWmtscHXemaP9HCjhwhekw3UKNsWtW9xVLU7myIgBDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(82310400005)(82740400003)(81166007)(36860700001)(47076005)(83380400001)(33716001)(70206006)(70586007)(426003)(16576012)(66899021)(4326008)(110136005)(336012)(86362001)(54906003)(103116003)(2906002)(316002)(16526019)(186003)(26005)(9686003)(44832011)(7416002)(7406005)(5660300002)(41300700001)(8676002)(8936002)(478600001)(40460700003)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:00:59.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0aee3-8b1c-4b07-660c-08db62d28992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for monitor or control group needs to be=0A=
done one at a time. For example:=0A=
=0A=
  $mount -t resctrl resctrl /sys/fs/resctrl/=0A=
  $mkdir /sys/fs/resctrl/ctrl_grp1=0A=
  $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
  $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
  $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
=0A=
This is not user-friendly when dealing with hundreds of tasks.=0A=
=0A=
Support multiple task assignment in one command with tasks ids separated=0A=
by commas. For example:=0A=
  $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    8 +++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   30 ++++++++++++++++++++--------=
--=0A=
 2 files changed, 27 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index 387ccbcb558f..290f01aa3002 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -292,7 +292,13 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
+	group. Multiple tasks can be added by separating the task ids=0A=
+	with commas. Tasks will be assigned sequentially. Multiple=0A=
+	failures are not supported. A single failure encountered while=0A=
+	attempting to assign a task will cause the operation to abort.=0A=
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.=0A=
+=0A=
+	If the group is a CTRL_MON group the task is removed from=0A=
 	whichever previous CTRL_MON group owned the task and also from=0A=
 	any MON group that owned the task. If the group is a MON group,=0A=
 	then the task must already belong to the CTRL_MON parent of this=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 6ad33f355861..504137a5d31f 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
n_file *of,=0A=
 				    char *buf, size_t nbytes, loff_t off)=0A=
 {=0A=
 	struct rdtgroup *rdtgrp;=0A=
+	char *pid_str;=0A=
 	int ret =3D 0;=0A=
 	pid_t pid;=0A=
 =0A=
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)=0A=
-		return -EINVAL;=0A=
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
 	if (!rdtgrp) {=0A=
 		rdtgroup_kn_unlock(of->kn);=0A=
@@ -708,16 +707,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
n_file *of,=0A=
 	}=0A=
 	rdt_last_cmd_clear();=0A=
 =0A=
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||=0A=
-	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {=0A=
-		ret =3D -EINVAL;=0A=
-		rdt_last_cmd_puts("Pseudo-locking in progress\n");=0A=
-		goto unlock;=0A=
-	}=0A=
+	while (buf && buf[0] !=3D '\0') {=0A=
+		pid_str =3D strim(strsep(&buf, ","));=0A=
 =0A=
-	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+		if (kstrtoint(pid_str, 0, &pid)) {=0A=
+			rdt_last_cmd_puts("Task list parsing error\n");=0A=
+			ret =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
 =0A=
-unlock:=0A=
+		if (pid < 0) {=0A=
+			rdt_last_cmd_printf("Invalid pid %d value\n", pid);=0A=
+			ret =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+		if (ret) {=0A=
+			rdt_last_cmd_printf("Error while processing task %d\n", pid);=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
 	rdtgroup_kn_unlock(of->kn);=0A=
 =0A=
 	return ret ?: nbytes;=0A=
=0A=

