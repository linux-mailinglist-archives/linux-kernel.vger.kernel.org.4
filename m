Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D405E783F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIWK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIWK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34266122634
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E7F6123F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA911C433D6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:26:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M8R6qgI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663928788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgWPyzZNjKxy0P2YXKLOdQ3Qr9+tTm5v6GiBVGnh5ts=;
        b=M8R6qgI2/KFogmJnRbiITSqWktoq0R5NDFvI9tkKeJfSsikLsrjkIwC3+neOP3mvb8sRaX
        5HAaYVqc++JhG85Ke8PPfY1iuq3c5pSPdnridNXCxD6pY0muffCYfByUQrRA5dSFP09vOt
        RsOQSaqK8TTSjC3kD+q1C96G5fF0HDs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ecdf6b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Sep 2022 10:26:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: clamp credited irq bits to maximum mixed
Date:   Fri, 23 Sep 2022 12:26:15 +0200
Message-Id: <20220923102615.3890383-1-Jason@zx2c4.com>
In-Reply-To: <20220923092204.3818698-1-Jason@zx2c4.com>
References: <20220923092204.3818698-1-Jason@zx2c4.com>
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

Since the most that's mixed into the pool is sizeof(long)*2, don't
credit more than that many bytes of entropy.

Fixes: e3e33fc2ea7f ("random: do not use input pool from hard IRQs")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 520a385c7dab..2f370aa248b2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1004,7 +1004,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	local_irq_enable();
 
 	mix_pool_bytes(pool, sizeof(pool));
-	credit_init_bits(max(1u, (count & U16_MAX) / 64));
+	credit_init_bits(clamp_t(unsigned int, (count & U16_MAX) / 64, 1, sizeof(pool) * 8));
 
 	memzero_explicit(pool, sizeof(pool));
 }
-- 
2.37.3

