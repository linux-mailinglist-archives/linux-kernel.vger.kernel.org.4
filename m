Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C2A5BE883
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiITOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiITORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D185723B;
        Tue, 20 Sep 2022 07:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0F6622C9;
        Tue, 20 Sep 2022 14:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573DBC433D6;
        Tue, 20 Sep 2022 14:14:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qt6+LjC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663683287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGcIeiqeQ+HS0QuciXX8z8BYA5ktdXUWt1D1mDhVW+s=;
        b=Qt6+LjC5kuokCGDGfgat4875HqXzeIURqazycms/NKkiX8SYTZHrVXV45XWn5D8ygnEvhW
        AHcJvWyjE1gNwF1zKKyQN+uee5HrlRYn1A5qChtKBQHFELsXB12LiBs2jxElD0pPILKVOM
        z1PmnADb8NGYvEiVlxLUo8FWId9DMEQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e2f7f43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Sep 2022 14:14:47 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] random: throttle hwrng writes if no entropy is credited
Date:   Tue, 20 Sep 2022 16:14:38 +0200
Message-Id: <20220920141438.2782446-1-Jason@zx2c4.com>
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

This value is currently never set to zero, because the hwrng thread only
runs if it's going to be non-zero. This is an oversight, however, that
Dominik is working on fixing. In preparation for this, and so that
there's less coordination required between my tree and Herbert's, make
this currently useless, but not harmful, change here now, in hopes that
Dominik can make the corresponding change in the hwrng core later.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 16e0c5f6cf2f..520a385c7dab 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -865,9 +865,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 
 	/*
 	 * Throttle writing to once every reseed interval, unless we're not yet
-	 * initialized.
+	 * initialized or no entropy is credited.
 	 */
-	if (!kthread_should_stop() && crng_ready())
+	if (!kthread_should_stop() && (crng_ready() || !entropy))
 		schedule_timeout_interruptible(crng_reseed_interval());
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
-- 
2.37.3

