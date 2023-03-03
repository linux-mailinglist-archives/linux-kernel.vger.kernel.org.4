Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0C6A9E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCCR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCCR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:56:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A664FCDF0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:56:30 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z5so2169772ilq.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677866190;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=W4/j3zPt3kbsMVYWGfqkaLJ7EnHBT+wlLaGxbW94XYY=;
        b=oSaAku4eZQ1nSGQj7/Fl6DEgcZ3Upux3wA6k3WmjhirpNvH/sJ0wmHA+TcUu+l+5DU
         6pcTuULoZrJZoLs+TvJCBampeXjZFuqyjFPNwZHOMKoDmCQvw+QmbJ84/7H6Kje4YtqY
         xxAOHy8AoKPYBc9Lw2HM0hFyuTFUACaodNaC6GNEdxKu2mHOGiAWfr8Vx94+tSf+lbEt
         8/KXL5H6h/lVgnOIuxkdqMm1RT2UCmF0C2Mxwp1PqE4Vn20yvaVzPwwHLpOtgO1KZVwA
         Kcjy4nXFHqV1hNUyzQxg6K20qgJERzmUSslyZZkJXz/pQs6WMm21Pyw2Q4XaTfwpd/OB
         QeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866190;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4/j3zPt3kbsMVYWGfqkaLJ7EnHBT+wlLaGxbW94XYY=;
        b=Yk8scViOhYS1xNPf6sgXFjQCzxOp7fQjmG5OZb3h/NEWxzG+jLcwQTcZXvlM9XPw8g
         0EBHzCFXDGMXrtwd6g4rnQr1mA9ImlmPCXioH514gZHGWSVdBPwef0zC+iTQ/YA85Koq
         NBdy5Nt5B0PdEY9BIHhg9iMJs6X02u0wkCB3Qo9QdsabCZa7dWw7PCvmLfx1B2SpZpdZ
         Wc2PTZX4iUFDpPEg/jj7rIzymiQaNoQ8rinIwAXxaiN06KIDsfpyDZsFDxjRr9ntfp7s
         fGSZMqk2d8bBt+POHUjGAY2c4VKQMODIPjFPq2GN0U1MtyI7+DhIyrZYn3sDUixSsU8r
         Qb4Q==
X-Gm-Message-State: AO0yUKXuwbpa75Q0qcWdWLHclLrPX66QV05l8i3ajO9vXujGUa5pXTSI
        Kl70aert6d0WleweaRIWk1jny+C9gWg=
X-Google-Smtp-Source: AK7set86MLSNEwHxWq+P0AGslCjEvvPXGD4V/tnD0qYYW6RdK2L7AYr/KqLZ8JvI8wwKQO2oYpGiag==
X-Received: by 2002:a05:6e02:1c84:b0:315:3421:ef27 with SMTP id w4-20020a056e021c8400b003153421ef27mr2531696ill.29.1677866189892;
        Fri, 03 Mar 2023 09:56:29 -0800 (PST)
Received: from ArchLinux ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id c4-20020a92bd04000000b00317998c5b99sm743131ile.77.2023.03.03.09.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:56:29 -0800 (PST)
References: <20230303161906.831686-1-schspa@gmail.com>
 <814636e6-9a8a-9ab1-03a0-ed3702024227@redhat.com>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     tglx@linutronix.de, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
Date:   Sat, 04 Mar 2023 01:53:22 +0800
In-reply-to: <814636e6-9a8a-9ab1-03a0-ed3702024227@redhat.com>
Message-ID: <m2a60t67nb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Waiman Long <longman@redhat.com> writes:

> On 3/3/23 11:19, Schspa Shi wrote:
>> The is_static_object implementation relay on the initial state of the
>> object. If multiple places are accessed concurrently, there is a
>> probability that the debug object has been registered in the system, which
>> will invalidate the judgment of is_static_object.
>>
>> The following is the scenario where the problem occurs:
>>
>> T0                                                   T1
>> =========================================================================
>> mod_timer();
>>    debug_object_assert_init
>> 	db = get_bucket((unsigned long) addr);
>> 	raw_spin_lock_irqsave(&db->lock, flags);
>> 	obj = lookup_object(addr, db);
>>      if (!obj) {
>> 		raw_spin_unlock_irqrestore(&db->lock, flags);
>>          << Context switch >>
>>                                               mod_timer();
>>                                                 debug_object_assert_init
>>                                                 ...
>>                                                 enqueue_timer();
>>          /*
>>           * The initial state changed a static timer object, and
>>           * is_static_object will return false
>>           */
>>
>>          if (descr->is_static_object &&
>> 			descr->is_static_object(addr)) {
>>                  debug_object_init();
>>              } else {
>>                 << Hit here for a static object >>
>> 			   debug_print_object(&o, "assert_init");
>> 			   debug_object_fixup(descr->fixup_assert_init, addr,
>> 					   ODEBUG_STATE_NOTAVAILABLE);
>>              }
>>      }
>>
>> To fix it, we got the is_static_object called within db->lock, and save
>> it's state to struct debug_obj. This will ensure we won't hit the code
>> branch not belong to the static object.
>>
>> For the same static object, debug_object_init may enter multiple times, but
>> there is a lock in debug_object_init to ensure that there is no problem.
>>
>> Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
>> Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>   include/linux/debugobjects.h |  1 +
>>   lib/debugobjects.c           | 71 ++++++++++++++++++++++++++++--------
>>   2 files changed, 56 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
>> index 32444686b6ff4..544a6111b97f6 100644
>> --- a/include/linux/debugobjects.h
>> +++ b/include/linux/debugobjects.h
>> @@ -30,6 +30,7 @@ struct debug_obj {
>>   	enum debug_obj_state	state;
>>   	unsigned int		astate;
>>   	void			*object;
>> +	bool			is_static;
>>   	const struct debug_obj_descr *descr;
>>   };
>
> The patch looks reasonable. My main concern is the increase in size of the
> debug_obj structure. It is an additional 8 bytes on 64-bit arches. How much will
> we save performance-wise by caching it in the debug_obj. Alternatively, you may
> pack it within the current size by, maybe, reducing the size of state.
>

Yes, we can change this to:

struct debug_obj {
	struct hlist_node	node;
	struct {
		enum debug_obj_state	state : 31;
		bool					is_static : 1;
	};
	unsigned int		astate;
	void			*object;
	const struct debug_obj_descr *descr;
};

Which won't increase the object size.

(gdb) ptype /o struct debug_obj
/* offset      |    size */  type = struct debug_obj {
/*      0      |       0 */    struct hlist_node {
                                   <incomplete type>

                                   /* total size (bytes):    0 */
                               } node;
/*     16      |       4 */    struct {
/*     16: 0   |       4 */        enum debug_obj_state state : 31;
/*     19: 7   |       1 */        bool is_static : 1;

                                   /* total size (bytes):    4 */
                               };
/*     20      |       4 */    unsigned int astate;
/*     24      |       8 */    void *object;
/*     32      |       8 */    const struct debug_obj_descr *descr;

                               /* total size (bytes):   40 */
                             }


> Cheers,
> Longman
>
>>   diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index df86e649d8be0..d1be18158a1f7 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -275,6 +275,8 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>>   		obj->descr  = descr;
>>   		obj->state  = ODEBUG_STATE_NONE;
>>   		obj->astate = 0;
>> +		obj->is_static = descr->is_static_object &&
>> +			descr->is_static_object(addr);
>>   		hlist_add_head(&obj->node, &b->list);
>>   	}
>>   	return obj;
>> @@ -581,7 +583,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>>   			debug_objects_oom();
>>   			return;
>>   		}
>> +
>>   		check_stack = true;
>> +	} else {
>> +		/*
>> +		 * The debug object is inited, and we should check this again
>> +		 */
>> +		if (obj->is_static) {
>> +			raw_spin_unlock_irqrestore(&db->lock, flags);
>> +			return;
>> +		}
>>   	}
>>     	switch (obj->state) {
>> @@ -640,6 +651,29 @@ void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
>>   }
>>   EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
>>   +/*
>> + * Check static object.
>> + */
>> +static bool debug_object_check_static(struct debug_bucket *db, void *addr,
>> +			const struct debug_obj_descr *descr)
>> +{
>> +	struct debug_obj *obj;
>> +
>> +	/*
>> +	 * The is_static_object implementation relay on the initial state of the
>> +	 * object. If multiple places are accessed concurrently, there is a
>> +	 * probability that the debug object has been registered in the system,
>> +	 * which will invalidate the judgment of is_static_object.
>> +	 */
>> +	lockdep_assert_held(&db->lock);
>> +
>> +	obj = lookup_object(addr, db);
>> +	if (likely(obj))
>> +		return obj->is_static;
>> +
>> +	return descr->is_static_object && descr->is_static_object(addr);
>> +}
>> +
>>   /**
>>    * debug_object_activate - debug checks when an object is activated
>>    * @addr:	address of the object
>> @@ -656,6 +690,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>>   	struct debug_obj o = { .object = addr,
>>   			       .state = ODEBUG_STATE_NOTAVAILABLE,
>>   			       .descr = descr };
>> +	bool is_static;
>>     	if (!debug_objects_enabled)
>>   		return 0;
>> @@ -696,6 +731,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>>   		return ret;
>>   	}
>>   +	is_static = debug_object_check_static(db, addr, descr);
>>   	raw_spin_unlock_irqrestore(&db->lock, flags);
>>     	/*
>> @@ -705,7 +741,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>>   	 * static object is tracked in the object tracker. If
>>   	 * not, this must be a bug, so we try to fix it up.
>>   	 */
>> -	if (descr->is_static_object && descr->is_static_object(addr)) {
>> +	if (is_static) {
>>   		/* track this static object */
>>   		debug_object_init(addr, descr);
>>   		debug_object_activate(addr, descr);
>> @@ -872,6 +908,7 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
>>   	struct debug_bucket *db;
>>   	struct debug_obj *obj;
>>   	unsigned long flags;
>> +	bool is_static;
>>     	if (!debug_objects_enabled)
>>   		return;
>> @@ -886,13 +923,14 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
>>   				       .state = ODEBUG_STATE_NOTAVAILABLE,
>>   				       .descr = descr };
>>   +		is_static = debug_object_check_static(db, addr, descr);
>>   		raw_spin_unlock_irqrestore(&db->lock, flags);
>>   		/*
>>   		 * Maybe the object is static, and we let the type specific
>>   		 * code confirm. Track this static object if true, else invoke
>>   		 * fixup.
>>   		 */
>> -		if (descr->is_static_object && descr->is_static_object(addr)) {
>> +		if (is_static) {
>>   			/* Track this static object */
>>   			debug_object_init(addr, descr);
>>   		} else {
>> @@ -1215,7 +1253,8 @@ static __initconst const struct debug_obj_descr descr_type_test = {
>>   	.fixup_free		= fixup_free,
>>   };
>>   -static __initdata struct self_test obj = { .static_init = 0 };
>> +static struct self_test obj __initdata = { .static_init = 0 };
>> +static struct self_test sobj __initdata = { .static_init = 1 };
>>     static void __init debug_objects_selftest(void)
>>   {
>> @@ -1256,26 +1295,26 @@ static void __init debug_objects_selftest(void)
>>   	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
>>   		goto out;
>>   -	obj.static_init = 1;
>> -	debug_object_activate(&obj, &descr_type_test);
>> -	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>> +	debug_object_init(&sobj, &descr_type_test);
>> +	debug_object_activate(&sobj, &descr_type_test);
>> +	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>>   		goto out;
>> -	debug_object_init(&obj, &descr_type_test);
>> -	if (check_results(&obj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
>> +	debug_object_init(&sobj, &descr_type_test);
>> +	if (check_results(&sobj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
>>   		goto out;
>> -	debug_object_free(&obj, &descr_type_test);
>> -	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
>> +	debug_object_free(&sobj, &descr_type_test);
>> +	if (check_results(&sobj, ODEBUG_STATE_NONE, fixups, warnings))
>>   		goto out;
>>     #ifdef CONFIG_DEBUG_OBJECTS_FREE
>> -	debug_object_init(&obj, &descr_type_test);
>> -	if (check_results(&obj, ODEBUG_STATE_INIT, fixups, warnings))
>> +	debug_object_init(&sobj, &descr_type_test);
>> +	if (check_results(&sobj, ODEBUG_STATE_INIT, fixups, warnings))
>>   		goto out;
>> -	debug_object_activate(&obj, &descr_type_test);
>> -	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>> +	debug_object_activate(&sobj, &descr_type_test);
>> +	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
>>   		goto out;
>> -	__debug_check_no_obj_freed(&obj, sizeof(obj));
>> -	if (check_results(&obj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
>> +	__debug_check_no_obj_freed(&sobj, sizeof(sobj));
>> +	if (check_results(&sobj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
>>   		goto out;
>>   #endif
>>   	pr_info("selftest passed\n");


-- 
BRs
Schspa Shi
