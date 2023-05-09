Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF696FD2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjEIWao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEIWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:30:42 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6DF26A3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:30:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c5749b10fso39495739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683671440; x=1686263440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SXK0aVd0ASJIuJX5pK4PwIfpEk40A9QzlabEVtHB58=;
        b=EOiAv1HxX1YyTRZ2DmFol5UxawoLJ1hMo7zXvX/W6yZHEmBbxprYkT7pelZMoL5w1n
         Ls7g//HEtEeWKa02ZJLdNyGlNTiNEBK6H9n3YMwnDQ8hOq52PX6YJ1ZWPGwpoKCE2ZLA
         uzZmbmkt47WGcqPy4qw+wPYFyD+85Eu7Q4Bm2Lb0zGNOGYpUifmax4roloaB0a6KG+14
         jmH5G+ppttzP7wO9STRTMcZMwX2GrNIpwLdWfBFyVH4tnGWw2JlSkPnZ3NBpF5DCHywz
         1AP2cGXYTV6+Z0M9dtu1I6+lxPITmD051w0iErkSBmNNgQtLIRJBJzX8xr8DOde/X84F
         fmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671440; x=1686263440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SXK0aVd0ASJIuJX5pK4PwIfpEk40A9QzlabEVtHB58=;
        b=MQP2BnWnrlQ9u7H5EgVFjgEpymjDZwLnX0rvnaZrC1OGxw38wUz4rz7yqkfkzx+NRw
         Gjp14EMZOeRrH6aDLPyQ5+2GKhpQLK9BPllcqLTt8s7Z8nq1CX914sWbrZuciEL46W8L
         OWBfzx79geJVivqv1mCONywvr+llGlOjtUMKNJG79+vMs8gwIEVGOQ8BWGTze+aFmJRU
         ePbHz3jK1DkzzLUMgPm+kr/MDZXGs4/BwQzBnVwxEZxToaXCwZgjMJF7lV9IbEwY628e
         U/juB9HbCzYx/ttndRVRWbC443PPMnAu1Jjp5CDO4viJpI4qBV+AhBIP5sXHOo6BwMzK
         tHOA==
X-Gm-Message-State: AC+VfDwgF8XGc7LPGbsOyEwj+zOpVa+B/2VAQBxelVioAiFufG1AgSs+
        T2HNkXLc0GR6gnhob/7q0Bk=
X-Google-Smtp-Source: ACHHUZ4dwFx6jCuJca8A5uta76BQXxrS9aU+bjgxgDDF+oyZL5HkD54KwOKgO5g96/reCQ93ztnIcg==
X-Received: by 2002:a5e:8810:0:b0:76c:69bd:d519 with SMTP id l16-20020a5e8810000000b0076c69bdd519mr457267ioj.0.1683671440437;
        Tue, 09 May 2023 15:30:40 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d9ac1000000b00760f535cd5asm3103481ion.10.2023.05.09.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:30:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     security@kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: kernfs: Prefer strscpy over strlcpy calls
Date:   Tue,  9 May 2023 22:30:36 +0000
Message-ID: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
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
overflows if a source string is not NUL-terminated.
Since strscpy() returns -E2BIG on truncate, we rely on
strlen(src) to imitate strlcpy behavior.

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


