Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2C611709
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJ1QHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJ1QG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:06:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EED36795
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:05:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so7139193wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwmCRs4VSiMfypRrD7D2mR4onALfK9W6TO7PXOA1Xlw=;
        b=fTjuqZyXsmSTk2cIPQ/0aCdcmB+/FsutYK3NdLqf0DNci1I6j4hl4AqlqJPNqSeZB5
         iDopaXFIaQajYePTXR/Usccjn+rhQ9YX6MbdOUr0ZesAHQlVZooI4D5brDiy7dhu7agq
         Q/NstEV5l8VKCLuC9BJpvAswKqto1GtwHQh+Hw40PzQiaCjkBS6jy3nbos9b9boaZlmY
         X2pFBOtPo/H288fAyaWlJY5gX5XDRG96CynvLC8nfaSz1HNYXON2ICyXFoZdGqeyA1ey
         VtWHe6HwzBGqTVOm7vA8I5pQlC1XDtdkd4p4fIyvk7gHki9UnZeRYFFL1pj4YmTx47gq
         0L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwmCRs4VSiMfypRrD7D2mR4onALfK9W6TO7PXOA1Xlw=;
        b=3RqoLDZ8tO9HaRkaeYfFQW9Po8RkT4dg/E/Us9IJNfBKd2g9qZQNxlASek2KDRXBrK
         a7FIhyAc4kf3Lg5ZJN0Cmg9hAr3358UGSGnuP/Sha9kbPUhdDBlsb1ym0ZsYwtjmERLv
         3xisawhc47AiWfUpH/5tg/WdhEzEZ8GMcPvo1zxXCwLMr3Nwmv+EJyHJQRzfx4dfWsy3
         mPg8nvpLo1Mn6u5yQLOkgSezwPYCpWrZaoW3wLBVJoCAH3J7HrhDvuoBbzb8GV+QnEO6
         fnh8PLsrAPD3C8AdNgGlbzMbbCldboGjN1RvtoPJCUmrHO9LrjfsPkOUevzJnNu24nFP
         P9hw==
X-Gm-Message-State: ACrzQf1svB+2tyRwhYoTHG8suV7JGn7Y65ZH3Za89AHPDTqjc7nXhY2P
        kFMZJeQLM43kLZxuxEKI7fFFzw==
X-Google-Smtp-Source: AMsMyM6LAIow3wsRy3i/XkJRAuc+KOqBrJiL8BkCF5fHKU+6HuYulPKWA1OkiKQ5ODgHDgEeChW/0g==
X-Received: by 2002:adf:f384:0:b0:236:64ad:c958 with SMTP id m4-20020adff384000000b0023664adc958mr63408wro.174.1666973126321;
        Fri, 28 Oct 2022 09:05:26 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id dn10-20020a05600c654a00b003a3170a7af9sm4560049wmb.4.2022.10.28.09.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:05:25 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason@zx2c4.com, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, andre.przywara@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] random: Use arch_get_random*_early() in random_init()
Date:   Fri, 28 Oct 2022 17:00:42 +0100
Message-Id: <20221028160041.753052-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reworking the archrandom handling, commit d349ab99eec7 ("random:
handle archrandom with multiple longs") switched to the non-early
archrandom helpers in random_init(), which broke initialization of the
entropy pool from the arm64 random generator.

Indeed at that point the arm64 CPU features, which verify that all CPUs
have compatible capabilities, are not finalized so arch_get_random_seed_longs()
is unsuccessful. Instead random_init() should use the _early functions,
which check only the boot CPU on arm64. On other architectures the
_early functions directly call the normal ones.

Fixes: d349ab99eec7 ("random: handle archrandom with multiple longs")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/char/random.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2fe28eeb2f38..085af17c32f5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -791,13 +791,14 @@ void __init random_init_early(const char *command_line)
 #endif
 
 	for (i = 0, arch_bits = sizeof(entropy) * 8; i < ARRAY_SIZE(entropy);) {
-		longs = arch_get_random_seed_longs(entropy, ARRAY_SIZE(entropy) - i);
+		longs = arch_get_random_seed_longs_early(entropy,
+							 ARRAY_SIZE(entropy) - i);
 		if (longs) {
 			_mix_pool_bytes(entropy, sizeof(*entropy) * longs);
 			i += longs;
 			continue;
 		}
-		longs = arch_get_random_longs(entropy, ARRAY_SIZE(entropy) - i);
+		longs = arch_get_random_longs_early(entropy, ARRAY_SIZE(entropy) - i);
 		if (longs) {
 			_mix_pool_bytes(entropy, sizeof(*entropy) * longs);
 			i += longs;
-- 
2.37.3

