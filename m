Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C564861A6C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKEBqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03912A95;
        Fri,  4 Nov 2022 18:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E430FB8303B;
        Sat,  5 Nov 2022 01:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DD4C433D6;
        Sat,  5 Nov 2022 01:46:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C9b81/Ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667612789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVfzsmyWwLOBIsDi6l8Xg2Te/JyeRyrFJMucpVazSvA=;
        b=C9b81/Ek2nHkNGMf8MG0JmpYsZBqcaY8gvrJ5CH+9WpKwgqSOagajTQt3ZjNtfdH0EsrC/
        SXByqG+69D3b/8KoH1QbomR2j1hRrZoAseDOlDeS1ZRLcFDzxACnJrZYjb4CkJWeizYvq/
        /Fkg3bp5LJOlpuEWJqXiERX1ln52Ca0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 05143520 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 5 Nov 2022 01:46:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: fdt: parse early params before adding bootloader randomness
Date:   Sat,  5 Nov 2022 02:46:13 +0100
Message-Id: <20221105014613.113503-1-Jason@zx2c4.com>
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

FDT is examined so early that it's before the first incidental call to
parse_early_param(). This is similar to EFI, except EFI actually added
an explicitly call to parse_early_param(). Let's do the same here, so
that specifying `random.trust_bootloader=0` is not ignored.

Fixes: d97c68d178fb ("random: treat bootloader trust toggle the same way as cpu trust toggle")
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/of/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7b571a631639..6d959117fd4f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1195,6 +1195,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
+		/* Parse random.trust_bootloader if it's in command line. */
+		parse_early_param();
+
 		add_bootloader_randomness(rng_seed, l);
 
 		/* try to clear seed so it won't be found. */
-- 
2.38.1

