Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC4636196
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiKWOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiKWOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:23:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3522715
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:23:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B9FA1F8B4;
        Wed, 23 Nov 2022 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669213396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkYuuxe82E2nL0DoU4uOiZuona551nVAHZBpMme8S88=;
        b=JH1NjfeAKELxkNE50nWUQMpw//bOTdBco2EuPYXN9XjqQw01ZlpNEfsaC028lWgrsW89km
        CE+BaxDJm9JVD7U+V2YYAUd/8iOBH7nA792+WxfuW37kycavHyj0Ezoo7Fn0RtWXECg5jE
        AuPMEC/BMN28z3jfn/8NXVs3NQ95+dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669213396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkYuuxe82E2nL0DoU4uOiZuona551nVAHZBpMme8S88=;
        b=dpMBHBX3ivPjCMXkVacbOS3ougIrXzDPfGhuBPgOdmRH0TyIO4a7Q4rjycfMwz0RMWjHlJ
        7i5qFq5AZL0Q6ICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA34A13AE7;
        Wed, 23 Nov 2022 14:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ko6fMNMsfmNIIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 14:23:15 +0000
Message-ID: <0058169a-1659-7ab1-edff-de9ebadcf236@suse.cz>
Date:   Wed, 23 Nov 2022 15:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/12] mm, slab: ignore hardened usercopy parameters when
 disabled
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-2-vbabka@suse.cz>
 <206E0154-63A6-45CF-8E19-BD01B35AEF0B@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <206E0154-63A6-45CF-8E19-BD01B35AEF0B@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/22 22:35, Kees Cook wrote:
> On November 21, 2022 9:11:51 AM PST, Vlastimil Babka <vbabka@suse.cz> wrote:
>>With CONFIG_HARDENED_USERCOPY not enabled, there are no
>>__check_heap_object() checks happening that would use the kmem_cache
>>useroffset and usersize fields. Yet the fields are still initialized,
>>preventing merging of otherwise compatible caches. Thus ignore the
>>values passed to cache creation and leave them zero when
>>CONFIG_HARDENED_USERCOPY is disabled.
>>
>>In a quick virtme boot test, this has reduced the number of caches in
>>/proc/slabinfo from 131 to 111.
>>
>>Cc: Kees Cook <keescook@chromium.org>
>>Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>---
>> mm/slab_common.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>diff --git a/mm/slab_common.c b/mm/slab_common.c
>>index 0042fb2730d1..a8cb5de255fc 100644
>>--- a/mm/slab_common.c
>>+++ b/mm/slab_common.c
>>@@ -317,7 +317,8 @@ kmem_cache_create_usercopy(const char *name,
>> 	flags &= CACHE_CREATE_MASK;
>> 
>> 	/* Fail closed on bad usersize of useroffset values. */
>>-	if (WARN_ON(!usersize && useroffset) ||
>>+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
>>+	    WARN_ON(!usersize && useroffset) ||
>> 	    WARN_ON(size < usersize || size - usersize < useroffset))
>> 		usersize = useroffset = 0;
>> 
>>@@ -640,6 +641,9 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
>> 		align = max(align, size);
>> 	s->align = calculate_alignment(flags, align, size);
>> 
>>+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY))
>>+		useroffset = usersize = 0;
>>+
>> 	s->useroffset = useroffset;
>> 	s->usersize = usersize;
>> 
> 
> "Always non-mergeable" is intentional here, but I do see the argument
> for not doing it under hardened-usercopy.
> 
> That said, if you keep this part, maybe go the full step and ifdef away
> useroffset/usersize's struct member definition and other logic, especially
> for SLUB_TINY benefits, so 2 ulongs are dropped from the cache struct?

Okay, probably won't make much difference in practice, but for consistency...
----8<----
From 3cdb7b6ad16a9d95603b482969fa870f996ac9dc Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 16 Nov 2022 15:56:32 +0100
Subject: [PATCH] mm, slab: ignore hardened usercopy parameters when disabled

With CONFIG_HARDENED_USERCOPY not enabled, there are no
__check_heap_object() checks happening that would use the struct
kmem_cache useroffset and usersize fields. Yet the fields are still
initialized, preventing merging of otherwise compatible caches.

Also the fields contribute to struct kmem_cache size unnecessarily when
unused. Thus #ifdef them out completely when CONFIG_HARDENED_USERCOPY is
disabled.

In a quick virtme boot test, this has reduced the number of caches in
/proc/slabinfo from 131 to 111.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab_def.h | 2 ++
 include/linux/slub_def.h | 2 ++
 mm/slab.h                | 2 --
 mm/slab_common.c         | 9 ++++++++-
 mm/slub.c                | 4 ++++
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index f0ffad6a3365..5834bad8ad78 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -80,8 +80,10 @@ struct kmem_cache {
 	unsigned int *random_seq;
 #endif
 
+#ifdef CONFIG_HARDENED_USERCOPY
 	unsigned int useroffset;	/* Usercopy region offset */
 	unsigned int usersize;		/* Usercopy region size */
+#endif
 
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index f9c68a9dac04..7ed5e455cbf4 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -136,8 +136,10 @@ struct kmem_cache {
 	struct kasan_cache kasan_info;
 #endif
 
+#ifdef CONFIG_HARDENED_USERCOPY
 	unsigned int useroffset;	/* Usercopy region offset */
 	unsigned int usersize;		/* Usercopy region size */
+#endif
 
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
diff --git a/mm/slab.h b/mm/slab.h
index 0202a8c2f0d2..db9a7984e22e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -207,8 +207,6 @@ struct kmem_cache {
 	unsigned int size;	/* The aligned/padded/added on size  */
 	unsigned int align;	/* Alignment as calculated */
 	slab_flags_t flags;	/* Active flags on the slab */
-	unsigned int useroffset;/* Usercopy region offset */
-	unsigned int usersize;	/* Usercopy region size */
 	const char *name;	/* Slab name for sysfs */
 	int refcount;		/* Use counter */
 	void (*ctor)(void *);	/* Called on object slot creation */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0042fb2730d1..4339c839a452 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -143,8 +143,10 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (s->ctor)
 		return 1;
 
+#ifdef CONFIG_HARDENED_USERCOPY
 	if (s->usersize)
 		return 1;
+#endif
 
 	/*
 	 * We may have set a slab to be unmergeable during bootstrap.
@@ -223,8 +225,10 @@ static struct kmem_cache *create_cache(const char *name,
 	s->size = s->object_size = object_size;
 	s->align = align;
 	s->ctor = ctor;
+#ifdef CONFIG_HARDENED_USERCOPY
 	s->useroffset = useroffset;
 	s->usersize = usersize;
+#endif
 
 	err = __kmem_cache_create(s, flags);
 	if (err)
@@ -317,7 +321,8 @@ kmem_cache_create_usercopy(const char *name,
 	flags &= CACHE_CREATE_MASK;
 
 	/* Fail closed on bad usersize of useroffset values. */
-	if (WARN_ON(!usersize && useroffset) ||
+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
+	    WARN_ON(!usersize && useroffset) ||
 	    WARN_ON(size < usersize || size - usersize < useroffset))
 		usersize = useroffset = 0;
 
@@ -640,8 +645,10 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 		align = max(align, size);
 	s->align = calculate_alignment(flags, align, size);
 
+#ifdef CONFIG_HARDENED_USERCOPY
 	s->useroffset = useroffset;
 	s->usersize = usersize;
+#endif
 
 	err = __kmem_cache_create(s, flags);
 
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..e32db8540767 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5502,11 +5502,13 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 SLAB_ATTR_RO(cache_dma);
 #endif
 
+#ifdef CONFIG_HARDENED_USERCOPY
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
 	return sysfs_emit(buf, "%u\n", s->usersize);
 }
 SLAB_ATTR_RO(usersize);
+#endif
 
 static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
 {
@@ -5803,7 +5805,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_FAILSLAB
 	&failslab_attr.attr,
 #endif
+#ifdef CONFIG_HARDENED_USERCOPY
 	&usersize_attr.attr,
+#endif
 #ifdef CONFIG_KFENCE
 	&skip_kfence_attr.attr,
 #endif
-- 
2.38.1


