Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF246C95C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjCZOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjCZOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479826A4B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4SEpAZ3Co48l0WtBJogj3lgjXv6FH1i+TsoTsFNkCq6XQg8slMT1XhrACd7q2DSevMzqK1LWcrEIhPa/dCyJOX8DcTIoKDu60NsGr+4J+Y7Brk5Fc20m1m+HgBfHoLfdyVwcXRM11pNTWbYR2FM4KcsM7gTBL0jkElPKdsqaAKrzsm2HYT9CBE1Fj20c3oa7hiMUua+7isSQXomzJx+OUc4GZorj29Qsygtko4GJapXwfqY6bhHGDBcxKGJpJmnw3/o12QCAKaz4B7aiKOMl5b3PU1qn3StBGVzi6AdO62ku/b1h8Yc2Pf5ayucegQI0kxWLEcCyW31N2I++6QHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZOd8+VWlBTQm3ysuapRL8TUJrtzoFTQJXHfy5b7Lis=;
 b=n9L7Qos1ldu9I7iVIJ5+3fhtWhk0JL+PJhfqQGhrSwtT+SrLzU7uVwqTkLfMJ8n+M7Lp3LYzgQ6wOaAStRDTlgv78Z/cxF6p53pLLgSMIirUafK3Aot3VoAMXMcxv+3xffRQYlms0X0JiStCwcwdyffN+bnopjuPsh26HVHRzmmZkSx1IgGK+HRQoGpRgDJPGnIKWKpzmMpFVtSNGFQDI/sasxgaa30ioBbYfJrMwoVqrhuidfRIle/dyds2ZnDWgPuHcHSNMlhlsNku7Q1+QmQbe+HvzissPMa3n+I4/Utv5W5qE1fDxbNRUImZ+6sfimJJpFupqYkx1SXoon8QnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZOd8+VWlBTQm3ysuapRL8TUJrtzoFTQJXHfy5b7Lis=;
 b=QWh81SVQCj6VhSfeCCnSF/0ljp5+Yi1rjJBol2c5M0tROZzlW4GGh++4Oat+hsGobET5vhqCN41ds99PsFzRc+CHkW9tkMfvJFxFr5i5VB5hK9J3Hd31Mjp9OxxyQX5jInOSu8PBQ5vNOqoGKjVe9EcOwN/LIpCZ5HTlcUeAsjo=
Received: from BL1PR13CA0132.namprd13.prod.outlook.com (2603:10b6:208:2bb::17)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Sun, 26 Mar
 2023 14:47:43 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::7c) by BL1PR13CA0132.outlook.office365.com
 (2603:10b6:208:2bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.13 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:42 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:39 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 06/11] x86/mm: Add generic guest initialization hook
Date:   Sun, 26 Mar 2023 20:16:56 +0530
Message-ID: <20230326144701.3039598-7-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: b9674fdd-f6a7-498b-3a28-08db2e090e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJLwUFnX5QueNxKQeFVJ4veDiDUsT+ui7BMQHcdb6+T9k12AmLn6pwi7CVE7epQX2RPnwPETZLj6jW4MbT9Fm2kvUjXtzPHdDJsdzytsJpyLENLlRfMbZQlYx2f1pup3+PCtEOMAMfhXda8JJyikncQ1Ex8MaJQxtmybqYH69I5Ct3p4fXQsG0cnHZWt8Y0ulHIKpsb6Ih8qzvr4jFHtg/sksoBJb412Vxq4RExE+pT/9EG59lxHPZ2ZKfRRD5UDP0CVaCwsAVfI9IshAYkn557RnvB2o05lxGNMw4pXFhstudivPpgS3osRzc1rZK24oe42p8PQxvcO+ktWzqs2vNu3F8UR/c1pxvtjkrlAKG5uI3b/Bxvqq3/KF9Y2Q2kfk0dV39y7lSOXR+gf5j/Mks8UjGnkMtnrAygqXzY1ePIfpesU6X/u77rrodsrjiIiea7dwyZsW8HsMuW2aVdA28iWwgrQhh2XzSwGDaC3g20BaaIvTIYV9yFg2ccvcZHdMxCYR8XBiuAJMP8dDGqH7jqNqLf2MNcyveTNWoDtmEBYO9iO2zLb/RuHswwDxMXAHQLi3LRPlYb/aH79RP7+Z9uqOowhOrWL15/Mu8NnlqTJVnzqCuBfrx51DWyi+TUKR486u4gQFrs7+khTSMRGf29NaDUtNZfmgRfvYoN/sxBfxsUJVy2MWeKjC9MkQsOUwNRM+dIGsBss/9rB+AcWMbv7xLkYU9fmD/JFPIw7ChujzWjZpfpqPegm++7d4X/Y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(336012)(2616005)(4326008)(70206006)(70586007)(8676002)(54906003)(7696005)(478600001)(1076003)(26005)(16526019)(186003)(110136005)(316002)(6666004)(82310400005)(2906002)(40480700001)(36756003)(40460700003)(41300700001)(36860700001)(5660300002)(82740400003)(8936002)(81166007)(356005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:42.9648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9674fdd-f6a7-498b-3a28-08db2e090e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.34.1

