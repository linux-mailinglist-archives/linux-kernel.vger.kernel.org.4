Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF685EE247
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiI1Quk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiI1Quc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2FD7754A;
        Wed, 28 Sep 2022 09:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 887B061F2D;
        Wed, 28 Sep 2022 16:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE28C433D6;
        Wed, 28 Sep 2022 16:50:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BtbkVSOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664383824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MPljTNW527gCkehfhx8+XdIZwq9wSOk7roP1gIrDLuo=;
        b=BtbkVSOzwf0mLL7A4X2f+vXElefHugzoYFA0h0lt2b6NqsFsPkYD5Vju2wkvDmmW8X8jSC
        GxUeZzLv2cKZ4dngbOw6SPyH4Z2gW+DFa7/DUWw3yVK7NuRGF6KOeyDEq/x/G23+grpgxc
        32Icf+qZ/9i78XsM+sRklrylcE9Q0Qs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ef8b7b80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 28 Sep 2022 16:50:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: add 8-bit and 16-bit batches
Date:   Wed, 28 Sep 2022 18:50:18 +0200
Message-Id: <20220928165018.73496-1-Jason@zx2c4.com>
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

There are numerous places in the kernel that would be sped up by having
smaller batches. Currently those callsites do `get_random_u32() & 0xff`
or similar. Since these are pretty spread out, and will require patches
to multiple different trees, let's get ahead of the curve and lay the
foundation for `get_random_u8()` and `get_random_u16()`, so that it's
then possible to start submitting conversion patches leisurely.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 2 ++
 include/linux/random.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f2aa3ab1b458..64ee16ffb8b7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -506,6 +506,8 @@ EXPORT_SYMBOL(get_random_ ##type);
 
 DEFINE_BATCHED_ENTROPY(u64)
 DEFINE_BATCHED_ENTROPY(u32)
+DEFINE_BATCHED_ENTROPY(u16)
+DEFINE_BATCHED_ENTROPY(u8)
 
 #ifdef CONFIG_SMP
 /*
diff --git a/include/linux/random.h b/include/linux/random.h
index a9e6e16f9774..2c130f8f18e5 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -38,6 +38,8 @@ static inline int unregister_random_vmfork_notifier(struct notifier_block *nb) {
 #endif
 
 void get_random_bytes(void *buf, size_t len);
+u8 get_random_u8(void);
+u16 get_random_u16(void);
 u32 get_random_u32(void);
 u64 get_random_u64(void);
 static inline unsigned int get_random_int(void)
-- 
2.37.3

