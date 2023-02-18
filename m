Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912369B6AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBRAYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBRAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:24:49 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2868AC7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:24:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 71so1545335pfy.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5vVwyAQ55wNLDUtqrtmD/1Z+qTuBcjbFag28luNQnM=;
        b=YlNdhKE94JN4VCU/zFwGBM+X7o4FpF1mtRYx9Vm3YDvCPC0x+9piJ4QPNv1photuus
         6yoPNxMcy32POE6MQ6chGPKciyPg0EvdVcH6Ts9rDJSpj4zMk1tFOO0/kD58et59BGLs
         FzOdw2NCQPmDTNrjl/vZQM5dgAeW8Qo2L+7uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5vVwyAQ55wNLDUtqrtmD/1Z+qTuBcjbFag28luNQnM=;
        b=EOXs70qqLp5eD56leG+33d/X9dTpIFkTMxHLBzSvROf5HPUFhWECWw/Ms1TyBX0IGx
         rM6aUYBfpSJ0YZFrShA2wzzNviaFvwlr3jP+u+YLXeI9gBI8F0+7LZ9FbjutBDU0Yxc6
         QqOSnXg/BEerpQe26w5oNmDX+aIF3NB4aNIdmGz1bOJ5ys7nnz5Lst9rWCv2cC6letUM
         kqIt9yrP3lIEJ1fsvPr8QCi4bwu8mMuu4ZsbZV8VpUFQ1Ba6yjBldSn6vTVagonhbccL
         6+e9F2oR2fGHii3b+l9HHSPK+3b2B9mxgsxDaxckMhfLrIUZZs20+w9qUaI1dekDZvYN
         ysXQ==
X-Gm-Message-State: AO0yUKU0hatntNrpNAiLEy+vHnbPE75ey/57Q51P8sxC7EpsAYRtbW5h
        dVPTu6AQkbNrxellHpyA/ArNyA==
X-Google-Smtp-Source: AK7set9SKV1ZGGWc8yfKGG7qjAn7gN4xzzRalTQ699/IayTMJj+0YWXeHa+rCv9f28IqMGPGFwlFZg==
X-Received: by 2002:a05:6a00:1a89:b0:5a8:c913:b108 with SMTP id e9-20020a056a001a8900b005a8c913b108mr8072070pfv.9.1676679884734;
        Fri, 17 Feb 2023 16:24:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m11-20020aa78a0b000000b005a8ba70315bsm3565585pfa.6.2023.02.17.16.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 16:24:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <sfrench@samba.org>
Cc:     Kees Cook <keescook@chromium.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] smb3: Replace smb2pdu 1-element arrays with flex-arrays
Date:   Fri, 17 Feb 2023 16:24:40 -0800
Message-Id: <20230218002436.give.204-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17108; h=from:subject:message-id; bh=ZFLims21xIxcLkFS8ChGKC6hOyqv/PVr08sy8W4F6zE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj8BrHA1n0jvp6mL/I6YqZrfpvnMMPvvmM/Ykgbwao rNQ/ZHeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY/AaxwAKCRCJcvTf3G3AJu7ED/ 0eXQWwwDphjAozC2VNaXfMpIQ317doxEh7l9k5zlsgyhQbFvJhZAy+9RtWfbMSeKmCtttZI0MFZrLP +qKJZMNAcc4V7JRAhEMYOy9kv/9rxSUxJlRHpsZ5TXX8V3Kbfhwwjqnw+csRrwXazv9ZuFdXWrMd8v bZOs11U8f01Fr/pUgqRdmQ16233LDk6Ng/BVwZ1ccmOXgnLmRVwzYvH6mzt/Hh6BCpMj2xdGJ93jaP x34irx3amZrdJFlu89J0JQcQ0gG9OT00DQVgQdHzhrq9dguXP6P5ExLPcWz0iGABxD3qGrO7JmjDUo krU3sJRB3DsJf83ylFrGOY3TyeMlifeVtx9EDwOXF3UkmM6czLkrtGiKw26k8nMHRXck5hi0RZjnho yW5aiqTA8juMB6aZFP3RLQ/kq5dTBq/2sSfxKIdj4TOVX5yCViWt8maxAyd09jvAUfit5j3Z9KnvIz dmD5wFr5miZ+iLvQYt198jb/+/wx71acM/cOq2Pb8gw51L2j2VcN00ssZaYbnN8uOk155Kuk2NsgNz qaxaGJgmaY2GE8CBtn/LlY6+LK8Wceswc/XaDxbmqKvmwG9dXTpelDqGpjRb8nxdg/MKrWtdHXQmeL FKdQnUWLyvazwLFoPW0QT2tV7eSrFN8T1fRdb9/6uCtHMN1npekS0KNPFiUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

Replace the trailing 1-element array with a flexible array in the
following structures:

	struct smb2_err_rsp
	struct smb2_tree_connect_req
	struct smb2_negotiate_rsp
	struct smb2_sess_setup_req
	struct smb2_sess_setup_rsp
	struct smb2_read_req
	struct smb2_read_rsp
	struct smb2_write_req
	struct smb2_write_rsp
	struct smb2_query_directory_req
	struct smb2_query_directory_rsp
	struct smb2_set_info_req
	struct smb2_change_notify_rsp
	struct smb2_create_rsp
	struct smb2_query_info_req
	struct smb2_query_info_rsp

Replace the trailing 1-element array with a flexible array, but leave
the existing structure padding:

	struct smb2_file_all_info
	struct smb2_lock_req

Adjust all related size calculations to match the changes to sizeof().

No machine code output or .data section differences are produced after
these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: Fix missed static initializers (Namjae Jeon)
v2: https://lore.kernel.org/lkml/20230214232928.gonna.714-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230214215446.never.567-kees@kernel.org
---
 fs/cifs/smb2file.c        |  2 +-
 fs/cifs/smb2misc.c        |  2 +-
 fs/cifs/smb2ops.c         | 14 ++++++-------
 fs/cifs/smb2pdu.c         | 16 +++++++--------
 fs/cifs/smb2pdu.h         |  2 +-
 fs/ksmbd/smb2ops.c        |  8 ++++----
 fs/ksmbd/smb2pdu.c        |  6 ++----
 fs/smbfs_common/smb2pdu.h | 42 ++++++++++++++++++++++-----------------
 8 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index 9f1dd04b555a..e0ee96d69d49 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -35,7 +35,7 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 		len = (u32)err->ErrorContextCount * (offsetof(struct smb2_error_context_rsp,
 							      ErrorContextData) +
 						     sizeof(struct smb2_symlink_err_rsp));
-		if (le32_to_cpu(err->ByteCount) < len || iov->iov_len < len + sizeof(*err))
+		if (le32_to_cpu(err->ByteCount) < len || iov->iov_len < len + sizeof(*err) + 1)
 			return ERR_PTR(-EINVAL);
 
 		p = (struct smb2_error_context_rsp *)err->ErrorData;
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 572293c18e16..3935a60db5c3 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -113,7 +113,7 @@ static __u32 get_neg_ctxt_len(struct smb2_hdr *hdr, __u32 len,
 	} else if (nc_offset + 1 == non_ctxlen) {
 		cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
 		size_of_pad_before_neg_ctxts = 0;
-	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE)
+	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE + 1)
 		/* has padding, but no SPNEGO blob */
 		size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen + 1;
 	else
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 95586292d089..f3fd3846d7d9 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5640,7 +5640,7 @@ struct smb_version_values smb20_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5662,7 +5662,7 @@ struct smb_version_values smb21_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5683,7 +5683,7 @@ struct smb_version_values smb3any_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5704,7 +5704,7 @@ struct smb_version_values smbdefault_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5725,7 +5725,7 @@ struct smb_version_values smb30_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5746,7 +5746,7 @@ struct smb_version_values smb302_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5767,7 +5767,7 @@ struct smb_version_values smb311_values = {
 	.header_size = sizeof(struct smb2_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 3bc0aa8a18b2..4982f5e65e13 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1373,7 +1373,7 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
 	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req) - 1 /* pad */);
+		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
 	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
@@ -1892,8 +1892,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	iov[0].iov_len = total_len - 1;
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req)
-			- 1 /* pad */);
+	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
 	req->PathLength = cpu_to_le16(unc_path_len);
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
@@ -3773,7 +3772,7 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 			ses->Suid, (u8)watch_tree, completion_filter);
 		/* validate that notify information is plausible */
 		if ((rsp_iov.iov_base == NULL) ||
-		    (rsp_iov.iov_len < sizeof(struct smb2_change_notify_rsp)))
+		    (rsp_iov.iov_len < sizeof(struct smb2_change_notify_rsp) + 1))
 			goto cnotify_exit;
 
 		smb_rsp = (struct smb2_change_notify_rsp *)rsp_iov.iov_base;
@@ -4966,7 +4965,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	memcpy(bufptr, &asteriks, len);
 
 	req->FileNameOffset =
-		cpu_to_le16(sizeof(struct smb2_query_directory_req) - 1);
+		cpu_to_le16(sizeof(struct smb2_query_directory_req));
 	req->FileNameLength = cpu_to_le16(len);
 	/*
 	 * BB could be 30 bytes or so longer if we used SMB2 specific
@@ -5162,8 +5161,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->VolatileFileId = volatile_fid;
 	req->AdditionalInformation = cpu_to_le32(additional_info);
 
-	req->BufferOffset =
-			cpu_to_le16(sizeof(struct smb2_set_info_req) - 1);
+	req->BufferOffset = cpu_to_le16(sizeof(struct smb2_set_info_req));
 	req->BufferLength = cpu_to_le32(*size);
 
 	memcpy(req->Buffer, *data, *size);
@@ -5397,9 +5395,9 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	req->VolatileFileId = volatile_fid;
 	/* 1 for pad */
 	req->InputBufferOffset =
-			cpu_to_le16(sizeof(struct smb2_query_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_query_info_req));
 	req->OutputBufferLength = cpu_to_le32(
-		outbuf_len + sizeof(struct smb2_query_info_rsp) - 1);
+		outbuf_len + sizeof(struct smb2_query_info_rsp));
 
 	iov->iov_base = (char *)req;
 	iov->iov_len = total_len;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 3ad7ec44317c..2114e8a0c63a 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -57,7 +57,7 @@ struct smb2_rdma_crypto_transform {
 #define COMPOUND_FID 0xFFFFFFFFFFFFFFFFULL
 
 #define SMB2_SYMLINK_STRUCT_SIZE \
-	(sizeof(struct smb2_err_rsp) - 1 + sizeof(struct smb2_symlink_err_rsp))
+	(sizeof(struct smb2_err_rsp) + sizeof(struct smb2_symlink_err_rsp))
 
 #define SYMLINK_ERROR_TAG 0x4c4d5953
 
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index e401302478c3..aed7704a0672 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -26,7 +26,7 @@ static struct smb_version_values smb21_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -52,7 +52,7 @@ static struct smb_version_values smb30_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -79,7 +79,7 @@ static struct smb_version_values smb302_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -106,7 +106,7 @@ static struct smb_version_values smb311_server_values = {
 	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
 	.header_size = sizeof(struct smb2_hdr),
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 619857af0cc2..aef72077fc75 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -274,8 +274,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 		le16_to_cpu(rsp->SecurityBufferOffset));
 	inc_rfc1001_len(work->response_buf,
 			sizeof(struct smb2_negotiate_rsp) -
-			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-			AUTH_GSS_LENGTH);
+			sizeof(struct smb2_hdr) + AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
@@ -1205,8 +1204,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 				  le16_to_cpu(rsp->SecurityBufferOffset));
 	inc_rfc1001_len(work->response_buf, sizeof(struct smb2_negotiate_rsp) -
-			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-			 AUTH_GSS_LENGTH);
+			sizeof(struct smb2_hdr) + AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	conn->use_spnego = true;
 
diff --git a/fs/smbfs_common/smb2pdu.h b/fs/smbfs_common/smb2pdu.h
index 7d605db3bb3b..ace133cf6072 100644
--- a/fs/smbfs_common/smb2pdu.h
+++ b/fs/smbfs_common/smb2pdu.h
@@ -167,7 +167,7 @@ struct smb2_err_rsp {
 	__u8   ErrorContextCount;
 	__u8   Reserved;
 	__le32 ByteCount;  /* even if zero, at least one byte follows */
-	__u8   ErrorData[1];  /* variable length */
+	__u8   ErrorData[];  /* variable length */
 } __packed;
 
 #define SMB3_AES_CCM_NONCE 11
@@ -308,7 +308,7 @@ struct smb2_tree_connect_req {
 	__le16 Flags;		/* Flags in SMB3.1.1 */
 	__le16 PathOffset;
 	__le16 PathLength;
-	__u8   Buffer[1];	/* variable length */
+	__u8   Buffer[];	/* variable length */
 } __packed;
 
 /* Possible ShareType values */
@@ -595,7 +595,7 @@ struct smb2_negotiate_rsp {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 
@@ -616,7 +616,7 @@ struct smb2_sess_setup_req {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Currently defined SessionFlags */
@@ -633,7 +633,7 @@ struct smb2_sess_setup_rsp {
 	__le16 SessionFlags;
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 
@@ -715,7 +715,7 @@ struct smb2_read_req {
 	__le32 RemainingBytes;
 	__le16 ReadChannelInfoOffset;
 	__le16 ReadChannelInfoLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Read flags */
@@ -730,7 +730,7 @@ struct smb2_read_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 
@@ -754,7 +754,7 @@ struct smb2_write_req {
 	__le16 WriteChannelInfoOffset;
 	__le16 WriteChannelInfoLength;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_write_rsp {
@@ -765,7 +765,7 @@ struct smb2_write_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Reserved2;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 
@@ -812,7 +812,10 @@ struct smb2_lock_req {
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
 	/* Followed by at least one */
-	struct smb2_lock_element locks[1];
+	union {
+		struct smb2_lock_element lock;
+		DECLARE_FLEX_ARRAY(struct smb2_lock_element, locks);
+	};
 } __packed;
 
 struct smb2_lock_rsp {
@@ -866,7 +869,7 @@ struct smb2_query_directory_req {
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_directory_rsp {
@@ -874,7 +877,7 @@ struct smb2_query_directory_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /*
@@ -897,7 +900,7 @@ struct smb2_set_info_req {
 	__le32 AdditionalInformation;
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_set_info_rsp {
@@ -952,7 +955,7 @@ struct smb2_change_notify_rsp {
 	__le16	StructureSize;  /* Must be 9 */
 	__le16	OutputBufferOffset;
 	__le32	OutputBufferLength;
-	__u8	Buffer[1]; /* array of file notify structs */
+	__u8	Buffer[]; /* array of file notify structs */
 } __packed;
 
 
@@ -1158,7 +1161,7 @@ struct smb2_create_rsp {
 	__u64  VolatileFileId;
 	__le32 CreateContextsOffset;
 	__le32 CreateContextsLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct create_posix {
@@ -1501,7 +1504,7 @@ struct smb2_query_info_req {
 	__le32 Flags;
 	__u64  PersistentFileId;
 	__u64  VolatileFileId;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_info_rsp {
@@ -1509,7 +1512,7 @@ struct smb2_query_info_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /*
@@ -1570,7 +1573,10 @@ struct smb2_file_all_info { /* data block encoding of response to level 18 */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char   FileName[1];
+	union {
+		char __pad;	/* Legacy structure padding */
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __packed; /* level 18 Query */
 
 struct smb2_file_eof_info { /* encoding of request for level 10 */
-- 
2.34.1

