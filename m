Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0A704412
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEPDqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEPDp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:45:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBD55A8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:45:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643a1fed360so8384142b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684208757; x=1686800757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6xFm5v7Zliq3lQdYvYJJM7LEIo9eVLB2Vl6mhd8DHI=;
        b=RAczxxBxYyMSZJjVasUdeYM77Gq40PtSHaaMLD0DjQeMs8vPZgi6NSorFQkASWrCwg
         qT5mZFiQZDoUFfrkxuZfrkEF+4xsKQAXf22F5hJ0kjchSj9yTT7JERtPq+ncBzq0WeXX
         awW11lvxDNmdCadLsYmwTh6DsXrH0fN7svpJjnMeyUIb+z8qWSup1diiPHJbx3ZD6MzS
         J93Pe7tPM+ehcVHPExahCtgYpMYCV385NVhct/UKAexHclI8ouHfX6WzQb5OhmmOaS5k
         brGh4tNpyrj3JnrEkWhXfGKk4hfYLWiFWbmbhaUfkDByWEEqAo5r46OpCMlxo2qoXt+/
         AFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208757; x=1686800757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6xFm5v7Zliq3lQdYvYJJM7LEIo9eVLB2Vl6mhd8DHI=;
        b=FRQnSuasAqDsplHF+O3DCC0WWJz6HpCK8FLXouP9O7jfPaIWehbBX31r/uL12nSm3n
         eSD0wIux73crC4SWV8v9Y99jrLaaPXZciTw9rH5Rjk0YJeo2rUn8ebP7CxgZESUK0cZM
         PYU1M/HTjGuBZ35njjjd+OWt7M635hMwYy6wBgWKk5w7nJNXHt9e85qnNszSDR7/QzYv
         Yf2+zMgzdY5Ptw1y0cBPIkCE7fA0z28H3vzbr1ldMqBNyEAfV/7UO2+u3LtD5lRD8G0k
         bNmSkKCMKGimorY3IK6Wk125l0XUy8vtwZxCD7X/wUTEBglxfNsSDuLKGQYY08qhX/Lf
         BasA==
X-Gm-Message-State: AC+VfDxaf1Bbz8uCL4gMWWw9qRe3NDOL6d83uuS2teOzjyj58JUosdqz
        vYlYpdACk8O51m+JZEZKjcgnqw==
X-Google-Smtp-Source: ACHHUZ56WoYFeSj3BHyPQukZPnzA11OQRYSDO7dolYWR9RwgzZ75qh8S99h/y6XeuE5d4Qt3DDJ/Tg==
X-Received: by 2002:a05:6a00:1496:b0:643:857d:879a with SMTP id v22-20020a056a00149600b00643857d879amr52781034pfu.24.1684208757169;
        Mon, 15 May 2023 20:45:57 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b0063db25e140bsm12488032pfp.32.2023.05.15.20.45.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 20:45:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
Date:   Tue, 16 May 2023 11:45:36 +0800
Message-Id: <20230516034536.25548-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root->ino_idr is supposed to be protected by kernfs_idr_lock, fix
it.

Fixes: 488dee96bb62 ("kernfs: allow creating kernfs objects with arbitrary uid/gid")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/kernfs/dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45b6919903e6..84a2cd196076 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -525,6 +525,13 @@ void kernfs_get(struct kernfs_node *kn)
 }
 EXPORT_SYMBOL_GPL(kernfs_get);
 
+static void kernfs_idr_remove(struct kernfs_root *root, struct kernfs_node *kn)
+{
+	spin_lock(&kernfs_idr_lock);
+	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	spin_unlock(&kernfs_idr_lock);
+}
+
 /**
  * kernfs_put - put a reference count on a kernfs_node
  * @kn: the target kernfs_node
@@ -559,9 +566,7 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	spin_lock(&kernfs_idr_lock);
-	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	spin_unlock(&kernfs_idr_lock);
+	kernfs_idr_remove(root, kn);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -655,7 +660,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
-	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	kernfs_idr_remove(root, kn);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
-- 
2.11.0

