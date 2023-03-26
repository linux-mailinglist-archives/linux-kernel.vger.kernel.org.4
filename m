Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6C6C95CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjCZOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjCZOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:48:01 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4B865B2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpaJKreZt4cH292xJtun1lwA1L7YWJKE+fwCtuzmRoiIx1RBSfVwWq9bJFcF/goTKZweRyc/u8k2d9C7LbN2znCDWY2VTs+uQXE9EdQT68eTYseVE3+OeoVi4lKTmcBo8XGxIwfsHu4K9VAwtJGoBegcr4QhRViuQyqkbhDeP9A/2lwsSsqOmdFTMMqxUCTUEDigclexorFAXolN3M+XJ0ro4uf9DUkJtynGikaRVwFI3IHH+DvIU8F1SSfxdrFgdSBy9OpcdNZtbAYoROeuAqfFfbBEdvFvqLnqkHuPFSmE/VyqgKKaAL3VWxaT1Pdf2I/kuZ7kopibX5vW7V8Rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze86LUa0Gg0kC2N5eSAqM4UWybZ3yRCrNeXFDD+tz2E=;
 b=EVG3VBZqrQ4IZCiADU2oasJ4RLi07USDllN7WgdH65gCJW4r+uRAwAJE8CnuqVGWJDKLNZzk1IOEaVaFaHXQtmrfFm6w16TI/LxDcAXd5DUrAVWx/sNNKmGOC2LnYLPJCsQGdubO7dnS4Cd6N9ztff3M1JAE51Rc+4lbiFbSnQSn2MLZfateO2JgoCzz4pkMD/3gWTf3p+ttRr65hV2kdlOYfo4DYyyn/wg1xoZEqMUcNZMXxZ9u5SzFBwZW/QSMJ7utYw0lmMu72oy/msDjRLU3nlhyN8oMmT7vSAX9S73Dk4FtVXlnuVk6op8YK+xMofbm8NPH45vFwDJtkznRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze86LUa0Gg0kC2N5eSAqM4UWybZ3yRCrNeXFDD+tz2E=;
 b=4EIp+EKCKdtGUc43fbroBKOa8hlVUwK5jCbGymrVB+64I0uq62l8p4uNVh1yIeR9ZL6fDt7Gv64/fn0Io6EZgZhli5thJ76XpygwIRvgkrT61vB28GJFwphbIyKrobmBgixqAFEPHqggFI4IB1XPLxiD0GJnrO/ipSkJ3GbNeBE=
Received: from MN2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:208:e8::37)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Sun, 26 Mar
 2023 14:47:49 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::8d) by MN2PR20CA0024.outlook.office365.com
 (2603:10b6:208:e8::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:49 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:46 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
Date:   Sun, 26 Mar 2023 20:16:58 +0530
Message-ID: <20230326144701.3039598-9-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cef3afc-b41d-48a0-2834-08db2e091218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn2iC7BOyJuphTaZNMEks3PldhyOddFeaTEO30vZMc9+VNZKBta+sY41Ry1vEQ7zSwcQg+CmAa7SOgwrvoxsGNhNmEu6JI8C6C2i2HQXj2uWbeFYRkVZpbe/N/j9EbZY/K+qLlgPSDm7md2pKhY9FpD38a2OiuTgJ9GH458zKrWVAKHiHghqz4erMqx6AovBfuvMnMHPz2hXXxQVpB8cdeywyRYG2Md/DDgvAFLckp/8lOsvAbxS/SixORh7zGna/FBCW2UfU+gerqTMNp53rIWvZo0guiwquxMnZ7L3U9y4mBYWtrylgntebWYVgiOrP+nXJYiZAu21ZggRj+rkCoG7mxO2O7qSb+MwQRKfAO2xTv6hUtaGWfL4CbfJLdqsB0pssN2PlC/OziJRRGzj2kFuoBdBOzeU8L6VIw5X//bDXOB5gFtHkkMFzuoqqi5WqZJ/TA2ac0zn4O1OLbTMjgAV2xuSC/HJUp+WY6uiJWg1+7C0aagTEXLTd1CM7mWGgRQE+Cjk0PNPSlu3SZ4XkY190GdqV3NYMbb75ynFF3mIUz+Q1WiLxbFtGqOo21UXWBPJ3xKVsTtCTjN7cSPT0Qd2L+5AjQw+VGFfTHoeYdwqhiQJja1ZarIFZQJWLLuWz87msSOvr8jktlgBJ4KbIGzO6ghtMjBy9kTU5risGDVi6VTVAHfRdyprq0R+9hb8YBx7cRh8RAtSCEdhCIMgKPbYfnzln4euVerPx2t6c84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(336012)(2616005)(4326008)(70206006)(70586007)(8676002)(54906003)(7696005)(478600001)(1076003)(26005)(16526019)(186003)(110136005)(316002)(6666004)(82310400005)(2906002)(40480700001)(30864003)(36756003)(40460700003)(41300700001)(36860700001)(5660300002)(82740400003)(8936002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:49.5744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cef3afc-b41d-48a0-2834-08db2e091218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Secure TSC in SNP enabled guests. Secure TSC
allows guest to securely use RDTSC/RDTSCP instructions as the
parameters being used cannot be changed by hypervisor once the
guest is launched.

During the boot-up of the secondary cpus, SecureTSC enabled
guests need to query TSC info from Security processor (PSP).
This communication channel is encrypted between the security
processor and the guest, hypervisor is just the conduit to
deliver the guest messages to the security processor. Each
message is protected with an AEAD (AES-256 GCM). Use minimal
GCM library to encrypt/decrypt SNP Guest messages to communicate
with the PSP.

Moreover, the hypervisor should not be intercepting RDTSC/RDTSCP
when Secure TSC is enabled. A #VC exception will be generated if
the RDTSC/RDTSCP instructions are being intercepted. If this should
occur and Secure TSC is enabled, terminate guest execution.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/sev-guest.h | 18 +++++++
 arch/x86/include/asm/sev.h       |  2 +
 arch/x86/include/asm/svm.h       |  6 ++-
 arch/x86/kernel/sev-shared.c     |  7 +++
 arch/x86/kernel/sev.c            | 92 +++++++++++++++++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c    |  6 +++
 include/linux/cc_platform.h      |  8 +++
 7 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
index 834cdae302ad..d5ed041ce06b 100644
--- a/arch/x86/include/asm/sev-guest.h
+++ b/arch/x86/include/asm/sev-guest.h
@@ -37,6 +37,8 @@ enum msg_type {
 	SNP_MSG_ABSORB_RSP,
 	SNP_MSG_VMRK_REQ,
 	SNP_MSG_VMRK_RSP,
+	SNP_MSG_TSC_INFO_REQ = 17,
+	SNP_MSG_TSC_INFO_RSP,
 
 	SNP_MSG_TYPE_MAX
 };
@@ -75,6 +77,22 @@ struct snp_guest_req {
 	u8 msg_type;
 };
 
+struct snp_tsc_info_req {
+#define SNP_TSC_INFO_REQ_SZ 128
+	/* Must be zero filled */
+	u8 rsvd[SNP_TSC_INFO_REQ_SZ];
+} __packed;
+
+struct snp_tsc_info_resp {
+	/* Status of TSC_INFO message */
+	u32 status;
+	u32 rsvd1;
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u64 tsc_factor;
+	u8 rsvd2[96];
+} __packed;
+
 int snp_send_guest_request(struct snp_guest_dev *dev, struct snp_guest_req *req);
 bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 36868e21c3e0..d05cbab5e9e0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -218,6 +218,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
+bool __init snp_secure_tsc_prepare(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
@@ -238,6 +239,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline bool __init snp_secure_tsc_prepare(void) { return false; }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
 					  unsigned long *fw_err)
 {
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 770dcf75eaa9..c781f8e0aae4 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -404,7 +404,9 @@ struct sev_es_save_area {
 	u8 reserved_0x298[80];
 	u32 pkru;
 	u32 tsc_aux;
-	u8 reserved_0x2f0[24];
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u8 reserved_0x300[8];
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
@@ -536,7 +538,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
-	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..1c22025b298f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -912,6 +912,13 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
+	/*
+	 * RDTSC and RDTSCP should not be intercepted when Secure TSC is
+	 * enabled. Terminate the SNP guest when the interception is enabled.
+	 */
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		return ES_VMM_ERROR;
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3750e545d688..280aaa1e6aad 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -72,6 +72,10 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Secure TSC values read using TSC_INFO SNP Guest request */
+static u64 guest_tsc_scale __ro_after_init;
+static u64 guest_tsc_offset __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -1107,7 +1111,7 @@ static void *alloc_shared_pages(size_t sz)
 	return page_address(page);
 }
 
-static int snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
+static int __init snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
 {
 	u64 gpa;
 	int ret;
@@ -1406,6 +1410,80 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
 }
 EXPORT_SYMBOL_GPL(snp_assign_vmpck);
 
+static int __init snp_get_tsc_info(void)
+{
+	u8 buf[SNP_TSC_INFO_REQ_SZ + AUTHTAG_LEN];
+	struct snp_tsc_info_resp tsc_resp = {0};
+	struct snp_tsc_info_req tsc_req;
+	struct snp_guest_req req;
+	struct snp_guest_dev dev;
+	int rc, resp_len;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(tsc_resp) + AUTHTAG_LEN;
+	if (sizeof(buf) < resp_len)
+		return -EINVAL;
+
+	/* Zero the tsc_info_req */
+	memzero_explicit(&tsc_req, sizeof(tsc_req));
+	memzero_explicit(&req, sizeof(req));
+
+	dev.pdata = platform_data;
+	if (!snp_assign_vmpck(&dev, 0))
+		return -EINVAL;
+
+	req.msg_version = MSG_HDR_VER;
+	req.msg_type = SNP_MSG_TSC_INFO_REQ;
+	req.req_buf = &tsc_req;
+	req.req_sz = sizeof(tsc_req);
+	req.resp_buf = buf;
+	req.resp_sz = resp_len;
+	req.fw_err = NULL;
+	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+	rc = snp_send_guest_request(&dev, &req);
+	if (rc)
+		goto err_req;
+
+	memcpy(&tsc_resp, buf, sizeof(tsc_resp));
+	pr_debug("%s: Valid response status %x scale %llx offset %llx factor %llx\n",
+		 __func__, tsc_resp.status, tsc_resp.tsc_scale, tsc_resp.tsc_offset,
+		 tsc_resp.tsc_factor);
+
+	guest_tsc_scale = tsc_resp.tsc_scale;
+	guest_tsc_offset = tsc_resp.tsc_offset;
+
+err_req:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(&tsc_resp, sizeof(tsc_resp));
+	memzero_explicit(&req, sizeof(req));
+
+	return rc;
+}
+
+bool __init snp_secure_tsc_prepare(void)
+{
+	platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
+	if (!platform_data)
+		return false;
+
+	/* Initialize the PSP channel to send snp messages */
+	if (snp_setup_psp_messaging(platform_data))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
+		if (snp_get_tsc_info())
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		pr_info("SecureTSC enabled\n");
+	}
+	return true;
+}
+
 static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
@@ -1506,6 +1584,12 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	vmsa->vmpl		= 0;
 	vmsa->sev_features	= sev_status >> 2;
 
+	/* Setting Secure TSC parameters */
+	if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
+		vmsa->tsc_scale = guest_tsc_scale;
+		vmsa->tsc_offset = guest_tsc_offset;
+	}
+
 	/* Switch the page over to a VMSA page now that it is initialized */
 	ret = snp_set_vmsa(vmsa, true);
 	if (ret) {
@@ -2698,11 +2782,7 @@ static int __init snp_init_platform_device(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
-	if (!platform_data)
-		return -ENOMEM;
-
-	if (snp_setup_psp_messaging(platform_data))
+	if (!platform_data->ctx)
 		return -ENODEV;
 
 	if (platform_device_add_data(&sev_guest_device, platform_data, sizeof(*platform_data)))
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 9c4d8dbcb129..7d2388e52b8f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -215,6 +215,11 @@ void __init sme_map_bootdata(char *real_mode_data)
 	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
 }
 
+void __init amd_enc_init(void)
+{
+	snp_secure_tsc_prepare();
+}
+
 void __init sev_setup_arch(void)
 {
 	phys_addr_t total_mem = memblock_phys_mem_size();
@@ -501,6 +506,7 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_init		     = amd_enc_init;
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..e081ca4d5da2 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,14 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_GUEST_SECURE_TSC: Secure TSC is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP Secure TSC feature.
+	 */
+	CC_ATTR_GUEST_SECURE_TSC,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.34.1

