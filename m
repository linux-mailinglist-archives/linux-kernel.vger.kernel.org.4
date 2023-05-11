Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC106FF35E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjEKNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjEKNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:47:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60082CE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:47:37 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34BDlZn2062221;
        Thu, 11 May 2023 22:47:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 11 May 2023 22:47:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34BDlZsn062218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 May 2023 22:47:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
Date:   Thu, 11 May 2023 22:47:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH] debugobject: don't wake up kswapd from fill_pool()
Content-Language: en-US
To:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <000000000000008ddb05fb5e2576@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000008ddb05fb5e2576@google.com>
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

syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
(__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
Since fill_pool() might be called with arbitrary locks held,
fill_pool() should not assume that holding pgdat->kswapd_wait is safe.

Also, __GFP_NORETRY is pointless for !__GFP_DIRECT_RECLAIM allocation.

Reported-by: syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=fe0c72f0ccbb93786380
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 003edc5ebd67..986adca357b4 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 
 static void fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 
-- 
2.18.4

