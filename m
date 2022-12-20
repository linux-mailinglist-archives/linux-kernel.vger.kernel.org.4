Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E86528B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiLTWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:06:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939DB54
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so32455677ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9+UYStnTWSGjcfg6nbEHqd+1X3j3uTcNPeBDTDi2dg=;
        b=A0qO9cEF9BExaKG++8+pMbm2JwjYr+J4MRScp+7250NNGhFaRVBpZSd2wGrXaKkQJv
         92dPcds0K8JnxSa5CreUj8k6FfD1QZ7+0Bx9ilEcxK5izAYSrhJc6XJun92Zh21cuK7o
         cXbXNoBRhc3DCd39gV8gFNMDMakCJHcFOgwP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9+UYStnTWSGjcfg6nbEHqd+1X3j3uTcNPeBDTDi2dg=;
        b=EU3nFuKxBabzGmpKIoWfjjXV9VE4hLKTKnIOPqX7FPriRrNtjYElke6F1O+B8ROjq8
         bLN6T13/wKA8976gYufwlULJOzwf7gQKGmyCT2ddn+L2Wo3Yx5ntIChSUnaf6vr/Xt1w
         kQRlUAW8GuHK1Pp/Xq8kpDphFJ/jSjm73Rfy8bphmZqBhz8nyXXfmwHBAm2A/REMQnlt
         DZCXQpqM2lL07arkuEhfmzNrzAE+Bno31gWK2vxh/ub9stYeZOaWfQKmetTQkDLvo7rC
         YydSUyS7iwYn7QkS7yTd2emetKqSrntSt6gvFQRf4VCA149UDREM7k8ZnKR/dpIUpqLJ
         LdwA==
X-Gm-Message-State: ANoB5plqSjpTstT7PaDviAl/+VG8tkJuMqkgYtmHQ/0YXmHc/ufB1SZZ
        sTPYw22HrI17LAkAMjxtXf06PQ==
X-Google-Smtp-Source: AA0mqf64dw9ElnGy3FTuo16O8Q1TsFPYHKFdEDEaGFCI5s7U/hoqkQIQm/gnBiMQDp/jO6uvS/m7ZQ==
X-Received: by 2002:a17:906:f2d5:b0:7c0:ff76:dc12 with SMTP id gz21-20020a170906f2d500b007c0ff76dc12mr39257082ejb.2.1671573968178;
        Tue, 20 Dec 2022 14:06:08 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:07 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 23:05:45 +0100
Subject: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot and
 load_limit_panic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Zc/gSka8wOP3G6tsawZGIGKxFRGZrCiyiT4x6FixMW4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojHLZcxNi1sPouIXr6mT+V5x5mHvydbMJzCO3YWh
 gn4sbiSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxywAKCRDRN9E+zzrEiDODD/
 0Q4Zvqb8s24SEseZLeUDz32F3wm0l0IZPp1VqYeoxcynPygcG2mdR2kznnMVhzeSL1CU+XTF6+dSY8
 1Fj/VpOcrWHhbaa0RvHl0XLZR63nY9Dhz6vBPjv5fM6jrCT3wpxQEtJPNXQ4PT7CMbWuqYi5JATa7p
 bYpgWNkqliE0ZAMZhxQ/NKaGOPKevRKyVH67KCW/PNn8Kr2f2nupjb5shNblfAOB4GXLUiYQS4s0TQ
 W2qbEzfyepWmZ9lzh77NnjJ4Qz2kxvKgdpzg4vBnz5BxBJBSNRvczvKOm6ayK1G2/rkrklptquK507
 tegnKH4juIa71ObyjuOSQrNf2Vq+waCmtLICjoHuTLxghgmMB/Gow/CD8Nocxx7NgLKkZ8SydPCvLJ
 Ekv/0p0Z/HpMpRWZhpWRDLvQZW6aye8njLrZHZmrLl4WamlcV9wR9ZtcDzGkXhkdyZNpqTiGtSz7kp
 +sUOQkebMUvG27zoDDQ6yRBNFsMVI9UQ471SeRGNrT8JE/JbdjZxCFIBsAKW3XhZBMEjC4HfYd+9Ig
 JEyWhkC8Snqx7AoYJv9E8qcSk9u4TyikYWPeV+Tppef3ZL7FeHki8xlpnHnFbtFL2XJS8I/Ttn1Va8
 yH72bJY+zqsfJ+d/dqdNwU15BYpCt0jFZltT2mb7t10hAYLaLwIsYQLq33hQ==
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
index 182e0c11b87b..5daf9990d5b8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permitted(void);
+bool kexec_load_permitted(bool crash_image);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ce1bca874a8d..7aefd134e319 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(flags & KEXEC_ON_CRASH))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a1efc70f4158..adf71f2be3ff 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permitted(void)
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
+bool kexec_load_permitted(bool crash_image)
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
index 29efa43ea951..6a1d4b07635e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(flags & KEXEC_FILE_FLAGS))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
