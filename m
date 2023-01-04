Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EBC65D607
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbjADOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbjADOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:39:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6363E7E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:39:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fy8so19059473ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgxvQK67tmMrLA74uOg//Gx6503PSr9SD0hLGo86OJA=;
        b=OsU1DngzOr4hhp/EoveJQE3TgkyHrAPpIqNakGYzicuHh+CEyyLyykYhfaAoqGFAP0
         LYbScr1P7QayvqjcETjQvA86XknilwM/8QYVJvo5EC3i5qtaTrRhxUBFdaiU4bPIhAxz
         Hbe9lGwRtmdSmOtj1sxtys51p9R+230EoGueY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgxvQK67tmMrLA74uOg//Gx6503PSr9SD0hLGo86OJA=;
        b=jRmNYNxT5Hbs7cZwDh05KLlZRMDnt1l49NxyE8Y9MmOSNNCYU18Htj8kPq8QMZTY+j
         Botk4YdgjWP+w57A+h7urR0JZ11OGca3iAfKQcaBJGt5Mn4WZ4z/e6gBKC+hMnoJD5qZ
         mTFOCUweKCP9hYF4/BwtVC08pJsxf0K/eQL99J4AjBwpwIbV9IO5Lct4USxSpP/PTt5B
         E0BO01kY4csPQJVkMPHnFmNmQrkITd3glcGwBeG9UsBS9KZccKtF6CPUgvEkCi9woNcF
         qg7tQXPJ7GyBHNKFwzAfiVXBqyP1T/BH0raymE+gpWHzDSVrgsMSYdA2ZDNWcg9IFjc+
         YlVw==
X-Gm-Message-State: AFqh2krzQEqDKLBoMeT1girfJ//Chu7i9mgyCNbz2nn1QdXusTGqo+fL
        1WvHlHrEl1y5YIRjpw2liV09qw==
X-Google-Smtp-Source: AMrXdXvnkGuCKVUdw8um3IaAa5qydCD325lajLfPnGFPmg5PN8jHu5yo2Sbj1UcOE9OWka3RWtYWTw==
X-Received: by 2002:a17:907:a643:b0:83c:7308:b2ed with SMTP id vu3-20020a170907a64300b0083c7308b2edmr41277617ejc.17.1672843150377;
        Wed, 04 Jan 2023 06:39:10 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:09 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 15:38:47 +0100
Subject: [PATCH v6 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v6-2-6a8531a09b9a@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2784; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=k6P1smlJYbqtcVyvGezj5oVw/cqtzE+zRS/qzT0ctCc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY+F5BhkliZFvYK5Ym2wT15gzQ6IywHdyBQuZv9D
 Oz2Fl7SJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPhQAKCRDRN9E+zzrEiCV9D/
 43PHdTJ87hSQ5gRjDLnN9QhBf/0sdKtpQSIVJtwjRwJj0fKVXNwKAbxnZGaKGFbK0+D6XWur5dsPhx
 zICLrbRMjNO5zu2acdEIcX0Ixyc1goxQxCWSvLbPGI13Gu0zXck2k1aGNHQxbrHsLsoMWv1eJmz7ur
 0A1lsCo+Tm3tAmEnvQh2aD6k3XqJloCXOAzXoiwo3JjNn7aUKZmMnNEOVMiMhnEORyLIkQanA6I6pL
 XJ8jguQA6h/Bp8Xn5ykknlVGxjJvu4Nn6rvEnUKm+kp7L1k8iiUK7HcFRf4VPocxKiILNgowAGfnlR
 mTGEFPqHMTv+Ht+GLfRhqEOd31vGL8VkT0ermM6YAqLuhXIONQn4Jaewcdw90K31Teiw5Y1mdal9tj
 J1IkZa48R7TpCMYFTXf7SibBowvNWa9Vrz8vbrM7SE3cjIUTs0JvqP6Vav0a2TmgMgKdcOPkNgDP6F
 EotJDSYyCD9L+VjV54ebwcd6Tw94km8BKQtiR8AdwBHagfrBuQIYUJtBL5nWYP7hP8HiQt4P4Ubj7c
 kk5rmipLfXeDwJNM5L+L3kUi38k3o9hch06PSlNgWkhmhBSPAlLZxWZ8qTXYLWRpyfFX35Qzx6p1xD
 bjTLM5g5f84UHd42O5GYOj3SQoPP2t4muxbQhIIms/wq5G20v9tluc/GAVQQ==
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
