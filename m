Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9270BED7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjEVM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjEVM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:56:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA7AA;
        Mon, 22 May 2023 05:56:12 -0700 (PDT)
Date:   Mon, 22 May 2023 12:56:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684760169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIrOEV3UUxlpbFp+rN0C9KkFZE50OIvh19Gvh/h9PPI=;
        b=AXMVhD7wnq7tAsoCB2MKnK97xN50ZcD8klFg6Wj6qviHET2vAtpn7OVFM2bxOti1SpneFS
        yGvLgyptQCLNgTbpAqZlGz+oKd0eLKKIeX9qqXSySAyqCzkdkwaU6fv6dKzHgKj3J65a27
        2oZJENG60anNOsK0iZRleQydZIgYSxfjxpKGRksOymdv2QwAXauxJyF/NvaAIAIVemFrTG
        pwITXqR9HwHHojkqxDIURt7Fp80+9Nicg+dspJzvK2JFwSX/RMKyh1/PFhoM6UHoq0xYCo
        EYhg/ykdhEmSfnUy/iCS/JhSCtclJWVW9s36vIPTamPbxVH2qQjhKIp5KgacpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684760169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIrOEV3UUxlpbFp+rN0C9KkFZE50OIvh19Gvh/h9PPI=;
        b=xOxkYSSlje/0EhkPNJm+Fc2y2qqVefNJ2o/aaP/Av0WCGIh0wH22GE53Zg4QwKacNneK1s
        AKTJKYMOtX5R+RCQ==
From:   "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Don't wake up kswapd from fill_pool()
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
References: <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Message-ID: <168476016890.404.6911447269153588182.tip-bot2@tip-bot2>
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

Commit-ID:     eb799279fb1f9c63c520fe8c1c41cb9154252db6
Gitweb:        https://git.kernel.org/tip/eb799279fb1f9c63c520fe8c1c41cb9154252db6
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Thu, 11 May 2023 22:47:32 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 May 2023 14:52:58 +02:00

debugobjects: Don't wake up kswapd from fill_pool()

syzbot is reporting a lockdep warning in fill_pool() because the allocation
from debugobjects is using GFP_ATOMIC, which is (__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
and therefore tries to wake up kswapd, which acquires kswapd_wait::lock.

Since fill_pool() might be called with arbitrary locks held, fill_pool()
should not assume that acquiring kswapd_wait::lock is safe.

Use __GFP_HIGH instead and remove __GFP_NORETRY as it is pointless for
!__GFP_DIRECT_RECLAIM allocation.

Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
Reported-by: syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp
Closes: https://syzkaller.appspot.com/bug?extid=fe0c72f0ccbb93786380
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 826c617..984985c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 
 static void fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 
