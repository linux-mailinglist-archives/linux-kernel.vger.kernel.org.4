Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB33680CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjA3MF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjA3MFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EAC144B5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoUtlDSWbh64LJvLrjKMreFuwiMTRtNttKyFzDRBaibRZ4BYXWKdO+KAxVrUF6CYdeI8m0ufa9Ad5hmWiv2hxaCVSvphIwvB7qMk6ws6rtsoHBJW3Bm7J8km4GUG3QHU6YQvJwOQinX7bM2GFCfXIJrDaXsycmEf2YjQ0kcv7Lq+BdHTAjJzlQQewlDQzIELC6j3jUCWtckT6JBrXdMTGItOX/r/2s5vGQfLtIgc24VY2BvzQebj/+WLNxCAH1Uck5bm8ubIIqqLG/qbZRDE5Vw9P8KPYNry6QoLvTRymyx+h+U+Fc92cXG6Fk4vhqc878zHpGeD994YadtYJG9Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h47+pIzHzcLFzz9VZq9otaQ4VkO9bJauzn1tJH6RXo=;
 b=js5UCJwSX9aNpxYkB5zkgXhTIwrptICeBVOvokBYPbiqamkBi17+cBrXJ8F3begrANKpxf1DfXGXVW5A7rcjBUvTYyK3HjgXI5nndPrVhOs34kBbDMPV70XZwMn9iwg0CD0w/jcCpq9mg1ftHBaDLBgWTyOA35CRMqVR+FgvVXcYaQ2DFE2E5UpPqWNlqvtyh9F4v6DwHa3W47MWvMFC1xeRZ1LvgRkvMTukUmeG+XAsmwfZDfQqjrSEW3bIoDTcepVg0bF6Cudbb3tFYaQUuD3DN1qrjpq9GrAl5pyEPXh/B9KkODbpFee1iohGCQ06IXsEbW7alRv3dznjhYO2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h47+pIzHzcLFzz9VZq9otaQ4VkO9bJauzn1tJH6RXo=;
 b=p+XsxKuKwbyuKXVNNm47pngLR/2zRmffsogUyOmmoil35AAdkxqv7f+ZFrek5WHYm0j8quIl5UhoVpCW3duItNXk0vcRLbDjq2aIU7X4fxtdwRM6hGvE5bofeJrm17JT4Yf/4wR2LDlUb2oG4nLigzQQ1lvBQUIAuAEzzPtDJew=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:52 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::2e) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Mon, 30 Jan 2023 12:04:52 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:48 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 09/11] x86/kvmclock: Use Secure TSC as clock if available
Date:   Mon, 30 Jan 2023 17:33:25 +0530
Message-ID: <20230130120327.977460-10-nikunj@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230130120327.977460-1-nikunj@amd.com>
References: <20230130120327.977460-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 666a1e80-3281-4c19-657c-08db02ba31da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifzilVcu39N9L2PIVrg90pNFMTnxUYccMR/AouoGN3k4hZmkPE+t5mvPHTU4r6zyFgxL1EI+MWxi6IugLA5KArbW4ZuM3mzCs7zx8BcCLbAmN+GM/16G2aukQyuLL/YXuO5GVTL8ciXFXwBSGtauRCtffkWoCRMpk5Bxu6iwLFdTt4L/aMUh90g20fg4dy/6/AS19pj1rRWAK+iN7Nv1UKn/p0c/tpTD9rVlgk+bRqkgWzHDU596TsxzvnbpFwX0zu3rGoDsVC3mRYzj40FZ53qsa5JOjJv2+Xg3kWBQZrBt2u1wGD0NLo1GQueO58tTIB5Zk2i7NTpy+pyZ0cMGFpLUodUtGh3cH7WfhANXI8jTq30ZNZVemAcB5+0yQpGROVXCgtUKCoUiuDIl0DPaKom6T4a/X+iy+gpBO1hWE2+/SIkD8sDFKK/YdpAIclMuRtOhR1OpxSitTA61FAZvhTtJdAHp48R8lcjUnR6s3t/vmKD6QpS3mIl4nuMRd8HfRbx+u0CMCjymSgcKsmbHV1T9KKXDm5zABAEQvFMuKZItM7Ttw3+TtpmOZSKageEHQNhMC397++dMjTREaZhGp1PySBdz5Kl3bbjvq1CQeFq1BDcV6xfUeGOwczBdgAEqiAJmQHxeIkIGpIGU1NZ+HLVoSLqkEr316qe8WsIfNpO2RidFjIZWU+fjZr6OTzwr7n85Hp8WCd2Y3g8NHkJ4l70/SDgNeq/G0lHly12GoXw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(81166007)(356005)(82740400003)(36860700001)(36756003)(54906003)(41300700001)(8936002)(5660300002)(110136005)(70586007)(316002)(70206006)(4326008)(8676002)(82310400005)(40480700001)(40460700003)(2906002)(4744005)(7416002)(336012)(83380400001)(426003)(2616005)(47076005)(7696005)(478600001)(26005)(186003)(16526019)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:52.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a1e80-3281-4c19-657c-08db02ba31da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD SNP guests having Secure TSC enabled, use Secure TSC based
clocksource instead of kvmclock.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 16333ba1904b..a0c207c62307 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -288,7 +288,7 @@ void __init kvmclock_init(void)
 {
 	u8 flags;
 
-	if (!kvm_para_available() || !kvmclock)
+	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		return;
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
-- 
2.32.0

