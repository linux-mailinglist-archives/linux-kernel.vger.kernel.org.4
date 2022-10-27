Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB70610489
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiJ0VhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiJ0VhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:37:20 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86972B44
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:37:19 -0700 (PDT)
Date:   Thu, 27 Oct 2022 21:37:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666906638; x=1667165838;
        bh=qOqRsISaPy8WRtmUNjqUH5CrgfQe9GLu6VNSH2AUc/s=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=FUFE/3cT8xKN0tQFmfifVFz88b0tVnn05nOWRJz6RMFuyIVoScOMtmZcjMgtziie4
         MxG9YxlRRA1UA+hY94Ssevq51eqIh46gUNcIsadtfzTYTsZVlHpC7fLesKciU6Zt2+
         xelEeKGl8MdkBdbMX89Cy5JKxYobSOmElEEIlc/nwZZS87l+SX1csliEIg+0w1GaKL
         J/1bfTYwGQMKqorT/0kqwHcIrELVnln3hr54KNYGaKfGqAGOfjWnUUtGA+5GRn+Wna
         wVDAEsyeFhjQgXgEVvxCh3jGB27z5s4QceGInX2XjKV0RTHO5sWb+OgCtp2YY6UGkZ
         ZNYW9gCkxy3YQ==
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH v1] timerqueue: use rb_entry_safe() in timerqueue_getnext()
Message-ID: <20221027212506.3745164-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `timerqueue_getnext()` is called on an empty timerqueue
the returned rb_node pointer will be NULL. Using `rb_entry()`
on a potentially NULL pointer will only - coincidentally - work
if the offset of the rb_node member is 0. This is currently the
case for `timerqueue_node`, but should this ever change,
`timerqueue_getnext()` will no longer work correctly on empty
timerqueues. To avoid this, switch to using `rb_entry_safe()`.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
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


