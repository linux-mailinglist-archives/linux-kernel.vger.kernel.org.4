Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA80C65D60A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjADOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbjADOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:39:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FDA45E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:39:13 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so83231676ejo.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ktTgqCg5vZndbEsq2NE84RTVG7aeSaApbDApUiy3yI=;
        b=bAo5rEoMeLXb+zWJpWccSUbC/52Xl5JUcRb7B7ldPjmJu8yrGJebcgfu2mvn6DoQOH
         DJpreAUPSRM8Os5s1oTyh3CCfi6WZSJnNqxdwx043PELATrAMnUMkGjBMipqFxsD6I2u
         shiCmP+MHLcOSwobb1InBZKdfL043vctCbYng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ktTgqCg5vZndbEsq2NE84RTVG7aeSaApbDApUiy3yI=;
        b=MLffjluwUk3Ck+G/f+H6hoitObbbpItp1i3IoWbjSCpyFsORH4TIKPddfywTNSwyhc
         uRzGMl+9LACJ2ict6bTx/liURAoq5/XmvVW6/fPQOlmxBGrgATuLFgmc1NNYkol1WYct
         7BaLkrWeQ//yY/8fnUnF1ZXGVTRGzMUxo9LWMsLxLk/O5rs0uoPrA+/nQviJBkZfZcoC
         gM+RTzBnDnnCXBNHmF3/dzt/KnKjnq0OzBAcFhXLC5w+m9zGSay2Yt7ryNXjqnsPyr9P
         d0eITIdTIMReIrBS4y9D2l8ri5ZPGo9VSCJogAKzeCgwVxPtIbOwHEXNbr2aqzWOzqJ7
         7AdA==
X-Gm-Message-State: AFqh2kqjv2mHaXujweNG8iUX1Pi4h12wlGpoGEPmAVPlv5aKZU+YwqyR
        joQ4/iTluyY0DmZzWg74uknIJg==
X-Google-Smtp-Source: AMrXdXuNx+d3v0Nfvuk68oEYdAFWRimFrEchPyE6TlxN7ROhq+mc7cuwNsyL8lc4Y9VgL1LLJfST/g==
X-Received: by 2002:a17:906:b150:b0:7c1:2931:2263 with SMTP id bt16-20020a170906b15000b007c129312263mr43585109ejb.71.1672843151848;
        Wed, 04 Jan 2023 06:39:11 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:11 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 15:38:48 +0100
Subject: [PATCH v6 3/3] kexec: Introduce sysctl parameters kexec_load_limit_*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v6-3-6a8531a09b9a@chromium.org>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
        kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=7913; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=pwr4lQSQU6e2iagP33ihhaoD9RG5CubbrBaEaThEAKM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY+HjBoWaxGoO7sxgdVTlJcthgWB365UeesT8qSd
 hvqseBiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPhwAKCRDRN9E+zzrEiAunD/
 91AfbnoUWa9e8aD0UKHg+GAqqRrXozPx01fMTG3wC2iUZxj/n2uMz/Y8QbTHYctYbTfVMTpx/jHg2K
 cbSS6gGr5ybyMAggEcwWMSPfYWS/rVzPFf6T8G0NpDwWEnbQ4QjHDaULMlPg5AXL5uReOCp0qh/CjQ
 k2MK/1noz9a6dzcMqHd25iw6UGm2HWY4VXSD7on2U1hzxCAixuddN5gPd8lwBxwpueWdRaq3EIX+BI
 0ECi9pmjTjN7BwiLeVDOPm8xI9hmn3SKhv/onx0MyBdYds4qYDZOgCxUWI/2/d+qa2V14UkKigfeQR
 g3c3YrWsOeWJTcCKad5PaGmNHk110c3wU8EZ5hCWcUXAMWyJbWXDh7GAOF6m8AVPtSsT2b++X9JQJw
 UUCys+nCBZmTEDOHNkS7ghuK3Q3YsjemCdfKa1LjHE1YSC18fK737LAKLRi3qv+vfFAQUX9HWBxWy7
 u2hkB6tkUVgrTIwmEC9BzneUHH6HUJIffKaBjcCpSklvHyU0VFnXEkMbJFIy8JkDT31zzdfVe0jilF
 yyWg2218E4cEthc8vrS0HQuGe/Rl5rCO/l2Z7k4ZB//JKMuQX9c7W4RoBIMSEp0xHdOJwxtHOSflS/
 xpS7m2cyXFO00X1x4m7hB6Mqmfn60Bhin0EGNy91xeKIdJLNMd5B15HPhzpA==
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

kexec allows replacing the current kernel with a different one. This is
usually a source of concerns for sysadmins that want to harden a system.

Linux already provides a way to disable loading new kexec kernel via
kexec_load_disabled, but that control is very coard, it is all or
nothing and does not make distinction between a panic kexec and a
normal kexec.

This patch introduces new sysctl parameters, with finner tunning to
specify how many times a kexec kernel can be loaded. The sysadmin can
set different limits for kexec panic and kexec reboot kernels. The
value can be modified at runtime via sysctl, but only with a stricter
value.

With these new parameters on place, a system with loadpin and verity
enabled, using the following kernel parameters:
sysctl.kexec_load_limit_reboot=0 sysct.kexec_load_limit_panic=1
can have a good warranty that if initrd tries to load a panic kernel,
a malitious user will have small chances to replace that kernel with a
different one, even if they can trigger timeouts on the disk where the
panic kernel lives.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
 include/linux/kexec.h                       |  2 +-
 kernel/kexec.c                              |  4 +-
 kernel/kexec_core.c                         | 87 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 97394bd9d065..d5fb4b6ef405 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -461,6 +461,24 @@ allowing a system to set up (and later use) an image without it being
 altered.
 Generally used together with the `modules_disabled`_ sysctl.
 
+kexec_load_limit_panic
+======================
+
+This parameter specifies a limit to the number of times the syscalls
+``kexec_load`` and ``kexec_file_load`` can be called with a crash
+image. It can only be set with a more restrictive value than the
+current one.
+
+== ======================================================
+-1 Unlimited calls to kexec. This is the default setting.
+N  Number of calls left.
+== ======================================================
+
+kexec_load_limit_reboot
+=======================
+
+Similar functionality as ``kexec_load_limit_panic``, but for a normal
+image.
 
 kptr_restrict
 =============
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 182e0c11b87b..791e65829f86 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permitted(void);
+bool kexec_load_permitted(int kexec_image_type);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ce1bca874a8d..92d301f98776 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -190,10 +190,12 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int image_type = (flags & KEXEC_ON_CRASH) ?
+			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(image_type))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a1efc70f4158..951541d78ca8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -926,10 +926,64 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+struct kexec_load_limit {
+	/* Mutex protects the limit count. */
+	struct mutex mutex;
+	int limit;
+};
+
+static struct kexec_load_limit load_limit_reboot = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
+	.limit = -1,
+};
+
+static struct kexec_load_limit load_limit_panic = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
+	.limit = -1,
+};
+
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
+
 #ifdef CONFIG_SYSCTL
+static int kexec_limit_handler(struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct kexec_load_limit *limit = table->data;
+	int val;
+	struct ctl_table tmp = {
+		.data = &val,
+		.maxlen = sizeof(val),
+		.mode = table->mode,
+	};
+	int ret;
+
+	if (write) {
+		ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
+		if (ret)
+			return ret;
+
+		if (val < 0)
+			return -EINVAL;
+
+		mutex_lock(&limit->mutex);
+		if (limit->limit != -1 && val >= limit->limit)
+			ret = -EINVAL;
+		else
+			limit->limit = val;
+		mutex_unlock(&limit->mutex);
+
+		return ret;
+	}
+
+	mutex_lock(&limit->mutex);
+	val = limit->limit;
+	mutex_unlock(&limit->mutex);
+
+	return proc_dointvec(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table kexec_core_sysctls[] = {
 	{
 		.procname	= "kexec_load_disabled",
@@ -941,6 +995,18 @@ static struct ctl_table kexec_core_sysctls[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "kexec_load_limit_panic",
+		.data		= &load_limit_panic,
+		.mode		= 0644,
+		.proc_handler	= kexec_limit_handler,
+	},
+	{
+		.procname	= "kexec_load_limit_reboot",
+		.data		= &load_limit_reboot,
+		.mode		= 0644,
+		.proc_handler	= kexec_limit_handler,
+	},
 	{ }
 };
 
@@ -952,13 +1018,30 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permitted(void)
+bool kexec_load_permitted(int kexec_image_type)
 {
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
+	limit = (kexec_image_type == KEXEC_TYPE_CRASH) ?
+		&load_limit_panic : &load_limit_reboot;
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
index 29efa43ea951..70e1e99038ee 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -326,11 +326,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
 		unsigned long, flags)
 {
-	int ret = 0, i;
+	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
+			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	struct kimage **dest_image, *image;
+	int ret = 0, i;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(image_type))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */
@@ -342,11 +344,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!kexec_trylock())
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_FILE_ON_CRASH) {
+	if (image_type == KEXEC_TYPE_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
 			arch_kexec_unprotect_crashkres();
+	} else {
+		dest_image = &kexec_image;
 	}
 
 	if (flags & KEXEC_FILE_UNLOAD)

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
