Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADF60060B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJQEoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJQEn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11A4DB7B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ADCBB80B37
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A3EC433D6;
        Mon, 17 Oct 2022 04:43:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hHKZuBt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665981832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5JStNHk0+LrndNMdMSbJEck91l1dLZQIDKk5fDCxAUY=;
        b=hHKZuBt1dhIZVxR7pPoKZxLznoX4ZftXyKbJQtV6fhyAYX26oVGicJpmigexe5u6UI9rK/
        YcINALw7riGAkc2dsp31wTXopBBQgHKWiZTXD6fW3+rA6H5pMLkMQKGqZ+B/QZ5ytwKMMP
        nZp+adi6HYSw3ENQ6AS+bM/xyC4G1ko=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 850eec55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Oct 2022 04:43:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     elver@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] kcsan: remove rng selftest
Date:   Sun, 16 Oct 2022 22:43:45 -0600
Message-Id: <20221017044345.15496-1-Jason@zx2c4.com>
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

The first test of the kcsan selftest appears to test if get_random_u32()
returns two zeros in a row, and requires that it doesn't. This seems
like a bogus critera. Remove it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 kernel/kcsan/selftest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 00cdf8fa5693..1740ce389e7f 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -22,13 +22,6 @@
 
 #define ITERS_PER_TEST 2000
 
-/* Test requirements. */
-static bool __init test_requires(void)
-{
-	/* random should be initialized for the below tests */
-	return get_random_u32() + get_random_u32() != 0;
-}
-
 /*
  * Test watchpoint encode and decode: check that encoding some access's info,
  * and then subsequent decode preserves the access's info.
@@ -259,7 +252,6 @@ static int __init kcsan_selftest(void)
 			pr_err("selftest: " #do_test " failed");               \
 	} while (0)
 
-	RUN_TEST(test_requires);
 	RUN_TEST(test_encode_decode);
 	RUN_TEST(test_matching_access);
 	RUN_TEST(test_barrier);
-- 
2.37.3

