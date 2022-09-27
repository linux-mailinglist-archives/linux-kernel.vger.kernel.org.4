Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CC5EBE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiI0J3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiI0J3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D80DB8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B8A61744
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19B1C433C1;
        Tue, 27 Sep 2022 09:29:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SJGYEiFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664270966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9W5E7M/w9APGO+1+fBgGOIMFZmpa2y+XwGEkMLLuG+U=;
        b=SJGYEiFftVoj3+y9MTwu3M/mnRY1YtJXhLEF3TSa9Y1dxCWREqOhbW6ipgPkKpI+pVQ2ah
        M/oWg3Kml1LXVuWOB63h9/nrpJXM95py3HBKuKp97ienAoY3Mlz8TwORo4nZdlDiE1LXVg
        hqMq434+kl4+EKD6sEr34xZnQWyaKb4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39a5dfb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 09:29:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] random: use init_utsname() instead of utsname()
Date:   Tue, 27 Sep 2022 11:29:20 +0200
Message-Id: <20220927092920.1559685-1-Jason@zx2c4.com>
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

Rather than going through the current-> indirection for utsname, at this
point in boot, init_utsname()==utsname(), so just use it directly that
way. Additionally, init_utsname() appears to be available nearly always,
so move it into random_init_early().

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0598450c72aa..eab334a425a1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -802,6 +802,7 @@ void __init random_init_early(const char *command_line)
 		++i;
 	}
 
+	_mix_pool_bytes(init_utsname(), sizeof(*(init_utsname())));
 	_mix_pool_bytes(command_line, strlen(command_line));
 
 	if (trust_cpu)
@@ -817,7 +818,6 @@ void __init random_init(void)
 	unsigned long entropy = random_get_entropy();
 	ktime_t now = ktime_get_real();
 
-	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
 	_mix_pool_bytes(&now, sizeof(now));
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	add_latent_entropy();
-- 
2.37.3

