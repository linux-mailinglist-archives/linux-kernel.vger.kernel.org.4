Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A4706C97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjEQPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjEQPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:25:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7F212B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:25:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561c11762b7so12678777b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337100; x=1686929100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ggg47owN/Xa0YfR4lvdlUbhDdcBcrmCX/I8JB/8yL0=;
        b=iUZSQG6ScPLcLq5ulkvVrIeqQDnsoRuyidNQGdtRFKt7tpBxxL6slfGHKU3gnCz2I2
         b1XoGHuOGD4cmSOGjLq7TarDVgMZf9GLQwDDWDAcMiSXI2l0NDxy3d2mItAwcYNvgiUH
         wr5m0OBOmqARgvMuwXUy97Mt3W7avGpXRPmDpiNeHQ8LVukmA/j2m2az/5RKHGQ0LqAy
         vfUexmRIkwBvMs13J606b8qF4j0fQzdDo+pvNAAJ6SZbGHH62HjCco/IQmzTQ9Yn5XCK
         fDxbG03ur49Z4FDV4YHnK9w7KM9JmDJnSHMgOR7eHROfHIPmONZSQd3ptYzJW+UPuTY2
         o+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337100; x=1686929100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ggg47owN/Xa0YfR4lvdlUbhDdcBcrmCX/I8JB/8yL0=;
        b=M60XrRRWCCEZeNITzprpYjGrrE1Evm47MAgw/PJvpMYe6Pp8FYIR4Cz65sR/WXqMqy
         SLHffp9ev8yXx9uUkerI82XR0O542rAwn82n8AaAWsfOdKn9sAnwdaqCd3t3Jm0yujhQ
         G1VJMn1CLJVM9B3siBNmCHZZPNM5gqdCB03IKKRBjfICNlsVWh2Yec7P0JHndfmbcUOy
         LuPg7Kadrou5GqbOYB4gc1l3ztrm/6tGdPO0HCG686LZgu9yvW00RxH0K+Emu5wmIE6h
         vuyhq3qWyEYy1j51jMKoQ/bg3fevsKKvnM5mg/9NgsU1lvW7mmqDbUlfrm8cfDqNlKyu
         YWLQ==
X-Gm-Message-State: AC+VfDytyenVCUWPF4nY2S5QL29rjgM+JotwGyZxtIQvjiXzhM8x+0KO
        CKiYgoWLou7/NupaPhEXp4zaYmV+yTDP
X-Google-Smtp-Source: ACHHUZ4PQdUXCCSLAtIZYL+7QWe9+mOuCPbxsm7ZroHCGZyIkmyybZwdcP1YWAVjFJjhuga1Q1j8HHkO7ivC
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:3c32:ed06:dc65:d66f])
 (user=jwylder job=sendgmr) by 2002:a81:b70b:0:b0:561:8fc0:24af with SMTP id
 v11-20020a81b70b000000b005618fc024afmr3497273ywh.9.1684337100529; Wed, 17 May
 2023 08:25:00 -0700 (PDT)
Date:   Wed, 17 May 2023 10:20:11 -0500
In-Reply-To: <20230517152444.3690870-1-jwylder@google.com>
Mime-Version: 1.0
References: <ZGQqzlU7XPF+rS8c@finisterre.sirena.org.uk> <20230517152444.3690870-1-jwylder@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517152444.3690870-2-jwylder@google.com>
Subject: [PATCH] regmap: Account for register length when chunking
From:   Jim Wylder <jwylder@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Jim Wylder <jwylder@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when regmap_raw_write() splits the data, it uses the
max_raw_write value defined for the bus.  For any bus that includes
the target register address in the max_raw_write value, the chunked
transmission will always exceed the maximum transmission length.
To avoid this problem, subtract the length of the register and the
padding from the maximum transmission.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index db7851f0e3b8c..fa2d3fba6ac9d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2082,6 +2082,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2089,8 +2091,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;

base-commit: ad2fd53a7870a395b8564697bef6c329d017c6c9
-- 
2.40.1.606.ga4b1b128d6-goog

