Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CC680CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjA3MGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbjA3MFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BED30EA0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVbW25B2Vm92dp6P+8215MD/UAnInKPE0MxOty4B2auvPHr1Aw8D7viSyUNNf5pMRptmpt1GWyhvr7URZDD2sS1i5NPq7uZKJ3rsgfO3iYp5RoJZK66GRrr+z9ecm3rZU/qWIaP7j8yHKco43V2oRoTFEAJhO7iTke+tqytG34nFdjDcOXnowpe6BsKq9sLFwOqcxXQKR1mIwYctoHeopFSa35n2xJltLHzrn7WU3l+JKj1i2U7dR6w1nqplHcbYsP2OR2P3YoJ0AURrkeYmBJSVb5XQTObgyo9awpW8sbqDJWDcJlTgsRr5kY1XmqthV5LxhiCbXZXNH6U65OhVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/52SvJsZahmZBi5pTpAiNXVYWzisw5i0r20TsyjcDU=;
 b=McMkplHjFS9DCDmtzGtySwnT2E8ax71qNc5WoG+Ujkr8RMmuUdnXTeLp6Qo8IcZmNhyo2GxxDES3bECL2yu2lum8ijor0BSTSzVmWIIqDJu7+CR8h3WTtaQtsgchHWNX0MO1Gb/e04otpl9/l1etZBN1CBXYZyNz74Nn6qM4N4Z1niOJRyToei6SWxHR9ecDT9nZHjtdDzj5y/mz5ghCE9z+cQyq8egeUC9wBVG0RBY/k5Jj7uVg1todp0P1Y840/7JYJDJuJ5BcNqhTyfcCqgxWujdxKIDLwWwJN7ZqCD73aOshpfN4jK8Giuud3bax1XTzf7rKE5chRYbuhg7W8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/52SvJsZahmZBi5pTpAiNXVYWzisw5i0r20TsyjcDU=;
 b=w0AyN78n5w2PImRm+FbWO8wbxETyo7jrW5LQCfZtkZnSmMpO5vAkPHnrQkzcgBBqzN94rCBnrcpzt3yUu+5MIACEE2coodFOcqP+QkFYKFJqy/DK6lM/7XRDw9fJWYGJ6+HizaSZHrkLdWttEkVvBADLU7nLy46sfsb0CMBdRxI=
Received: from MW4PR03CA0109.namprd03.prod.outlook.com (2603:10b6:303:b7::24)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 12:04:39 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::f5) by MW4PR03CA0109.outlook.office365.com
 (2603:10b6:303:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:39 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:35 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 06/11] x86/mm: Add generic guest initialization hook
Date:   Mon, 30 Jan 2023 17:33:22 +0530
Message-ID: <20230130120327.977460-7-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: c8921339-5381-46dc-9d65-08db02ba2a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8pVWraJ4A6MFYi9dJqqL1/m7impj+raYQAs1WTMbjWA0jwf2ZhZBTVuz5GNyuE3IJLxM7S2tKqAuzcihXutexPc0dccN0UoytZnfB8miJdtiBTFg2xsqTHiXAtRYzwSWEGtUFbzMNDVKBVkWHds7m6i+Z0E4SsMUXfcHbUpwUteX3IkavntjJ2lQLcGvEPBOtfg1Vs7tDlWcI5BwBy0oNNInUZFIV4jYs9ayqHQ1JfYs0MbMwcoLze8FcxQrQ0uYyz9pfw6ZArVGzjv18x72vwfwx08uUSwhOL9WgUZuqXdQ+kv1ro+oWcCrrRSU9MHFsjYvEM8nBYZPuRkz4Dmop0tcRd1GMDhV8kUJUbinpTKW6rZzVC1oP1isZ0djscBa9mCq35I5cfxYzxI4oMvTBC7IJ2ZBNj5sQenBzlLaFmjOZaQitOIk5/VY3wSb5mzj9+bJrbe1KHYY4wUmIPw9ZKpSpIIuP8QX52Fjg5IIqf1JFZrl5aNWI+fNkBGf3b1ly1MvTJut55Wtu6Qkqz67OJoRHAQ84xn9bxtUQ3xPpKU0MQRO57o+1tRHDCdhszqTwtiQEcgUgwG7lNI22Z4KY8GjjQKoSWh0x3kNa/DamTyLEhe66Jut6KTOsw5X6uqUYyM7wNoPkkgTWef3nAG1xnqnl0U9prUm31URWaQ/bYIRGcddEN2xJR/NC/ORgAuWan1BowMpk9hFrkVi95SspXXWU2J/GUIcUD2aohBm+yVoR2ESnswDNdZSHsjHeJR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(81166007)(2906002)(7696005)(6666004)(7416002)(478600001)(110136005)(54906003)(41300700001)(36756003)(356005)(2616005)(336012)(47076005)(426003)(1076003)(8676002)(4326008)(70586007)(70206006)(316002)(40460700003)(8936002)(5660300002)(40480700001)(36860700001)(82740400003)(26005)(16526019)(186003)(83380400001)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:39.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8921339-5381-46dc-9d65-08db02ba2a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic enc_init guest hook for performing any type of
initialization that is vendor specific.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 2 ++
 arch/x86/mm/mem_encrypt.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c1c8c581759d..4026ac30a79f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -148,12 +148,14 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_init			Prepare and initialize encryption features
  */
 struct x86_guest {
 	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_init)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d361b463..a71996e51a9c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -134,6 +134,7 @@ static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_init_noop(void) { }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
@@ -155,6 +156,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_init		   = enc_init_noop,
 	},
 };
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14e185f..01abecc9a774 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -84,5 +84,8 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
+	if (x86_platform.guest.enc_init)
+		x86_platform.guest.enc_init();
+
 	print_mem_encrypt_feature_info();
 }
-- 
2.32.0

