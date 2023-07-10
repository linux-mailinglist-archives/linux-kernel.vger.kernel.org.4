Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256074D41F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGJLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjGJLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:03:00 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B98FE5;
        Mon, 10 Jul 2023 04:02:55 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANPrb019779;
        Mon, 10 Jul 2023 05:23:25 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANP88019777;
        Mon, 10 Jul 2023 05:23:25 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 08/13] Add namespace implementation.
Date:   Mon, 10 Jul 2023 05:23:14 -0500
Message-Id: <20230710102319.19716-9-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSEM implements a security modeling namespace that allows
security models to be implemented that are independent of other
security modeling namespaces.  This allows multiple security
models and modes of modeling (external vs. internal) to be
implemented.  A security modeling namespace is conceptually
similar to other resource namespaces implemented in the kernel

The TSEM control plane is used to cause a process to leave the
root security modeling namespace and institute a new subordinate
modeling namespace.  Additional processes that fork from this
process inherit the the characteristics of the security modeling
namespace.

Each modeling namespace has a unique numeric identifier that is
implemented as an incremented unsigned 64 bit value in order to
preclude overflow.  The id value of 0 is reserved for the root
security modeling namespace.

Each security modeling namespace is designated as either
internally or externally modeled.  An internally modeled namespace
has its security model implemented by a Trusted Modeling Agent
(TMA) implementation that is run in the context of the kernel.

Externally modeled namespaces have a description of the security
event exported to a trust orchestrator running in userspace.
That trust orchestrator has an associated Trusted Modeling Agent
running in a context that implements the root of trust for the
security namespace.

A process that exports a security event description is scheduled
away into an interruptible sleep state.  The trust orchestrator
that created the external modeling namespace is responsible for
using the TSEM control plane to wake the process up and set the
trust status of the process to be trusted or untrusted.  Only
processes that carries the CAP_ML capability can wake up a
process and set its trust status.

An init function is surfaced from this file that is called by the
TSEM initialization function.  This function is responsible for
creating a workqueue that will handle asynchronous release of
resources that were allocated for a modeling domain, including
the release of the pseudo-file that was created for exporting
domain events.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/namespace.c | 347 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 347 insertions(+)
 create mode 100644 security/tsem/namespace.c

diff --git a/security/tsem/namespace.c b/security/tsem/namespace.c
new file mode 100644
index 000000000000..ba2e8f550838
--- /dev/null
+++ b/security/tsem/namespace.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2023 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file implements TSEM namespaces.
+ */
+
+#include "tsem.h"
+
+static u64 context_id;
+
+struct context_key {
+	struct list_head list;
+	u64 context_id;
+	u8 key[HASH_MAX_DIGESTSIZE];
+};
+
+DEFINE_MUTEX(context_id_mutex);
+LIST_HEAD(context_id_list);
+
+static void remove_task_key(u64 context_id)
+{
+	struct context_key *entry, *tmp_entry;
+
+	list_for_each_entry_safe(entry, tmp_entry, &context_id_list, list) {
+		if (context_id == entry->context_id) {
+			list_del(&entry->list);
+			kfree(entry);
+			break;
+		}
+	}
+}
+
+static int generate_task_key(const char *keystr, u64 context_id,
+			     struct tsem_task *t_ttask,
+			     struct tsem_task *p_ttask)
+{
+	int retn;
+	bool found_key, valid_key = false;
+	unsigned int size = tsem_digestsize();
+	struct context_key *entry;
+
+	while (!valid_key) {
+		get_random_bytes(t_ttask->task_key, size);
+		retn = tsem_ns_event_key(t_ttask->task_key, keystr,
+					 p_ttask->task_key);
+		if (retn)
+			goto done;
+
+		if (list_empty(&context_id_list))
+			break;
+
+		found_key = false;
+		list_for_each_entry(entry, &context_id_list, list) {
+			if (memcmp(entry->key, p_ttask->task_key, size) == 0)
+				found_key = true;
+		}
+		if (!found_key)
+			valid_key = true;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	entry->context_id = context_id;
+	memcpy(entry->key, p_ttask->task_key, size);
+	list_add_tail(&entry->list, &context_id_list);
+	retn = 0;
+
+ done:
+	return retn;
+}
+
+static struct tsem_external *allocate_external(u64 context_id,
+					       const char *keystr)
+{
+	int retn = -ENOMEM;
+	char bufr[20 + 1];
+	struct tsem_external *external;
+	struct tsem_task *t_ttask = tsem_task(current);
+	struct tsem_task *p_ttask = tsem_task(current->real_parent);
+
+	external = kzalloc(sizeof(*external), GFP_KERNEL);
+	if (!external)
+		goto done;
+
+	retn = generate_task_key(keystr, context_id, t_ttask, p_ttask);
+	if (retn)
+		goto done;
+
+	spin_lock_init(&external->export_lock);
+	INIT_LIST_HEAD(&external->export_list);
+
+	init_waitqueue_head(&external->wq);
+
+	scnprintf(bufr, sizeof(bufr), "%llu", context_id);
+	external->dentry = tsem_fs_create_external(bufr);
+	if (IS_ERR(external->dentry)) {
+		retn = PTR_ERR(external->dentry);
+		external->dentry = NULL;
+	} else
+		retn = 0;
+
+ done:
+	if (retn) {
+		memset(t_ttask->task_key, '\0', tsem_digestsize());
+		memset(p_ttask->task_key, '\0', tsem_digestsize());
+		kfree(external);
+		remove_task_key(context_id);
+		external = ERR_PTR(retn);
+	} else
+		p_ttask->tma_for_ns = context_id;
+
+	return external;
+}
+
+static void wq_put(struct work_struct *work)
+{
+	struct tsem_context *ctx;
+
+	ctx = container_of(work, struct tsem_context, work);
+
+	if (ctx->external) {
+		mutex_lock(&context_id_mutex);
+		remove_task_key(ctx->id);
+		mutex_unlock(&context_id_mutex);
+
+		securityfs_remove(ctx->external->dentry);
+		tsem_export_magazine_free(ctx->external);
+		kfree(ctx->external);
+	} else
+		tsem_model_free(ctx);
+
+	crypto_free_shash(ctx->tfm);
+	tsem_event_magazine_free(ctx);
+	kfree(ctx->digestname);
+	kfree(ctx);
+}
+
+static void ns_free(struct kref *kref)
+{
+	struct tsem_context *ctx;
+
+	ctx = container_of(kref, struct tsem_context, kref);
+
+	INIT_WORK(&ctx->work, wq_put);
+	if (!queue_work(system_wq, &ctx->work))
+		WARN_ON_ONCE(1);
+}
+
+/**
+ * tsem_ns_put() - Release a reference to a modeling context.
+ * @ctx: A pointer to the TMA context for which a reference is
+ *	 to be released.
+ *
+ * This function is called to release a reference to a TMA modeling
+ * domain.  The release of the last reference calls the ns_free()
+ * function that schedules the actual work to release the resources
+ * associated with the namespace to a workqueue.
+ */
+void tsem_ns_put(struct tsem_context *ctx)
+{
+	kref_put(&ctx->kref, ns_free);
+}
+
+/**
+ * tsem_ns_event_key() - Generate TMA authentication key.
+ * @task_key: A pointer to the buffer containing the task identification
+ *	      key that was randomly generated for the modeling domain.
+ * @keystr: A pointer to the buffer containing the TMA authentication key
+ *	    in ASCII hexadecimal form.
+ *
+ * This function generates the authentication key that will be used
+ * to validate a call by a TMA to set the trust status of the process.
+ *
+ * Return: This function returns 0 if the key was properly generated
+ *	   or a negative value if a hashing error occurred.
+ */
+int tsem_ns_event_key(u8 *task_key, const char *keystr, u8 *key)
+{
+	bool retn;
+	u8 tma_key[HASH_MAX_DIGESTSIZE];
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	retn = hex2bin(tma_key, keystr, tsem_digestsize());
+	if (retn)
+		return -EINVAL;
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		return retn;
+
+	retn = crypto_shash_update(shash, task_key, tsem_digestsize());
+	if (retn)
+		return retn;
+
+	return crypto_shash_finup(shash, tma_key, tsem_digestsize(), key);
+}
+
+static struct crypto_shash *configure_digest(const char *digest,
+					     char **digestname,
+					     u8 *zero_digest)
+{
+	int retn;
+	struct crypto_shash *tfm;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	*digestname = kstrdup(digest, GFP_KERNEL);
+	if (!*digestname)
+		return ERR_PTR(-ENOMEM);
+
+	tfm = crypto_alloc_shash(digest, 0, 0);
+	if (IS_ERR(tfm))
+		return tfm;
+
+	shash->tfm = tfm;
+	retn = crypto_shash_digest(shash, NULL, 0, zero_digest);
+	if (retn) {
+		crypto_free_shash(tfm);
+		tfm = NULL;
+	}
+
+	return tfm;
+}
+
+/**
+ * tsem_ns_create() - Create a TSEM modeling namespace.
+ * @type:   The type of namespace being created.
+ * @digest: A null terminated character buffer containing the name
+ *	    of the hash function that is to be used for the modeling
+ *	    domain.
+ * @ns:     The enumeration type that specifies whether the security
+ *	    event descriptions should reference the initial user
+ *	    namespace or the current user namespace.
+ * @key:    A pointer to a null-terminated buffer containing the key
+ *	    that will be used to authenticate the TMA's ability to set
+ *	    the trust status of a process.
+ *
+ * This function is used to create either an internally or externally
+ * modeled TSEM namespace.  The type of the namespace to be created
+ * is specified with the tsem_control_type enumeration value.  A
+ * request for an internally model namespace causes a new structure to be
+ * allocated that will hold the description of the security model.
+ * An externally modeled domain will have a control structure allocated
+ * that manages the export of security event descriptions to the
+ * trust orchestrator that is responsible for running the TMA
+ * implementation.
+ *
+ * Return: This function returns 0 if the namespace was created and
+ *	   a negative error value on error.
+ */
+int tsem_ns_create(const enum tsem_control_type type, const char *digest,
+		   const enum tsem_ns_reference ns, const char *key,
+		   unsigned int cache_size)
+{
+	u8 zero_digest[HASH_MAX_DIGESTSIZE];
+	char *use_digest;
+	int retn = -ENOMEM;
+	u64 new_id;
+	struct tsem_task *tsk = tsem_task(current);
+	struct tsem_context *new_ctx;
+	struct tsem_model *model = NULL;
+	struct crypto_shash *tfm;
+
+	tfm = configure_digest(digest, &use_digest, zero_digest);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	new_ctx = kzalloc(sizeof(*new_ctx), GFP_KERNEL);
+	if (!new_ctx)
+		return retn;
+
+	mutex_lock(&context_id_mutex);
+	new_id = context_id + 1;
+
+	retn = tsem_event_magazine_allocate(new_ctx, cache_size);
+	if (retn)
+		goto done;
+
+	if (type == TSEM_CONTROL_INTERNAL) {
+		model = tsem_model_allocate(cache_size);
+		if (!model)
+			goto done;
+		new_ctx->model = model;
+	}
+	if (type == TSEM_CONTROL_EXTERNAL) {
+		if (crypto_shash_digestsize(tfm)*2 != strlen(key)) {
+			retn = -EINVAL;
+			goto done;
+		}
+
+		new_ctx->external = allocate_external(new_id, key);
+		if (IS_ERR(new_ctx->external)) {
+			retn = PTR_ERR(new_ctx->external);
+			new_ctx->external = NULL;
+			goto done;
+		}
+
+		retn = tsem_export_magazine_allocate(new_ctx->external,
+						     cache_size);
+		if (retn)
+			goto done;
+	}
+
+	kref_init(&new_ctx->kref);
+
+	new_ctx->id = new_id;
+	new_ctx->tfm = tfm;
+	new_ctx->digestname = use_digest;
+	memcpy(new_ctx->zero_digest, zero_digest,
+	       crypto_shash_digestsize(tfm));
+
+	if (ns == TSEM_NS_CURRENT)
+		new_ctx->use_current_ns = true;
+	memcpy(new_ctx->actions, tsk->context->actions,
+	       sizeof(new_ctx->actions));
+	retn = 0;
+
+ done:
+	if (retn) {
+		remove_task_key(new_id);
+		crypto_free_shash(tfm);
+		tsem_event_magazine_free(new_ctx);
+		kfree(use_digest);
+		if (new_ctx->external)
+			tsem_export_magazine_free(new_ctx->external);
+		kfree(new_ctx->external);
+		kfree(new_ctx);
+		kfree(model);
+	} else {
+		context_id = new_id;
+		tsk->context = new_ctx;
+		if (type == TSEM_CONTROL_EXTERNAL)
+			retn = tsem_export_aggregate();
+		else
+			retn = tsem_model_add_aggregate();
+	}
+
+	mutex_unlock(&context_id_mutex);
+	return retn;
+}
-- 
2.39.1

