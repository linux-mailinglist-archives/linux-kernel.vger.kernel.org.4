Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4456C339E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCUOEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCUOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9021974
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p34so4617552wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykroFktY9fNmY/87dXJCl889ZnSkfkqipjmmGP7vOgc=;
        b=VykILIRu+PxytE834wAk3AmXUwDqBI+8+wJpR9J4VMKMjyGeevk4UN9dUippTv2V+R
         T/q6QCPA8DA1GVguLN3nDIBaZpr0tLIn+wKdwVcJj6d0CsEtq1rfD1B2DogWq5SmdAev
         Qkp2brdHH0Bzy6m62qYGv0GQona9qOeoAf8/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykroFktY9fNmY/87dXJCl889ZnSkfkqipjmmGP7vOgc=;
        b=7EnecRHbaJLadE6jKMGRfAe0FIWjhO6qDlV08mbR0icaLX4Q3rdPkhtcWYSTbUFS0M
         Ghjn/DyPpO6QIUxZr/oJ5pFFtPs+Zz00i3spufhcJ6U4UwFooqrKi0EleDPMjk6hhd43
         js3Jd6Zy53jxv7lTCnOfa+cUN80r5HtNNRBjQOV8sFN3YOyI4G7bk5kxNSicgGeWjz8K
         +aRMyUF79T+koCXFgvO6sdxmMnpXBZVZH6sWj+Tp+iUHImHfCll+66wbZwmgCHuC0upz
         zW5aai8yVJBsev4mPVfw1ocGDMq5A/JXvqzmnPrO5ACqC/x2K3DdgPi9J+BBmw+hP7d1
         s9dw==
X-Gm-Message-State: AO0yUKWTf0+NC8sgiWuS6XVx3u3dc7KX/ljowpW/vemLjmOEAiTbqJxX
        xfcQysiOidRe+afBWuA6EYV1LH8uIcJz+LOPoFY=
X-Google-Smtp-Source: AK7set/l4atxTFuR6+OMHjrTy8DlJp75cZIGxKw1iuLBk07gOwJqlxt3az85e+mf8msegGMjWk9wBg==
X-Received: by 2002:a05:600c:1c1a:b0:3e1:e149:b67b with SMTP id j26-20020a05600c1c1a00b003e1e149b67bmr12660322wms.18.1679407478878;
        Tue, 21 Mar 2023 07:04:38 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:38 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 3/7] ftrace: Remove the legacy _ftrace_direct API
Date:   Tue, 21 Mar 2023 15:04:20 +0100
Message-Id: <20230321140424.345218-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This API relies on a single global ops, used for all direct calls
registered with it. However, to implement arm64 direct calls, we need
each ops to point to a single direct call trampoline.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/ftrace.h |  32 ----
 kernel/trace/ftrace.c  | 393 -----------------------------------------
 2 files changed, 425 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 5b68ee874bc1..2f400c9f0787 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -397,14 +397,6 @@ struct ftrace_func_entry {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 extern int ftrace_direct_func_count;
-int register_ftrace_direct(unsigned long ip, unsigned long addr);
-int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
-int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
-struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
-int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-				struct dyn_ftrace *rec,
-				unsigned long old_addr,
-				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
@@ -415,30 +407,6 @@ int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
-static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	return -ENOTSUPP;
-}
-static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	return -ENOTSUPP;
-}
-static inline int modify_ftrace_direct(unsigned long ip,
-				       unsigned long old_addr, unsigned long new_addr)
-{
-	return -ENOTSUPP;
-}
-static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
-{
-	return NULL;
-}
-static inline int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-					      struct dyn_ftrace *rec,
-					      unsigned long old_addr,
-					      unsigned long new_addr)
-{
-	return -ENODEV;
-}
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fa379cf91fdb..fca478396d31 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2590,20 +2590,6 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
-
-struct ftrace_ops direct_ops = {
-	.func		= call_direct_funcs,
-	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
-			  | FTRACE_OPS_FL_PERMANENT,
-	/*
-	 * By declaring the main trampoline as this trampoline
-	 * it will never have one allocated for it. Allocated
-	 * trampolines should not call direct functions.
-	 * The direct_ops should only be called by the builtin
-	 * ftrace_regs_caller trampoline.
-	 */
-	.trampoline	= FTRACE_REGS_ADDR,
-};
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
@@ -5300,387 +5286,8 @@ struct ftrace_direct_func {
 
 static LIST_HEAD(ftrace_direct_funcs);
 
-/**
- * ftrace_find_direct_func - test an address if it is a registered direct caller
- * @addr: The address of a registered direct caller
- *
- * This searches to see if a ftrace direct caller has been registered
- * at a specific address, and if so, it returns a descriptor for it.
- *
- * This can be used by architecture code to see if an address is
- * a direct caller (trampoline) attached to a fentry/mcount location.
- * This is useful for the function_graph tracer, as it may need to
- * do adjustments if it traced a location that also has a direct
- * trampoline attached to it.
- */
-struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
-{
-	struct ftrace_direct_func *entry;
-	bool found = false;
-
-	/* May be called by fgraph trampoline (protected by rcu tasks) */
-	list_for_each_entry_rcu(entry, &ftrace_direct_funcs, next) {
-		if (entry->addr == addr) {
-			found = true;
-			break;
-		}
-	}
-	if (found)
-		return entry;
-
-	return NULL;
-}
-
-static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-
-	direct = kmalloc(sizeof(*direct), GFP_KERNEL);
-	if (!direct)
-		return NULL;
-	direct->addr = addr;
-	direct->count = 0;
-	list_add_rcu(&direct->next, &ftrace_direct_funcs);
-	ftrace_direct_func_count++;
-	return direct;
-}
-
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-/**
- * register_ftrace_direct - Call a custom trampoline directly
- * @ip: The address of the nop at the beginning of a function
- * @addr: The address of the trampoline to call at @ip
- *
- * This is used to connect a direct call from the nop location (@ip)
- * at the start of ftrace traced functions. The location that it calls
- * (@addr) must be able to handle a direct call, and save the parameters
- * of the function being traced, and restore them (or inject new ones
- * if needed), before returning.
- *
- * Returns:
- *  0 on success
- *  -EBUSY - Another direct function is already attached (there can be only one)
- *  -ENODEV - @ip does not point to a ftrace nop location (or not supported)
- *  -ENOMEM - There was an allocation failure.
- */
-int register_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-	struct ftrace_func_entry *entry;
-	struct ftrace_hash *free_hash = NULL;
-	struct dyn_ftrace *rec;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	/* See if there's a direct function at @ip already */
-	ret = -EBUSY;
-	if (ftrace_find_rec_direct(ip))
-		goto out_unlock;
-
-	ret = -ENODEV;
-	rec = lookup_rec(ip, ip);
-	if (!rec)
-		goto out_unlock;
-
-	/*
-	 * Check if the rec says it has a direct call but we didn't
-	 * find one earlier?
-	 */
-	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
-		goto out_unlock;
-
-	/* Make sure the ip points to the exact record */
-	if (ip != rec->ip) {
-		ip = rec->ip;
-		/* Need to check this ip for a direct. */
-		if (ftrace_find_rec_direct(ip))
-			goto out_unlock;
-	}
-
-	ret = -ENOMEM;
-	direct = ftrace_find_direct_func(addr);
-	if (!direct) {
-		direct = ftrace_alloc_direct_func(addr);
-		if (!direct)
-			goto out_unlock;
-	}
-
-	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
-	if (!entry)
-		goto out_unlock;
-
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
-
-	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
-		ret = register_ftrace_function_nolock(&direct_ops);
-		if (ret)
-			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-	}
-
-	if (ret) {
-		remove_hash_entry(direct_functions, entry);
-		kfree(entry);
-		if (!direct->count) {
-			list_del_rcu(&direct->next);
-			synchronize_rcu_tasks();
-			kfree(direct);
-			if (free_hash)
-				free_ftrace_hash(free_hash);
-			free_hash = NULL;
-			ftrace_direct_func_count--;
-		}
-	} else {
-		direct->count++;
-	}
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
-	if (free_hash) {
-		synchronize_rcu_tasks();
-		free_ftrace_hash(free_hash);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_ftrace_direct);
-
-static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
-						   struct dyn_ftrace **recp)
-{
-	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
-
-	rec = lookup_rec(*ip, *ip);
-	if (!rec)
-		return NULL;
-
-	entry = __ftrace_lookup_ip(direct_functions, rec->ip);
-	if (!entry) {
-		WARN_ON(rec->flags & FTRACE_FL_DIRECT);
-		return NULL;
-	}
-
-	WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
-
-	/* Passed in ip just needs to be on the call site */
-	*ip = rec->ip;
-
-	if (recp)
-		*recp = rec;
-
-	return entry;
-}
-
-int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-	struct ftrace_func_entry *entry;
-	struct ftrace_hash *hash;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, NULL);
-	if (!entry)
-		goto out_unlock;
-
-	hash = direct_ops.func_hash->filter_hash;
-	if (hash->count == 1)
-		unregister_ftrace_function(&direct_ops);
-
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-
-	WARN_ON(ret);
-
-	remove_hash_entry(direct_functions, entry);
-
-	direct = ftrace_find_direct_func(addr);
-	if (!WARN_ON(!direct)) {
-		/* This is the good path (see the ! before WARN) */
-		direct->count--;
-		WARN_ON(direct->count < 0);
-		if (!direct->count) {
-			list_del_rcu(&direct->next);
-			synchronize_rcu_tasks();
-			kfree(direct);
-			kfree(entry);
-			ftrace_direct_func_count--;
-		}
-	}
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
-
-static struct ftrace_ops stub_ops = {
-	.func		= ftrace_stub,
-};
-
-/**
- * ftrace_modify_direct_caller - modify ftrace nop directly
- * @entry: The ftrace hash entry of the direct helper for @rec
- * @rec: The record representing the function site to patch
- * @old_addr: The location that the site at @rec->ip currently calls
- * @new_addr: The location that the site at @rec->ip should call
- *
- * An architecture may overwrite this function to optimize the
- * changing of the direct callback on an ftrace nop location.
- * This is called with the ftrace_lock mutex held, and no other
- * ftrace callbacks are on the associated record (@rec). Thus,
- * it is safe to modify the ftrace record, where it should be
- * currently calling @old_addr directly, to call @new_addr.
- *
- * This is called with direct_mutex locked.
- *
- * Safety checks should be made to make sure that the code at
- * @rec->ip is currently calling @old_addr. And this must
- * also update entry->direct to @new_addr.
- */
-int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-				       struct dyn_ftrace *rec,
-				       unsigned long old_addr,
-				       unsigned long new_addr)
-{
-	unsigned long ip = rec->ip;
-	int ret;
-
-	lockdep_assert_held(&direct_mutex);
-
-	/*
-	 * The ftrace_lock was used to determine if the record
-	 * had more than one registered user to it. If it did,
-	 * we needed to prevent that from changing to do the quick
-	 * switch. But if it did not (only a direct caller was attached)
-	 * then this function is called. But this function can deal
-	 * with attached callers to the rec that we care about, and
-	 * since this function uses standard ftrace calls that take
-	 * the ftrace_lock mutex, we need to release it.
-	 */
-	mutex_unlock(&ftrace_lock);
-
-	/*
-	 * By setting a stub function at the same address, we force
-	 * the code to call the iterator and the direct_ops helper.
-	 * This means that @ip does not call the direct call, and
-	 * we can simply modify it.
-	 */
-	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
-	if (ret)
-		goto out_lock;
-
-	ret = register_ftrace_function_nolock(&stub_ops);
-	if (ret) {
-		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-		goto out_lock;
-	}
-
-	entry->direct = new_addr;
-
-	/*
-	 * By removing the stub, we put back the direct call, calling
-	 * the @new_addr.
-	 */
-	unregister_ftrace_function(&stub_ops);
-	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-
- out_lock:
-	mutex_lock(&ftrace_lock);
-
-	return ret;
-}
-
-/**
- * modify_ftrace_direct - Modify an existing direct call to call something else
- * @ip: The instruction pointer to modify
- * @old_addr: The address that the current @ip calls directly
- * @new_addr: The address that the @ip should call
- *
- * This modifies a ftrace direct caller at an instruction pointer without
- * having to disable it first. The direct call will switch over to the
- * @new_addr without missing anything.
- *
- * Returns: zero on success. Non zero on error, which includes:
- *  -ENODEV : the @ip given has no direct caller attached
- *  -EINVAL : the @old_addr does not match the current direct caller
- */
-int modify_ftrace_direct(unsigned long ip,
-			 unsigned long old_addr, unsigned long new_addr)
-{
-	struct ftrace_direct_func *direct, *new_direct = NULL;
-	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	mutex_lock(&ftrace_lock);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, &rec);
-	if (!entry)
-		goto out_unlock;
-
-	ret = -EINVAL;
-	if (entry->direct != old_addr)
-		goto out_unlock;
-
-	direct = ftrace_find_direct_func(old_addr);
-	if (WARN_ON(!direct))
-		goto out_unlock;
-	if (direct->count > 1) {
-		ret = -ENOMEM;
-		new_direct = ftrace_alloc_direct_func(new_addr);
-		if (!new_direct)
-			goto out_unlock;
-		direct->count--;
-		new_direct->count++;
-	} else {
-		direct->addr = new_addr;
-	}
-
-	/*
-	 * If there's no other ftrace callback on the rec->ip location,
-	 * then it can be changed directly by the architecture.
-	 * If there is another caller, then we just need to change the
-	 * direct caller helper to point to @new_addr.
-	 */
-	if (ftrace_rec_count(rec) == 1) {
-		ret = ftrace_modify_direct_caller(entry, rec, old_addr, new_addr);
-	} else {
-		entry->direct = new_addr;
-		ret = 0;
-	}
-
-	if (unlikely(ret && new_direct)) {
-		direct->count++;
-		list_del_rcu(&new_direct->next);
-		synchronize_rcu_tasks();
-		kfree(new_direct);
-		ftrace_direct_func_count--;
-	}
-
- out_unlock:
-	mutex_unlock(&ftrace_lock);
-	mutex_unlock(&direct_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(modify_ftrace_direct);
-
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
-- 
2.40.0.rc2.332.ga46443480c-goog

