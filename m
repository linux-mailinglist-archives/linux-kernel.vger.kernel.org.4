Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB5680CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjA3MEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjA3ME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE42CC75
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C90h1VzK217hXe6XW6cqBI6UQaZph8aIaxxfqteGTAf4/DdPecUGdRyzppwOyLXfy70LRJMd1Azfm1yPxVH0ci58A/0MVERVAjYVhWuhHIlJ9LaggZTFQqdQuIsjl3RY/cpIlUbg0+6P/W0WFceHObukbFSBhjURjBxW1hmUxC7TwBpc+/VmPbihlK8+L7y404oem954c/rp8u4YmHGJirlvurMn0L2ABlRRAjTocdIqGWgM6nfdG6V05pJqgAz7JXCE/bnOfoWGhIIODrS7pHUajDBWAzE7mqFoad0xCH9bmkoCG3GeiIdDxtV96GoPH/toPOCwgYrkoXs+f2Uy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XLC65fWePD1MkUbaGXqUdgbi83wJG5BRe0lEFiPoJo=;
 b=nnXtBirYyj+6gXNAAdZMRsXtmlsNpVb1/EERVf4CLHI/aBsqFuKoRQU3aGACBlWsdO17GjttE/vrA5v/wxgxoaj+Edi56JpMiGTBhmdKf7gI1rMryXB/uDyMdJn19rSeS894a09jC/8bUZjBwGxtj6OI4tA/6ZqX5f7B/aDMTS+N/Ex//PXeNC5nXuSlTNX/5kvivcphjNPo/XjdQAPoYr7KpAcFI5HgKBL/0znReR4yiyJixY60FXDLE2qtiELUGPOr+iTOU3UJfEQucRuTl5F1V5pB2SQGQdf5eqgAgmdY7kI8Vo+JlN/O9gvu0sYPmY6uEl/w1WLOd64QJkLZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XLC65fWePD1MkUbaGXqUdgbi83wJG5BRe0lEFiPoJo=;
 b=YmBxe+61rGv32fGUy7C7JA/PpsEDMdt0nqyay9jByWjkZiDwWg4iyse1F0n+hRAJl7ffjREVV25fttGTLem4gh9+lFYCps1Z5oDSUKoIauu4CyeOLWISB4oflxwSRUlvTu6LQPV/yVstcn4Xka8Qr0RGPgxOzaZYT7Bt1QEUZ6E=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:18 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::2c) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 12:04:17 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:13 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>, Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 01/11] virt: sev-guest: Use AES GCM crypto library
Date:   Mon, 30 Jan 2023 17:33:17 +0530
Message-ID: <20230130120327.977460-2-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 768b78cb-cee3-463a-61b6-08db02ba1d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53ZI8ep/Hev/FTetxe04ulMYAlLeA0A8hJsTQfpZ/iByTb8atHdaGK3kqcnU+nNZNe+Pjw/t8c/xMz9/DPBhUrYZPg8y9fSWlnRqcJtEpPiZL18YVJxZ3uVt3eDR5P5cCX6jw+hpAKZNhGP7lAi0XvO7bhc6BL/a5ExLLDLZhgeI2WS0SEt9f7nwfbD3WG29jAHLELXikc89eVHTZR2a0H6G/x2z8tmcvzPAk9RH+T0Gg1KWQlk0F8HSkHP3/AGW7/bozakfWz11KIkbgpvoCrmbA9nUdYYBSaD3FuIqIMFS15GIMG1SZvKRhmPpxhw/pQAVRH31X+dgb9FiFaQf1d+krexf+IV7ryBaT7TNKe3GtExrLXiaHbJw/UEWhkcMPbwoQT1km29DykElm/J/cyZCoUIDf2Fvw9Pnc9kQ2OK4PtT2sCDtRwfTX2tK7zJO1+OtwETWpQZWzpwopXwJSmfp94c9vaQCYrks3E//GTnFeICI5RvixhZiZHZOHV/lK8BQSkgguCyVQkvH7f41t1XKVlZlenitlOT4xBIY+jFu44Jco5IPrU8/pPtgVjouBUTI/IpcLNUz0c/5OOmRs42yP4zrd680NsS68FPOHj/uYSz3SrdmohwciSqlDJReqquaXk0+LGj51Z9GQ4KkwCKSO4yPyyf6/5Ls4nxfDiWNIgWkjDX+CDXHwVX1Zn6xpYRH2a19WnG38VxY+zxbFVxWGrh0ePlOEvwvQ1MhLHX6703yAgmiBkE8qTkM5XWIjoRsaCIpFDE8xf6HhuIoBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(426003)(40480700001)(47076005)(83380400001)(36860700001)(5660300002)(41300700001)(8936002)(7416002)(30864003)(26005)(966005)(1076003)(16526019)(2616005)(186003)(336012)(82740400003)(356005)(40460700003)(81166007)(4326008)(70206006)(316002)(110136005)(478600001)(54906003)(8676002)(70586007)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:17.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768b78cb-cee3-463a-61b6-08db02ba1d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEV-SNP guests with SecureTSC enabled need to send a TSC_INFO SNP
Guest message to the AMD security processor before the smpboot phase
starts. Details from the TSC_INFO response have to be programmed in
the VMSA before the secondary CPUs are brought up.

Start using the AES GCM library implementation as the crypto API is not
available yet this early.

Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org
CC: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |   3 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 172 +++++++-----------------
 drivers/virt/coco/sev-guest/sev-guest.h |   3 +
 3 files changed, 53 insertions(+), 125 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index f9db0799ae67..bcc760bfb468 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,8 +2,7 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
-	select CRYPTO_AEAD2
-	select CRYPTO_GCM
+	select CRYPTO_LIB_AESGCM
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
 	  the PSP without risk from a malicious hypervisor who wishes to read,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..20bb38242018 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -16,8 +16,7 @@
 #include <linux/miscdevice.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
-#include <crypto/aead.h>
-#include <linux/scatterlist.h>
+#include <crypto/gcm.h>
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
@@ -28,21 +27,13 @@
 #include "sev-guest.h"
 
 #define DEVICE_NAME	"sev-guest"
-#define AAD_LEN		48
-#define MSG_HDR_VER	1
-
-struct snp_guest_crypto {
-	struct crypto_aead *tfm;
-	u8 *iv, *authtag;
-	int iv_len, a_len;
-};
 
 struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
 	void *certs_data;
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
@@ -57,6 +48,15 @@ MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
+static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
+{
+	if (snp_dev && snp_dev->ctx)
+		return snp_dev->ctx->authsize;
+
+	WARN_ONCE(1, "Unable to get crypto authsize\n");
+	return 0;
+}
+
 static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
 {
 	char zero_key[VMPCK_KEY_LEN] = {0};
@@ -141,132 +141,59 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 	return container_of(dev, struct snp_guest_dev, misc);
 }
 
-static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
+static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 {
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 
-	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
-	if (!crypto)
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
 		return NULL;
 
-	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
-	if (IS_ERR(crypto->tfm))
-		goto e_free;
-
-	if (crypto_aead_setkey(crypto->tfm, key, keylen))
-		goto e_free_crypto;
-
-	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
-	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->iv)
-		goto e_free_crypto;
-
-	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
-		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
-			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
-			goto e_free_iv;
-		}
+	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
+		pr_err("SNP: crypto init failed\n");
+		kfree(ctx);
+		return NULL;
 	}
 
-	crypto->a_len = crypto_aead_authsize(crypto->tfm);
-	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->authtag)
-		goto e_free_iv;
-
-	return crypto;
-
-e_free_iv:
-	kfree(crypto->iv);
-e_free_crypto:
-	crypto_free_aead(crypto->tfm);
-e_free:
-	kfree(crypto);
-
-	return NULL;
-}
-
-static void deinit_crypto(struct snp_guest_crypto *crypto)
-{
-	crypto_free_aead(crypto->tfm);
-	kfree(crypto->iv);
-	kfree(crypto->authtag);
-	kfree(crypto);
-}
-
-static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
-			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
-{
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct scatterlist src[3], dst[3];
-	DECLARE_CRYPTO_WAIT(wait);
-	struct aead_request *req;
-	int ret;
-
-	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	/*
-	 * AEAD memory operations:
-	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
-	 * |  msg header      |  plaintext       |  hdr->authtag  |
-	 * | bytes 30h - 5Fh  |    or            |                |
-	 * |                  |   cipher         |                |
-	 * +------------------+------------------+----------------+
-	 */
-	sg_init_table(src, 3);
-	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
-	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
-
-	sg_init_table(dst, 3);
-	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
-	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
-
-	aead_request_set_ad(req, AAD_LEN);
-	aead_request_set_tfm(req, crypto->tfm);
-	aead_request_set_callback(req, 0, crypto_req_done, &wait);
-
-	aead_request_set_crypt(req, src, dst, len, crypto->iv);
-	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
-
-	aead_request_free(req);
-	return ret;
+	return ctx;
 }
 
-static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+static int __enc_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 			 void *plaintext, size_t len)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	if (WARN_ON((hdr->msg_sz + ctx->authsize) > sizeof(msg->payload)))
+		return -EBADMSG;
 
-	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
+	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	aesgcm_encrypt(ctx, msg->payload, plaintext, len, &hdr->algo, AAD_LEN,
+		       iv, hdr->authtag);
+	return 0;
 }
 
-static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 		       void *plaintext, size_t len)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
-	/* Build IV with response buffer sequence number */
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
+	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	if (aesgcm_decrypt(ctx, plaintext, msg->payload, len, &hdr->algo,
+			   AAD_LEN, iv, hdr->authtag))
+		return 0;
+	else
+		return -EBADMSG;
 }
 
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg *resp = snp_dev->response;
 	struct snp_guest_msg *req = snp_dev->request;
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
+	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
 	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
 		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
@@ -284,11 +211,11 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
+	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
 }
 
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
@@ -315,7 +242,7 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
 		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev, req, payload, sz);
+	return __enc_payload(snp_dev->ctx, req, payload, sz);
 }
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
@@ -407,7 +334,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_resp *resp;
 	struct snp_report_req req;
 	int rc, resp_len;
@@ -425,7 +351,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
 	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!resp)
 		return -ENOMEM;
@@ -446,7 +372,6 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_derived_key_resp resp = {0};
 	struct snp_derived_key_req req;
 	int rc, resp_len;
@@ -463,7 +388,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp.data) + crypto->a_len;
+	resp_len = sizeof(resp.data) + get_ctx_authsize(snp_dev);
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
@@ -488,7 +413,6 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
@@ -526,7 +450,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
 	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!resp)
 		return -ENOMEM;
@@ -735,8 +659,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
-	if (!snp_dev->crypto)
+	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
+	if (!snp_dev->ctx)
 		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
@@ -751,11 +675,13 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 	ret =  misc_register(misc);
 	if (ret)
-		goto e_free_cert_data;
+		goto e_free_ctx;
 
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
+e_free_ctx:
+	kfree(snp_dev->ctx);
 e_free_cert_data:
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
@@ -774,7 +700,7 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-	deinit_crypto(snp_dev->crypto);
+	kfree(snp_dev->ctx);
 	misc_deregister(&snp_dev->misc);
 
 	return 0;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
index 21bda26fdb95..ceb798a404d6 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -13,6 +13,9 @@
 #include <linux/types.h>
 
 #define MAX_AUTHTAG_LEN		32
+#define AUTHTAG_LEN		16
+#define AAD_LEN			48
+#define MSG_HDR_VER		1
 
 /* See SNP spec SNP_GUEST_REQUEST section for the structure */
 enum msg_type {
-- 
2.32.0

