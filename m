Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A526C95C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjCZOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjCZOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1C61B1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDjHmXIDHwSN80jeur6m8uAcaebFAZSQWWwFYAiIWvd1/HY/mS7ddF9UEx96xNvAO6AtBUDd2NKwR1glBhv1rrRVWkQEjJXlPpnEcK0sD6C4AycumIPGwZx0QMQ7A3BiU6CH4zmDv0G445ijN5IQPDwtVDyiGKmZO7u4jpUsyUBnWzLOfNwsJi3arycruQB7QDxbEG5ginnaTUYMNuwuWOMS7MebyyOJElw2aeKX8ZbsoJIJP3wggl2h/CSdGxjvwBWB+TsmyW7TQQVsfTiepDXyTWECNI4f65vjo8OkJtClIVt4+3xpyuBPWE7B26nHUPi8VoMaUKfgEjEQ37zLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U31Vby/Fqrrgw0Ivkecm0SEmjf6GjxWhTpGVfrqw+7s=;
 b=QQ7ZYngvHGZO+gZiNNn+/A30N/n17IFwK5IdmpmwE/nNHkGP/hHiW1BW4Yc/RbFXbOUAte5FtaRpoR9Tb8Wa2ip1OxNPZejg/Ord+f32jYNsYGqJodRJzwJOqzlo2wxntQxyV9jI9+r1Ls9ZAfosP4M/17acFtLB2DcSRPCwfjcWfwgaH88i+PYbvJ85mNIda/ODTcE+cPwo6fBqjIvMsmu//WVVJJEhaqC906ijCJ/199k+W2a0s0oS+8c97w2WErlzKo7LvFzuT8ZsB4d8Pqa51RVxdyzJjReI/Ifp5Kf4siAzbH6hgl9b11G5ixlDiCrghuICxFORwZ8lowle5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U31Vby/Fqrrgw0Ivkecm0SEmjf6GjxWhTpGVfrqw+7s=;
 b=3993hK5USVHHL7He5HlFIMw/hNlyi0DAXZLU4L3wIJMDcPrqh2vqq0RyV8gLDqHhhBJ+rwCHcnJNEkY8fFg3xM4Bbaia4MRJENv8CN9V6KeUvcKw87inmpyi3nAEp7DHLfyg6y6HfNYtquqktVBaBeGhLuDYESWOllZiIKs4KBw=
Received: from BL1PR13CA0149.namprd13.prod.outlook.com (2603:10b6:208:2bb::34)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 14:47:33 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::e4) by BL1PR13CA0149.outlook.office365.com
 (2603:10b6:208:2bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:32 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:29 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 03/11] virt: sev-guest: Add snp_guest_req structure
Date:   Sun, 26 Mar 2023 20:16:53 +0530
Message-ID: <20230326144701.3039598-4-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e9568-c3c4-4dda-cffb-08db2e090806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaCg7yq6KnMRh3OwqCKoC4Hysl0dBk8zDp4bbXQI7UIhqi3C/Sn+MWIWrz6sDe9+SUHFkizYatKl6EPmmlIHRo2R+N4SQE5y9JY6v//UrDycDFsjNtYR9FLeA1IxiwNCN7yEvOnKRzWDAzMHor584GlYPy0yWBF6Kuu3Iw6jwtyb1hhQ6eYmM2RUCsr3koAGGNysA8exWsgYEFp28yyj1SLcn77gPURh8d+96nTyM2rVy+Pp09r5zznbw78H4nQEQA9o8PWCwlDD9Vz5i6k9fUBYhejODZP1H+5HAQBepUE9D3bLwweUw+JSHBcqkufBBV1quw3gZdQupi/yoOoRMRMJgC7US2FnhZ6LRqNsBJK0UBKKKXi5MitlBD4y9NjjlhSZm00Tkoxea6PTbJgbQQ4XqTkFsZ9//kLMDyDPq+sge3S6i4kGuCmfPOEPEYO8ftSoaancQc9KV2UxPIzPfCL9Re7cvv3HJYJTQFKpfGBk+UzfJUuzK/i8Ukwexg+MQ/ackraUyUXU09TK5rynXkiBAwB7rSjU+OUjTNw0NG/XOKX59Zw8fyGgEBC5o/A1P9bp4FwhuyzS9s91MThC7B//n8mmgdlv6S158QOFNFTh/85Dz/uoR87+CK6znRou55u/9Ma9WYc6LJ+cN3sRuqDcuolDTws2ZCm2XDjef1e1SdvvgQNnR8YKtPGjSyQY0w+ZUE5ZZY1TQeBmhRpXxgDy6oiwGJPcGy0re5DjTXI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(70586007)(47076005)(8936002)(8676002)(6666004)(2616005)(356005)(82310400005)(16526019)(26005)(83380400001)(1076003)(336012)(426003)(186003)(41300700001)(478600001)(36756003)(36860700001)(4326008)(7696005)(70206006)(2906002)(5660300002)(81166007)(40480700001)(110136005)(82740400003)(316002)(40460700003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:32.6835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e9568-c3c4-4dda-cffb-08db2e090806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/virt/coco/sev-guest/sev-guest.c | 87 ++++++++++++++-----------
 drivers/virt/coco/sev-guest/sev-guest.h | 19 ++++++
 2 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 6ae197b57644..ec93dee330f2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -60,16 +60,6 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
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
@@ -198,8 +188,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
+		 resp_hdr->msg_sz);
 
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
@@ -221,34 +212,34 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
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
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
 {
 	unsigned long err = 0xff, override_err = 0;
 	unsigned long req_start = jiffies;
@@ -262,7 +253,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -273,7 +264,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * IV reuse.
 		 */
 		override_npages = snp_dev->input.data_npages;
-		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * Override the error to inform callers the given extended
@@ -314,8 +305,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 */
 	snp_inc_msg_seqno(snp_dev);
 
-	if (fw_err)
-		*fw_err = override_err ?: err;
+	if (req->fw_err)
+		*req->fw_err = override_err ?: err;
 
 	if (override_npages)
 		snp_dev->input.data_npages = override_npages;
@@ -332,13 +323,14 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
 {
 	u64 seqno;
 	int rc;
 
+	if (!snp_dev || !req)
+		return -ENODEV;
+
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
 	if (!seqno)
@@ -347,21 +339,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
 	if (rc)
 		return rc;
 
-	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
+	rc = __handle_guest_request(snp_dev, req);
 	if (rc) {
-		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
+		if (rc == -EIO && *req->fw_err == SNP_GUEST_REQ_INVALID_LEN)
 			return rc;
 
-		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
+		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n",
+			  rc, *req->fw_err);
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	rc = verify_and_dec_payload(snp_dev, req->resp_buf, req->resp_sz);
 	if (rc) {
 		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
 		snp_disable_vmpck(snp_dev);
@@ -371,6 +364,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	return 0;
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
@@ -544,7 +555,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
+	if (is_vmpck_empty(snp_dev->vmpck)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
 		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
@@ -678,7 +689,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
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
2.34.1

