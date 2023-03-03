Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87446A9F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCCSke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCCSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:40:12 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194596230D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:39:17 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id b5so1382918iow.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677868743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYomWrnmlC5qmjiU53zdzd7whsCIWTUkR9FfRWLgTa0=;
        b=U9FxO9vuP9TlpksOhPjilHepjhcXpcFIo423RRWZ10KtVv8ttoen/K6Fpf/rtnrCjx
         24gvap5zVC5VO7mtFx7Az4DUrvka3QpkOGo6707y7Fqg58ObIk+oyi0McryOltn5Oocx
         kO1OJ/Cw46289yLhQxSCYpPcZmiNAO5JwgF6lf6UoSkIenXvARB36Rr6y8QjNttMffZA
         ihqWqkwh0nzeP5unZFPRJxG3L7LCzFsZ+m0HdYQNIobHaSrmAAeUmw8ulqE4xka4GuI6
         80S60XwrnIs+nGdgGEPgOivvmc3RqazVrTpYKN154HahQZR/X539Fu88quefgH253baO
         F9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677868743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYomWrnmlC5qmjiU53zdzd7whsCIWTUkR9FfRWLgTa0=;
        b=2y/beg436Ca9SAYbUuoSBGCMp7Fomp1PT1zsSYuinbBAXIxmwD3ovq6NjfzzwyBkm2
         PuT2cxuTF6G/Ij/owaG12G/GyTtmuzriE02fcPovX7wY62OcxxjLxPQS6DY9bxVNzHtb
         n9lLbPVegmxyFYx02m4DxfY5XfGlq+DcOo6QDxph9w0dfesvHtlC5qpECBfs/5I27Lu6
         5he+jIAZboQKvJBPRMeyBx5mrLDfPoDhxj1lnlZQG32YmW7ekwNb+UnsEiHMh2g4lY+9
         8znqCUROkRqJAluzq6uPxaabZZFP+9xdhhuE2A8d/oT2S1GHK8Q5RTZh8WiW2qWpoY54
         62XQ==
X-Gm-Message-State: AO0yUKVU6T4Vt6QymtUHZeSrP2fwZH4PhqGdva20t9s7hXpqqT53wjPu
        10D0Dkrp1lLIhCR9bOGD4BI=
X-Google-Smtp-Source: AK7set9xDFJS6J7F7yR5ukntR3mUu0AiwOm+t4+7VlPaqMWQz6vLccq/Ns1RhLrR/Cb8piqPak0lUg==
X-Received: by 2002:a5d:9555:0:b0:74c:91c3:3837 with SMTP id a21-20020a5d9555000000b0074c91c33837mr1761157ios.18.1677868743519;
        Fri, 03 Mar 2023 10:39:03 -0800 (PST)
Received: from ArchLinux.lan ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id e12-20020a5ede0c000000b0074c9a4bb374sm875009iok.11.2023.03.03.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:39:03 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     tglx@linutronix.de, longman@redhat.com, swboyd@chromium.org,
        linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] debugobject: fix concurrency issues with is_static_object
Date:   Sat,  4 Mar 2023 02:31:47 +0800
Message-Id: <20230303183147.934793-1-schspa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The is_static_object implementation relay on the initial state of the
object. If multiple places are accessed concurrently, there is a
probability that the debug object has been registered in the system, which
will invalidate the judgment of is_static_object.

The following is the scenario where the problem occurs:

T0                                                   T1
=========================================================================
mod_timer();
  debug_object_assert_init
	db = get_bucket((unsigned long) addr);
	raw_spin_lock_irqsave(&db->lock, flags);
	obj = lookup_object(addr, db);
    if (!obj) {
		raw_spin_unlock_irqrestore(&db->lock, flags);
        << Context switch >>
                                             mod_timer();
                                               debug_object_assert_init
                                               ...
                                               enqueue_timer();
        /*
         * The initial state changed a static timer object, and
         * is_static_object will return false
         */

        if (descr->is_static_object &&
			descr->is_static_object(addr)) {
                debug_object_init();
            } else {
               << Hit here for a static object >>
			   debug_print_object(&o, "assert_init");
			   debug_object_fixup(descr->fixup_assert_init, addr,
					   ODEBUG_STATE_NOTAVAILABLE);
            }
    }

To fix it, we got the is_static_object called within db->lock, and save
it's state to struct debug_obj. This will ensure we won't hit the code
branch not belong to the static object.

For the same static object, debug_object_init may enter multiple times, but
there is a lock in debug_object_init to ensure that there is no problem.

Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
Signed-off-by: Schspa Shi <schspa@gmail.com>
---
Changes from v1:
 - Reduce debug object size as Waiman Long suggested.
 - Add description for new members.

---
 include/linux/debugobjects.h |  6 ++-
 lib/debugobjects.c           | 71 ++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 32444686b6ff4..19f9fb80557f6 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -21,13 +21,17 @@ struct debug_obj_descr;
  * struct debug_obj - representation of an tracked object
  * @node:	hlist node to link the object into the tracker list
  * @state:	tracked object state
+ * @is_state:	flag used to indicate that it is a static object
  * @astate:	current active state
  * @object:	pointer to the real object
  * @descr:	pointer to an object type specific debug description structure
  */
 struct debug_obj {
 	struct hlist_node	node;
-	enum debug_obj_state	state;
+	struct {
+		enum debug_obj_state	state : 31;
+		bool			is_static : 1;
+	};
 	unsigned int		astate;
 	void			*object;
 	const struct debug_obj_descr *descr;
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df86e649d8be0..d1be18158a1f7 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -275,6 +275,8 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 		obj->descr  = descr;
 		obj->state  = ODEBUG_STATE_NONE;
 		obj->astate = 0;
+		obj->is_static = descr->is_static_object &&
+			descr->is_static_object(addr);
 		hlist_add_head(&obj->node, &b->list);
 	}
 	return obj;
@@ -581,7 +583,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 			debug_objects_oom();
 			return;
 		}
+
 		check_stack = true;
+	} else {
+		/*
+		 * The debug object is inited, and we should check this again
+		 */
+		if (obj->is_static) {
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
+		}
 	}
 
 	switch (obj->state) {
@@ -640,6 +651,29 @@ void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
 }
 EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 
+/*
+ * Check static object.
+ */
+static bool debug_object_check_static(struct debug_bucket *db, void *addr,
+			const struct debug_obj_descr *descr)
+{
+	struct debug_obj *obj;
+
+	/*
+	 * The is_static_object implementation relay on the initial state of the
+	 * object. If multiple places are accessed concurrently, there is a
+	 * probability that the debug object has been registered in the system,
+	 * which will invalidate the judgment of is_static_object.
+	 */
+	lockdep_assert_held(&db->lock);
+
+	obj = lookup_object(addr, db);
+	if (likely(obj))
+		return obj->is_static;
+
+	return descr->is_static_object && descr->is_static_object(addr);
+}
+
 /**
  * debug_object_activate - debug checks when an object is activated
  * @addr:	address of the object
@@ -656,6 +690,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	struct debug_obj o = { .object = addr,
 			       .state = ODEBUG_STATE_NOTAVAILABLE,
 			       .descr = descr };
+	bool is_static;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -696,6 +731,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 		return ret;
 	}
 
+	is_static = debug_object_check_static(db, addr, descr);
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 
 	/*
@@ -705,7 +741,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	 * static object is tracked in the object tracker. If
 	 * not, this must be a bug, so we try to fix it up.
 	 */
-	if (descr->is_static_object && descr->is_static_object(addr)) {
+	if (is_static) {
 		/* track this static object */
 		debug_object_init(addr, descr);
 		debug_object_activate(addr, descr);
@@ -872,6 +908,7 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool is_static;
 
 	if (!debug_objects_enabled)
 		return;
@@ -886,13 +923,14 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
+		is_static = debug_object_check_static(db, addr, descr);
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		/*
 		 * Maybe the object is static, and we let the type specific
 		 * code confirm. Track this static object if true, else invoke
 		 * fixup.
 		 */
-		if (descr->is_static_object && descr->is_static_object(addr)) {
+		if (is_static) {
 			/* Track this static object */
 			debug_object_init(addr, descr);
 		} else {
@@ -1215,7 +1253,8 @@ static __initconst const struct debug_obj_descr descr_type_test = {
 	.fixup_free		= fixup_free,
 };
 
-static __initdata struct self_test obj = { .static_init = 0 };
+static struct self_test obj __initdata = { .static_init = 0 };
+static struct self_test sobj __initdata = { .static_init = 1 };
 
 static void __init debug_objects_selftest(void)
 {
@@ -1256,26 +1295,26 @@ static void __init debug_objects_selftest(void)
 	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
 		goto out;
 
-	obj.static_init = 1;
-	debug_object_activate(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
+	debug_object_init(&sobj, &descr_type_test);
+	debug_object_activate(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
 		goto out;
-	debug_object_init(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
+	debug_object_init(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
 		goto out;
-	debug_object_free(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
+	debug_object_free(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_NONE, fixups, warnings))
 		goto out;
 
 #ifdef CONFIG_DEBUG_OBJECTS_FREE
-	debug_object_init(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_INIT, fixups, warnings))
+	debug_object_init(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_INIT, fixups, warnings))
 		goto out;
-	debug_object_activate(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
+	debug_object_activate(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
 		goto out;
-	__debug_check_no_obj_freed(&obj, sizeof(obj));
-	if (check_results(&obj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
+	__debug_check_no_obj_freed(&sobj, sizeof(sobj));
+	if (check_results(&sobj, ODEBUG_STATE_NONE, ++fixups, ++warnings))
 		goto out;
 #endif
 	pr_info("selftest passed\n");
-- 
2.39.2

