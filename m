Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67026697846
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjBOIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjBOIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:34:54 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C936FCF;
        Wed, 15 Feb 2023 00:34:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id y186so22pgb.10;
        Wed, 15 Feb 2023 00:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPi7xiAI6eAt2R20RcGc0yiA68oMwbx0n93NNjF27nI=;
        b=ihRs+bM0QSwnRrFxRJSDOaUo0eetuDiAqiT23n/MaB8EjaDbIGV8yWOdOYXzHltNlk
         GEXazSsSy/Hf6BzxZz1Iq/KYt3KCKX9eN99sHpGmzHqupVUR8DT2+9jPH4cZbkLZXKeQ
         0xAXMYv9a87MT6AmcPkTk69pWoaLbprqSoGIlLWRji0B+z+b6TlI/vdHcHrvBaUYWpCG
         28xlofVCXDC24IQ6Dp5nlUfMioS2XIHvabHG6lthHAbnE2Dv/m9Jc6zNTuYXh73MO63D
         iwDvh7gmyWVm6Svwfv2U1n/YhaXiU+Ov/8QkE0FmiLTL/G/zw+6cjlRZEZltjJxBiHwf
         XXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPi7xiAI6eAt2R20RcGc0yiA68oMwbx0n93NNjF27nI=;
        b=o6OF5UbYqzQb31XXkE9JqNUQ429mSm/6Heh2H5MIyF0wfO4fFwIVwNUQx1J9/7M3iL
         7meaHH+mS7k+g9PRLKeH3Vn0gt3HIuksrDXq5lRGDv9PdxXuk+ZM0F4wn+beQpsLvu9o
         CauANOkTOzcDMlQL0C7PcIiQANs8ZGOhU8kub8akVb9rV3N2132zVqLWwOtlR/jyNmGq
         iRRx8YCF4PdRHDZXqDepohVKyE8y6+Hu8May+b6jLkQuLoarunLmgfm9tcg/OFeKdjMf
         zh64AeiakLiujunpLzetrquSzjp4Ch8eHTIr64UJfz33FPZGDo0QlRjUcuoaIkz8FL1D
         lrbg==
X-Gm-Message-State: AO0yUKUHv5bQBnhlPP/tFkdEEimju6PVA2OOUQ/kbNnPgCT27ODitWVy
        EvzMJ05NH2qoE225638cui0=
X-Google-Smtp-Source: AK7set8OxptjF1uPj7AePYt17pID2doTHVF7spDoWP0HfMXl2igAO8QAme1hbjIRKDt4VoLMDWXd5A==
X-Received: by 2002:a62:8202:0:b0:5a8:c116:edc with SMTP id w2-20020a628202000000b005a8c1160edcmr1029234pfd.1.1676450070770;
        Wed, 15 Feb 2023 00:34:30 -0800 (PST)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7929a000000b0058b927b9653sm11459571pfa.92.2023.02.15.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 00:34:30 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, lsahlber@redhat.com, hyc.lee@gmail.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v5] ksmbd: fix possible memory leak in smb2_lock()
Date:   Wed, 15 Feb 2023 16:33:50 +0800
Message-Id: <20230215083350.5815-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

argv needs to be free when setup_async_work fails or when the current
process is woken up.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

v2: avoid NULL pointer dereference in set_close_state_blocked_works().
v3: avoid race condition between smb2_lock() and smb2_cancel().
v4: use another way to avoid race condition.
v5: Keep things under the control of request_lock and f_lock.

 fs/ksmbd/smb2pdu.c   | 28 +++++++++++++---------------
 fs/ksmbd/vfs_cache.c |  5 ++---
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d681f91947d9..875eecc6b95e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6644,7 +6644,7 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
-	struct ksmbd_work *cancel_work = NULL, *iter;
+	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
@@ -6666,7 +6666,9 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),
 				    le16_to_cpu(chdr->Command));
-			cancel_work = iter;
+			iter->state = KSMBD_WORK_CANCELLED;
+			if (iter->cancel_fn)
+				iter->cancel_fn(iter->cancel_argv);
 			break;
 		}
 		spin_unlock(&conn->request_lock);
@@ -6685,18 +6687,12 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with mid %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->MessageId),
 				    le16_to_cpu(chdr->Command));
-			cancel_work = iter;
+			iter->state = KSMBD_WORK_CANCELLED;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
 	}
 
-	if (cancel_work) {
-		cancel_work->state = KSMBD_WORK_CANCELLED;
-		if (cancel_work->cancel_fn)
-			cancel_work->cancel_fn(cancel_work->cancel_argv);
-	}
-
 	/* For SMB2_CANCEL command itself send no response*/
 	work->send_no_response = 1;
 	return 0;
@@ -7061,6 +7057,14 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
+				spin_lock(&work->conn->request_lock);
+				spin_lock(&fp->f_lock);
+				list_del(&work->fp_entry);
+				work->cancel_fn = NULL;
+				kfree(argv);
+				spin_unlock(&fp->f_lock);
+				spin_unlock(&work->conn->request_lock);
+
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7069,9 +7073,6 @@ int smb2_lock(struct ksmbd_work *work)
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
-						spin_lock(&fp->f_lock);
-						list_del(&work->fp_entry);
-						spin_unlock(&fp->f_lock);
 						rsp->hdr.Status =
 							STATUS_CANCELLED;
 						kfree(smb_lock);
@@ -7093,9 +7094,6 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&smb_lock->clist);
 				spin_unlock(&work->conn->llist_lock);
 
-				spin_lock(&fp->f_lock);
-				list_del(&work->fp_entry);
-				spin_unlock(&fp->f_lock);
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index da9163b00350..0ae5dd0829e9 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -364,12 +364,11 @@ static void __put_fd_final(struct ksmbd_work *work, struct ksmbd_file *fp)
 
 static void set_close_state_blocked_works(struct ksmbd_file *fp)
 {
-	struct ksmbd_work *cancel_work, *ctmp;
+	struct ksmbd_work *cancel_work;
 
 	spin_lock(&fp->f_lock);
-	list_for_each_entry_safe(cancel_work, ctmp, &fp->blocked_works,
+	list_for_each_entry(cancel_work, &fp->blocked_works,
 				 fp_entry) {
-		list_del(&cancel_work->fp_entry);
 		cancel_work->state = KSMBD_WORK_CLOSED;
 		cancel_work->cancel_fn(cancel_work->cancel_argv);
 	}
-- 
2.34.1

