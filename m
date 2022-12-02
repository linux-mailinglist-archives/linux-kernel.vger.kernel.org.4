Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC106405F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiLBLm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiLBLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:42:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602BCAF84;
        Fri,  2 Dec 2022 03:42:22 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:42:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669981340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2Vn6wXmkx0a7mZfcOSbKqYbGwrk92B5MZTOKP0fS5U=;
        b=2VSQKT/tMjt3lv1J+QVd4bQFz3xkoDrdHs0cYXCgjqYPVe3fBqWyC/QlorLo6sqGgcEbFJ
        1krieE+yft161hiG4KnM+5tA6MXKNVqvBRXmNSZRM3HmbX1jtadY/npMn75rqkUe7tIn6h
        Gpe4GHcLOZAl3x2llPEbPKr64ZPNWjAymKwIrTCgiXdN1u1KaEk258aU+x9zS7DSCZTTA9
        BQmjbxsAPMZepMMTWLTIJZT+IIqB1cyvHLRfhmmpcw22QQf08qTV20LG7okgq3Wtuckf2B
        MXGkm/41hvPtrKH1ZWeJH1j8g2Kc2dyh6dpwTihRapNGILUoqNVRrjwXTkXFXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669981340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2Vn6wXmkx0a7mZfcOSbKqYbGwrk92B5MZTOKP0fS5U=;
        b=im4+CQl3lKmRL4RmQbLooPq+h0Jqc6/ePp5/KlCG0O6GQcUD4F01fd8yGMhpgoLGtBrSwj
        HFsIs+KwEI/DDTAA==
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Print object pointer in
 debug_print_object()
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220519202201.2348343-1-swboyd@chromium.org>
References: <20220519202201.2348343-1-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <166998133867.4906.9430088873803994370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     c4db2d3b70e586c7c856c891f4f7052e8d789a06
Gitweb:        https://git.kernel.org/tip/c4db2d3b70e586c7c856c891f4f7052e8d789a06
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Thu, 19 May 2022 13:22:01 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:32:24 +01:00

debugobjects: Print object pointer in debug_print_object()

Delayed kobject debugging (CONFIG_DEBUG_KOBJECT_RELEASE) prints the kobject
pointer that's being released in kobject_release() before scheduling a
randomly delayed work to do the actual release work.

If the caller of kobject_put() frees the kobject upon return then this will
typically emit a debugobject warning about freeing an active timer.

Usually the release function is the function that does the kfree() of the
struct containing the kobject.

For example the following print is seen

 kobject: 'queue' (ffff888114236190): kobject_release, parent 0000000000000000 (delayed 1000)
 ------------[ cut here ]------------
 ODEBUG: free active (active state 0) object type: timer_list hint: kobject_delayed_cleanup+0x0/0x390

but the kobject printk cannot be matched with the debug object printk
because it could be any number of kobjects that was released around that
time. The random delay for the work doesn't help either.

Print the address of the object being tracked to help to figure out which
kobject is the problem here. Note that this does not use %px here to match
the other %p usage in debugobject debugging. Due to %p usage it is required
to disable pointer hashing to correlate the two pointer printks.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220519202201.2348343-1-swboyd@chromium.org

---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 337d797..4c670d3 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -500,9 +500,9 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 			descr->debug_hint(obj->object) : NULL;
 		limit++;
 		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
-				 "object type: %s hint: %pS\n",
+				 "object: %p object type: %s hint: %pS\n",
 			msg, obj_states[obj->state], obj->astate,
-			descr->name, hint);
+			obj->object, descr->name, hint);
 	}
 	debug_objects_warnings++;
 }
