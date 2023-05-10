Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6365F6FD373
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjEJBMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJBMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:12:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510B2715
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:12:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-333866a265fso37315715ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 18:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683681160; x=1686273160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/byOb/YN2FOhEDLOzvgCisBLsbxrs48FYxmgO/WV78=;
        b=Fit7T8MDmBd51PmKKPB7LCXu6FNmYlbmWemucUxo4fmsQMtzpyOWk5dLIVtlML6wfb
         nA4qaYpN5QhEaKVv1H0br5OEdFIt2HXH9Je2Zbtbne62Jvt6IWRdvsy7K7kprLruYTHB
         JPFIsV7B9f4/1lLTTlBOLC7BdzNI+EhKKlG1TjkkbvV6my0BzFP45MJqZ4trmUpm9OVc
         kjoyC2QgVs8UUMkARfFyE2oU2Xf2AvlhE/t3iJS0lYo/30QvTCmlzUjHRsM/WHM+mbhE
         1CEvLrOGWQn0NT8s2VY84MtlUsynnizmwjQRUhmcvKnbnR01US8ZWH2t5AbImZo/8UYI
         MToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683681160; x=1686273160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/byOb/YN2FOhEDLOzvgCisBLsbxrs48FYxmgO/WV78=;
        b=YSjpoMsSIUcYUpEkM0tccZdX7q5DLh5BAO1YDkupgH53bZqUM2rqgQXJQEi+tZfDQ3
         bNFT3V8jK0haA2sr4b+ulvRDly1/onTsE+Xlwr5xmyw9fifVMJzGWmPu538lVT4ePS/C
         h3l+tkPIxe7SPOhjRcSQZNUGOWcNXgY8YV/AE+yU8nzpUeOWpEHyfXGQID8+AXw+1nx3
         db6gXvyA2ioiaCUQjjqNF5F8OtJIkSp5xB1UKba+SybOhutGQH6U58mumVBcjoALde3t
         6Ik3sf47luFKs/7qPu7pIV7ZJ/mxZfBldKm2rJv3+CO9oKzwvCaeS1EhlstLgiuC3XuJ
         B7ww==
X-Gm-Message-State: AC+VfDxSvFx14mwJizrjNuunjzr69f6PQU9z6rQy81nD5ypDNzeRq660
        ZJutsZHGE+9k4JkxYTUoSDo=
X-Google-Smtp-Source: ACHHUZ7IKyYHXn1scXwOJcSVlK8BWEqzkTW/xG3x1n7UJJBOG0saLOBytu5CCF0dTZCpMZZb725PIQ==
X-Received: by 2002:a92:d6c7:0:b0:335:277c:384d with SMTP id z7-20020a92d6c7000000b00335277c384dmr8399426ilp.23.1683681160283;
        Tue, 09 May 2023 18:12:40 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id i33-20020a026021000000b004165f64968csm3156046jac.103.2023.05.09.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 18:12:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     security@kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernfs: Prefer strscpy over strlcpy calls
Date:   Wed, 10 May 2023 01:11:22 +0000
Message-ID: <20230510011122.3040915-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
Since strscpy() returns -E2BIG on truncate, we rely on
strlen(src) to imitate strlcpy behavior.

This is part of a tree-wide cleanup to remove the strlcpy() function
entirely from the kernel [2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/kernfs/dir.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45b6919903e6..0f46d7b304b0 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -51,12 +51,19 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 #endif
 }
 
+/* strscpy_mock_strlcpy - imitates strlcpy API but uses strscpy underneath. */
+static size_t strscpy_mock_strlcpy(char *dest, const char *src, size_t count)
+{
+	strscpy(dest, src, count);
+	return strlen(src);
+}
+
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
 	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy_mock_strlcpy(buf, "(null)", buflen);
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	return strscpy_mock_strlcpy(buf, kn->parent ? kn->name : "/", buflen);
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -141,13 +148,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	int i, j;
 
 	if (!kn_to)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy_mock_strlcpy(buf, "(null)", buflen);
 
 	if (!kn_from)
 		kn_from = kernfs_root(kn_to)->kn;
 
 	if (kn_from == kn_to)
-		return strlcpy(buf, "/", buflen);
+		return strscpy_mock_strlcpy(buf, "/", buflen);
 
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
@@ -159,16 +166,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	buf[0] = '\0';
 
 	for (i = 0; i < depth_from; i++)
-		len += strlcpy(buf + len, parent_str,
+		len += strscpy_mock_strlcpy(buf + len, parent_str,
 			       len < buflen ? buflen - len : 0);
 
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
 			kn = kn->parent;
-		len += strlcpy(buf + len, "/",
+		len += strscpy_mock_strlcpy(buf + len, "/",
 			       len < buflen ? buflen - len : 0);
-		len += strlcpy(buf + len, kn->name,
+		len += strscpy_mock_strlcpy(buf + len, kn->name,
 			       len < buflen ? buflen - len : 0);
 	}
 
@@ -851,7 +858,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy_mock_strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
 	if (len >= sizeof(kernfs_pr_cont_buf)) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
-- 
2.40.1.521.gf1e218fcd8-goog


