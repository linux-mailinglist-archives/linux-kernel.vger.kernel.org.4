Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440856195AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDLxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:53:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658F23EB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DA95B82D0B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A109DC433C1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:53:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Stwyvq6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667562810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P1WNgGuTgzxJoGzLKQbpCX19XEa7suiDjJAeme5wj5g=;
        b=Stwyvq6ndWFJfQ9RI9PlJe1o90SSUC/RhEwc9Glcc7QUYoy67pxFENq9p8p6TWMis5mQxz
        1EZq7M5nM1QffP3DV6K43qSXBKaBRK2bAXgtA+FHb4oo0/b1Y/3brCCyPvL4Ptcp3JT3nm
        DGnPcMNHNi3V9zstwlEvdfmHH0aaBW8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24002018 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 4 Nov 2022 11:53:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: modernize documentation comment on get_random_bytes()
Date:   Fri,  4 Nov 2022 12:53:23 +0100
Message-Id: <20221104115323.161094-1-Jason@zx2c4.com>
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

The prior text was very old and made outdated references to TCP sequence
numbers, which should use one of the integer functions instead, since
batched entropy was introduced. The current way of describing the
quality of functions is just to say that it's as good as /dev/urandom,
which now all the functions are.

Fixes: f5b98461cb81 ("random: use chacha20 for get_random_int/long")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf6144c1de7d..4591d55cb135 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -384,11 +384,11 @@ static void _get_random_bytes(void *buf, size_t len)
 }
 
 /*
- * This function is the exported kernel interface. It returns some number of
- * good random numbers, suitable for key generation, seeding TCP sequence
- * numbers, etc. In order to ensure that the randomness returned by this
- * function is okay, the function wait_for_random_bytes() should be called and
- * return 0 at least once at any point prior.
+ * This returns random bytes in arbitrary quantities. The quality of the
+ * random bytes is good as /dev/urandom. In order to ensure that the
+ * randomness provided by this function is okay, the function
+ * wait_for_random_bytes() should be called and return 0 at least once
+ * at any point prior.
  */
 void get_random_bytes(void *buf, size_t len)
 {
-- 
2.38.1

