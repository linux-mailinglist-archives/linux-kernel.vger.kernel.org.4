Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31C62D85D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiKQKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiKQKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:48:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472556451;
        Thu, 17 Nov 2022 02:48:35 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668682114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4IFvxSet/7PW9ySTqnRUqNtH6uQwRwx3Vdr6bt1r3Y=;
        b=SxwCtBv/ekx6NQB4zVKghpecvlg27/GyeII9aDCqUQxCG36KKBUFes3vPodD+m8N0hy5b9
        PZQGkm6/4qfoHEAz+UPhDAsQBiT9314ed7mt4GgexNpjmcW20URTm5DXNb4yD17rB7d2wS
        3HzEyxoc98IxklznjPDypE4JgUZjHyS2BKdLR0QPQglLoF/cz76FfR/UrBPLVzf0//7Bl4
        uHHaV8Mr048+JDBG6qC8e86dF61IsJLZiNgynst3IrUkuudKQmnNUj82SV8L6hDcixADbE
        MyKSHV4J8Xg99k6PhEmHLr3veB48gyaGnFPwrYQnMExKW1qHcluDuULTzlKVrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668682114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4IFvxSet/7PW9ySTqnRUqNtH6uQwRwx3Vdr6bt1r3Y=;
        b=Uc3WIGXZIN+9FKyGH09zopYS0lg2imKGg0GDx1lM9Xu/7NXVZ/m+PjkC2oXyrLPORCdbBq
        pIfsKk2Lz8jPdGAA==
From:   tip-bot2 for =?utf-8?q?Barnab=C3=A1s_P=C5=91cze?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timerqueue: Use rb_entry_safe() in timerqueue_getnext()
Cc:     pobrn@protonmail.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221114195421.342929-1-pobrn@protonmail.com>
References: <20221114195421.342929-1-pobrn@protonmail.com>
MIME-Version: 1.0
Message-ID: <166868211308.4906.2733783319911974339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2f117484329b233455ee278f2d9b0a4356835060
Gitweb:        https://git.kernel.org/tip/2f117484329b233455ee278f2d9b0a43568=
35060
Author:        Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
AuthorDate:    Mon, 14 Nov 2022 19:54:23=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 11:26:20 +01:00

timerqueue: Use rb_entry_safe() in timerqueue_getnext()

When `timerqueue_getnext()` is called on an empty timer queue, it will
use `rb_entry()` on a NULL pointer, which is invalid. Fix that by using
`rb_entry_safe()` which handles NULL pointers.

This has not caused any issues so far because the offset of the `rb_node`
member in `timerqueue_node` is 0, so `rb_entry()` is essentially a no-op.

Fixes: 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next timer=
")
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221114195421.342929-1-pobrn@protonmail.com

---
 include/linux/timerqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 9388408..adc80e2 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -35,7 +35,7 @@ struct timerqueue_node *timerqueue_getnext(struct timerqueu=
e_head *head)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&head->rb_root);
=20
-	return rb_entry(leftmost, struct timerqueue_node, node);
+	return rb_entry_safe(leftmost, struct timerqueue_node, node);
 }
=20
 static inline void timerqueue_init(struct timerqueue_node *node)
