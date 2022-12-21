Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2BE653735
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiLUTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiLUTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:46:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DEC26109
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:46:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z92so32892ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=WX7m0hFptzAKKxKsaaznTLCeqXMlEsjlHE0rP+ZyG0YNSw3h+7aI7mg0glILNtGFCz
         kzOlSrRMq6Oix0VtjYBFRnisX2Hn0x2yoaYyc6H5n87Xgzm59sWQtqEsetF/PRaxhxNX
         gSrN4JjE5E5W5C9pns16Llt81QhijcSi4pGHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=GwFwfO/E3qMbOJw5UWrrevWIapXcmoQNT1xoCz3eX4+HkkoDBAq/psClM4OWPyrruU
         k2FGGZQxM6zpk4y2tEQZfimz51J88ujQqAAFA9z3MTF37uy33Bl8UkYmeamChs5UY8pQ
         Oys/qw/+an+Qc5rohOKThrgCHz3DmkzgCSaqqhI2pb58dpchbiIfYI/MVtsrecQ9xav9
         HSyO9k94xW1yEeg8SAqIZP7bSdqANR6lZLYzoE/5ZC4guhCF7v0U2btkMj12vKbK30ub
         EZvTI33oCpj5TT4YfKUE5dlRo94l+p7cmBHkq0UdR4F6PN7LqNtYRDwtZ7HxEzsvQtCH
         VGWg==
X-Gm-Message-State: AFqh2kpPVN+Q/6M0yWd0SkTaGaWvwpH94CDHth/7RRz9Xd/r0n5hWlKy
        WKEvu+9599nJ6lRmf3nk5CiN7Q==
X-Google-Smtp-Source: AMrXdXtTZ4AJlQ9U0G+e+iBRcvddnW65aUk/yN9aZH2F8Alh6420BexRna4Td4t+M3AftNwqnXtCKQ==
X-Received: by 2002:a05:6402:501f:b0:460:5706:d1fa with SMTP id p31-20020a056402501f00b004605706d1famr2808261eda.18.1671651972067;
        Wed, 21 Dec 2022 11:46:12 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0046cbcc86bdesm7382008edu.7.2022.12.21.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:46:11 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 20:45:58 +0100
Subject: [PATCH v5 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v5-2-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@redhat.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rm7FZlNI1K3HcWDQ5vaPpIW63r8rInBklo9MHxPCtFE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2J+j6VSiwnd2NWq7ZYy+eTh20kxBVZ9N+tQgsO4
 igsMiaWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NifgAKCRDRN9E+zzrEiGD7EA
 CYxHLKOPM0+bvFezijOnO/4euoKLtab/2RYTcKlJRXfaLDSfpGPq/yiF2XmosQXz9H1wOwxZjPq0UV
 S+/PlFVreAJhuOn9yogBEAdK9wkQu4xJUtE84othkWC84aYXOHQK6PSZCScw6dWYV3JV2v3JOrNqB3
 hRcsbyMxlyPsXIdpxlwA6ZHmdLVsivB1zoYcJl7CwUGPNcC+/OLyyVORgUI55LdUAVqeHxyaVfuGav
 gY8xZzttKJEAlpzfB5cz7yyqK1Zd5FPdV/1BDsxLEG2G1ej1IFkaoUZItbfAPHq+w/q+zJfpv76m3L
 7bw4bH8WT321wqTso6Ixppe2rUErDpNDtDWSUJJDIlRZJeWmr0opiVPxaG+i51uWHfO3d7YKV6JJ16
 ACej0FAbBCJgZgAGSWby008b6GoyJWcMoN4a6xfP6hEDqjsmSYDJ+GQNBuWg3U0t/PlFDJbQZS2Y2c
 C3QCGfQ+o+6QYZ5RTV0pv90pQZunYJ3VJlaxVD16OSM+HRroJGo1zhLgJeMbDr+00+BNw9BRUnEtQk
 KQ7E20venuQA+qKYRD+AB1egECzOpXL1bpBMNjmE8254qy60xBRjk3iM1dqnApJPFBI9qSKY4V39ZC
 kH4XZdG16Fnrhi2q3Mr4lD8J1Q5WMmGdya5RTg4lw0296MOpLuJqkhRD3+Gw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
