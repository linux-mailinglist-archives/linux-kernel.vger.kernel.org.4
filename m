Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04B64894C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLIT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLIT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214DFACC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:57:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so6029196pjd.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWRQXWMGLPgHepp4vFWTTWBscI/fkP3Si7wPX1GCGCk=;
        b=euqFpG+4uBmvDf843vzZWop+YwoQXBlPf7xZAvfP7CUKN0IBX5xhIxbaRt4orfqkPh
         y9ggtZJHS/QIOVAQA1qopga++DFumRKRURcPC5xzeH8wrgIeCUVpsio5L4MIpTubhkj3
         teI5hu3BHh2BaubBAhfnhNs85u/g5vJNaGsXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWRQXWMGLPgHepp4vFWTTWBscI/fkP3Si7wPX1GCGCk=;
        b=pJuuKi+d0/7YKxhxO3SqEYYeYFoLnJLV0Ptili7TpGxbd5urvsDDKGebW8cop2tfKi
         yCMYM6hHDPYUr4WJikFvC6CGapOhTZ28gBmavpsMR6EQq3pghNVVVfpSnbwXIGuLv7qE
         s65ofq9dpvkiAPOa2iAitttvh0WWlhuj4gDqJAdP84XYtjvgBYmAPHKWbGoI38FQ9P+l
         cGuBxAdexVMpj+8n1YnY9RDt76ojk5IifL6Oh/3a/heeawronLc6QACbiiMDT3bP2s1A
         bmNajSNnIdjJWzRnKbeFr3xFdy/i7tUlk65P1HntUvGvu8d9e4nR1MOtiG8OdkaDCtNO
         sTZQ==
X-Gm-Message-State: ANoB5pmISN2usCgluxCWSnE5bpNORUpByaDSiIycKNI3XsdxsM8YgyxR
        JbefVUAJ6+Gcf0OtIsi745YGDrQ5mAsKlvzE
X-Google-Smtp-Source: AA0mqf4xreSs2kzJGdPh7ZzAenPhd/07+xeZE9HjNIvQ4yzD3TI933zWiQ1lKTSzRaY/8XsSLATOFg==
X-Received: by 2002:a17:902:7243:b0:18c:cde:fddb with SMTP id c3-20020a170902724300b0018c0cdefddbmr5513700pll.65.1670615868075;
        Fri, 09 Dec 2022 11:57:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b00188c9c11559sm1713993plh.1.2022.12.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:57:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] LoadPin: Refactor read-only check into a helper
Date:   Fri,  9 Dec 2022 11:57:42 -0800
Message-Id: <20221209195746.1366607-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; h=from:subject; bh=gbYMbpgNPEhAbd9b/hiVEdi/hzWQV3pKzGKmwKeatLM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5M4v863YO6OmjVAFboqWMjG+L24JbKQ295kQddg gOTTpUqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OTOAAKCRCJcvTf3G3AJmBXEA Ckm9C7K7+KpajGNz01m4kpN8j+B9Uh9yHTSEHIRzhNPhaYrRavAx15k+ok+34SVIDmwD9yA7F9fg+i p6dmh1hpfThWXVuHH+KFw2jl7ag+g3XuagmOeLArJ8QlJte9iJ/qePM01979RwywvQ58mKDuyNfV5C URF1KUR24VIDmkd6UsSvndjBfeR0IH4g2pnloK7pCmkpKJc/5wKm8wRQrWCFuh+f/cBNxjLUf9pulM zkM5Mht0zLP481O7GbDImBdYk3E+F2dRRhg4fS2KG5io6VvwQKtaCdwj5Lwg8iP69ACE7/D86/Gxkb o11b6wAnj6HQv0zT5f+h27oXGHPR0YVObqaQKU5bnt6r87ryn7JdYS9GLtqF9ToR2eiowLfxJDC7of x4fFsNmfMYJQcEOXNzXZBDM0CMvVHzL1LuMM2UNyQZs82AV0u0HQH5v7pznh63Fo0lEdzTKEz8VclN cuG/isssBg/HIf2vVQowPMvDvUZyUqaDQm8Ex/QBrPMLbDURLk7xWT9UGIY49+DywGxN8maa4Qr9Bw ZQMstCN2Zk8itpTs7HYSuBJKzS2QbxT71fQDtot3+Qz5N7Rc57dZ+HGeALsXS2PyrbuJ3L8PCSgJcA Cr8HBfjXNL0sVJn1HCjyvc4Ibx67CdX/OBNHpmiXpFmFMNXSzEfliun+nmMA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing mounts to shift when not enforced, move
read-only checking into a separate helper.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 110a5ab2b46b..ca0eff3ce9d0 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -72,28 +72,21 @@ static struct ctl_table loadpin_sysctl_table[] = {
 	{ }
 };
 
-/*
- * This must be called after early kernel init, since then the rootdev
- * is available.
- */
-static void check_pinning_enforcement(struct super_block *mnt_sb)
+static void report_writable(struct super_block *mnt_sb, bool writable)
 {
-	bool ro = false;
-
 	/*
 	 * If load pinning is not enforced via a read-only block
 	 * device, allow sysctl to change modes for testing.
 	 */
 	if (mnt_sb->s_bdev) {
-		ro = bdev_read_only(mnt_sb->s_bdev);
 		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
 			MINOR(mnt_sb->s_bdev->bd_dev),
-			ro ? "read-only" : "writable");
+			writable ? "writable" : "read-only");
 	} else
 		pr_info("mnt_sb lacks block device, treating as: writable\n");
 
-	if (!ro) {
+	if (writable) {
 		if (!register_sysctl_paths(loadpin_sysctl_path,
 					   loadpin_sysctl_table))
 			pr_notice("sysctl registration failed!\n");
@@ -103,12 +96,26 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 		pr_info("load pinning engaged.\n");
 }
 #else
-static void check_pinning_enforcement(struct super_block *mnt_sb)
+static void report_writable(struct super_block *mnt_sb, bool writable)
 {
 	pr_info("load pinning engaged.\n");
 }
 #endif
 
+/*
+ * This must be called after early kernel init, since then the rootdev
+ * is available.
+ */
+static bool sb_is_writable(struct super_block *mnt_sb)
+{
+	bool writable = true;
+
+	if (mnt_sb->s_bdev)
+		writable = !bdev_read_only(mnt_sb->s_bdev);
+
+	return writable;
+}
+
 static void loadpin_sb_free_security(struct super_block *mnt_sb)
 {
 	/*
@@ -126,6 +133,7 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
+	bool load_root_writable;
 
 	/* If the file id is excluded, ignore the pinning. */
 	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
@@ -146,6 +154,7 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 	}
 
 	load_root = file->f_path.mnt->mnt_sb;
+	load_root_writable = sb_is_writable(load_root);
 
 	/* First loaded module/firmware defines the root for all others. */
 	spin_lock(&pinned_root_spinlock);
@@ -162,7 +171,7 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 		 * enforcing. This would be purely cosmetic.
 		 */
 		spin_unlock(&pinned_root_spinlock);
-		check_pinning_enforcement(pinned_root);
+		report_writable(pinned_root, load_root_writable);
 		report_load(origin, file, "pinned");
 	} else {
 		spin_unlock(&pinned_root_spinlock);
-- 
2.34.1

