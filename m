Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3AB64C266
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiLNCwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiLNCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6217A8D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670986286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvXYXT7+pZNjN3bsp9+0AEDOU4OMWFYmE3SAXAaEld0=;
        b=JbmO1LSzu+tuhIo6GXcle8PSPwzWYI4jx7oGBCJWKpgLiv+0a1/L5R7FweGmLTJhsdJlpI
        OrYIV3LU+QbiwRY9nit1vw2kqUaN7WkfXGnut4H28ejtC8R/HB9mNJRuNskvaxX8O0URkm
        NLeebrY0RbHh5pEOlpXmJ/JaWhvM69w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-pa7vWdvINQiKRuTjDpGF-w-1; Tue, 13 Dec 2022 21:51:22 -0500
X-MC-Unique: pa7vWdvINQiKRuTjDpGF-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 327A0806002;
        Wed, 14 Dec 2022 02:51:22 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA9A492B00;
        Wed, 14 Dec 2022 02:51:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] lib/percpu-refcount: support to exit refcount automatically during releasing
Date:   Wed, 14 Dec 2022 10:50:59 +0800
Message-Id: <20221214025101.1268437-2-ming.lei@redhat.com>
In-Reply-To: <20221214025101.1268437-1-ming.lei@redhat.com>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only have two users in which percpu_ref_exit() is called from
->release().

Add flag of PERCPU_REF_AUTO_EXIT for avoiding to call percpu_ref_exit()
from ->release() directly since we need to drain ->release() in
percpu_ref_exit() for fixing use-after-free.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/percpu-refcount.h | 21 +++++++++++++++++++--
 lib/percpu-refcount.c           |  9 ++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..006c6aae261e 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -90,6 +90,11 @@ enum {
 	 * Allow switching from atomic mode to percpu mode.
 	 */
 	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
+
+	/*
+	 * call percpu_ref_exit() when releasing
+	 */
+	PERCPU_REF_AUTO_EXIT	= 1 << 3,
 };
 
 struct percpu_ref_data {
@@ -98,6 +103,7 @@ struct percpu_ref_data {
 	percpu_ref_func_t	*confirm_switch;
 	bool			force_atomic:1;
 	bool			allow_reinit:1;
+	bool			auto_exit:1;
 	struct rcu_head		rcu;
 	struct percpu_ref	*ref;
 };
@@ -331,8 +337,19 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
-		ref->data->release(ref);
+	else {
+		struct percpu_ref_data *data = ref->data;
+		struct percpu_ref copy = *ref;
+		bool release = false;
+
+		if (unlikely(atomic_long_sub_and_test(nr, &data->count))) {
+			data->release(ref);
+			release = true;
+		}
+
+		if (release && data->auto_exit)
+			percpu_ref_exit(&copy);
+	}
 
 	rcu_read_unlock();
 }
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 668f6aa6a75d..c0cadf92948f 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -82,6 +82,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 
 	data->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
 	data->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
+	data->auto_exit = flags & PERCPU_REF_AUTO_EXIT;
 
 	if (flags & (PERCPU_REF_INIT_ATOMIC | PERCPU_REF_INIT_DEAD)) {
 		ref->percpu_count_ptr |= __PERCPU_REF_ATOMIC;
@@ -123,9 +124,11 @@ static void __percpu_ref_exit(struct percpu_ref *ref)
  *
  * This function exits @ref.  The caller is responsible for ensuring that
  * @ref is no longer in active use.  The usual places to invoke this
- * function from are the @ref->release() callback or in init failure path
- * where percpu_ref_init() succeeded but other parts of the initialization
- * of the embedding object failed.
+ * function from are where the refcounter is confirmed as idle or in init
+ * failure path where percpu_ref_init() succeeded but other parts of the
+ * initialization of the embedding object failed. For caller which needs
+ * to call percpu_ref_exit() in ->release, please pass PERCPU_REF_AUTO_EXIT
+ * to percpu_ref_init().
  */
 void percpu_ref_exit(struct percpu_ref *ref)
 {
-- 
2.38.1

