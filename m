Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730C7506CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjGLLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjGLLsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:48:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96A2119;
        Wed, 12 Jul 2023 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162466; x=1720698466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jIekYEv/mCaiq571PcVklUhND7deBIECiGN863EZEiE=;
  b=ZIb1QP9gKqnWRQmsjQzelDAt3T+oy2CPTNKpY1ttNdJKwLtpkBBL5J+0
   zSUtp1n2VPalVhxowIAdXqKAQKl3PNHREoaP7WAPAuNFTL3c6upfZM5K7
   C7pXh2xdolyw4GLvm+kXv73ADiqOv9xLD7SSMJnM2zHNc7DlJOkKFNpRw
   I39acaFUmm96WmqpNGej1ivNGqmZapIEjzahZSTLM/tEenJVznedkN+P+
   x40VwlmLfMuuj8oTC19kuBtFmyUHSzh4Tm+DLPvy5khI9/GinJerTeySI
   nc8rjRkcE1cmpw715HeM/KNHglnl+6axiAtP4bjVRq6syLds7qtpb1rgU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469057"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094028"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094028"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:16 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 01/17] drm/i915: Add ability for tracking buffer objects per client
Date:   Wed, 12 Jul 2023 12:45:49 +0100
Message-Id: <20230712114605.519432-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

In order to show per client memory usage lets add some infrastructure
which enables tracking buffer objects owned by clients.

We add a per client list protected by a new per client lock and to support
delayed destruction (post client exit) we make tracked objects hold
references to the owning client.

Also, object memory region teardown is moved to the existing RCU free
callback to allow safe dereference from the fdinfo RCU read section.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c    | 13 +++++--
 .../gpu/drm/i915/gem/i915_gem_object_types.h  | 12 +++++++
 drivers/gpu/drm/i915/i915_drm_client.c        | 36 +++++++++++++++++++
 drivers/gpu/drm/i915/i915_drm_client.h        | 32 +++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 97ac6fb37958..3dc4fbb67d2b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -105,6 +105,10 @@ void i915_gem_object_init(struct drm_i915_gem_object *obj,
 
 	INIT_LIST_HEAD(&obj->mm.link);
 
+#ifdef CONFIG_PROC_FS
+	INIT_LIST_HEAD(&obj->client_link);
+#endif
+
 	INIT_LIST_HEAD(&obj->lut_list);
 	spin_lock_init(&obj->lut_lock);
 
@@ -292,6 +296,10 @@ void __i915_gem_free_object_rcu(struct rcu_head *head)
 		container_of(head, typeof(*obj), rcu);
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 
+	/* We need to keep this alive for RCU read access from fdinfo. */
+	if (obj->mm.n_placements > 1)
+		kfree(obj->mm.placements);
+
 	i915_gem_object_free(obj);
 
 	GEM_BUG_ON(!atomic_read(&i915->mm.free_count));
@@ -388,9 +396,6 @@ void __i915_gem_free_object(struct drm_i915_gem_object *obj)
 	if (obj->ops->release)
 		obj->ops->release(obj);
 
-	if (obj->mm.n_placements > 1)
-		kfree(obj->mm.placements);
-
 	if (obj->shares_resv_from)
 		i915_vm_resv_put(obj->shares_resv_from);
 
@@ -441,6 +446,8 @@ static void i915_gem_free_object(struct drm_gem_object *gem_obj)
 
 	GEM_BUG_ON(i915_gem_object_is_framebuffer(obj));
 
+	i915_drm_client_remove_object(obj);
+
 	/*
 	 * Before we free the object, make sure any pure RCU-only
 	 * read-side critical sections are complete, e.g.
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index e72c57716bee..8de2b91b3edf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -300,6 +300,18 @@ struct drm_i915_gem_object {
 	 */
 	struct i915_address_space *shares_resv_from;
 
+#ifdef CONFIG_PROC_FS
+	/**
+	 * @client: @i915_drm_client which created the object
+	 */
+	struct i915_drm_client *client;
+
+	/**
+	 * @client_link: Link into @i915_drm_client.objects_list
+	 */
+	struct list_head client_link;
+#endif
+
 	union {
 		struct rcu_head rcu;
 		struct llist_node freed;
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index 2a44b3876cb5..2e5e69edc0f9 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -28,6 +28,10 @@ struct i915_drm_client *i915_drm_client_alloc(void)
 	kref_init(&client->kref);
 	spin_lock_init(&client->ctx_lock);
 	INIT_LIST_HEAD(&client->ctx_list);
+#ifdef CONFIG_PROC_FS
+	spin_lock_init(&client->objects_lock);
+	INIT_LIST_HEAD(&client->objects_list);
+#endif
 
 	return client;
 }
@@ -108,4 +112,36 @@ void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
 	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
 		show_client_class(p, i915, file_priv->client, i);
 }
+
+void i915_drm_client_add_object(struct i915_drm_client *client,
+				struct drm_i915_gem_object *obj)
+{
+	unsigned long flags;
+
+	GEM_WARN_ON(obj->client);
+	GEM_WARN_ON(!list_empty(&obj->client_link));
+
+	spin_lock_irqsave(&client->objects_lock, flags);
+	obj->client = i915_drm_client_get(client);
+	list_add_tail_rcu(&obj->client_link, &client->objects_list);
+	spin_unlock_irqrestore(&client->objects_lock, flags);
+}
+
+bool i915_drm_client_remove_object(struct drm_i915_gem_object *obj)
+{
+	struct i915_drm_client *client = fetch_and_zero(&obj->client);
+	unsigned long flags;
+
+	/* Object may not be associated with a client. */
+	if (!client)
+		return false;
+
+	spin_lock_irqsave(&client->objects_lock, flags);
+	list_del_rcu(&obj->client_link);
+	spin_unlock_irqrestore(&client->objects_lock, flags);
+
+	i915_drm_client_put(client);
+
+	return true;
+}
 #endif
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 67816c912bca..5f58fdf7dcb8 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -12,6 +12,9 @@
 
 #include <uapi/drm/i915_drm.h>
 
+#include "i915_file_private.h"
+#include "gem/i915_gem_object_types.h"
+
 #define I915_LAST_UABI_ENGINE_CLASS I915_ENGINE_CLASS_COMPUTE
 
 struct drm_file;
@@ -25,6 +28,20 @@ struct i915_drm_client {
 	spinlock_t ctx_lock; /* For add/remove from ctx_list. */
 	struct list_head ctx_list; /* List of contexts belonging to client. */
 
+#ifdef CONFIG_PROC_FS
+	/**
+	 * @objects_lock: lock protecting @objects_list
+	 */
+	spinlock_t objects_lock;
+
+	/**
+	 * @objects_list: list of objects created by this client
+	 *
+	 * Protected by @objects_lock.
+	 */
+	struct list_head objects_list;
+#endif
+
 	/**
 	 * @past_runtime: Accumulation of pphwsp runtimes from closed contexts.
 	 */
@@ -49,4 +66,19 @@ struct i915_drm_client *i915_drm_client_alloc(void);
 
 void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
 
+#ifdef CONFIG_PROC_FS
+void i915_drm_client_add_object(struct i915_drm_client *client,
+				struct drm_i915_gem_object *obj);
+bool i915_drm_client_remove_object(struct drm_i915_gem_object *obj);
+#else
+static inline void i915_drm_client_add_object(struct i915_drm_client *client,
+					      struct drm_i915_gem_object *obj)
+{
+}
+
+static inline bool i915_drm_client_remove_object(struct drm_i915_gem_object *obj)
+{
+}
+#endif
+
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.39.2

