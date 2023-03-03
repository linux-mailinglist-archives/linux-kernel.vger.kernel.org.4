Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96986A9C95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCCRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCCRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:00:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490F10AB9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677862807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMud9j+Ztnx0qwD66EFefzAn46fZ9c9vCfAfyc0CBTA=;
        b=QGqINCtCXHrH6czYdwsXT3QsF7/IVdYOZGGzqZpbkjPnD3D/R9/ETGwmBubjxXDfbD2bqo
        SvZsp2BGW50j/bHbt1tW3M0lRc1zm0t2EsTYa0qv8hnd/VDUHk0yMwOcQJcaiBnNv6RDCc
        PSgdbp1zlBP8vhj0wD8/Nr+m5m3ifZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-wrcgQT9cPIGshM_qv91tSw-1; Fri, 03 Mar 2023 12:00:03 -0500
X-MC-Unique: wrcgQT9cPIGshM_qv91tSw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9D60857A9F;
        Fri,  3 Mar 2023 17:00:02 +0000 (UTC)
Received: from [10.22.34.145] (unknown [10.22.34.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 777FE492C3E;
        Fri,  3 Mar 2023 17:00:02 +0000 (UTC)
Message-ID: <814636e6-9a8a-9ab1-03a0-ed3702024227@redhat.com>
Date:   Fri, 3 Mar 2023 12:00:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, tglx@linutronix.de,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
References: <20230303161906.831686-1-schspa@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230303161906.831686-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/23 11:19, Schspa Shi wrote:
> The is_static_object implementation relay on the initial state of the
> object. If multiple places are accessed concurrently, there is a
> probability that the debug object has been registered in the system, which
> will invalidate the judgment of is_static_object.
>
> The following is the scenario where the problem occurs:
>
> T0                                                   T1
> =========================================================================
> mod_timer();
>    debug_object_assert_init
> 	db = get_bucket((unsigned long) addr);
> 	raw_spin_lock_irqsave(&db->lock, flags);
> 	obj = lookup_object(addr, db);
>      if (!obj) {
> 		raw_spin_unlock_irqrestore(&db->lock, flags);
>          << Context switch >>
>                                               mod_timer();
>                                                 debug_object_assert_init
>                                                 ...
>                                                 enqueue_timer();
>          /*
>           * The initial state changed a static timer object, and
>           * is_static_object will return false
>           */
>
>          if (descr->is_static_object &&
> 			descr->is_static_object(addr)) {
>                  debug_object_init();
>              } else {
>                 << Hit here for a static object >>
> 			   debug_print_object(&o, "assert_init");
> 			   debug_object_fixup(descr->fixup_assert_init, addr,
> 					   ODEBUG_STATE_NOTAVAILABLE);
>              }
>      }
>
> To fix it, we got the is_static_object called within db->lock, and save
> it's state to struct debug_obj. This will ensure we won't hit the code
> branch not belong to the static object.
>
> For the same static object, debug_object_init may enter multiple times, but
> there is a lock in debug_object_init to ensure that there is no problem.
>
> Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>   include/linux/debugobjects.h |  1 +
>   lib/debugobjects.c           | 71 ++++++++++++++++++++++++++++--------
>   2 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
> index 32444686b6ff4..544a6111b97f6 100644
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -30,6 +30,7 @@ struct debug_obj {
>   	enum debug_obj_state	state;
>   	unsigned int		astate;
>   	void			*object;
> +	bool			is_static;
>   	const struct debug_obj_descr *descr;
>   };

The patch looks reasonable. My main concern is the increase in size of 
the debug_obj structure. It is an additional 8 bytes on 64-bit arches. 
How much will we save performance-wise by caching it in the debug_obj. 
Alternatively, you may pack it within the current size by, maybe, 
reducing the size of state.

Cheers,
Longman

>   
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index df86e649d8be0..d1be18158a1f7 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -275,6 +275,8 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>   		obj->descr  = descr;
>   		obj->state  = ODEBUG_STATE_NONE;
>   		obj->astate = 0;
> +		obj->is_static = descr->is_static_object &&
> +			descr->is_static_object(addr);
>   		hlist_add_head(&obj->node, &b->list);
>   	}
>   	return obj;
> @@ -581,7 +583,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>   			debug_objects_oom();
>   			return;
>   		}
> +
>   		check_stack = true;
> +	} else {
> +		/*
> +		 * The debug object is inited, and we should check this again
> +		 */
> +		if (obj->is_static) {
> +			raw_spin_unlock_irqrestore(&db->lock, flags);
> +			return;
> +		}
>   	}
>   
>   	switch (obj->state) {
> @@ -640,6 +651,29 @@ void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
>   }
>   EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
>   
> +/*
> + * Check static object.
> + */
> +static bool debug_object_check_static(struct debug_bucket *db, void *addr,
> +			const struct debug_obj_descr *descr)
> +{
> +	struct debug_obj *obj;
> +
> +	/*
> +	 * The is_static_object implementation relay on the initial state of the
> +	 * object. If multiple places are accessed concurrently, there is a
> +	 * probability that the debug object has been registered in the system,
> +	 * which will invalidate the judgment of is_static_object.
> +	 */
> +	lockdep_assert_held(&db->lock);
> +
> +	obj = lookup_object(addr, db);
> +	if (likely(obj))
> +		return obj->is_static;
> +
> +	return descr->is_static_object && descr->is_static_object(addr);
> +}
> +
>   /**
>    * debug_object_activate - debug checks when an object is activated
>    * @addr:	address of the object
> @@ -656,6 +690,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>   	struct debug_obj o = { .object = addr,
>   			       .state = ODEBUG_STATE_NOTAVAILABLE,
>   			       .descr = descr };
> +	bool is_static;
>   
>   	if (!debug_objects_enabled)
>   		return 0;
> @@ -696,6 +731,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>   		return ret;
>   	}
>   
> +	is_static = debug_object_check_static(db, addr, descr);
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
>   
>   	/*
> @@ -705,7 +741,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>   	 * static object is tracked in the object tracker. If
>   	 * not, this must be a bug, so we try to fix it up.
>   	 */
> -	if (descr->is_static_object && descr->is_static_object(addr)) {
> +	if (is_static) {
>   		/* track this static object */
>   		debug_object_init(addr, descr);
>   		debug_object_activate(addr, descr);
> @@ -872,6 +908,7 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
>   	struct debug_bucket *db;
>   	struct debug_obj *obj;
>   	unsigned long flags;
> +	bool is_static;
>   
>   	if (!debug_objects_enabled)
>   		return;
> @@ -886,13 +923,14 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
>   				       .state = ODEBUG_STATE_NOTAVAILABLE,
>   				       .descr = descr };
>   
> +		is_static = debug_object_check_static(db, addr, descr);
>   		raw_spin_unlock_irqrestore(&db->lock, flags);
>   		/*
>   		 * Maybe the object is static, and we let the type specific
>   		 * code confirm. Track this static object if true, else invoke
>   		 * fixup.
>   		 */
> -		if (descr->is_static_object && descr->is_static_object(addr)) {
> +		if (is_static) {
>   			/* Track this static object */
>   			debug_object_init(addr, descr);
>   		} else {
> @@ -1215,7 +1253,8 @@ static __initconst const struct debug_obj_descr descr_type_test = {
>   	.fixup_free		= fixup_free,
>   };
>   
> -static __initdata struct self_test obj = { .static_init = 0 };
> +static struct self_test obj __initdata = { .static_init = 0 };
> +static struct self_test sobj __initdata = { .static_init = 1 };
>   
>   static void __init debug_objects_selftest(void)
>   {
> @@ -1256,26 +1295,26 @@ static void __init debug_objects_selftest(void)
>   	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
>   		goto out;
>   
> -	obj.static_init = 1;
> -	debug_object_activate(&obj, &descr_type_test);
> -	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
> +	debug_object_init(&sobj, &descr_type_test);
> +	debug_object_activate(&sobj, &descr_type_test);
> +	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>   		goto out;
> -	debug_object_init(&obj, &descr_type_test);
> -	if (check_results(&obj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
> +	debug_object_init(&sobj, &descr_type_test);
> +	if (check_results(&sobj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
>   		goto out;
> -	debug_object_free(&obj, &descr_type_test);
> -	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
> +	debug_object_free(&sobj, &descr_type_test);
> +	if (check_results(&sobj, ODEBUG_STATE_NONE, fixups, warnings))
>   		goto out;
>   
>   #ifdef CONFIG_DEBUG_OBJECTS_FREE
> -	debug_object_init(&obj, &descr_type_test);
> -	if (check_results(&obj, ODEBUG_STATE_INIT, fixups, warnings))
> +	debug_object_init(&sobj, &descr_type_test);
> +	if (check_results(&sobj, ODEBUG_STATE_INIT, fixups, warnings))
>   		goto out;
> -	debug_object_activate(&obj, &descr_type_test);
> -	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
> +	debug_object_activate(&sobj, &descr_type_test);
> +	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>   		goto out;
> -	__debug_check_no_obj_freed(&obj, sizeof(obj));
> -	if (check_results(&obj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
> +	__debug_check_no_obj_freed(&sobj, sizeof(sobj));
> +	if (check_results(&sobj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
>   		goto out;
>   #endif
>   	pr_info("selftest passed\n");

