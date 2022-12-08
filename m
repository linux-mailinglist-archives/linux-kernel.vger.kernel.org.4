Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE897647470
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLHQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLHQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:38:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C113F1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:38:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fc4so5302646ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ3ul1jQRXTmaEsuvA4DkzO41vWZ0ws2E+AUBitFzrQ=;
        b=k/7X3z9v4qZ29jB2yYGyTKe0hRoo77mPXZfDtm/XwjaqyLx2sHjGxg9aBpwD9Ee3qz
         Np0blameSJM60Ssvq6O9wMJFkHCAokczTYCo3ver8LXm+zG6gA+ypMSfMMzlou1PPHti
         ELRuj4yf83+9A377gSgGNh1Ubqx45IuT2Fo1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ3ul1jQRXTmaEsuvA4DkzO41vWZ0ws2E+AUBitFzrQ=;
        b=Zv9VUrxfpgyz9h2V3ZgaTH2vOsC/GudGQp7Rsb+ZsIfNat/7H1o62zgCjtwXmNYVwG
         rWeca9bwwT3WFstvCs0PFT2N5TJTlKM6d4CgrFgb8vahVjfFXJToPFy4O9Qffh+xul/k
         Xp1TsoEczUbQYXmzOlROupjZajgmnVXOVfmy3e0jn8oq64btGZYheLJDfHmD4lSVBFyP
         2MddbYPf2e//X5kyG0gYIgvkaVvxQBDqJl1cVInfl20RNXSiQlVBrPW5KHyVBeFFMS6K
         PuZ3NU7j+PmxRojtH32T0gCLax0zwz5IsVMCluwBLDvOnxE6U4ytwrE+AXesYC99eL92
         Wjcg==
X-Gm-Message-State: ANoB5pmul55LvXs3JeZAW0GHN9jF6SjZ48ev4xHh5PU09w9t4ZWhrLKM
        1NEahDsExUsIQ+qSmfdghWbjcA==
X-Google-Smtp-Source: AA0mqf7ngwJXA0LQ0pE9LI12ePlzBri7eOWpsblIAQol5/TWLcdwNMC2uMVjWTpBXXshpczBCf+Jqw==
X-Received: by 2002:a17:906:3716:b0:7c0:bbab:22e5 with SMTP id d22-20020a170906371600b007c0bbab22e5mr2410973ejc.16.1670517498873;
        Thu, 08 Dec 2022 08:38:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 08 Dec 2022 17:38:01 +0100
Subject: [PATCH v2 2/3] kexec: Factor out kexec_load_permited
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v2-2-c498313c1bb5@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=oo014ZHz6Xm+AA2th2qtraBO9RjgGW/IoV0rNAHz2pg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLz9anViJqu4KFmbxZAiE4U2e9028qdN4mFsCU/
 1AN51y+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS8wAKCRDRN9E+zzrEiA5dD/
 9Pnutdugl35mpmsNND3wkKYkKNVhDCU8yN/9efaLGUCOX18rdNdmF3OzB74ulcQOMbIr2OtHsVwpo8
 774SGkYfiSh0s0ZSNKxDlPkWagoP/wxCj6puE4NrwNwCTkvB3kzOeS4FZClutvKDzN/fds75Ulgh9N
 S1EjqrWZhSjN+O/xNJmUUun3CDqvmnmT6D2U+mTDX8RqDAEAp1bNjEObBHgL1hVqYifBtLOZS667yS
 YLSakIjNXJt2J+TIHfM0r+gMO7RIbhNef66a9jQ4Xg2BLiReHsLjFTbeU9C3K9GHvPqkIk1kI/FJ88
 MQRmL8zMvoSiStw8sG5VHDDS/OFaWUCl4rtasmT+CtoQ4EvL17sn42HGV64EDP0kIERzVUnmnQXxXv
 8G/IblodKjK7Yx8/ABySgL3/I3sV1HAwgA0Nfnc6NhEA5yjDHQx//rajtVLww7eodwn+zhovNohNm1
 AVd1ovekbd3kDn1Wtpz00x+ED5qhmZaNi1+IA++Kk+l5J/Uzk1GiY8zAhVg7s07Jky/3/c7XVrCRhe
 rfGeUjRbUmaQnUpA9r7+4wtRsHWQerSnZK6D3nVj2Kz6nc+1Sv2os3AMUPdrbXpKNfHSRzc1QmqDDm
 W2PLGlbTyb6BM1UX4yi0LbPbZivH+/xZAuHbRinNocOiAsO8108osa8eKAAg==
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
index 41a686996aaa..e9e1ab5e8006 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -406,7 +406,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
-extern int kexec_load_disabled;
+
+bool kexec_load_permited(void);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..d83fc9093aff 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permited())
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..18bd90ca9c99 100644
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
 
+bool kexec_load_permited(void)
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
index 45637511e0de..701147c118d4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permited())
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
