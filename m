Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898F680CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjA3MGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjA3MF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21914EBB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIba+h6k7jNDt7rutyzpwCuI9OlUGQuDF2pAy292+kYSr6GHUMFsdnFR0uZ5LvY8xHd0LITqHnyWBTGLGffeDOitChJthKnuQlsREjjwSBTHNp8guUUM/HhKn3HZGxTjJm/QWptrosoiMHX6zApGWPmIu1ICWUuIovjj4QLgzhWWyKfqBaQBPgIeV/qYJNiTOwbiIPs9jhFOzhd8fSMJ0dT+oGipcTVXE0pEcAXSPGUgrhOml6gjUYBRmWn7QYk/RrcA9KB+OvhLLA5INLybp5jT4LNJE8ClOCRpG8KcD+wuTPnSNPsgQs/BN+Rk8nwLrW6Nnzfi7G850yIIXadjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ll2BXGHWdZMd4O8YYI3PJMJFzIYU39LZrATRmGNAoQ=;
 b=HX9DUNy036QnF4N53iutbg2KEchft+/ct3AVaxAvyAFFjfU+iCrWz7EwA2lu73ZiN93lm/7tl9vv9SHu4YnU1xTUUQQ2vdDGvRvYAMtOZsx2ZrspKuZSR5tet1knMKMSyP3HTtHTS12k53T7axh6vhhkG6Z4ILFyGLGwGv0LLvF4U/DvzJGDqp8r8/w2BF56y7YwtB9hf8B8i9DeooBdKeTUzuWJuxrgaLeGcUF4T5imriWDqz2XGwD6qjh9pkQhstvOgijweZkb7DgGyoPj83zDl0EG1krdhAgcoAOVeZ8gN0hYeamPHaWK8rESPE4KrT4k2duou2yWU1X6DqD/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ll2BXGHWdZMd4O8YYI3PJMJFzIYU39LZrATRmGNAoQ=;
 b=UPaI5vBaWWiNhqXd6hN0T1nvByDCMJQgmaCMYcPo1exm0wrIGBadsFIqqcslpsjHP6tQTgBDYRaiTHVyK/fGx915YRJ57SNBk+FFUKii8asqQowsgF3/cm94NaAWni5lurUf1btZLK8AknZGyq1/ZphcROEmV15NSEwl321vAeU=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:57 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::cf) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:56 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:52 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 10/11] x86/tsc: Mark Secure TSC as reliable clocksource
Date:   Mon, 30 Jan 2023 17:33:26 +0530
Message-ID: <20230130120327.977460-11-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bbb921-9db9-4f31-dbd4-08db02ba346e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbW5XicjqR2YPy88ddkOCMJC+a2vX3zzQ0s7xAk7xtQ2oWf63pQdAPkXxNOpPkZffLVkIrfmAAN456P2ygTxUujVvDH5Iq2KChGI+5GQUrVGW5a/+LY4mBMe8i+CYF/6TV7GZSue7paI5HXnYOunBwsZYKJ3MD9S+WlgjcNM/5U9hpsyrVu1ph7lblzJJpyRElTTEonYxE80NfBiajVh0fRhkFE/f9ZY3bk15XbZzvzNQcAIX8QoCeuUqc8yQbqwa+QZuyEvg32SxELbvcXfGc9rFbKhtGzNITpW3NzT5TZ41N3Oio1j0deQVME//7DgTcDMnbeLUBs9gsn/gYioBRkPN32lRQRwWiMbb+9uKSyEE6DNVdMfTXRVD/xS+A7uWBDMDiSlkWDlq8f35uzzJbx2J9g8I+GPhxW1JRB2nL94a2DG/OUfkKTva4NdvUWFNP4TC6AxssjBAVx19CGzjG22A0F8Sh2g1LRQbNp1vWFj85GflLxugBQN6JJ1C//y49HSk+cSGdl0dNBSru/fpedYgJPUsZjquRCDd0vLO9+rrVGCnsRb2vcYFvvwW/MhjEV/EZif8MqBuFyrLWGtgG+kjfWTvQ39mF9zp28k7poiuBs6+VAgM8cNSbFCg9vm/9olZyU+GSWEIAQXKovU0BCgtYO4Y0he5xTaGbA+f1i9Q6wJYgMk26Mcxagm2ykbTpwxb/hD3Yj/8Xz2VoTy33kg3mDyGEyDZzqjvqrtovU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(316002)(16526019)(4744005)(186003)(356005)(5660300002)(81166007)(26005)(1076003)(36756003)(110136005)(54906003)(7416002)(40460700003)(2616005)(6666004)(82740400003)(82310400005)(40480700001)(47076005)(7696005)(426003)(336012)(83380400001)(478600001)(4326008)(8676002)(70206006)(70586007)(8936002)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:56.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bbb921-9db9-4f31-dbd4-08db02ba346e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SNP guests may have Secure TSC feature enabled. Secure TSC as
clocksource is wrongly marked as unstable, mark Secure TSC as
reliable.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..7a7a5eaacb54 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1200,7 +1200,7 @@ static void __init check_system_tsc_reliable(void)
 			tsc_clocksource_reliable = 1;
 	}
 #endif
-	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
+	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE) || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		tsc_clocksource_reliable = 1;
 
 	/*
-- 
2.32.0

