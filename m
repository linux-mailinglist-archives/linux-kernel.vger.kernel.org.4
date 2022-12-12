Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA74649BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiLLKJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLLKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D472E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pHt8h8JzTw3hYQhiL9yzOA4a/UjkavQuV0JP+2drbGA=;
        b=ug2mmPYD1Hk2tOWgKJvsGdKbLV8ywocnw3C/NxFdq4oRH+YURUyp7o3Y0966JCZLdXVDNJ
        GJMFYIGwSvnVG7xj7Sj/kp/TupMW2UbLWwFSBoU6AZplLGlhDptiGkxgXrJ0/07lIqcVSH
        fktPPTVIaTDCs/LkdtKBAL0a51G95UIUtLfJczwiZaMYNREl4suBvo1X5GItwwG0JMxgvn
        lkPzqpJGFPmBYnZOJcHcALpaQEv8CQxYTLUM5mMHjrvQE1yejS479HcwmOvt8BUJA7cLqR
        GHnw7fThvf4Ao0GQEJrMQSQlXGMyFOJ0LY2SuG0ShYkj/1La6aQcGQnqH0diWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pHt8h8JzTw3hYQhiL9yzOA4a/UjkavQuV0JP+2drbGA=;
        b=9NPtAVGNn53FR8UPssaJg7moS2Hsi8ZvDmpdhY4JxoifQa0Su3B3X1rBg7xl/TFH5lTisU
        kyEMpsuvdu2LJDAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083907908.564878.17662405881760397931.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:00 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2022-12-10

up to:  c4db2d3b70e5: debugobjects: Print object pointer in debug_print_objec=
t()

A single update for debugobjetcs:

  Add the object pointer to the debug output for better correlation with
  other debug facilities.


Thanks,

	tglx

------------------>
Stephen Boyd (1):
      debugobjects: Print object pointer in debug_print_object()


 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 337d797a7141..4c670d3b6965 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -500,9 +500,9 @@ static void debug_print_object(struct debug_obj *obj, cha=
r *msg)
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

