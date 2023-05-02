Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C96F3ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjEBIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjEBIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:12:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178C046AF;
        Tue,  2 May 2023 01:12:17 -0700 (PDT)
Date:   Tue, 02 May 2023 08:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683015135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4wkqt8zGvhlDhOnkrLIF/F3emolKIX/SCnr5m0IpSU=;
        b=qtKyLR1HnRzssc2Itk3+asvrAhS3V2PvQAqybrU2KIzYuT0ONN7+4qmWJzIxG1BEHL4LUM
        /i6rKHKX2qcR4jpiHmqr9f4VJeCS+nMwrzcxFcsQFFte6pFwjsdyN6c0QGGLMjO9dMVudQ
        xw2OpWZPQCynapdzilPReLmv0BO1tAWW5lqg+52XeZv8lH9fGT1EMKNbSIvu4Pqwh3dzxY
        hdAyHOAXNTzmyfm3mK2F+tpQqAAdn4RSJ490sDLhh8w0DWE6NTGV9LDgJaTdVJAtpUDtIZ
        E4SfNgmcCJilaLAQk0ddWMQMhx+fMEdnhl0awLCKgZOL5j9m05rWth/tdo4KbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683015135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4wkqt8zGvhlDhOnkrLIF/F3emolKIX/SCnr5m0IpSU=;
        b=Poww+cKNbZ2gvG9/jBER65CNge9aJFTl9rLn6B7pBHqdwiJl9iQYtbws6YgeaqOp0CHgaL
        E1HdNhqJXG8/5RBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobject: Ensure pool refill (again)
Cc:     Ido Schimmel <idosch@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <871qk05a9d.ffs@tglx>
References: <871qk05a9d.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168301513479.404.6581313024633204676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     0af462f19e635ad522f28981238334620881badc
Gitweb:        https://git.kernel.org/tip/0af462f19e635ad522f28981238334620881badc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 01 May 2023 17:42:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 02 May 2023 10:07:04 +02:00

debugobject: Ensure pool refill (again)

The recent fix to ensure atomicity of lookup and allocation inadvertently
broke the pool refill mechanism.

Prior to that change debug_objects_activate() and debug_objecs_assert_init()
invoked debug_objecs_init() to set up the tracking object for statically
initialized objects. That's not longer the case and debug_objecs_init() is
now the only place which does pool refills.

Depending on the number of statically initialized objects this can be
enough to actually deplete the pool, which was observed by Ido via a
debugobjects OOM warning.

Restore the old behaviour by adding explicit refill opportunities to
debug_objects_activate() and debug_objecs_assert_init().

Fixes: 63a759694eed ("debugobject: Prevent init race with static objects")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/871qk05a9d.ffs@tglx


---
 lib/debugobjects.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b796799..003edc5 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -587,6 +587,16 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket 
 	return NULL;
 }
 
+static void debug_objects_fill_pool(void)
+{
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
@@ -595,12 +605,7 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
@@ -685,6 +690,8 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
@@ -894,6 +901,8 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
