Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A566ACB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjANQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjANQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:50:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2C3A9A;
        Sat, 14 Jan 2023 08:50:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a184so18204887pfa.9;
        Sat, 14 Jan 2023 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZly66Ps0eB33co09HnOQatKjFfOi6yr5GhUn1KYlDU=;
        b=FAVOLUS9ICwO++64A7PSe0pjIcOEtzpXz7bJSZz52hfSZu8dKGxDGhSlPrNU6nk1st
         d4R3uYjvi3rbrmtp1V30CBEmVb7GkJ6qWve9hkODkRZGqvOkXgFZ0Vw5xBiptuKCN9l2
         +ig2eyzSPyE7Zz/fP2SKRm3OeDbNJHKWqivDHyYF+6l9ZJBxYX7Tls8Ut2lX8q64O4oT
         dHTp0AFaYlNj1u++KJMzQ9OfwOxv+alPk3JkE7mDSnk0waNWX2m+a3inh4ZuIw1JG0bV
         Q9r9AW37T1fkyzbohT2gVArYL+rxyjIXgXZxDKReyS65PyRz8xLpkBu75/bFtxVHMuXp
         IQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZly66Ps0eB33co09HnOQatKjFfOi6yr5GhUn1KYlDU=;
        b=EYxu/H/t7nego9o9Bp9tqElGW1QDnqze5Lg1EuPfVk2jeAR78wRaPIAQ7ztWSRWo2n
         VlWc0AX4xAvjr100JNPE4CNZNfgl10FlCtaZCuZ0ORt1vzQKzhaFtg53xanM0hHRQQ+G
         Ljg4TBYTs+NCV4uIQKokxyW8c0dose8We5KWNBIPuMIZD4xkM89dqvYN0e9qBpSE/tYK
         6QbzLUsx4+tgjc1UrpoypyeJ7pLsMcm12Os3gsksqHmNyKpe3LHJQ+K6rKdEJtRQj39r
         r5XNa0FRhquOCUJg/Rb1fYayA6JevFEld8le0QphUTgjLuCvSZmQuST+PhoaVFIseyjA
         0zmQ==
X-Gm-Message-State: AFqh2ko34nAO7IQWTkQ5ARUmM0Kow8LV1h64gzF+ivBTY4k8nc4LExY8
        5bZ3L6b/6yHbR420xPuL1fE4lj6P2HE=
X-Google-Smtp-Source: AMrXdXskaADfyXZPiXQBnsq5Xv+wHt17uljPJQdoFsQXvusgV10GH8au07ItipctqmEOkab2bIkuHA==
X-Received: by 2002:a05:6a00:1da3:b0:589:d831:ad2a with SMTP id z35-20020a056a001da300b00589d831ad2amr18625228pfw.6.1673715054981;
        Sat, 14 Jan 2023 08:50:54 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id 186-20020a6216c3000000b0057fec210d33sm14148888pfw.152.2023.01.14.08.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:50:54 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH] apparmor: make aa_set_current_onexec return void
Date:   Sun, 15 Jan 2023 00:49:52 +0800
Message-Id: <20230114164952.232653-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Change the return type to void since it always return 0, and no need
to do the checking in aa_set_current_onexec.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
---
 security/apparmor/domain.c       | 2 +-
 security/apparmor/include/task.h | 2 +-
 security/apparmor/task.c         | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6dd3cc5309bf..bbc9c8a87b8e 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1446,7 +1446,7 @@ int aa_change_profile(const char *fqname, int flags)
 		}
 
 		/* full transition will be built in exec path */
-		error = aa_set_current_onexec(target, stack);
+		aa_set_current_onexec(target, stack);
 	}
 
 audit:
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 13437d62c70f..01717fe432c3 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -30,7 +30,7 @@ struct aa_task_ctx {
 };
 
 int aa_replace_current_label(struct aa_label *label);
-int aa_set_current_onexec(struct aa_label *label, bool stack);
+void aa_set_current_onexec(struct aa_label *label, bool stack);
 int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index 84d16a29bfcb..5671a716fcd2 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -93,9 +93,8 @@ int aa_replace_current_label(struct aa_label *label)
  * aa_set_current_onexec - set the tasks change_profile to happen onexec
  * @label: system label to set at exec  (MAYBE NULL to clear value)
  * @stack: whether stacking should be done
- * Returns: 0 or error on failure
  */
-int aa_set_current_onexec(struct aa_label *label, bool stack)
+void aa_set_current_onexec(struct aa_label *label, bool stack)
 {
 	struct aa_task_ctx *ctx = task_ctx(current);
 
@@ -103,8 +102,6 @@ int aa_set_current_onexec(struct aa_label *label, bool stack)
 	aa_put_label(ctx->onexec);
 	ctx->onexec = label;
 	ctx->token = stack;
-
-	return 0;
 }
 
 /**
-- 
2.31.1

