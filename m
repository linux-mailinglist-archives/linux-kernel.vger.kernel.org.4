Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A7653110
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLUMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiLUMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:50:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8422BF5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so36461562ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=R2RT15ASWFQQ+HJe+0sCo+uF2kmwezaj3G470IQ3VwrN9sGIz7hH7YtE7+LcKHt6Cj
         oJw2V0LJVsPN/SBndPAGkCuI6O+DXEN9nMef2mvpzYidC5dI2ivk5DxCDGzkMzM1FMVl
         QVCsZJW6B1pti7LEpdEOt0AR1rG8O44Pgjaag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=S1grZ1xWhcS/UqvylDTUuTb1lq8v5bmUSVYG8YCjKAi7nP4nVOTFVqvdMssEu+NFe2
         aTIElr5Y9BrujuTz0vQeglIkdrjzq+VxZ43ne1rPGMdlYE7BeYXPoJnALkxXrHZtK7jq
         ms1YAMRS3ZUTnXBjNxsN3yBKFUq1EYhqcm5rxDoMXlBUfJ3+YFhJ/yB3Kr2FAK16kxfG
         2RiJDlw72AnnnCXneCLm8B0Fxpr4eHrIVcBEp8gHbNlCpyLAJ0xZHMgIQ3szxH0MvFr6
         iLpQFMwYcPLDnzCL2u51vRmt+7EjwmKlAYex/XOFj5KZpMCZ1QUf5hZLz3krkzMGaZuB
         D1/A==
X-Gm-Message-State: AFqh2kr6mmd8F2kDHwgwh92spL50nvm6WabqXXknmvG1rQ7FsN6nWn23
        +NQ/RNiVMw+UPPhTzYZQ4tFb9A==
X-Google-Smtp-Source: AMrXdXsP7f6lqej8FU5+HkqvdNOpkaOSpgva0UJJ4q1TLYkqxkisLNkbycJ2AA6LvfmifmlzW3CSdA==
X-Received: by 2002:a17:907:d10:b0:82d:e258:fa55 with SMTP id gn16-20020a1709070d1000b0082de258fa55mr1453100ejc.36.1671627018527;
        Wed, 21 Dec 2022 04:50:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:17 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 13:50:02 +0100
Subject: [PATCH v4 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v4-2-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rm7FZlNI1K3HcWDQ5vaPpIW63r8rInBklo9MHxPCtFE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowECkFe21vSuqwF6tn2p8L+BKJ7tkuaiu4yiHveG
 nMtEFu+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MBAgAKCRDRN9E+zzrEiO7dD/
 0XCbh5Qt8a1g8a4Ymj0sdar9KtUlQmWiFta0b5GfuPwcKQF19M9Med6ybxz+sbYW42P4SmN9A2XNec
 hNqPXR722Yi+HMUx4Qd/B+ioG5bVXLpahjFybWh0OzFejOEsoFCdP+ZIGKqe7i6jIfWWayud7NCbIL
 6CXuHhCyrTGg8tpp3wsxfnogoFnEi6Q252E+w1Jgmlyyd/u1tMQbVSJ5XRnOpVTOPWFLecrDwZLRkm
 vJrOhRDdEnRjGh8q0E12ff/RTZ9giik6eekXfuPzJP6cI9mynKpzBzk8lxlqJzv/c1AdGr1eBvidU7
 SwH9z8VvgHgK6vuN/A2DcxIC2Nce4PgvCzE6HLf6N1SaFL1iLZgB1GfFvYRxKf3cstzH9PVF2aYtlm
 r+QOw7ZwzrUnuYCZ+oULXDrpN9BNvxXwiG8Z2XdLWWqApjvxbZg72DlSXqkoiXK1k67Lj60HEehYyc
 jW+mz5MmMhqWT9rPRTbOMYdx+ppB4Szq4LEWarobPro9UZ8hhekXyXhYqgdncIvlR707JCUDjuEfpa
 Y2/uGgzDL2NaIOghN2/Y6X29qA6cfq4aR5wEEKHh8YhUEJBL/lHtsVN//Na8/DHod2e95JHXdO1EFQ
 JCZkKRC/0AcMQmLyUH832g1pR/uqXtS1FKqQfFmUTzN8WRH+qZmdP3k0Psng==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both syscalls (kexec and kexec_file) do the same check, lets factor it
out.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/kexec.h |  3 ++-
 kernel/kexec.c        |  2 +-
 kernel/kexec_core.c   | 11 ++++++++++-
 kernel/kexec_file.c   |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..182e0c11b87b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -406,7 +406,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
-extern int kexec_load_disabled;
+
+bool kexec_load_permitted(void);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..ce1bca874a8d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permitted())
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..a1efc70f4158 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -928,7 +928,7 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
-int kexec_load_disabled;
+static int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
 	{
@@ -952,6 +952,15 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+bool kexec_load_permitted(void)
+{
+	/*
+	 * Only the superuser can use the kexec syscall and if it has not
+	 * been disabled.
+	 */
+	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..29efa43ea951 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permitted())
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
