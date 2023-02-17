Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8369A2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjBQAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:08:16 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247AC33446;
        Thu, 16 Feb 2023 16:08:15 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 274923F2FE;
        Fri, 17 Feb 2023 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676592493;
        bh=p3JVtjx8dt3W0Q/dpd/SmnqOoJaOmvUOKPFg8yElruU=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
         In-Reply-To:Content-Type;
        b=rH9PWZ/Owu/OXnl5Dun4c7nD2nsnIqv+GXb8iqpG+HF4+fKEgCv0LKt8z6JKdHNZ0
         XNnZxc+dGDE9raz2bSLU0djYC47vJDCrQm2D2Vt6XWQuy/h2EjNJggD+bIId6HNof3
         f3Iz7VsIkOFpwOcgebQxdBZLrD4lPxLSCsyzcMFdq/2yrdzTeBtwk7GluUrB5QXtUS
         kYmcKK1bN4AnmPSuWpTz0Akh4X3SI4ySijXkOAm2BiHtQ2mXjo1KSZqd/9dS9jU64o
         hvzKVazm9OoeX23+HtAQegJ8R9upfYlA+YyIRHSKfWeGzHFJuZVP3uEIOo24PmzMcC
         Omd/IwAXIWIjQ==
Message-ID: <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
Date:   Thu, 16 Feb 2023 16:08:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   John Johansen <john.johansen@canonical.com>
Subject: [PATCH v3] apparmor: global buffers spin lock may get contended
To:     LKLM <linux-kernel@vger.kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org,
        Anil Altinay <aaltinay@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
Content-Language: en-US
Organization: Canonical
In-Reply-To: <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From f44dee132b0b55386b7ea31e68c80d367b073ee0 Mon Sep 17 00:00:00 2001
From: John Johansen <john.johansen@canonical.com>
Date: Tue, 25 Oct 2022 01:18:41 -0700
Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock
  contention

On a heavily loaded machine there can be lock contention on the
global buffers lock. Add a percpu list to cache buffers on when
lock contention is encountered.

When allocating buffers attempt to use cached buffers first,
before taking the global buffers lock. When freeing buffers
try to put them back to the global list but if contention is
encountered, put the buffer on the percpu list.

The length of time a buffer is held on the percpu list is dynamically
adjusted based on lock contention.  The amount of hold time is rapidly
increased and slow ramped down.

v3:
- limit number of buffers that can be pushed onto the percpu
   list. This avoids a problem on some kernels where one percpu
   list can inherit buffers from another cpu after a reschedule,
   causing more kernel memory to used than is necessary. Under
   normal conditions this should eventually return to normal
   but under pathelogical conditions the extra memory consumption
   may have been unbouanded
v2:
- dynamically adjust buffer hold time on percpu list based on
   lock contention.
v1:
- cache buffers on percpu list on lock contention

Signed-off-by: John Johansen <john.johansen@canonical.com>
---
  security/apparmor/lsm.c | 81 ++++++++++++++++++++++++++++++++++++++---
  1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 25114735bc11..21f5ea20e715 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -49,12 +49,19 @@ union aa_buffer {
  	char buffer[1];
  };
  
+struct aa_local_cache {
+	unsigned int contention;
+	unsigned int hold;
+	struct list_head head;
+};
+
  #define RESERVE_COUNT 2
  static int reserve_count = RESERVE_COUNT;
  static int buffer_count;
  
  static LIST_HEAD(aa_global_buffers);
  static DEFINE_SPINLOCK(aa_buffers_lock);
+static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
  
  /*
   * LSM hook functions
@@ -1622,14 +1629,44 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
  	return 0;
  }
  
+static void update_contention(struct aa_local_cache *cache)
+{
+	cache->contention += 3;
+	if (cache->contention > 9)
+		cache->contention = 9;
+	cache->hold += 1 << cache->contention;		/* 8, 64, 512 */
+}
+
  char *aa_get_buffer(bool in_atomic)
  {
  	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
  	bool try_again = true;
  	gfp_t flags = (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
  
+	/* use per cpu cached buffers first */
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!list_empty(&cache->head)) {
+		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
+		list_del(&aa_buf->list);
+		cache->hold--;
+		put_cpu_ptr(&aa_local_buffers);
+		return &aa_buf->buffer[0];
+	}
+	put_cpu_ptr(&aa_local_buffers);
+
+	if (!spin_trylock(&aa_buffers_lock)) {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		update_contention(cache);
+		put_cpu_ptr(&aa_local_buffers);
+		spin_lock(&aa_buffers_lock);
+	} else {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		if (cache->contention)
+			cache->contention--;
+		put_cpu_ptr(&aa_local_buffers);
+	}
  retry:
-	spin_lock(&aa_buffers_lock);
  	if (buffer_count > reserve_count ||
  	    (in_atomic && !list_empty(&aa_global_buffers))) {
  		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
@@ -1655,6 +1692,7 @@ char *aa_get_buffer(bool in_atomic)
  	if (!aa_buf) {
  		if (try_again) {
  			try_again = false;
+			spin_lock(&aa_buffers_lock);
  			goto retry;
  		}
  		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
@@ -1666,15 +1704,39 @@ char *aa_get_buffer(bool in_atomic)
  void aa_put_buffer(char *buf)
  {
  	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
  
  	if (!buf)
  		return;
  	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
  
-	spin_lock(&aa_buffers_lock);
-	list_add(&aa_buf->list, &aa_global_buffers);
-	buffer_count++;
-	spin_unlock(&aa_buffers_lock);
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!cache->hold || cache->count >= 2) {
+		put_cpu_ptr(&aa_local_buffers);
+		if (spin_trylock(&aa_buffers_lock)) {
+		locked:
+			list_add(&aa_buf->list, &aa_global_buffers);
+			buffer_count++;
+			spin_unlock(&aa_buffers_lock);
+			cache = get_cpu_ptr(&aa_local_buffers);
+			if (cache->contention)
+				cache->contention--;
+			put_cpu_ptr(&aa_local_buffers);
+			return;
+		}
+		cache = get_cpu_ptr(&aa_local_buffers);
+		update_contention(cache);
+		if (cache->count >= 2) {
+			put_cpu_ptr(&aa_local_buffers);
+			spin_lock(&aa_buffers_lock);
+			/* force putting the buffer to global */
+			goto locked;
+		}
+	}
+
+	/* cache in percpu list */
+	list_add(&aa_buf->list, &cache->head);
+	put_cpu_ptr(&aa_local_buffers);
  }
  
  /*
@@ -1716,6 +1778,15 @@ static int __init alloc_buffers(void)
  	union aa_buffer *aa_buf;
  	int i, num;
  
+	/*
+	 * per cpu set of cached allocated buffers used to help reduce
+	 * lock contention
+	 */
+	for_each_possible_cpu(i) {
+		per_cpu(aa_local_buffers, i).contention = 0;
+		per_cpu(aa_local_buffers, i).hold = 0;
+		INIT_LIST_HEAD(&per_cpu(aa_local_buffers, i).head);
+	}
  	/*
  	 * A function may require two buffers at once. Usually the buffers are
  	 * used for a short period of time and are shared. On UP kernel buffers
-- 
2.34.1

