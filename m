Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88C714C46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjE2OkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjE2OkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:40:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9A19D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:39:55 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34TEdBcp017546;
        Mon, 29 May 2023 23:39:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Mon, 29 May 2023 23:39:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34TEdBWi017542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 May 2023 23:39:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1af29817-4698-c5ac-cf63-0dad289e740f@I-love.SAKURA.ne.jp>
Date:   Mon, 29 May 2023 23:39:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: [PATCH] debugobjects: turn off debug_objects_enabled from
 debug_objects_oom()
Content-Language: en-US
To:     syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
References: <0000000000003a2f8505fcd5f06b@google.com>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        wuchi <wuchi.zero@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000003a2f8505fcd5f06b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting false positive ODEBUG message immediately after
ODEBUG was disabled due to OOM.

  [ 1062.309646][T22911] ODEBUG: Out of memory. ODEBUG disabled
  [ 1062.886755][ T5171] ------------[ cut here ]------------
  [ 1062.892770][ T5171] ODEBUG: assert_init not available (active state 0) object: ffffc900056afb20 object type: timer_list hint: process_timeout+0x0/0x40

This race happened because debug_objects_oom() emitted OOM message but did
not turn off debug_objects_enabled, and debug_print_object() did not check
debug_objects_enabled when calling WARN().

  CPU 0 [ T5171]                CPU 1 [T22911]
  --------------                --------------
  debug_object_assert_init() {
    if (!debug_objects_enabled)
      return;
    db = get_bucket((unsigned long) addr); // Finds a bucket, but...
                                debug_objects_oom() {
                                  pr_warn("Out of memory. ODEBUG disabled\n");
                                  // all buckets get emptied here, and...
                                  hlist_move_list(&db->list, &freelist);
                                }
    lookup_object_or_alloc(addr, db, descr, false, true) {
      lookup_object(addr, b) {
        return NULL; // this bucket is already empty.
      }
      if (!descr->is_static_object || !descr->is_static_object(addr))
        return ERR_PTR(-ENOENT);
    }
    if (!obj) { // obj == ERR_PTR(-ENOENT) because non-static object.
       debug_objects_oom();
       return;
    }
    debug_print_object(&o, "assert_init") {
      // False positive due to not checking debug_objects_enabled.
      WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
           "object: %p object type: %s hint: %pS\n", ...);
    }
  }

Reported-by: syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=7937ba6a50bdd00fffdf
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 lib/debugobjects.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 984985c39c9b..63974e9edac5 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -466,6 +466,7 @@ static void debug_objects_oom(void)
 	unsigned long flags;
 	int i;
 
+	debug_objects_enabled = 0;
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
@@ -502,10 +503,10 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
 		limit++;
-		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
-				 "object: %p object type: %s hint: %pS\n",
-			msg, obj_states[obj->state], obj->astate,
-			obj->object, descr->name, hint);
+		WARN(debug_objects_enabled, KERN_ERR
+		     "ODEBUG: %s %s (active state %u) object: %p object type: %s hint: %pS\n",
+		     msg, obj_states[obj->state], obj->astate,
+		     obj->object, descr->name, hint);
 	}
 	debug_objects_warnings++;
 }
-- 
2.18.4

