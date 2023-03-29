Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59B6CDB77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjC2OD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjC2ODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:03:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951755BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z10so9323789pgr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680098546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=201B13UZk/ur2kBlvNBkJlC5f80F32l3qYGjPhn9UGk=;
        b=l589k9VceQVCSfGGt2mtcUk/mgCXBRxnZzNxeJPJ96SxR+hNJU+zRlqO7ZSCA9MSqR
         3PQaFvQiKRzgTCpXLUHVWPBoW47FdIIuKzGfg/deTBcaD6ZvUwjbddQU2QNgNiDa7vK5
         L54qu5HyIldHsuUKHaLR42uDwP6ugyJCnlotGlL0qYGZLWA9yEd1SABFZTHZE9DGiAcJ
         aQnjiPJ79C1dKUetzeHNeftJpdYhUExwemT5Y5x8NKb8p1zViRIAdn3V5ClQmBHBUn9I
         VVup8Tt1GSoNvyEgJnCH/thPhHF4ZnhiJG3otqlIxad26l3VhEZbNAGutOexfbMWvR0X
         Qbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=201B13UZk/ur2kBlvNBkJlC5f80F32l3qYGjPhn9UGk=;
        b=mbxjSMIJS1RvqeXefpvZuq1xgcvXzmmMaoutwtjB2kYMexvch2GgeeI/7bxNISIK+K
         Ej9+ot6Aa9ya3nZ7dHrrS/pO4db6YOI4Koy9Kq7l8cIQWq0FyEXiqFrL3Fb4U8fHrDqX
         S+pryolI+1hqVjGu0xidBwTwNGkrrK5KMfkW4dYi7bUlpKMd4ozlbiBNMII8DvIfL/Ul
         dUpINiHDuziN+s3Grqt8x1cs9PJzZ3cx6iXcrnHNRlvunij0rJp01SFY5TbTLsZh4OU7
         GCCUZVywDU0oiGj194UdmqtUJyOhHWnsIXYcj+kLLhdwnFFqwlbH0GJTO6Jo9AV8KRYg
         T+9g==
X-Gm-Message-State: AAQBX9d59o78RqVJE21LTmlYYq7baR/bsrgs/e1EEBEtdGrd9Uzvk9G5
        l5jELQ3NwagixYB1jCuqwW3iGA==
X-Google-Smtp-Source: AKy350aS4UxXoOIsHELZC+pNvz0Orc/jDx6TWEB+8m6gvhUkHKqYrpdjkPrCG/VD3G35YcxyACiV1Q==
X-Received: by 2002:a05:6a00:1d0f:b0:629:3f28:ead1 with SMTP id a15-20020a056a001d0f00b006293f28ead1mr2194928pfx.12.1680098545899;
        Wed, 29 Mar 2023 07:02:25 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:25 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Wed, 29 Mar 2023 22:01:54 +0800
Message-Id: <20230329140155.53272-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230329140155.53272-1-zhujia.zj@bytedance.com>
References: <20230329140155.53272-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 15 +++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e37..86892f471e761 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,25 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(xa)) {
+			rcu_read_lock();
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b9a90f1a0c015..26e5f8f123ef1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -329,6 +329,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return cachefiles_ondemand_object_is_reopening(req->object) &&
+			req->msg.opcode == CACHEFILES_OP_READ;
+}
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -359,6 +366,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
 {
 }
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.20.1

