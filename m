Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CCD63CD38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK3CQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3CQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:16:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1692FFD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 814F1B818C8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9871C433D6;
        Wed, 30 Nov 2022 02:16:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UMY2879q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669774598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UvY82SL3PoD6trW0Q0JTR9srAO10ODzpjZi+3KaLE1w=;
        b=UMY2879qlQs39InAkp9Cjhs1OW5NqbDFpoJK6yiDJ+A7Ek+r5NcybpznrpcgyXDBVuxVm+
        NwBHUdFWvnQap36KbArhIXpSDY9OgofjvegrtnnacdJe1bG4IRDiXdQWV/ZHfHrtQWpvfX
        cJXbCuyImeWaSdthrLUrrd+HVx2JZQ8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 874ea4eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 02:16:37 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: mix in cycle counter when jitter timer fires
Date:   Wed, 30 Nov 2022 03:16:33 +0100
Message-Id: <20221130021633.300422-1-Jason@zx2c4.com>
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

Rather than just relying on interaction between cache lines of the timer
and the main loop, also explicitly take into account the fact that the
timer might fire at some time that's hard to predict, due to scheduling,
interrupts, or cross-CPU conditions. Mix in a cycle counter during the
firing of the timer, in addition to the existing one during the
scheduling of the timer. It can't hurt and can only help.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2494e08c76d8..69ea6cb14a86 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1250,7 +1250,9 @@ struct entropy_timer_state {
 static void __cold entropy_timer(struct timer_list *timer)
 {
 	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
+	unsigned long entropy = random_get_entropy();
 
+	mix_pool_bytes(&entropy, sizeof(entropy));
 	if (atomic_inc_return(&state->samples) % state->samples_per_bit == 0)
 		credit_init_bits(1);
 }
-- 
2.38.1

