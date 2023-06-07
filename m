Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126E725EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjFGMU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbjFGMUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F21BE2;
        Wed,  7 Jun 2023 05:20:45 -0700 (PDT)
Date:   Wed, 07 Jun 2023 12:20:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686140444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpvlICurWarW51eR/TeI8KmBxKEzGBZ71h3PMPZpOKc=;
        b=Q26+m38iLKJc9LXLX69KNUjTejrLWC9dqRfz7yJG559Lv5ENyaBouEzOKccpP4GodJ0Lst
        FdXLVVyOMDVF0Jrnn9jdpBfAYwp5hPTjA/B8J3Rp+JR9StgepMkNs40OIceOvCDAv9ABn+
        Ha1KyEYnGt34IQ0gO3M4SDu5gawpN/SIQWTL91u8njevimONHlTJBdGbmVADbvfjJTvYH6
        bcGiOUgVXxQ8Lt7hw7L6hDB+S+yJLepT0b3y+pyRj8nAGjfhrpwkJpv1lp5ToKiuVChlrQ
        a5IOGe4POn22IoYhJVp/zIQP1t0nrvGBZSGzG/Hod7NidsAZAN5sAGlEMKC1Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686140444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpvlICurWarW51eR/TeI8KmBxKEzGBZ71h3PMPZpOKc=;
        b=MI56WvjtsdnYJ4oEqnCjhhbgUOUPR5M1wTaL+9kcouVyXdzrp7/Z9EmFuAPFZJO6jn7kcH
        Kmkxs3GujbeeMbCA==
From:   "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Recheck debug_objects_enabled
 before reporting
Cc:     syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <492fe2ae-5141-d548-ebd5-62f5fe2e57f7@I-love.SAKURA.ne.jp>
References: <492fe2ae-5141-d548-ebd5-62f5fe2e57f7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Message-ID: <168614044350.404.4585037016201397086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     8b64d420fe2450f82848178506d3e3a0bd195539
Gitweb:        https://git.kernel.org/tip/8b64d420fe2450f82848178506d3e3a0bd195539
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Wed, 07 Jun 2023 19:19:02 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Jun 2023 14:16:12 +02:00

debugobjects: Recheck debug_objects_enabled before reporting

syzbot is reporting false a positive ODEBUG message immediately after
ODEBUG was disabled due to OOM.

  [ 1062.309646][T22911] ODEBUG: Out of memory. ODEBUG disabled
  [ 1062.886755][ T5171] ------------[ cut here ]------------
  [ 1062.892770][ T5171] ODEBUG: assert_init not available (active state 0) object: ffffc900056afb20 object type: timer_list hint: process_timeout+0x0/0x40

  CPU 0 [ T5171]                CPU 1 [T22911]
  --------------                --------------
  debug_object_assert_init() {
    if (!debug_objects_enabled)
      return;
    db = get_bucket(addr);
                                lookup_object_or_alloc() {
                                  debug_objects_enabled = 0;
                                  return NULL;
                                }
                                debug_objects_oom() {
                                  pr_warn("Out of memory. ODEBUG disabled\n");
                                  // all buckets get emptied here, and
                                }
    lookup_object_or_alloc(addr, db, descr, false, true) {
      // this bucket is already empty.
      return ERR_PTR(-ENOENT);
    }
    // Emits false positive warning.
    debug_print_object(&o, "assert_init");
  }

Recheck debug_object_enabled in debug_print_object() to avoid that.

Reported-by: syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/492fe2ae-5141-d548-ebd5-62f5fe2e57f7@I-love.SAKURA.ne.jp
Closes: https://syzkaller.appspot.com/bug?extid=7937ba6a50bdd00fffdf
---
 lib/debugobjects.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 984985c..a517256 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -498,6 +498,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
