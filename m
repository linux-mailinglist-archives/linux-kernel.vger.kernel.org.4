Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8E68D145
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBGIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:07:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF3E46A7;
        Tue,  7 Feb 2023 00:07:40 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so17764649pjd.2;
        Tue, 07 Feb 2023 00:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFp1H7zEWEo65JRGCNO5MC+wGJcuBqHDrDuJftgqJI=;
        b=QfmhmHTNpzuf6D9N5mERvovFH91AIhO2K+rkGhNnrsBQYNUjJPwohIcjoro2zeAW2b
         VnaOnep/T37mkF4uADGp3L+E2m49RfEgZjFYmobughoa8H+oyGSOuvMfFoczGMpaYhrA
         7lhATEPfMmY5B/hV9iOpmyhHIC/mTGvMJROv/Q/guZPjuVHotFhWfe222pQ6b679LzFt
         yeh+BHWOiajURIYv1Ofxz6r+ljJ2CtaVb/fpbSaa0lQXcRhwpV0KSXN1SfNcMhilbiBW
         N4kl1L04Pv0HcW0C6ejGmAfS4/ciUfPnk50Yk3+e/ieZZyR1JdwlETy1He/qA/i5Dnjt
         wQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPFp1H7zEWEo65JRGCNO5MC+wGJcuBqHDrDuJftgqJI=;
        b=io64s4EpjqEBFjzOMrBgzawusVxNlntqq2FmU+1WTb1HEBCn6rEUe/5fNOlFSSrCCa
         /Okza0BJ056JTpMdlm28+Gcb7GdmqisJh8fYgH/QA/sZRgTAouKevEO2i1w0r6u2L+0+
         s908tcosCON4GKoS1bU8FYraIjTxmIaSw3Y/3LMofAaUTfCDrVgnCNykgOPv0Jx4BW68
         9OzQoCkFponvTGrGzuOjo13pIN1Zq4HP4Rmbi2tl82B/1azsptX+/YAjj47ffWYRD35Z
         3nhzmnLJX9mzhTDKqUkATnbGtmDXTgj8DOrNFWHA03plfoCHq17QvGVhhQeFGX/hJgiO
         RC4A==
X-Gm-Message-State: AO0yUKXDNqEHh+hDJVqRnp+NRIGKVZOK0yLAdXy9WYdBX86mVQHQbf12
        JfuNwuPl/q21OZC4Sr0T+Bo=
X-Google-Smtp-Source: AK7set8QSpbu+THG1Hof14mcYgYPGNK7e4i1ewUzFXmTu8m2xKUm0z/BpqTVDZIYJvBv6JpRXZUDew==
X-Received: by 2002:a05:6a20:8f04:b0:c0:5903:d4b2 with SMTP id b4-20020a056a208f0400b000c05903d4b2mr3057872pzk.5.1675757260274;
        Tue, 07 Feb 2023 00:07:40 -0800 (PST)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id v7-20020a63b947000000b004facdf070d6sm3716490pgo.39.2023.02.07.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:07:39 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, lsahlber@redhat.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3] ksmbd: fix possible memory leak in smb2_lock()
Date:   Tue,  7 Feb 2023 16:07:28 +0800
Message-Id: <20230207080728.15725-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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

v2: avoid NULL pointer dereference in set_close_state_blocked_works()
v3: avoid race condition between smb2_lock() and smb2_cancel()

 fs/ksmbd/smb2pdu.c   | 23 ++++++++++++++---------
 fs/ksmbd/vfs_cache.c |  2 ++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d681f91947d9..f4079518eaf6 100644
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
@@ -7050,6 +7046,7 @@ int smb2_lock(struct ksmbd_work *work)
 						      smb2_remove_blocked_lock,
 						      argv);
 				if (rc) {
+					kfree(argv);
 					err = -ENOMEM;
 					goto out;
 				}
@@ -7061,6 +7058,10 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
+				spin_lock(&work->conn->request_lock);
+				list_del_init(&work->async_request_entry);
+				spin_unlock(&work->conn->request_lock);
+
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7072,6 +7073,8 @@ int smb2_lock(struct ksmbd_work *work)
 						spin_lock(&fp->f_lock);
 						list_del(&work->fp_entry);
 						spin_unlock(&fp->f_lock);
+						work->cancel_fn = NULL;
+						kfree(argv);
 						rsp->hdr.Status =
 							STATUS_CANCELLED;
 						kfree(smb_lock);
@@ -7096,6 +7099,8 @@ int smb2_lock(struct ksmbd_work *work)
 				spin_lock(&fp->f_lock);
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
+				work->cancel_fn = NULL;
+				kfree(argv);
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index da9163b00350..761a8aa540ce 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct ksmbd_file *fp)
 		list_del(&cancel_work->fp_entry);
 		cancel_work->state = KSMBD_WORK_CLOSED;
 		cancel_work->cancel_fn(cancel_work->cancel_argv);
+		cancel_work->cancel_fn = NULL;
+		kfree(cancel_work->cancel_argv);
 	}
 	spin_unlock(&fp->f_lock);
 }
-- 
2.34.1

