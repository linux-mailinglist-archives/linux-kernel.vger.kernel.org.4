Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19485ECE42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiI0USe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiI0UR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:17:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484FE5853B;
        Tue, 27 Sep 2022 13:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4b82C6DIZNzJPFvJOLxz/5bq4QQKwgTp5gC5YCmhUvUudCXuxDmD0db4/syDLOOyioiSFJtPW+oBb4LuQNHwJnyRMgE4DGRvTrtoCD9VLF1wSIkQPoc26Bv92tCffMUFwvnhIsiwyMYU9cdt6/ohybKcxHrrgnDnJcVL2+Gdni8yi7uS9EeVqkqtNMvjWE2G3mMFqeNXtQalh6IOr7ywHI5ilwczvjO9fqC4gteGCG3cBlq8lpKP3WUdoTqKFKVyjW29GQmY7JaZcsP225+JhEHBrH3dO/oJYvOTAdwRZYNa7OTkZ+19En/ZsLbyLFn8DXLUM61AEnpHPQGcC2JZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSMQb+q9LfuQnUeUawckDw/WXYaWENehqGYlsG/07jM=;
 b=d9XaRwAKXaecmIDJbl3xh0eM1j0rmVqTz295jBHdereH9BXv52rdnbxg7UP4GJgbeq94xezqBs4G//f+c9FiNGts8V0vKqgkr9hPgFMXaExahpFvNKrn6skkmw7CtPzYXUfEkLk8BH8sy6ehMbf7vhPYBHnKQEbtOMNW0SUw2HSvb70UoOhg+5/JDks77auCUiJI/cJ2BJGnTEFzv3g9li95FlxKZqKR5rPZ5PsmQFyQsWKsWFkPydUwZZ6qTT5zxkzIEUYWuoOTHeV3iHM+kEFXMDp5ola0PGZ8LRGSpksBCE45rtGOU4ValXTJxxNyuA/tikPJSgdymPZFvJJdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSMQb+q9LfuQnUeUawckDw/WXYaWENehqGYlsG/07jM=;
 b=IjkO4oCf8L0tMWYVPvF5dJRGECTWRVGDNiEwIYBwtjvaWwO8IM7NAurLnPdkH9w+1lJRNPvnJEQUY6eRgvHi/aW+68ubvwhhl8RRTO4nSixHXpF4cKSnpZ3nJ9ON8ArougfwKWiMnS9rN765bB6f+2AmKrgQdMEXUc+SteiJR3M=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:16:39 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::f) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 20:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:16:37 -0500
Subject: [PATCH v5 2/2] x86/resctrl: Remove arch_has_empty_bitmaps
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
Date:   Tue, 27 Sep 2022 15:16:36 -0500
Message-ID: <166430979654.372014.615622285687642644.stgit@bmoger-ubuntu>
In-Reply-To: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: a14f7d43-3299-43f0-844f-08daa0c52f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5kP8UiiXhd2hNlzDvgnNY8ehNmE+khp7/wiNUexcUJzmVjCryAuG659LxqhNCNh4WtycmOiBK9KaY8q27mj1HS1afe+CU+wZodrOFWGw7b2Jrqa/Ny+HtaZEuGcCyRXNmoe3mW/0eZ66UqdJJjJfwRaJiyucQwvMim8ge2fxKyWY9Ye70ePR7d5iNxNlXhdeTONmoQ6rl/XMKBEWVCx26VHnSJkaLYuhxr89e9vdBL/BAU+PKE8yZkc1dshPamMPkifZK2adTT/Gflpi9O0QzSeHyyu0ZQ4h7S6iKFoWiwEzTkQ4BbpbvRVAitRBYgUGLj/RMqxIS1JI6eEroAyNBb/R0vljm9IeirtUSH8Sluro6Aox7ZcOZNRMI1FyXYT07fIxT1pUnzyNVuNIfyCjUXK6tr6g55mHWRV/3sqY0vkFBmwbijiweWG66z4ptQQvHquiOJURjVslvtbLR39lytFc9caVl7MnW83DFWFjhBc1RFep1puAmcoO9M+4FUPG0AKMUQQ3+nujZuhGjN82wtQ3/p2+wLwTGr7qPF3UoKOW1p2t3cDvDqeNn9i2U9deGjbLbraaDxcp8y1OY1wBAGIpyV/tozEY9xEAd9+AObuCVjGarfi1fSljIFZv0h+dCN/oENpD/kH1sPQQktkyFm9ukigi8h4dj380A/tMRJ4UGa9SsLqOv4F0iAS/TZUNRkUi8ycQSG9TtKLXiYvsAjpOqLIzfcp7/1NdmAEgcTAV9w4+V9S7frdtOp/giAo1RACPogLBTBQKKl9900ozMI9yl+9aTvcXsspss72S5Q+9RwFz+kgsXpA4wpe3q0jTgLCtRV/7QpAdI6JMV7Yag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(54906003)(40460700003)(70206006)(40480700001)(4326008)(16576012)(8676002)(478600001)(316002)(86362001)(70586007)(103116003)(82310400005)(336012)(186003)(356005)(16526019)(41300700001)(8936002)(81166007)(7416002)(5660300002)(36860700001)(2906002)(110136005)(33716001)(426003)(83380400001)(82740400003)(9686003)(44832011)(26005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:16:39.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14f7d43-3299-43f0-844f-08daa0c52f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field arch_has_empty_bitmaps is not required anymore. The field=0A=
min_cbm_bits is enough to validate the CBM (capacity bit mask) if the=0A=
architecture can support the zero CBM or not.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |    2 --=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    3 +--=0A=
 include/linux/resctrl.h                   |    6 +++---=0A=
 3 files changed, 4 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index a5c51a14fbce..c2657754672e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -869,7 +869,6 @@ static __init void rdt_init_res_defs_intel(void)=0A=
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||=0A=
 		    r->rid =3D=3D RDT_RESOURCE_L2) {=0A=
 			r->cache.arch_has_sparse_bitmaps =3D false;=0A=
-			r->cache.arch_has_empty_bitmaps =3D false;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D false;=0A=
 			r->cache.min_cbm_bits =3D 1;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
@@ -890,7 +889,6 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||=0A=
 		    r->rid =3D=3D RDT_RESOURCE_L2) {=0A=
 			r->cache.arch_has_sparse_bitmaps =3D true;=0A=
-			r->cache.arch_has_empty_bitmaps =3D true;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D true;=0A=
 			r->cache.min_cbm_bits =3D 0;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c=0A=
index 87666275eed9..7f38c8bd8429 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -98,8 +98,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt=
_resource *r)=0A=
 		return false;=0A=
 	}=0A=
 =0A=
-	if ((!r->cache.arch_has_empty_bitmaps && val =3D=3D 0) ||=0A=
-	    val > r->default_ctrl) {=0A=
+	if ((r->cache.min_cbm_bits > 0 && val =3D=3D 0) || val > r->default_ctrl)=
 {=0A=
 		rdt_last_cmd_puts("Mask out of range\n");=0A=
 		return false;=0A=
 	}=0A=
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h=0A=
index 21deb5212bbd..46ed8589857c 100644=0A=
--- a/include/linux/resctrl.h=0A=
+++ b/include/linux/resctrl.h=0A=
@@ -72,11 +72,12 @@ struct rdt_domain {=0A=
 /**=0A=
  * struct resctrl_cache - Cache allocation related data=0A=
  * @cbm_len:		Length of the cache bit mask=0A=
- * @min_cbm_bits:	Minimum number of consecutive bits to be set=0A=
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set.=0A=
+ *			The value 0 means the architecture can support=0A=
+ *			zero CBM.=0A=
  * @shareable_bits:	Bitmask of shareable resource with other=0A=
  *			executing entities=0A=
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.=0A=
- * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.=0A=
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache=0A=
  *				level has CPU scope.=0A=
  */=0A=
@@ -85,7 +86,6 @@ struct resctrl_cache {=0A=
 	unsigned int	min_cbm_bits;=0A=
 	unsigned int	shareable_bits;=0A=
 	bool		arch_has_sparse_bitmaps;=0A=
-	bool		arch_has_empty_bitmaps;=0A=
 	bool		arch_has_per_cpu_cfg;=0A=
 };=0A=
 =0A=
=0A=

