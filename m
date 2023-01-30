Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886CC680CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjA3MFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjA3MFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF49367FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElV40V89uZlYSn7zSA+ivUzgd3ws/g0d42/SOni3YXaxXKqb87WN29GfYtHV/gj50GVJRXlJiikgJQtVYEqnC1bto3CgJ0IVW8WcCuwvPM1rcsbYeedmMhndVws2M82e8ozqE6R0AN1prXiUqVY7XMGNIiAw7zS9XVqKtT4K/d1jEAxqnqpjkceLlcWfEfKqbT6TEUYatgPo8LeoI1+JugJgNCNMW/uMMyMHJtRCteh+GTurhQj0t3z4Duh+jNkfHwYRg68/AYmneNapkeWq17uvt0zQzigFadsfincI3+nXZLtlX3TTKCsIl6A84R3QI5E+c7WcCPsxX2qoCqbc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTlmczWwMx9tRbbEP9cFDNlj8MSP7Qbmbi637AnUGIY=;
 b=YxUyW5ISv2bEZXAa3cnp7wv+9atv5jBunEMdGbsmByrKYOVd8V1X5/tPwJRdiqmvazY/v41MbyB82eRpcJ1EH+fsFPmGUr4z+pwzdKu7EFB87KiUJEC3IHu5byCR/k9wxCaUintHqLgRfCkMdJoat66E+OIVmH2PNogrY2PA2kWWJcagYgBUwaTSfZ0J1jrBIKDIjeKDUvCGvAVxUzyZjqv2K1h7Sghie/DWTBNv7sVTyqJ25ZQPJTazfybjAgSdRXonNz43nR46E9RMsq++TBpgAaRaeN1lpZ/yIVztqyxK3qENwAZ0KPnZdQfpyYqCKKRpu7u87iZqtoUImXf+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTlmczWwMx9tRbbEP9cFDNlj8MSP7Qbmbi637AnUGIY=;
 b=TnRKmfSxBzWcVUByGJhXSH0jmjklqgbTIGo528yeav2EhZRZQOELYvTkdGJdmBEAS/EwfkhJXDYtIf+/3HKnuaDk+sVDqEpOGrtD1HPRgvvIKLXmqKrkOYngdpM3Lvzcu1jTnIL44fOQroQ3pJky9NLTYuLAUf0khlmgs+MYuLQ=
Received: from MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40) by
 CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 12:04:48 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::46) by MW2PR16CA0027.outlook.office365.com
 (2603:10b6:907::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 12:04:48 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:43 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 08/11] x86/sev: Add Secure TSC support for SNP guests
Date:   Mon, 30 Jan 2023 17:33:24 +0530
Message-ID: <20230130120327.977460-9-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 63085e22-05e7-4511-91a6-08db02ba2f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fUAYVe0jhLJBA19ImBS0mcFo7BQe4H0eHXqk46g1GadojpE+3Y/R8Nk5+4HFrUM4i+OyH/q23v0yG/cMSJwtyJOkgbyiWxnb3uQdI8xZ3HEBOqj+lM5SfRialcd2GE7lv9Q0gspCdBMwmwKBVhmZZ8kTilN587tNDOW2yItufgZTNWpGEtcPPACWf8Ft6X334IG0+Unh6mpSYzjtutEdu7keC8PwXe7KWPaRKmPWQ7WAtaKhtA9Je9gOwBRw6UsdeDI2sdidoh0RmOrofUPUfowIt78pv5KHmDax9YAL0fbFiPVV5lctzUqYtBPO1WRoF8KWHP/PLPZoSfgh9hYMW9uWZcU1rCEBRbQEwpNvKgvzqe0KSPpUclmO0YQ7VbiwJf0uXNZdqWFbHPZA57tQ6ioQsE8ZbWW+eGH5NT1dJqhsDIBzRg8XzAkwY89oTpbAqwVK55QJlzTfzzJjnkHdwN3FwpJ3Wk9YuctAqJOtjFLGYozcW8tWhs/5Tssjxujo7rhNhaZNV0ZOu3nSZgHFjlfcrwqKLAYdykn07MwewxrPiTc40+jgiUN9S++AaIhP3e9FM/0pZoJnlLdHRLjjd9a1dGW/pzWD4/FrJbuRDWY6F8nd0mXgTBqWga6YCkuZKsoGXkHQszOc6fTYQmvAhInHGUkDlB1l4XzherZzlVuF2rUMrkSTx1UvZfJijJgCUihFPjor70whCwahu+h01Pze3vucnPzKh+R2gVxFSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(316002)(8936002)(82740400003)(6666004)(1076003)(7696005)(478600001)(336012)(81166007)(2616005)(82310400005)(26005)(186003)(16526019)(356005)(30864003)(40460700003)(36756003)(7416002)(5660300002)(54906003)(110136005)(47076005)(426003)(40480700001)(2906002)(36860700001)(83380400001)(4326008)(8676002)(70586007)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:48.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63085e22-05e7-4511-91a6-08db02ba2f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index e49dae4edda5..ecc4e52c8519 100644
--- a/arch/x86/include/asm/sev-guest.h
+++ b/arch/x86/include/asm/sev-guest.h
@@ -34,6 +34,8 @@ enum msg_type {
 	SNP_MSG_ABSORB_RSP,
 	SNP_MSG_VMRK_REQ,
 	SNP_MSG_VMRK_RSP,
+	SNP_MSG_TSC_INFO_REQ = 17,
+	SNP_MSG_TSC_INFO_RSP,
 
 	SNP_MSG_TYPE_MAX
 };
@@ -72,6 +74,22 @@ struct snp_guest_req {
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
index cb1ee53ad3b1..d81d8963e3b1 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -402,7 +402,9 @@ struct sev_es_save_area {
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
@@ -534,7 +536,7 @@ static inline void __unused_size_checks(void)
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
index 3ca87cd4548e..55b6c8208e64 100644
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
@@ -1365,6 +1369,80 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
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
@@ -1465,6 +1543,12 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
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
@@ -2649,11 +2733,7 @@ static int __init snp_init_platform_device(void)
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
2.32.0

