Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640C8648952
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLIT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLIT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B313E01
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:57:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9222355pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGkVWEa5T6qjzunke8iqiL9y1vbCzAYhZe+DJ6bp/6U=;
        b=YxYIoV/nSKqI3pErZbKeQ+OkDCJm4+BV+FwVp0x9JxlywPESjTUrYN+hT1YeqoRHJj
         58pXWErDz4iQ3HmCmcfLNgA/9aKFWIIRJ1e68Nlc8f7cluB3scf4xAQjEODflZhqQpC1
         yYXvK9ZEHFO1UxFS1T65RhM/dlBkpLwKi5Qsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGkVWEa5T6qjzunke8iqiL9y1vbCzAYhZe+DJ6bp/6U=;
        b=p/WOfYcK9HOEriVGBMUkbRFUtqlJylm9jkvQHt/3e2PJKQOkEiUaJ+0sBARKLozevH
         8HCAzopP6B399paADSj0aoS0aj8/cP41M1QGRXpEjOBmz0ZCB9hIBK2/7DESWkeQARZx
         JRMQSBewk0GfwybxjYlopFLrA2gyoNFFFb6wM6awykRO3FozSH8PlWAHDAWTB4w9ic8M
         gRi7rYOMs2UTdL7O9KaOpG4+ovXZqiIq7fwYTcq2rlXqkanNj3tEaMrAJc57+Q8d9D7z
         cqfhnT3UNEEaZVUIPzHVw/XMKpjZvCMn1oZLDLkhJzbTwu1sGKObhjnIgN/ZkjWXgasL
         jluw==
X-Gm-Message-State: ANoB5pmSE9CbRSNwocQWqJmqE9C75y44Si6yfsENTgfBmjYp9VZuDjjc
        2ps5+IRq0AMf4MZslITARFIwmg==
X-Google-Smtp-Source: AA0mqf7AHghEqWHBk2qK+HA8SKaR3vV04rR+Y0hdwdmcjeKe7svSSE8m1yoEiOaO5NLGjTm3McEELw==
X-Received: by 2002:a17:90a:8f03:b0:218:fa36:ad6a with SMTP id g3-20020a17090a8f0300b00218fa36ad6amr7149816pjo.4.1670615870177;
        Fri, 09 Dec 2022 11:57:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a8b8800b002199eaa80e1sm1480173pjn.13.2022.12.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:57:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] LoadPin: Allow filesystem switch when not enforcing
Date:   Fri,  9 Dec 2022 11:57:45 -0800
Message-Id: <20221209195746.1366607-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; h=from:subject; bh=fZeLjQA82vU81dQmP0SkURZPi2Xeq07Q0YGb0gDxICs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5M5YgZfaDfRh3GV0WAB5frGjrqzt0HVxRlIyT5F ShdHp42JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OTOQAKCRCJcvTf3G3AJtIhEA CG+MP65o4vsx9LrA/BTfp93kFMlahQKQp/LZVmywRGc0dlSGywP1qJ82Hhunso+NQ3WyYgxK2k8gDu KDnDdlUhK3X45LokRqyWe+iHsZ/TLfCumpYikmt5nNknIHQrbsfWwRGk8iuztb0b6PELNloUxtWNyF P2Zlg6Keka/RrQrrI39kfz9rhRRq6Z7LfNh+zphduwb+T0QVPXIp/w811m/IK8Pe9ApPv0TQL0oWRv WwOPL9VTCopNFmmvwdR9D7ZatXo3JshPaQWcxaPQ/F5pNmgT+oR1vdZXTla7/RZG6ceyA2miKysWWX lO+JgyszP1nylCYySX6lf3TeoFLYj7IvyQbDH/KQ2RecO6PH0ADj6uvPrk1R83PJb+i6mBjLDMVaVu IC4U3FmsSyTTMU6X/0GhgzdPGLdfU+HNUHfSLmYORGQQHGEHSkZuXyF7UbUCaWqjk1C4gLh0KuT35N BDKNiY8ewe01D9912PnouT+X9yuP+D16iN6xZEp5qDXJwVKKcFmTvfY8M330lDiWR14umJgCERyp5e ZNoM70nrGCAlFqVP2bfgda0CV/EoCaMEZnDz8s4gksDnlgAN0/xMN3tz9R0Sj2JPVpKHA8NDdKlpws sHRWEv15zSNDSIwOR8i/yfMVJuRHW/3f23LTGeFfSXebtvraan+uYn18txtA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoadPin to be used at all in a classic distro environment, it needs
to allow for switching filesystems (from the initramfs to the "real"
root filesystem). To allow for this, if the "enforce" mode is not set at
boot, reset the pinned filesystem tracking when the pinned filesystem
gets unmounted instead of invalidating further loads. Once enforcement
is set, it cannot be unset, and the pinning will stick.

This means that distros can build with CONFIG_SECURITY_LOADPIN=y, but with
CONFIG_SECURITY_LOADPIN_ENFORCE disabled, but after boot is running,
the system can enable enforcement:

  $ sysctl -w kernel.loadpin.enforced=1

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ef12d77548ae..d73a281adf86 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -119,11 +119,16 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	/*
 	 * When unmounting the filesystem we were using for load
 	 * pinning, we acknowledge the superblock release, but make sure
-	 * no other modules or firmware can be loaded.
+	 * no other modules or firmware can be loaded when we are in
+	 * enforcing mode. Otherwise, allow the root to be reestablished.
 	 */
 	if (!IS_ERR_OR_NULL(pinned_root) && mnt_sb == pinned_root) {
-		pinned_root = ERR_PTR(-EIO);
-		pr_info("umount pinned fs: refusing further loads\n");
+		if (enforce) {
+			pinned_root = ERR_PTR(-EIO);
+			pr_info("umount pinned fs: refusing further loads\n");
+		} else {
+			pinned_root = NULL;
+		}
 	}
 }
 
@@ -158,8 +163,9 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 	/* First loaded module/firmware defines the root for all others. */
 	spin_lock(&pinned_root_spinlock);
 	/*
-	 * pinned_root is only NULL at startup. Otherwise, it is either
-	 * a valid reference, or an ERR_PTR.
+	 * pinned_root is only NULL at startup or when the pinned root has
+	 * been unmounted while we are not in enforcing mode. Otherwise, it
+	 * is either a valid reference, or an ERR_PTR.
 	 */
 	if (!pinned_root) {
 		pinned_root = load_root;
-- 
2.34.1

