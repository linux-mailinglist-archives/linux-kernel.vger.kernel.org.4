Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2F601C63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJQW2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJQW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:28:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA88263C;
        Mon, 17 Oct 2022 15:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6MFqE7qxv/HOIoPRMDzMyYZX/nkZYCaFNK+mqb82Ob05GtCAgLQiS1/gsDC9eed+euZ3YmqNSjvzgtrvLpxyS0J8FxcVTTDvb4wYob+tniKK5j4/9maunwEi5gUAs+9tiftT4BKqOvpdXHYGsfz6iYtFN5m+/x82TFflUvYE62bT0RvJpL1IpFl6TmdA9iWrwFLBMgVd9fXiDnam/Am2VuJgs2tDXBbmttpaRVmjSCOY1rTYP2UDDDb2K2HfjkrQgv9pDrpBhwSaoJD/YsxdQMkEZwEJIZXCEwpWhbFlvQUBYUYXEQaxOppriFh12GlHX1tAuaK7Fkt/tBz2wxXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq4oa+3zc/PBbhZYxnQdCj1S9LIubhbyf6Ixk9YWFLM=;
 b=cS3hoLGV64V+vhQaKAYqs9mk/xLinYA6yBJVWM3iztl8mgeBxkpE3a9WXZSF3Nq8flXw0hBKnO2TCsiN8lSFGyrdFd5p3oj+OaexV0osm/rghT3kCqo2ZaxdNdBRkDT+KMvw5PtatIi+umzB+IIrAF/NiOyry/63ava7mmKaFn7CeMURs3ajm3yszT9mF9KiZEjh6ot/etzf6QEFfvfx6YCefEtywC2a0bUjpKBJ964qrexsk0rLSQIT6lSuPHRlUI6+eBqqBGlw//BetiIc+8jYMYflBpyFk4RUsWtQep89dAkX/hLj26CMPUIKBgO4o+nej0w9ndGnHJdFZao7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq4oa+3zc/PBbhZYxnQdCj1S9LIubhbyf6Ixk9YWFLM=;
 b=G/1Mp/PuescZdTOOrAIhH8ZiZo1E/STsRNZcXjK3WN3H9/jketkbZ7spF7Y4hSHtFkJOVEVvxIsh3MzPOBU/WNYERoyQJotrD8ppeTQbJ60BSgxZLwrHSx0iiFgF8r0JalHK5IbrOVRk0NVobalsvRB1sxC5Z7+lsldmrCboYIE=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:27:23 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::23) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:22 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:27:20 -0500
Subject: [PATCH v7 10/12] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes event configuration
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
        <eranian@google.com>
Date:   Mon, 17 Oct 2022 17:27:20 -0500
Message-ID: <166604564017.5345.6396405092493072988.stgit@bmoger-ubuntu>
In-Reply-To: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c3bef5-342d-442d-bd15-08dab08ec2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmFYNOw9AxDmTv6CgWazU+cG0bgeD6lfq/232Dj7/TGVceOL7/gxZjSaktxrt/OCA+sZarFaXRfCbhRBejrSWpSIJdWfClSPATFRSap72R0k9QdQj66iuRKgKZwfNAYA8uxOglEMSouLtiKcx06g84MScNA5nexk/06O6nLktk5Cf11wW+N2wp93EjXG9Vae4t6xzPRMo++a5jporY10+0e4V6GkDBwdQsJMxT/u3cfQd0XufeCZgoAbA0HRmo1qIRhBivGkajO0FVY3XgLav32dZYvbX3KDrJjAUWlq5xfCSTa3DHO2R99MJcSsk+e1cg6YFejTuB0TKxHIEwhQFR7TeYHczqJ29yyGqnRTfw/RFjk1cpgsSaFVBVo53VT0ZPrSVj9UFVAZb0zN85k0nrqa2BAY1xkYBl4tN3diDp5tyFZ67i9w0YkYX/AlpxM3PqwAOkhjkWztt9vyu1MEDXaR8DRBy1+wTcjgoNreUZe/syrcfoZ7/yUe/O+dSB1Be2nyOTm04ojwJ2Qqhb0IWfW6vHTdSl6eGB5Vs7+9BcBoO61ldblrnD55mmTXFZhTdi37Y1yj12ttFH9xx0XfUxhnvfDWgUmvUjAdbDk3n4ES9XZS1WKaqBCD9yr1U1HjHqtpHndx3TCat2jooRiL7xfPqrbGf3e2scgjBi20Ox49Zt+c71/Wd30S2PdJI9mLuqSqYsVoaPT21QYGPiwxKH8i+a/tAQSGUQCub53A4xaAOq4q8zXASHeMV1AJh5EFJXyuNfXGS5pfufaKGu9xXBehrOUcrSBgvd00ZveSBH0jEofjts4/1OvFhJZGues9/stB9RB+Bno9xVihI8W3tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(16526019)(2906002)(336012)(186003)(426003)(40460700003)(103116003)(8676002)(26005)(4326008)(33716001)(82740400003)(47076005)(40480700001)(86362001)(81166007)(356005)(82310400005)(9686003)(16576012)(316002)(54906003)(36860700001)(7416002)(41300700001)(5660300002)(8936002)(44832011)(110136005)(70206006)(70586007)(478600001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:22.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c3bef5-342d-442d-bd15-08dab08ec2cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be changed by the user by writing=0A=
to the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_config.=0A=
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
For example:=0A=
To change the mbm_local_bytes to count all the non-temporal writes on=0A=
domain 0, the bits 2 and 3 needs to be set which is 1100b (in hex 0xc).=0A=
Run the command.=0A=
    $echo  0=3D0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
To change the mbm_local_bytes to count only reads to local NUMA domain 1,=
=0A=
the bit 0 needs to be set which 1b (in hex 0x1). Run the command.=0A=
    $echo  1=3D0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   21 +++++++++++++++++++++=0A=
 1 file changed, 21 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 25ff56ecb817..e744db5dc057 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1639,6 +1639,26 @@ static ssize_t mbm_total_config_write(struct kernfs_=
open_file *of,=0A=
 	return ret ?: nbytes;=0A=
 }=0A=
 =0A=
+static ssize_t mbm_local_config_write(struct kernfs_open_file *of,=0A=
+				      char *buf, size_t nbytes,=0A=
+				      loff_t off)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+	int ret;=0A=
+=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
+		return -EINVAL;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	ret =3D mon_config_parse(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1749,6 +1769,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_local_config_show,=0A=
+		.write		=3D mbm_local_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
=0A=

