Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CE6CDB72
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjC2ODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjC2ODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:03:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA20469C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b7so239799pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680098536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyRNuAUEDwU7cFP/FwiLl7ToUiN3TCE52oxG0Yaf7cc=;
        b=iQ4wh80Kq03ysjTxXIDtcgtYgWFf6onO3QJVR/Nz97PoDHP60/cNowM16zO+Dqsw+9
         pNmJwbEaF/x0ErB8rjPHZTcgPOf9AKZQ0k8yRx5q71DyNpzpYXDyERVEHz2raK6RmGnf
         Zp3xhYFnWawNieU/+GcGMMBAIAEP+/Rx5XMwnHE8JMxdZq91ivCusm9hYMc+qQKPYyLk
         mAQi/PcSWscDwgpGp61vKmgEfO702Xp8XOm2D2v0w9wHWXVAzRlf+aWEcDe0D9KmRXpw
         GM8XTzTGXfugqVUWjbMWKLhTN8xyIDwb2ZZQCG3KsTvVIrCIpWlpxNdtuCS8lq/S0ObG
         qZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyRNuAUEDwU7cFP/FwiLl7ToUiN3TCE52oxG0Yaf7cc=;
        b=0v1LNq4ncsld/flUJ9lsXb/TTpl7NvUL7nCMv6eXSP2fi0XCqD+I6UPDOt2P54Wokc
         8qRPEt6vP4DURusV6tJXpNae7QkD38UBd6g8fBiMy/aDMDOiXpw2OfPd1i/7jDbEyjXk
         CrUIDaNHTGhGmX9qRiMEUrtMp1FaKNGgGwujB/Xl2uM6K3ByfMfrlmqvdpF00EabFLma
         hvdE01qGt0N4WHGqut/bhMIwLSWa0zg3W+kj7CrQcvZmlcCcuXdU0oNunNPFUJMqK+Du
         F49E6wPWw7vaULR/LJoNsDmEdyOSwokfbSdY4zPjd0/fjfotR865dD+rVyVr24e/ajW4
         lONQ==
X-Gm-Message-State: AO0yUKUTfbmlLy4zWJ0Tdw8eE3sln6zCeJ6KZVBMM3KBRjBa3B0lO/iu
        QV7frxyQ6I2R/DW3apoVrl4j/Q==
X-Google-Smtp-Source: AKy350YWKcU5Tz0vDx13KeDsTJuXEcbEEysoKSFRGlDMpHfxoiSVpaPxA8XEoRCVcz3K1tRN6s+6Sg==
X-Received: by 2002:aa7:95a4:0:b0:626:dc8:b004 with SMTP id a4-20020aa795a4000000b006260dc8b004mr19577552pfk.26.1680098536504;
        Wed, 29 Mar 2023 07:02:16 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:16 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 1/5] cachefiles: introduce object ondemand state
Date:   Wed, 29 Mar 2023 22:01:51 +0800
Message-Id: <20230329140155.53272-2-zhujia.zj@bytedance.com>
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

Previously, @ondemand_id field was used not only to identify ondemand
state of the object, but also to represent the index of the xarray.
This commit introduces @state field to decouple the role of @ondemand_id
and adds helpers to access it.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/internal.h | 21 +++++++++++++++++++++
 fs/cachefiles/ondemand.c | 21 +++++++++------------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c4652084..00beedeaec183 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -44,6 +44,11 @@ struct cachefiles_volume {
 	struct dentry			*fanout[256];	/* Fanout subdirs */
 };
 
+enum cachefiles_object_state {
+	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
+	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
+};
+
 /*
  * Backing file state.
  */
@@ -62,6 +67,7 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	int				ondemand_id;
+	enum cachefiles_object_state	state;
 #endif
 };
 
@@ -296,6 +302,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
+CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68ce..90456b8a4b3e0 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -15,6 +15,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 
 	xa_lock(&cache->reqs);
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	cachefiles_ondemand_set_object_close(object);
 
 	/*
 	 * Flush all pending READ requests since their completion depends on
@@ -176,6 +177,8 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
+	cachefiles_ondemand_set_object_open(req->object);
+
 out:
 	complete(&req->done);
 	return ret;
@@ -363,7 +366,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+		if (opcode != CACHEFILES_OP_OPEN &&
+			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
@@ -430,18 +434,11 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
-	/*
-	 * It's possible that object id is still 0 if the cookie looking up
-	 * phase failed before OPEN request has ever been sent. Also avoid
-	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
-	 * anon_fd has already been closed.
-	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
+	req->msg.object_id = object->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -460,7 +457,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	int object_id = object->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
+	if (!cachefiles_ondemand_object_is_open(object)) {
 		WARN_ON_ONCE(object_id == 0);
 		pr_info_once("READ: anonymous fd closed prematurely.\n");
 		return -EIO;
@@ -485,7 +482,7 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
-- 
2.20.1

