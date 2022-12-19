Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C466507BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiLSGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiLSGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:43:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB863D6;
        Sun, 18 Dec 2022 22:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odLTESdZKsuZ76tNHHUfk/fi9p6kf7G+8KHgTAVgVfmv1z+Zsl4kMfcAmJofdHPq725qz3kdiWx/TDB/1rhc9PKN0c/nHjzK5yEv8UnveBdssGAakBkuRBirmwUb+7VAoPIwUXNNmjzkbj7bzyrkuWHhWoGU3FC15HlVwqJvsQnj1WvMqO5FJGwo9Bk0HsPjFzzCzt0x2NKA0I14UVA1YxiAL4i2uLDM15dZ0DQSisZygS5265trYINih763gsYUTiJW8fJfN51bEL7uCqu9QwGkmO3GT89x+U6YnmlAJH2nx3khT34O/etyhn9GbZ77m7bV2z7kdd495ZnKjtaxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=BCO/wowZt+JPceMVugBxz3bfvjVbWupbyy+aom1A40RLUEK7uGPmjeMkJo8I0eXrIOjz7owW2YrKTATJe1qcJgDpeGpiYM2IEqy6MmLatQidBCLzvyRDHJ9aTbPYogcgnFwX+N0AuPyVXlLnNDVTeLS5NnBPm9l+dLovuD+n0jF+fOf31xADpVdC3LPvDVyuXbum0KVduA/Adbyb+Hx/BYOR47yD6BmnXEhcbqSeYQ7bMRSX3+oJ6TlHXgjim+cVPAH6OAGFQzqhnTgKFhN3GAnasq5xrjsImQB8kBHRC1PI7/IY6y5IKbhaHsT3HzkF/4++uZFWnHPWcr5ugQKdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=U4nTKdDiXedDWewwZUN3p082v2o7OesuDZnSPYAUDyRNy6JvzXuv2vRBo6Wuq6/QkusD+EeZqN7wUNz4RjmD6oVXSOTpWiBDYYzDAAsbB2cx1MHwr28bF1VsaQRW+fLdEAF5qNine5VFBHkfeK0gINkeE+oFceX3dpgstwfFnaI=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:42:24 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::24) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.5 via Frontend
 Transport; Mon, 19 Dec 2022 06:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:42:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:54 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 11/13] Documentation: introduce amd pstate active mode kernel command line options
Date:   Mon, 19 Dec 2022 14:40:40 +0800
Message-ID: <20221219064042.661122-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3508d86c-3934-4fa4-ec25-08dae18c2fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hkQRXK0GaWEzFPGIMwFpEjAWrpHiCdxuJxA8ei25pvcRzrNpeO1UZCVKU7AQg92aoZhfNiPQw7U0nG0uG8okM4x+ONdlh9eUW8sylE4EVGLwCJV1oBTA70wRkx+F7EmHqszxHd+sDsiWJ4bP4cHHmYBFDOLd7U9qjtF07jbUkUJykycbHfQ1V83PfTOwguUFouZNHngf1JvkLzKk+MnQucCBp8oL60InYvNO3qCA1mqoOi89flgFDUmoQZ220zod1FL+fjloCh7EqsInIhktoUGj6X4YpFYNGDBbyo+7Tni8EJC2j/mmMmAAmMjGi5awK7zmWDvWzfA0FtZdcwv3dQkyObeew27nF3id+IMkv7XEl4Ach9oJpNQ2nEus6E6f+wimNHRbbI6RjDJ+siBz3USd84iWxzrG0V1FcvB9kVNq/Gh9g1kA8Bi9vnafsEv80SoeKuDOGn+p5+Ab8DjDwsm1Ydv4VpBVuD4jHaz3JOLQ2/oUjXddybcXjJ7JgO9ybLZK/4C/XZeWGb7KEDXu7IeXmNs0dJP/yiS0asCHPTgOBo1wntVA8R13XMn43PpQVQ3EjQnzHioAkGM+X+bEeJoQnekNjc0fl6euAvCTQHsF58KVBhBWnzyrFkGDBOh7zuW9RhPSF3dtydRX5mqJsSuzk1yYticC9LZfz0Qz0IrG3sssbZrUDdEYdDsaThZzXow0HIvBzEsydmQMjnVxWxbi/J5j2ISyugelnbCHgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(336012)(81166007)(8676002)(1076003)(4326008)(82740400003)(2906002)(82310400005)(44832011)(8936002)(36756003)(40460700003)(36860700001)(47076005)(83380400001)(5660300002)(426003)(356005)(7696005)(6666004)(478600001)(110136005)(86362001)(54906003)(316002)(70206006)(70586007)(26005)(186003)(16526019)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:42:24.0899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3508d86c-3934-4fa4-ec25-08dae18c2fe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at 1 ms timescale
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..73a02816f6f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

