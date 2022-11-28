Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A327B63A64C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiK1KoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiK1KoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:44:05 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE34D2FB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:44:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so7944343ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEdrYKs1l92oDoYXxk/BBvzoFFgUAzw23QwIrQ7Ayls=;
        b=Ws0PVJEKda0rkFvC7nwwPxm+jr9N8y6LLGY86fewpXTBEcN266byjmpKuT8y4pcBb9
         aiaa+GJkv7YJ1Mr/KMf1CUZZ0wI7oNytrPLz8F56EJKDRkPlo7MTm9ArDqCbUP8PWPxR
         FaH7kOiqdmAadf/taxH6DDNUp+m3EwxmvAdD2rS2Tn/gH/vtAV+cHGiYKn4YY4H3lJ2v
         ci2W/F0zevESqQW6oRNCX4+duWKMVr2evISA5EzQLq8dQHET9NY3NAucQimS1r9wnbjU
         hBRwJ+tUevHRFNilJwUFFjmQOopPOZ/JnPDGVwzKnIAApGxs97g2c8GTaA2WbS52MXqe
         Z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEdrYKs1l92oDoYXxk/BBvzoFFgUAzw23QwIrQ7Ayls=;
        b=SsHldXRfKYzPkup7s5snmG1NODxZzM+Sqvh1OuSoiHRxG5M2HO2FSSm2Xi2trk9xzZ
         yle9z+oF/14ePGJYy2s3O078aJgh4cuQGwsoJx37iH+VY5K0nhrhpx9Y09E3pLxnLX3n
         6LKPtsE5rHTRAKM3mF9uhI0BUbLAiJXWW/kwHEprr6ht/Ff6kVp3sk+yJbf2DlTPgFcy
         mSrRn5haSdMcNGC6LQovAqsT2f7u/ZZlbi3+WxLEcYjhTVL/jbP8TJSlmfZr/T4W+QT1
         aDzSY34KVvxuv19dh8qrmSXFy3/K27+ZnxqHVj2U1tdd6ZdLFn6BTX3p+PTTNc1h6C6x
         ToBg==
X-Gm-Message-State: ANoB5pktF6lQEG0x5TKuJX/CJnM6rTktEj//U2T10ZCDwYiui0jueh3I
        6hI3+vdXjnIpGTwA/ldKN8c8mw==
X-Google-Smtp-Source: AA0mqf5HudkU8INv7wBUqk4m7SlIyNLIbgdN0FTTra8wHpjxNPzegalto1m1ocNxUGKkgFjbaATbnw==
X-Received: by 2002:a05:651c:b26:b0:277:9847:286a with SMTP id b38-20020a05651c0b2600b002779847286amr10427471ljr.309.1669632242561;
        Mon, 28 Nov 2022 02:44:02 -0800 (PST)
Received: from localhost (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004afc1607130sm1667108lfr.8.2022.11.28.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:44:01 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     elver@google.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        davidgow@google.com, Jason@zx2c4.com,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] kernel: kcsan: kcsan_test: build without structleak plugin
Date:   Mon, 28 Nov 2022 11:43:58 +0100
Message-Id: <20221128104358.2660634-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Building kcsan_test with strucleak plugin enabled makes the stack frame
size to grow.

kernel/kcsan/kcsan_test.c:704:1: error: the frame size of 3296 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Turn off the structleak plugin checks for kcsan_test.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/kcsan/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 4f35d1bced6a..8cf70f068d92 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -17,4 +17,5 @@ KCSAN_INSTRUMENT_BARRIERS_selftest.o := y
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
 CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
+CFLAGS_kcsan_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
-- 
2.35.1

