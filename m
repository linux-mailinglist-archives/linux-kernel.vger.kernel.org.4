Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84F06CDB70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjC2ODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC2ODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:03:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93340C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y19so9335056pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680098539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipz6nTPRZ3Cs9OsNmMIh4U9rG9HmGZtivZr/8M/3lr4=;
        b=KK5RXIWBzOFHUKrSn9Akg3XNn5mIB+AFnUVMOtoHbzi8h4bmZvhzB913MMW3xR9qNL
         nal5MnGN92l38eEs5rCDhiH7Ywb1lLxV4DFyySym7Wq03Fo8mTU4Xp6ag/7iavAT92dt
         PPrFCxA9eFgti0a/wnvShWjT1/3w+iWmUEkKMH9NxRonwHIx3XZfBGdu5N7guQd7TCUS
         DPvBI0IZ7dxsQ25o+miaDO1KiICiwk2BTXqlWjo7JyZ2PSfGPyk/dInT7ChXKLs+UAm2
         PELYGkA3fmB2nrkTSTCPU9Jz0T1z/aKZdNZlX3U6dODgbSmPkdc/Vs+Oo3n4dgDJJ3+F
         bz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipz6nTPRZ3Cs9OsNmMIh4U9rG9HmGZtivZr/8M/3lr4=;
        b=PPdB+rBdY721brjpKx0ds4B2x6R9E7MegqA0OjYWHjvOMZVinkmfWjVJxqp72fvA0P
         D/cyAE2kW9CebfccwX+iBasWgr1t6LubzR324enJ3SGQc2gbi4Uc83DaCz+W24A8LHjq
         4OEjcm1bINdnVVNEI7iqXrGBD96G+GqSVcM8abPXfKtQ9x1uf5/8n1IWaC/kB48Suu+I
         3vGR9pbz5oJm8n8jWuJNIQJYM8NiLq9vwNf+qj913k70ntRjiDO3qcFt3M77XyueSfdS
         YY6kwrJKd5yR6Xjooyy6hA0uP5uxO5UJo9qCqXre8qBzUzn+7d1+q5S/VO5fIb5bU1xy
         q2Rg==
X-Gm-Message-State: AAQBX9fXcWrdJvi2qlJDerLlvlFYBE8+XKeQCYXwEPQ/Gzh76JhruDPL
        V1iFSMQIxMQ/dtNJKl0bkXlz3w==
X-Google-Smtp-Source: AKy350agFd23rtp9fJIObJvoc0ZU1y001hab30mZqUB26ZN/Mugpz+vVPw1b2lYdWEbiNpp8miSTrw==
X-Received: by 2002:a62:1bc4:0:b0:61d:e10f:4e70 with SMTP id b187-20020a621bc4000000b0061de10f4e70mr17953451pfb.0.1680098539612;
        Wed, 29 Mar 2023 07:02:19 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:19 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date:   Wed, 29 Mar 2023 22:01:52 +0800
Message-Id: <20230329140155.53272-3-zhujia.zj@bytedance.com>
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

We'll introduce a @work_struct field for @object in subsequent patches,
it will enlarge the size of @object.
As the result of that, this commit extracts ondemand info field from
@object.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/interface.c |  7 ++++++-
 fs/cachefiles/internal.h  | 26 ++++++++++++++++++++++----
 fs/cachefiles/ondemand.c  | 34 ++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 40052bdb33655..35ba2117a6f65 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -31,6 +31,11 @@ struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
 	if (!object)
 		return NULL;
 
+	if (cachefiles_ondemand_init_obj_info(object, volume)) {
+		kmem_cache_free(cachefiles_object_jar, object);
+		return NULL;
+	}
+
 	refcount_set(&object->ref, 1);
 
 	spin_lock_init(&object->lock);
@@ -88,7 +93,7 @@ void cachefiles_put_object(struct cachefiles_object *object,
 		ASSERTCMP(object->file, ==, NULL);
 
 		kfree(object->d_name);
-
+		cachefiles_ondemand_deinit_obj_info(object);
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
 		object->cookie = NULL;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 00beedeaec183..b0fe76964bc0d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -49,6 +49,12 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
 };
 
+struct cachefiles_ondemand_info {
+	int				ondemand_id;
+	enum cachefiles_object_state	state;
+	struct cachefiles_object	*object;
+};
+
 /*
  * Backing file state.
  */
@@ -66,8 +72,7 @@ struct cachefiles_object {
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
-	int				ondemand_id;
-	enum cachefiles_object_state	state;
+	struct cachefiles_ondemand_info	*ondemand;
 #endif
 };
 
@@ -302,17 +307,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+					struct cachefiles_volume *volume);
+extern void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj);
+
 #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
 static inline bool								\
 cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
 {												\
-	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+	return object->ondemand->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
 }												\
 												\
 static inline void								\
 cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 {												\
-	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+	object->ondemand->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
 }
 
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
@@ -338,6 +347,15 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+						struct cachefiles_volume *volume)
+{
+	return 0;
+}
+static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
+{
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 90456b8a4b3e0..deb7e3007aa1d 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -9,12 +9,13 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 {
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	int object_id = object->ondemand_id;
+	struct cachefiles_ondemand_info *info = object->ondemand;
+	int object_id = info->ondemand_id;
 	struct cachefiles_req *req;
 	XA_STATE(xas, &cache->reqs, 0);
 
 	xa_lock(&cache->reqs);
-	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
 
 	/*
@@ -222,7 +223,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	req->msg.object_id = object_id;
-	object->ondemand_id = object_id;
+	object->ondemand->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
@@ -368,7 +369,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 
 		if (opcode != CACHEFILES_OP_OPEN &&
 			!cachefiles_ondemand_object_is_open(object)) {
-			WARN_ON_ONCE(object->ondemand_id == 0);
+			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -438,7 +439,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->ondemand_id;
+	req->msg.object_id = object->ondemand->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -454,7 +455,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
+	int object_id = object->ondemand->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
 	if (!cachefiles_ondemand_object_is_open(object)) {
@@ -500,6 +501,27 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 			cachefiles_ondemand_init_close_req, NULL);
 }
 
+int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+				struct cachefiles_volume *volume)
+{
+	if (!cachefiles_in_ondemand_mode(volume->cache))
+		return 0;
+
+	object->ondemand = kzalloc(sizeof(struct cachefiles_ondemand_info),
+					GFP_KERNEL);
+	if (!object->ondemand)
+		return -ENOMEM;
+
+	object->ondemand->object = object;
+	return 0;
+}
+
+void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *object)
+{
+	kfree(object->ondemand);
+	object->ondemand = NULL;
+}
+
 int cachefiles_ondemand_read(struct cachefiles_object *object,
 			     loff_t pos, size_t len)
 {
-- 
2.20.1

