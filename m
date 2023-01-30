Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75C680CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjA3MFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjA3ME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F611166DB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hubbE5g0epqywGVAQFHIWMxhXwyd53cJiottuxjR3MGR42/86/NDGSrdsBRa+NZjxPZWTvE0PSA71EQKIkHZmNV/w2LxmWVaj48ZNzREfEitjsxU4Y3tqjiDRvgBPaSVg6/bbfQLqsg5fjfigJ7RKWVT8ZNHql8eae+4/KQ9YFBuamHjWu+nEX3/6giSrF/x3JFr8mEqvgB/L6bQ18SrS6ugo97X87/DZLO9CUEQg/qLT1GA6FWa21eszS5rVXQ/0Y8NLOtDC/XpE+iuk5KBCdnL84l5gzpGCGCwgA6xq4id/JEEkmy7PUAwaEjdnz6rOkt7VPSr/G6wAbZJdzEGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLX8HSg/td5Jz7Y4RmBCckIOZBIP6GPe5e0rID/wkME=;
 b=CbTlujy8xyAwnLKlpXFYs+rHC0JvX0MVk+3oBTq9PmfcJyIhNuy6GDKuPqB0qCEQt1Ow6/qO79xUcF5sSfIUI4F/0cIXewpS/kV0+SJPWvusiBjzHaqQgs8hB5SnpwCrQhhD1vDsBL8sYS1afAAsR4H/TfB8XtZLYAh0afF+R9cX18fyGlJYTPjJqNYVyjaSGtNJYn3vxlWatuM6sXg0HCmQzYbaZAM66QTHIrr5JxJCLrciVX5Pw/AB0ZTl7rmyWPPanUh7Tma4zuWWGpQYShDoUfExJwNkXNRkrWrW9Zn7fyXyBnghiZQrh6/FRb4DmDAjaLcqRxbVzAJfS017Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLX8HSg/td5Jz7Y4RmBCckIOZBIP6GPe5e0rID/wkME=;
 b=S7UdH2KugoPHSD1TVdcA7kgryUoWnS2COPWFDpLMmF/ZLq9AFQS3LmG3qIk7LVK1jjnyPI8lNvsFIPEqE+cBBBalxERdz/avCh5BS4WhMX4BhBzyVDjd4JgOq3xlhZ1xTrLyl8wZW+VLs6QstELNj5AmtwAlRbQcHCFJ7/KDddA=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:27 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e0) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:27 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:22 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 03/11] virt: sev-guest: Add snp_guest_req structure
Date:   Mon, 30 Jan 2023 17:33:19 +0530
Message-ID: <20230130120327.977460-4-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a874574-faba-4087-fa93-08db02ba22c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSUZnoz/LPQm+zr7irt9IP4Gzp+jNRSYc98hkM6eWnwOMnOpQKYJimtvzcgdKxds24zEJ4SaWnE+1aBwTCsOaKmRhcJo7G2XfEadODBZr7ZpqOlec/25Pb4rXsstndx4RVSrQKcY92SZgcuoDTz4fHD6CbqvyN8dee7yTIVpe1WQq/MHjVxsBJ6LhixoRC25tzTcioQXh9hln7h/zBnFnaT1Xp0yB1L/y2Q84YABoHuz+2rPhGX70vdOnNOqA3LYHlRkHD9vmHjnxqQVDLB3a1D0glcmpq7D2d35Aa1M0ki1UBEe1glLHH6mEP1H/JAEt79klnd483ERTCZ3SOL2fMqosiX4qXSiGOb9ujbTEKrnSsokK3qJToTqe46hJRgtU9eiLI5LR+LjDXtds2LvD8EK2z2nlW16YnpCxvlo1/U7tfBQPF2QQk3FAiuaXjjygUJzIdPEa1Kf69nqMx5CtFh6gBT0eos+Qx/oJ8HwxT1/V9EvvHw1gQxp1rzJqFYPLQf1U8SA1Ce/uk8MRxicukhUOy0fKkTlEaaaAfkNbGfOwKRI5v5t37lKOEONNGTeJyNhUVPPKCerP+7EfKbj0WVt4Br46BLzHq7A6w8QbOL1Upz/nYa/d17R59O0dwIfZWxsQEUEJtAZ1fh+8eIjmnXjOkbQuqqDvV5Az95sKCtcSMgaCth338/VWlwe1q9j9rVuPwVXOkSVAD9jn63AIwRN8IxSkMfGGDrUfFs6h2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(426003)(40480700001)(47076005)(83380400001)(36860700001)(5660300002)(41300700001)(8936002)(7416002)(26005)(1076003)(6666004)(16526019)(2616005)(186003)(336012)(82740400003)(356005)(40460700003)(81166007)(4326008)(70206006)(316002)(110136005)(478600001)(54906003)(8676002)(70586007)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:27.1714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a874574-faba-4087-fa93-08db02ba22c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a snp_guest_req structure to simplify the function arguments. The
structure will be used to call the SNP Guest message request API
instead of passing a long list of parameters.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 84 ++++++++++++++-----------
 drivers/virt/coco/sev-guest/sev-guest.h | 19 ++++++
 2 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 106cabce1ccd..af5b965c6c29 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -57,16 +57,6 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 	return 0;
 }
 
-static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
-{
-	char zero_key[VMPCK_KEY_LEN] = {0};
-
-	if (snp_dev->vmpck)
-		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
-
-	return true;
-}
-
 /*
  * If an error is received from the host or AMD Secure Processor (ASP) there
  * are two options. Either retry the exact same encrypted request or discontinue
@@ -195,8 +185,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
+		 resp_hdr->msg_sz);
 
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
@@ -218,41 +209,42 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
 }
 
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
-			void *payload, size_t sz)
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno,
+		       struct snp_guest_req *req, u8 __vmpck_id)
 {
-	struct snp_guest_msg *req = snp_dev->request;
-	struct snp_guest_msg_hdr *hdr = &req->hdr;
+	struct snp_guest_msg *msg = snp_dev->request;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
 
-	memset(req, 0, sizeof(*req));
+	memset(msg, 0, sizeof(*msg));
 
 	hdr->algo = SNP_AEAD_AES_256_GCM;
 	hdr->hdr_version = MSG_HDR_VER;
 	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = type;
-	hdr->msg_version = version;
+	hdr->msg_type = req->msg_type;
+	hdr->msg_version = req->msg_version;
 	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = vmpck_id;
-	hdr->msg_sz = sz;
+	hdr->msg_vmpck = __vmpck_id;
+	hdr->msg_sz = req->req_sz;
 
 	/* Verify the sequence number is non-zero */
 	if (!hdr->msg_seqno)
 		return -ENOSR;
 
-	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
+	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev->ctx, req, payload, sz);
+	return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
 {
 	unsigned long err;
 	u64 seqno;
 	int rc;
 
+	if (!snp_dev || !req)
+		return -ENODEV;
+
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
 	if (!seqno)
@@ -261,7 +253,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
 	if (rc)
 		return rc;
 
@@ -271,7 +263,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
 
 	/*
 	 * If the extended guest request fails due to having too small of a
@@ -279,11 +271,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * extended data request in order to increment the sequence number
 	 * and thus avoid IV reuse.
 	 */
-	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+	if (req->exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 	    err == SNP_GUEST_REQ_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
-		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+		req->exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * If this call to the firmware succeeds, the sequence number can
@@ -293,7 +285,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
 
 		/*
 		 * Override the error to inform callers the given extended
@@ -304,17 +296,17 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		snp_dev->input.data_npages = certs_npages;
 	}
 
-	if (fw_err)
-		*fw_err = err;
+	if (req->fw_err)
+		*req->fw_err = err;
 
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+			  rc, *req->fw_err);
 		goto disable_vmpck;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	rc = verify_and_dec_payload(snp_dev, req->resp_buf, req->resp_sz);
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected unexpected decode failure from ASP. rc: %d\n",
@@ -332,6 +324,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	return rc;
 }
 
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
+				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz, __u64 *fw_err)
+{
+	struct snp_guest_req guest_req = {
+		.msg_version = msg_version,
+		.msg_type = msg_type,
+		.req_buf = req_buf,
+		.req_sz = req_sz,
+		.resp_buf = resp_buf,
+		.resp_sz = resp_sz,
+		.fw_err = fw_err,
+		.exit_code = exit_code,
+	};
+	return snp_send_guest_request(snp_dev, &guest_req);
+}
+
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_report_resp *resp;
@@ -505,7 +515,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
+	if (is_vmpck_empty(snp_dev->vmpck)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
 		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
@@ -636,7 +646,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	}
 
 	/* Verify that VMPCK is not zero. */
-	if (is_vmpck_empty(snp_dev)) {
+	if (is_vmpck_empty(snp_dev->vmpck)) {
 		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
 		goto e_unmap;
 	}
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
index ceb798a404d6..d245578d988e 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -63,4 +63,23 @@ struct snp_guest_msg {
 	u8 payload[4000];
 } __packed;
 
+struct snp_guest_req {
+	void *req_buf, *resp_buf;
+	size_t req_sz, resp_sz;
+	u64 exit_code;
+	u64 *fw_err;
+	u8 msg_version;
+	u8 msg_type;
+};
+
+static inline bool is_vmpck_empty(u8 *vmpck)
+{
+	char zero_key[VMPCK_KEY_LEN] = {0};
+
+	if (vmpck)
+		return !memcmp(vmpck, zero_key, VMPCK_KEY_LEN);
+
+	return true;
+}
+
 #endif /* __VIRT_SEVGUEST_H__ */
-- 
2.32.0

