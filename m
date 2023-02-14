Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E18695945
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjBNGhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjBNGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:37:09 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CE46A2;
        Mon, 13 Feb 2023 22:37:02 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so698667pjd.1;
        Mon, 13 Feb 2023 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676356621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnxmCF6k1tGRKN+Vv7UG4BB7rYWnJ27buU46lEjmmCU=;
        b=ZHM1tLpGM9wb6u9JMpYWvsws5X51jGVoF/64pc7rMds82LwbJQmqgFdxQzIieTkpgY
         1SAjVrh7q/o+O3MtN1wtW6Q9GOkUObJgYzCNg5nQb9GdnxFKI+e3WkWoho0PRQBvO3qX
         YzWX1c/N/ZRO/Px5bHTxHWLQB3YJHm8HKF2BKAEzaojxOII03PDWjRnRLh+imdEIcxea
         Zn3w2G/RMbel8Dj3b248W//80hF++4dNXhQFeB8tIdbl3reb7yhEy5s3e0vsRIOK9FkW
         Slq9JdUhhQjA9sM/T5ArTXkPIadKjlKEC0QfEftfiaAdeZjywOS/GumLjj1gYg+AIks/
         VePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676356621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnxmCF6k1tGRKN+Vv7UG4BB7rYWnJ27buU46lEjmmCU=;
        b=k54lPnqC3DBelUht1sXFmLxilqkkQ0MA4tWZs6Yf6qXSu5i/lkFRZoG6f7+qbp+hoW
         yFhg1ccFmTEpIYA0YfMBlG/jB3aG9LoTM9cl7xTPjrU0QZOPNh0HT0hWQk20dzkONnAi
         grUqdhG91ZfSHW/f2iBse4erWpDWvfucJOSDvoX/DbGczWFh77HgrhSB42vGP7Dw4ItP
         ZpBZHXO0VXy1UhX0iEweepNhBhXaFdZz4NDFc4eb5UBNYE51hQEFBbiG2FXfzI0CZgLc
         dyI8IBfhqf/q0B3nJKEgEyGJ5joN0czM/xPLqkFAaI1uE69Syd8w1/ikuwPZnQayJ8qp
         OqKg==
X-Gm-Message-State: AO0yUKVTmFIRXrrUL/s/9GWOyObaVMHUxt107NRh86qc+dbBbS5Y0pqk
        MK8dBrdbQNsvahIyniQegEQ=
X-Google-Smtp-Source: AK7set8AitKSnYqnZkfJEYztn2RDJOzcAas1dq3RZvWqhgxP8K0elWllgCZxnNj2mHxkBpDEws4FSw==
X-Received: by 2002:a05:6a20:54a3:b0:bc:604a:5a94 with SMTP id i35-20020a056a2054a300b000bc604a5a94mr1443755pzk.1.1676356621571;
        Mon, 13 Feb 2023 22:37:01 -0800 (PST)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id x24-20020a63db58000000b004df4fbb9823sm8052651pgi.68.2023.02.13.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:37:01 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, lsahlber@redhat.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v4] ksmbd: fix possible memory leak in smb2_lock()
Date:   Tue, 14 Feb 2023 14:36:50 +0800
Message-Id: <20230214063650.12832-1-hbh25y@gmail.com>
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

v2: avoid NULL pointer dereference in set_close_state_blocked_works()
v3: avoid race condition between smb2_lock() and smb2_cancel()
v4: use another way to avoid race condition

 fs/ksmbd/smb2pdu.c   | 20 +++++++++++++-------
 fs/ksmbd/vfs_cache.c |  2 ++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d681f91947d9..1b517d3ca2ef 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6666,7 +6666,8 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),
 				    le16_to_cpu(chdr->Command));
-			cancel_work = iter;
+			if (iter->cancel_fn)
+				cancel_work = iter;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
@@ -7050,6 +7051,7 @@ int smb2_lock(struct ksmbd_work *work)
 						      smb2_remove_blocked_lock,
 						      argv);
 				if (rc) {
+					kfree(argv);
 					err = -ENOMEM;
 					goto out;
 				}
@@ -7061,6 +7063,16 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
+				spin_lock(&work->conn->request_lock);
+				spin_lock(&fp->f_lock);
+				if (work->state != KSMBD_WORK_CLOSED) {
+					list_del(&work->fp_entry);
+					work->cancel_fn = NULL;
+					kfree(argv);
+				}
+				spin_unlock(&fp->f_lock);
+				spin_unlock(&work->conn->request_lock);
+
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7069,9 +7081,6 @@ int smb2_lock(struct ksmbd_work *work)
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
-						spin_lock(&fp->f_lock);
-						list_del(&work->fp_entry);
-						spin_unlock(&fp->f_lock);
 						rsp->hdr.Status =
 							STATUS_CANCELLED;
 						kfree(smb_lock);
@@ -7093,9 +7102,6 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&smb_lock->clist);
 				spin_unlock(&work->conn->llist_lock);
 
-				spin_lock(&fp->f_lock);
-				list_del(&work->fp_entry);
-				spin_unlock(&fp->f_lock);
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

