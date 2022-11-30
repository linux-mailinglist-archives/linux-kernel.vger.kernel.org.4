Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76DF63CD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiK3CI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiK3CIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:08:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3EB61BBE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D961C61975
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4D6C43470;
        Wed, 30 Nov 2022 02:08:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SzFBB6kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669774100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qx27PPQsL8B5UR3meaN6u0WkQxvqKygl6e21SY/4K90=;
        b=SzFBB6kvF0S7FWPQPSyvgKOElnuPY/k6YToCSxAvEYG6ayB/lCZrlLJoeDSmKMzOWpDOvF
        +eJ44cerf8wDRfviChonRji1TWeqdFRyzhXKZvEGchTW0sdnGBWe7vUfxAGfZHX/+n8I09
        d1L9sHYnivH1GgpRRwhhsfftoV6k250=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 877dbd7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 02:08:19 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] random: align entropy_timer_state to cache line
Date:   Wed, 30 Nov 2022 03:08:15 +0100
Message-Id: <20221130020815.283814-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The theory behind the jitter dance is that multiple things are poking at
the same cache line. This only works, however, if those things are
actually all in the same cache line. Ensure this is the case by aligning
the struct on the stack to the cache line size.

On x86, this indeed aligns the stack struct:

 000000000000000c <try_to_generate_entropy>:
 {
    c:  55                      push   %rbp
-   d:  53                      push   %rbx
-   e:  48 83 ec 38             sub    $0x38,%rsp
+   d:  48 89 e5                mov    %rsp,%rbp
+  10:  41 54                   push   %r12
+  12:  53                      push   %rbx
+  13:  48 83 e4 c0             and    $0xffffffffffffffc0,%rsp
+  17:  48 83 ec 40             sub    $0x40,%rsp

Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 67558b95d531..2494e08c76d8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
 static void __cold try_to_generate_entropy(void)
 {
 	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
-	struct entropy_timer_state stack;
+	struct entropy_timer_state stack ____cacheline_aligned;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
 	int cpu = -1;
-- 
2.38.1

