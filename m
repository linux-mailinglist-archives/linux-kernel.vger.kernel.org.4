Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4B5F85F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJHPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:47:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC94316E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A94B80B8D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE704C433C1;
        Sat,  8 Oct 2022 15:47:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C3VRJb88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665244037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHGPZI9TAFZXuftbhzouX4C1DXmHG0LSAvVwmxpYbHQ=;
        b=C3VRJb886fi2tZ+NaC9z2isSA5lG+x1IDF4DY/b+R9zp79b5EpIwINsffyKW21plsC8sXT
        5adlDd4+qGFgocfiYe+ta1U6AyDTFrMeDunoU7dF7Xua9v2EZNdjlUQ7EzDayZQbCUHIU0
        ktht4Z7SP/ct6D0yhCC4GQziOqNZv7o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8f6f8318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 8 Oct 2022 15:47:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] Revert "mfd: syscon: Remove repetition of the regmap_get_val_endian()"
Date:   Sat,  8 Oct 2022 09:47:00 -0600
Message-Id: <20221008154700.404837-1-Jason@zx2c4.com>
In-Reply-To: <Y0GZwkDwnak2ReTt@zx2c4.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
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

This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
the syscon driver. Little-endian is not effected, which means likely
it's important to handle regmap_get_val_endian() in this function after
all.

Cc: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 72a95859728a ("mfd: syscon: Remove repetition of the regmap_get_val_endian()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/mfd/syscon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 9489e80e905a..bdb2ce7ff03b 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -66,6 +66,14 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		goto err_map;
 	}
 
+	/* Parse the device's DT node for an endianness specification */
+	if (of_property_read_bool(np, "big-endian"))
+		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
+	else if (of_property_read_bool(np, "little-endian"))
+		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
+	else if (of_property_read_bool(np, "native-endian"))
+		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
+
 	/*
 	 * search for reg-io-width property in DT. If it is not provided,
 	 * default to 4 bytes. regmap_init_mmio will return an error if values
-- 
2.37.3

