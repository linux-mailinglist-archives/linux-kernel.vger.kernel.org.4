Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45A6FF8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbjEKRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386479017
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965a68abfd4so1688746266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827683; x=1686419683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RoJ+WGkxh0ZHVALKBMRWYolMs636xMb4Qisk/gwfjs=;
        b=ohekcepe//LFr5zpuoHNeKD0oiWjGL6PPy+KvkT48GgRyJpCA915dx5U0lHy/4dHwO
         My7I7b3iOESC5OqLgG2M6u9s+gqIFcOnWZDC6+loysJBsjmuuSQYYnFaM72rv2meH5cY
         FCynMxoT0lhz6PY26g0TjGcybTWn2ZPK+8MFzNRXyE1eigo94PkjTPaEMgLJyLWRycry
         h2KV+SjKP3IWnqYxTsfkF2czExFaeFH/ehVVJJly+O+wTJFrdrr4eBF9UiMzoJVYBmHj
         8P2ZW1YKw+I8JO6E4T2BoomZ0RmrRTwS+qPgm9dMXmO7z7+ANehQaM+NjzBmp4eMDj0Q
         530Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827683; x=1686419683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RoJ+WGkxh0ZHVALKBMRWYolMs636xMb4Qisk/gwfjs=;
        b=VIXXp/oW6ujSnIpusl02AFWdwITZ9JmNA2/ANu9dOZ5LzxP0qX/spPJkum5D0sQopS
         51kEFcsD69A9QpPplpFXdzOU+phhE6e2zHhieL/iEpaPATEt1t+cfEj4lFh4h1+4oHGo
         pTXFHMJEIeKch79Wb+FFL5uyTk1T99GTMl/FUv3sjXNCUWm9+GIKfxcDaRkFsYL4Cz+7
         2HZnS//tn5aKdFx3mrObruKGHwIAx+smGxJEVQ1ucxNNwspfP3Fm34rj6tx0ay60RPW/
         HNRsQ6MGRkzZKBBPRfuSJbCOsGslRKco3ICV+hJfRDloogZ1FyTSfd+dKlqJWNCDpsgN
         JH7Q==
X-Gm-Message-State: AC+VfDw0oXlWWVL8VPOYrII7zBSjkHVi5zXyCr5fgIBsShgdO1vidfKm
        3yDyLAA7au//vBaBZzeseeDdg38wGL7YhKGWvkIhgg==
X-Google-Smtp-Source: ACHHUZ4G1UFJ2ox7eH2dZNDJA2jlm8ardAVzt337eSwI5HyBnu4z6t743/TnUsK6yVetee6JY4bI1A==
X-Received: by 2002:a17:907:7b9b:b0:957:db05:a35d with SMTP id ne27-20020a1709077b9b00b00957db05a35dmr23846516ejc.48.1683827683546;
        Thu, 11 May 2023 10:54:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id ty20-20020a170907c71400b0096621340285sm4290928ejc.198.2023.05.11.10.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:54:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RESEND PATCH] media: i2c: video: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:54:41 +0200
Message-Id: <20230511175441.281940-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/i2c/video-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index dddf9827b314..abd472dcd497 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -274,7 +274,7 @@ static const struct hwmon_channel_info amg88xx_temp = {
 	.config = amg88xx_temp_config,
 };
 
-static const struct hwmon_channel_info *amg88xx_info[] = {
+static const struct hwmon_channel_info * const amg88xx_info[] = {
 	&amg88xx_temp,
 	NULL
 };
-- 
2.34.1

