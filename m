Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A198863FDB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLBBgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiLBBf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:35:57 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36044D3A11
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:35:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v3so3188117pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9zf1d7pWFvO5Dl06Tc/rERXX92s0ACmtz1UYSxOlaY=;
        b=FvIJKzfhufXOfFCwbK279zKP3kDpFkktmuEZtRklod4CjdJZXWVx2GkmuMC+NBUBAu
         ehvM8eVp2de1X6BG99Db5X3LgBBChBic5sHpT5lnWZzI9pmMm7bb3cqs3DAYrbTF8bGT
         hhTDQq47TN5mYVRB0LBflW7mbrbzHg1eej8qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9zf1d7pWFvO5Dl06Tc/rERXX92s0ACmtz1UYSxOlaY=;
        b=H10PWTnMwOHb3hQjsEnINn3heNmxDI+9hKS5jpw/NV83bwLgh7ClxlG9ngF40HRymn
         24d8bQD+odGQRc4ykvPC8PfyGnDHVpA7glXwcT+Pnj7unyozVFRZ8Ksywwb490i7BqVy
         HgslM4xZf1RAuSW8jB4d/JYe4yHU7OYUer3ma4tqBZWSwGEHStR+3pGt1WTa6m1obiUu
         5aSzgkuKelDqjcOZybv4auxiurmiYFm+JnMqqCn0chXHeRH9UWpUjc3cd1/20PK879tc
         thPgZCQiYJEs0YOXTaUa79mUwJq7BTPd54SdH63uj7HMwuFgTcKGeNjuXP/hQRc9Uiu0
         cXKA==
X-Gm-Message-State: ANoB5pkqCFJ/8OoyuvuocKZLobjm5m98ilT+YqVNPPH4UV1mnWCAXCjg
        qdrhRM2BBcA2+hynsJjr8TuskA==
X-Google-Smtp-Source: AA0mqf5U6cAcfIY0KczveH8JC47fGVR/DPcSmhhCcGdd6sMEPHIwgKSla0q12Mb0HdqPSscEG5qYpA==
X-Received: by 2002:a65:6a01:0:b0:477:693f:b8d3 with SMTP id m1-20020a656a01000000b00477693fb8d3mr43344990pgu.333.1669944955762;
        Thu, 01 Dec 2022 17:35:55 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id s13-20020a65690d000000b00477fb27eaddsm3074241pgq.63.2022.12.01.17.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:35:55 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3] mm/memfd: security hook for memfd_create
Date:   Fri,  2 Dec 2022 01:34:03 +0000
Message-Id: <20221202013404.163143-6-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

The new security_memfd_create allows lsm to check flags of
memfd_create.

The security by default system (such as chromeos) can use this
to implement system wide lsm to allow only non-executable memfd
being created.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 6 ++++++
 mm/memfd.c                    | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ec119da1d89b..fd40840927c8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..5a18a6552278 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -543,6 +543,10 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
+ * @memfd_create:
+ *	@name is the name of memfd file.
+ *	@flags is the flags used in memfd_create.
+ *	Return 0 if permission is granted.
  * @mmap_addr :
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..5b87a780822a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_memfd_create(char *name, unsigned int flags);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_memfd_create(char *name, unsigned int flags)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/mm/memfd.c b/mm/memfd.c
index 69e897dea6d5..96dcfbfed09e 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -346,6 +346,11 @@ SYSCALL_DEFINE2(memfd_create,
 		goto err_name;
 	}
 
+	/* security hook for memfd_create */
+	error = security_memfd_create(name, flags);
+	if (error)
+		return error;
+
 	if (flags & MFD_HUGETLB) {
 		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
 					HUGETLB_ANONHUGE_INODE,
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

