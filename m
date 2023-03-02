Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3F6A8A32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCBUZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:25:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7257D11;
        Thu,  2 Mar 2023 12:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDG0aKi7tovdKXNMiRGJjDSVbNTjCYgNrgLE7cbe3uG9FeE7aHb8dAm0v3PaWqUdOaI8mC1p727kNkE02yLAMUgK4l0boG7ua56T7/OpKX3Rq6mx8sK0kbAyc03LTPBdf5rR8cnFjqjeNGslVP8/lT7mhLYyuqJIgrf2VOeunvEP4ijKiE8ZL160+faG2Os8nhAm8D1/OPz+vSSvOtR01QDxz1ezlqPMWp8Jbg+l8uH12tC05NXB+k/QATLw+wlAHflm70W9c41BTJFbqsFL0MmP9XVlFLAF73j27G1SWjAUM18s3dt0iDchffQFDHe705eWU+tfbqApDzBGNlUtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHYM3f0BQdq5Sq2aeopo9p/HK6fR//kM+KW9AWlxysc=;
 b=ZIeW3Op9OKCI3NqEKGC7hTT1IL87tSKym8pQJB3JxZt5fYMYHAXVW09UKnuwT5C1oVKbsVdBsLgtW7RXyGMSlKquepDcLIUz6JtxOAxMRJYZM/btRWJ7GZsu2Yd+VlTydZd4Y5O4zUZjPPBQKBsun4DVQ6fdlyG2pihx74H9rx4qpkssP/d3XP/wZl+6ctKx6AcSdg5e7igEHZAEflO2jwEc5MjW5OGbput5TmSyvHSq87vT9uCUgMSSxnp1tr7Dnrb1ccapN1RwI3H4goMbGx/fqn/kn6XfNQ887L/RLZ9r/pboWFXnbBHtaE8FjLWxA90T3zQB/yaXrNUng7VpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHYM3f0BQdq5Sq2aeopo9p/HK6fR//kM+KW9AWlxysc=;
 b=invNYSyXSMrDw67tfAIrNlX4bNfpWZ5pwfP7C5ctUrwULqm6Z0N9K7MeF50ZBaNvrs3h4gLPttIOkX24Q6I1PGhPKandolIezo6tQsXJUK/o8EubwQMwtv4yezicbpeb/6eWgsD9WrWAj45bWL2mmvfXwrG3iGZgmGjFjvWTON8=
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 20:24:56 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::50) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:24:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:54 -0600
Subject: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for resctrl
 groups
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
Date:   Thu, 2 Mar 2023 14:24:54 -0600
Message-ID: <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: b001c721-0903-4f9f-ac0d-08db1b5c3065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObPIVEl7puWIlxT6orCAtphkuuW2UsEzs9EKoNnaljLJwAYxh7rD1jmITKqHKuPCyQiz666aFSdfUrC1bVLAUK5d2YkzAeJvVvTGCePycYZFn+nLdxdli/2AZ6chHDpNkAyVMTvvPN+EKbsDP5ERYEWexaUf1/g165lz/Ali0klcuZ/0/XKTNLojgn0sXmGMY7b3tS6L/wA5msPgq4PZMRanRyr9cnSpUwMYXG5YdVURzRRi6UKOkirlC0QSvYi24DEm5Q7YHlc6mVyygXsnnxr5VYxh+aZv4/9i+H1vMQTRT92LjQ2M9UuDLM6Fu286aJ3eKdpyJ17+ujW01hlP89t+N1aFZdWi2KijeoaIYXszSEhDk+Ww8HyNwAxCnE8A+MmQ4GnAUNCU62rFKdoLG+Uz6VN6UVkw30BGgWr8NyS3MvRg4Xe4480DDEbNOizmxF7/5dW1JOTfkxv0yNaHySszOUaevYOT5FFQDhAHaz4Zuk5yTHTKrpouakbzq5mHRb/xbfixec21PwLp7IqY+1E3emmEhJIkcdox2zuNQKuFIdLmM2fMQgOjtmEaJM7QEYHphTQkfQFw69Wb7MM7HZq0Fw7oM+FX42iKUnO4z+s0tTrQ3GKQXdGbhtEMYuJO7qehKu17FPDMBVly8OFtyl5i/c94DG2KWF27PEub2rpnxb8DZip61Q1qBufwG3b7+8IBjc9fg1aRzoqsD4zSOKB/hM2Omulbk5+1cJRaoeWSA4drmj+6z52aHsZB56ksmrFRyBKEG+uXwiC7daIHbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(9686003)(336012)(26005)(186003)(16526019)(316002)(54906003)(110136005)(4326008)(41300700001)(8676002)(44832011)(16576012)(2906002)(70206006)(70586007)(7406005)(81166007)(7416002)(478600001)(8936002)(5660300002)(82740400003)(33716001)(86362001)(40480700001)(82310400005)(103116003)(356005)(36860700001)(83380400001)(426003)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:56.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b001c721-0903-4f9f-ac0d-08db1b5c3065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user creates a control or monitor group, the CLOSID or RMID=0A=
are not visible to the user. These are architecturally defined entities.=0A=
There is no harm in displaying these in resctrl groups. Sometimes it=0A=
can help to debug the issues.=0A=
=0A=
Add CLOSID and RMID to the control/monitor groups display in resctrl=0A=
interface.=0A=
=0A=
$cat /sys/fs/resctrl/clos1/closid=0A=
1=0A=
$cat /sys/fs/resctrl/mon_groups/mon1/rmid=0A=
3=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |   17 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 61 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 25203f20002d..67eae74fe40c 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -321,6 +321,15 @@ All groups contain the following files:=0A=
 	Just like "cpus", only using ranges of CPUs instead of bitmasks.=0A=
 =0A=
 =0A=
+"rmid":=0A=
+	Available only with debug option.Reading this file shows the=0A=
+	Resource Monitoring ID (RMID) for monitoring the resource=0A=
+	utilization. Monitoring is performed by tagging each core (or=0A=
+	thread) or process via a RMID. Kernel assigns a new RMID when=0A=
+	a group is created depending on the available RMIDs. Multiple=0A=
+	cores (or threads) or processes can share a same RMID in a resctrl=0A=
+	domain.=0A=
+=0A=
 When control is enabled all CTRL_MON groups will also contain:=0A=
 =0A=
 "schemata":=0A=
@@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"closid":=0A=
+	Available only with debug option. Reading this file shows the=0A=
+	Class of Service (CLOS) id which acts as a resource control tag=0A=
+	on which the resources can be throttled. Kernel assigns a new=0A=
+	CLOSID a control group is created depending on the available=0A=
+	CLOSIDs. Multiple cores(or threads) or processes can share a=0A=
+	same CLOSID in a resctrl domain.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 1eb538965bd3..389d64b42704 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -760,6 +760,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
 *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int rdtgroup_closid_show(struct kernfs_open_file *of,=0A=
+				struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->closid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,=0A=
+			      struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_PROC_CPU_RESCTRL=0A=
 =0A=
 /*=0A=
@@ -1821,6 +1853,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_tasks_show,=0A=
 		.fflags		=3D RFTYPE_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "rmid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
 		.mode		=3D 0644,=0A=
@@ -1844,6 +1882,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RFTYPE_BASE_CTRL,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "closid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

