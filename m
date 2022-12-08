Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6246647473
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLHQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiLHQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:38:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44709286CE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:38:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c17so2515466edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nXDL6kXVne0kc9TUvNDrggV3hJQmgrUq1c5voIjIIY=;
        b=PojL+2VW16cI+CcvRz8pQZWoBJ9qktlie/qAPj5ucWA5MY8xtpgOHHVDVRU5pAe7Ce
         nDMmiPUpy0eW53Q6kW23pyE7V2lP4nW7AbwoIeQfkrOqyTUr4G+BupC0g3nDqnKbB6sP
         ldvNVDRaqGjV6SEVCCxtCFgoIT/1ss5WM32c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nXDL6kXVne0kc9TUvNDrggV3hJQmgrUq1c5voIjIIY=;
        b=xVdgVQfdYoqLW2kx+SN528HBran6HyNbHlHJsx0aa1X+mhfpqFa2HsW/F+bTsYOg8x
         eQxGKkhaQkaFJVSpPPFKZ/n48nA0/FJg0o1TXvZfrBODaocHxtCvtjrap61ndZmGs978
         LkbkvQ7obffajkKQglcjjt2heKT+4eBJa2vOkJ+rStVE97u+buJw9oIOL9jKlNwRGj44
         2sPJ5RPdiaUiEOwrNGn5H0rDuBElMsLvv4WTcIcV1kkR23QbZsAF2Bqga/Z2LC75cqWR
         TjuutimWbzLcc2hRsRisnoPtw0tbHtRyELfdMOl7JbaOGWH23K5WTdTJkdzZsrRLptoE
         eRHQ==
X-Gm-Message-State: ANoB5pmslEgiIm3Hb6NUZhWkc873k8sGekppeznVmxMKLNmP4elja6IY
        b6+t2r9JfxMW9QIB+imIUrbG/A==
X-Google-Smtp-Source: AA0mqf4CXQQmQaEo4whtEenrTv1AF48ud3Wm8rJD9/sh1MVGHJSDMD4mFmnIAgfRq63Kr0Qkr+X62A==
X-Received: by 2002:a05:6402:4284:b0:45c:835c:eab7 with SMTP id g4-20020a056402428400b0045c835ceab7mr2555836edc.37.1670517499837;
        Thu, 08 Dec 2022 08:38:19 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 08 Dec 2022 17:38:02 +0100
Subject: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and
 load_limit_panic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kexec@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5820; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ufAC+5YemcJmz894l6PORczSfr2QBpgPQ5bjY5F1p5U=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhL1d+L3xiTqMUfLNsBi+qtGpD5Qyq+yPRk8XU3C
 qeZYpfGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS9QAKCRDRN9E+zzrEiOw9EA
 Ci4347jIGvkhhvZj0crcvK5gwVYFGy86RP/xrwiw1eNsD4O5aYVg/imd6Nc49cl04xIhEeTj/hv1W/
 hkARCp318XqH7yNDOpH5IAE3TKoKalTtEKGbrWCsaD4pCUf4oYuRKqNq2Zu+WFw3/vnGoUXSX9SBRw
 A6HYl93KHYPcrFL0QqE+StFWwWYqBwmkxsM+1boorjoLIV3hL0xZDfMH/o4KY2YK0uAPXPm1WPNc/o
 WZgslC6WHQhWKRowkutP4MCINeOIbd5SCP1jIuukVb4q8xsGzKNlcQ1Hz0vW3YFYWaOY/hsjGzAIFZ
 sUwO7jou4m9QOjkXzctFUIQKWjyTwbwGLHlzxPqWKKvnQ+W+U3yY2a5I7Q3fLpvIFrJoJt505mshGc
 bhBJBXKGorGs4F0nP5F5Evh90AUQsAaNcQgwgnqvqytM+TAzLXSXr57DZHZ/PRRnUEqEOb0J4eZXJt
 IPM9sjrhAmU+Y1/nhOAEN84BmowIsyz8QMjpZkTlALIc29owcmvKAi8DrM/wPCxJJOypZlSY7Lx24G
 FE7KiVsqpaR5KDpx5kK9C3ompKCNYN7PMoySslSGsnpNfWzjC96bSFRJqB2Qy6JR5tBaIIz6Dh0GTh
 b0lX3nfY+sVZ6nbUulNMptRcET51QU4x3Fori81S1zjoUm6JjXW3cuyF86RA==
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

Add two parameter to specify how many times a kexec kernel can be loaded.

The sysadmin can set different limits for kexec panic and kexec reboot
kernels.

The value can be modified at runtime via sysfs, but only with a value
smaller than the current one (except -1).

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++
 include/linux/kexec.h                           |  2 +-
 kernel/kexec.c                                  |  2 +-
 kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
 kernel/kexec_file.c                             |  2 +-
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..2b37d6a20747 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2374,6 +2374,20 @@
 			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
 			are exclusive, so you cannot specify multiple forms.
 
+	kexec_core.load_limit_reboot=
+	kexec_core.load_limit_panic=
+			[KNL]
+			This parameter specifies a limit to the number of times
+			a kexec kernel can be loaded.
+			Format: <int>
+			-1  = Unlimited.
+			int = Number of times kexec can be called.
+
+			During runtime, this parameter can be modified with a
+			value smaller than the current one (but not -1).
+
+			Default: -1
+
 	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
 			Format: <Controller#>[,poll interval]
 			The controller # is the number of the ehci usb debug
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e9e1ab5e8006..3d7d10f7187a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permited(void);
+bool kexec_load_permited(bool crash_image);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index d83fc9093aff..2b0856e83fe1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permited())
+	if (!kexec_load_permited(flags & KEXEC_ON_CRASH))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 18bd90ca9c99..7f9d5288b24b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permited(void)
+struct kexec_load_limit {
+	/* Mutex protects the limit count. */
+	struct mutex mutex;
+	int limit;
+};
+
+struct kexec_load_limit load_limit_reboot = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
+	.limit = -1,
+};
+
+struct kexec_load_limit load_limit_panic = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
+	.limit = -1,
+};
+
+static int param_get_limit(char *buffer, const struct kernel_param *kp)
 {
+	int ret;
+	struct kexec_load_limit *limit = kp->arg;
+
+	mutex_lock(&limit->mutex);
+	ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);
+	mutex_unlock(&limit->mutex);
+
+	return ret;
+}
+
+static int param_set_limit(const char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+	struct kexec_load_limit *limit = kp->arg;
+	int new_val;
+
+	ret = kstrtoint(buffer, 0, &new_val);
+	if (ret)
+		return ret;
+
+	new_val = max(-1, new_val);
+
+	mutex_lock(&limit->mutex);
+
+	if (new_val == -1 && limit->limit != -1) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (limit->limit != -1 && new_val > limit->limit) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	limit->limit = new_val;
+
+done:
+	mutex_unlock(&limit->mutex);
+
+	return ret;
+}
+
+static const struct kernel_param_ops load_limit_ops = {
+	.get = param_get_limit,
+	.set = param_set_limit,
+};
+
+module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
+MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
+
+module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
+MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");
+
+bool kexec_load_permited(bool crash_image)
+{
+	struct kexec_load_limit *limit;
+
 	/*
 	 * Only the superuser can use the kexec syscall and if it has not
 	 * been disabled.
 	 */
-	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
+	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+		return false;
+
+	/* Check limit counter and decrease it.*/
+	limit = crash_image ? &load_limit_panic : &load_limit_reboot;
+	mutex_lock(&limit->mutex);
+	if (!limit->limit) {
+		mutex_unlock(&limit->mutex);
+		return false;
+	}
+	if (limit->limit != -1)
+		limit->limit--;
+	mutex_unlock(&limit->mutex);
+
+	return true;
 }
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 701147c118d4..61212a9252a6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permited())
+	if (!kexec_load_permited(flags & KEXEC_FILE_FLAGS))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
