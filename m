Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A168B42F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBFCgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:36:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEAE16AD9;
        Sun,  5 Feb 2023 18:36:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id be8so10705796plb.7;
        Sun, 05 Feb 2023 18:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+cE40mYt/YZ3gKyxcDxSlTc7fer6UTH007ffZfN2JQ=;
        b=o/vYp9lh8d1HczPNBGmpssGWetlPH2wF7i6qFch1P25Zx7irSdGLeKI0rRfvwvkNaA
         B1+sbHiwf6DLIsdqrpCoF2NdnPp3VSjPvSHSgX91NmEkciJQmL2bzM9Zl3ZGhKTu2fLf
         P3FD9fC2TXJIwmNTxL0ziuVlSumBhk72S+VzcssME0rpn0r1ZiHLSh4wxEsZFMChqxO1
         XGUX1dFq6M18/6od5zffXI6PTKyPSUZP2s+iECenfKLcq9Kwd1Hk4t6ZJwsCsnHSVveO
         W8Xyvf7v/qyQzz3HdE7hbMH7GM5ZVo8XIBsuS2587tqM7ofeHRL/bxxZaEJIgmZruTF2
         GQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+cE40mYt/YZ3gKyxcDxSlTc7fer6UTH007ffZfN2JQ=;
        b=N8eDiN7RTQ0VVBIg7ukZiygJDKFNTM/hxvrTKwFemcRmZnGjmJpOVUyNpH7DFVWiCF
         gykipBfocIjl3Nne6Dmkfg42OjmMKoI7Ow/PAd63mMW2q3Bp9N3VpgX5M8//jQ9rahqy
         SkI3hQWC+4C4MYRNWb8phc55JVpgxO7HBPh9v0QXIYwn2XiyrTNBO6BMnJeFtBx7MCNs
         AjzfNoRlQQqYOA8dxHp7c8v8AcJLUvtoocoULFZSG47ZFe6U4c4QiWRdy/R/ilorO7l9
         AdYSA6ZD82nRdLwjskSQXj9c3GbXWnxqyhDXCYlzTChi4LCkoqdvVNwFKt4aI516fWm5
         EhGQ==
X-Gm-Message-State: AO0yUKVWg52YmXcmEWhLCAaxKqGtz4fOJj6mSoR56N48SyrY3PbE1PIR
        kLK7yhYO5yFcNSVc8eMmRJY6w+De2kE=
X-Google-Smtp-Source: AK7set/hdZmNigWA4baORrLFr/m7/4ir2evJ1KU5za/ThQMIBl30gP2VdqaNm8HU/1XHg8HB2GXRHA==
X-Received: by 2002:a17:902:d502:b0:18f:a0de:6ac8 with SMTP id b2-20020a170902d50200b0018fa0de6ac8mr20694830plg.2.1675651001431;
        Sun, 05 Feb 2023 18:36:41 -0800 (PST)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b0019896d29197sm5583904plk.46.2023.02.05.18.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 18:36:40 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, lsahlber@redhat.com, hyc.lee@gmail.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] ksmbd: fix possible memory leak in smb2_lock()
Date:   Mon,  6 Feb 2023 10:36:30 +0800
Message-Id: <20230206023630.9457-1-hbh25y@gmail.com>
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

 fs/ksmbd/smb2pdu.c   | 5 +++++
 fs/ksmbd/vfs_cache.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d681f91947d9..177a24704021 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7050,6 +7050,7 @@ int smb2_lock(struct ksmbd_work *work)
 						      smb2_remove_blocked_lock,
 						      argv);
 				if (rc) {
+					kfree(argv);
 					err = -ENOMEM;
 					goto out;
 				}
@@ -7072,6 +7073,8 @@ int smb2_lock(struct ksmbd_work *work)
 						spin_lock(&fp->f_lock);
 						list_del(&work->fp_entry);
 						spin_unlock(&fp->f_lock);
+						kfree(argv);
+						work->cancel_fn = NULL;
 						rsp->hdr.Status =
 							STATUS_CANCELLED;
 						kfree(smb_lock);
@@ -7096,6 +7099,8 @@ int smb2_lock(struct ksmbd_work *work)
 				spin_lock(&fp->f_lock);
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
+				kfree(argv);
+				work->cancel_fn = NULL;
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index da9163b00350..eb95c16393b7 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct ksmbd_file *fp)
 		list_del(&cancel_work->fp_entry);
 		cancel_work->state = KSMBD_WORK_CLOSED;
 		cancel_work->cancel_fn(cancel_work->cancel_argv);
+		kfree(cancel_work->cancel_argv);
+		cancel_work->cancel_fn = NULL;
 	}
 	spin_unlock(&fp->f_lock);
 }
-- 
2.34.1

