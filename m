Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA675E81C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiIWS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIWS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70193123845
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD1E061852
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858ACC433C1;
        Fri, 23 Sep 2022 18:29:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bWL3YQUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663957740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x5diehr+PLPQnahzXFkfrnEatWD+TKm3celsdu2ut0E=;
        b=bWL3YQUxU+fSPggS2C5pR6oaL/glLUOywHqIswZHJs5QO/cmyQ84G9gtsHPlyV7+6nuc8r
        RBvixOrH0ElklJJnXuPoakGEyBMLDg54h2fqhIpwwVDzpDEAEYWtUuwIQc2IQZ4CBn9YSS
        zrSgVXtxXlT0bUREyjzGuj5JtYtmBVo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 60ee715c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Sep 2022 18:29:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] random: avoid reading two cache lines on irq randomness
Date:   Fri, 23 Sep 2022 20:28:49 +0200
Message-Id: <20220923182849.4145148-1-Jason@zx2c4.com>
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

In order to avoid reading and dirtying two cache lines on every IRQ, move
the work_struct to the bottom of the fast_pool struct. add_interrupt_
randomness() always touches .pool and .count, which are currently split,
because .mix pushes everything down. Instead, move .mix to the bottom,
so that .pool and .count are always in the first cache line, since the
.mix is only accessed when the pool is full.

Fixes: 58340f8e952b ("random: defer fast pool mixing to worker")
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2f370aa248b2..a90d96f4b3bb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -918,10 +918,10 @@ EXPORT_SYMBOL_GPL(unregister_random_vmfork_notifier);
 #endif
 
 struct fast_pool {
-	struct work_struct mix;
 	unsigned long pool[4];
 	unsigned long last;
 	unsigned int count;
+	struct work_struct mix;
 };
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
-- 
2.37.3

