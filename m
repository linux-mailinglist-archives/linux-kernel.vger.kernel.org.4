Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184C76F93BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEFTLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750F19B3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 12:11:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683400273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5qxPxJdjuzi5qhtVxwUOhNdmUZonUWqsXS+jNUmuk0=;
        b=glbdR3nQy0v0FmLLwbJPzJIr/nC8Ko4NHF3xbdxGHAbLZqP/SjinMYpsXgaHt2WXRPM6IQ
        AdZXWxogLrUI0phpw71gTb7vlVQDYbEhaWDV39mqE861xiV/bRInlBfZquJowH9+NEkdsZ
        2t+1cJSpoTUhqgoyw0oCIi9x+259iE+iz3NEkKHMsqZwW5ZVLwjzwDupdUgCJZeC16y+nV
        wCoHrimKSWsPZlsPMZzMq7ySnVbulJXJVgsDHGWwj2a/hTuCC7bGfA8Wc7GxuwhDUlYDHT
        BMKFM8/g8HqU7d0Q0T56XATQaqyk7F2+SEjOj63dQFUl5cbe0c+zJr8pE4BCoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683400273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5qxPxJdjuzi5qhtVxwUOhNdmUZonUWqsXS+jNUmuk0=;
        b=QJBJMPLk0h6VCOZ4WHml9TEXWtpTP0e1JLuMsBr6EbUsF9qO8GtSNASEW7ev8tZ1+z/Yuw
        Xd1u6PpZFk97YsDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.4-rc1
Message-ID: <168340025919.2105360.9722828595496474732.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sat,  6 May 2023 21:11:13 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2023-05-06

up to:  0af462f19e63: debugobject: Ensure pool refill (again)


A single fix for debugobjects:

  The recent fix to ensure atomicity of lookup and allocation inadvertently
  broke the pool refill mechanism, so that debugobject OOMs now in certain
  situations. The reason is that the functions which got updated no longer
  invoke debug_objecs_init(), which is now the only place to care about
  refilling the tracking object pool.

  Restore the original behaviour by adding explicit refill opportunities to
  those places.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      debugobject: Ensure pool refill (again)


 lib/debugobjects.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b796799fadb2..003edc5ebd67 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -587,6 +587,16 @@ static struct debug_obj *lookup_object_or_alloc(void *ad=
dr, struct debug_bucket
 	return NULL;
 }
=20
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
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int ons=
tack)
 {
@@ -595,12 +605,7 @@ __debug_object_init(void *addr, const struct debug_obj_d=
escr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
=20
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
+	debug_objects_fill_pool();
=20
 	db =3D get_bucket((unsigned long) addr);
=20
@@ -685,6 +690,8 @@ int debug_object_activate(void *addr, const struct debug_=
obj_descr *descr)
 	if (!debug_objects_enabled)
 		return 0;
=20
+	debug_objects_fill_pool();
+
 	db =3D get_bucket((unsigned long) addr);
=20
 	raw_spin_lock_irqsave(&db->lock, flags);
@@ -894,6 +901,8 @@ void debug_object_assert_init(void *addr, const struct de=
bug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
=20
+	debug_objects_fill_pool();
+
 	db =3D get_bucket((unsigned long) addr);
=20
 	raw_spin_lock_irqsave(&db->lock, flags);

