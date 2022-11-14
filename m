Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFB6289E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiKNTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiKNTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:54:38 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F5271B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:54:37 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668455673; x=1668714873;
        bh=svjeS0KSKiKaa8XQ3/EP+LqmTKTFzWL6J01aoUmFJgQ=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=RDEwWDxXj8v6CobY6tGsKiEqldkDCO/9FxGEbr3OhZJYlj0YallYth2LMsQhqIw45
         9GdEj4PpK7wbtbHIcgWaG0R+hYaXA0LcRWdY1UzO3kvlBP+i0fug0fjdrUsJECsSJz
         bukhPb0c3YyJorrazNCiY91Q6114uagSxHEpDHl0CX6TkzBY5+9cFZhr2h/7FM/vDy
         /oxlmCP0+djYLCOIkj3U0s+kD+duuKG41vy253kh5mC/J0ByTY3KGKt+rpr4Vqf4fJ
         3vpMwow0ArWpI36RpO9pkXIh/xvB8Rjv46LseA3KSJZ82VUgxCyU2ekho4xyBeE383
         ug8EEcsVRQ2/A==
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH v2] timerqueue: use rb_entry_safe() in timerqueue_getnext()
Message-ID: <20221114195421.342929-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `timerqueue_getnext()` is called on an empty timer queue, it will
use `rb_entry()` on a NULL pointer, which is invalid. Fix that by using
`rb_entry_safe()` which handles NULL pointers.

This has not caused any issues so far because the offset of the `rb_node`
member in `timerqueue_node` is 0, so `rb_entry()` is essentially a no-op.

Fixes: 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next tim=
er")
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
changes in v2:
 - reword commit message

---
 include/linux/timerqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 93884086f392..adc80e29168e 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -35,7 +35,7 @@ struct timerqueue_node *timerqueue_getnext(struct timerqu=
eue_head *head)
 {
 =09struct rb_node *leftmost =3D rb_first_cached(&head->rb_root);

-=09return rb_entry(leftmost, struct timerqueue_node, node);
+=09return rb_entry_safe(leftmost, struct timerqueue_node, node);
 }

 static inline void timerqueue_init(struct timerqueue_node *node)
--
2.38.1


