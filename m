Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180885E5361
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIUSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIUSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39992A3D0A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9120B81D24
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E61C433C1;
        Wed, 21 Sep 2022 18:52:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kXWWoNJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663786364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRvaya5ay1AaNBwL788C8UpIUvHN1pcmxB0gggACD5I=;
        b=kXWWoNJG2TaWDq8HstkcqNh1dEcGFA0JYm3izkfwSOoG854gEC1s9Ipoj9RsYbI2gSvDun
        FUdAqeajTPCnFZzQGA0kJAFESRHtuF9ve/orq9lTP2aVTpvjdWcQOPcaIvow1G3QQBFoPb
        jbxotIpcH1w4WA1t5MtOC+7DU0CGszg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 092e0670 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 21 Sep 2022 18:52:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
Date:   Wed, 21 Sep 2022 20:52:08 +0200
Message-Id: <20220921185208.3549140-2-Jason@zx2c4.com>
In-Reply-To: <20220921185208.3549140-1-Jason@zx2c4.com>
References: <20220921185208.3549140-1-Jason@zx2c4.com>
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

Rather than rebooting into a system with no entropy, regenerate the RNG
seed before rebooting, so that the new system has a fresh seed.

Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/virt/config.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 4ab22946ff68..c41d2277de95 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -45,10 +45,18 @@ static void virt_halt(void)
 		;
 }
 
+static struct bi_record *rng_seed_record;
+
 static void virt_reset(void)
 {
 	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
 
+	if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
+		u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
+		get_random_bytes((u8 *)rng_seed_record->data + 2, len);
+		*(u16 *)rng_seed_record->data = len;
+	}
+
 	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
 	local_irq_disable();
 	while (1)
@@ -101,6 +109,8 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
 		 * length to prevent kexec from using it.
 		 */
 		memzero_explicit((void *)data, len + 2);
+		 /* Store a reference to be filled in on reboot. */
+		rng_seed_record = (void *)record;
 		break;
 	}
 	default:
-- 
2.37.3

