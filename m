Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD1611E45
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJ1XrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJ1XrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:47:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9591D6399
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 307C9B82DCF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F0C43470
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:47:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DFRcfkq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667000819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CwZILQgNTZsVEIwqxKFfIsjiCXqQfDBaZH788lgziH0=;
        b=DFRcfkq1Ng24NRdy/88nPKsaCy02Dw0AQ2CXUtOy+OFDnCmH1dUhEF42obGAIQh+IhQpNB
        unCHHOHrjuoH0oGcmY3OCEo92hnUnsObTvPLWg3hC4Mb4Obc0VwQjzKJiwX20ym2oUztpR
        gd1idHPJOqim/JceqDwO5gwNelyXtUE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d13eef6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 28 Oct 2022 23:46:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: do not include <asm/archrandom.h> from random.h
Date:   Sat, 29 Oct 2022 01:46:55 +0200
Message-Id: <20221028234655.98770-1-Jason@zx2c4.com>
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

The <asm/archrandom.h> header is a random.c private detail, not
something to be called by other code. As such, don't make it
automatically available by way of random.h.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 1 +
 include/linux/random.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e3cf4f51ed58..a7afd17db075 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -55,6 +55,7 @@
 #include <linux/siphash.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
diff --git a/include/linux/random.h b/include/linux/random.h
index 2bdd3add3400..47e7cf126e8f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -151,8 +151,6 @@ declare_get_random_var_wait(long, unsigned long)
  */
 #include <linux/prandom.h>
 
-#include <asm/archrandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.38.1

