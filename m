Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CD6FF8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjEKRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjEKRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:46:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE819BA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:46:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1593983766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827214; x=1686419214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w10pXzBXXA8TvY3Yamk/BTpqwZGim8+uZJGGktQkRcU=;
        b=M0II5MKSdmQmnrtsEzOojZkt5itSV6IRUkyFPhsF7OHlccuPFX5bqhcFqdCULySxAs
         Xl5IogWe7chmAQy132m3jdounJJrF7BhXBX/Mwk0Hjf40BU1/3wDGvrqU+OLWRzUIx8I
         4jF50D9NLQ82ir5XFkiYtSsSdGblENEDcIdMOSWoBUPq9vPM0yhT6Q/TObpnh8tmdPZP
         8qnz9AUqdVcXjy8o4O8j0V1x1Z7TboBzaI4GfW2DdMhK7Ke/wz+mmMcfO7fv4smydRtZ
         3cA+8j8uSTPK3OH0Fu868BDdlCZDZ4cvVM8LwCez7o2S6QN6X4w1yhVqca0G9tPAuAWI
         eaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827214; x=1686419214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w10pXzBXXA8TvY3Yamk/BTpqwZGim8+uZJGGktQkRcU=;
        b=Hobsi03FgHqEp9uJ8z+fVoEcKSLBXLd8b5/SKu2d1bUk6rzc/ZFZ33MI6PIARUuacc
         uHt0X4XBTKkl9Xx/+OvRb+GqNo9/Oh0dzvLyZPed5xmEOfREPRGLHF5A79VwJnOgMRMc
         92BcocQ5/3e4SsvNjPwFeUkI4FBxaf1uxXltm3vL5Kc0R2CI16LeSsNwzPufncOVxsoI
         75RPkt5jTeSHKtoamqNEOZoBrUEVgWf2CaKKcQ4+un7a9TRKpGUgC2f7MJIwbqf9Q/B0
         4SZxCDPuhcIUcgVCX2Kshl2vukq3bDC/oKsEMl7TSKq1HFjyl2MoUeS4rzqGnGMPnuNU
         OZMQ==
X-Gm-Message-State: AC+VfDzpd0eX9Hu4qz57q+Mp4YfDkXatlrIyhSh+oAIC8J6ea7x/p/4B
        3GlSzxWOsHsOunSBDi0uZF2D2Q==
X-Google-Smtp-Source: ACHHUZ4UTTdqCPBb/fskbugWXNHeyHl/TFIRurwmR3RwkAjY3S0nJxhVXqSxWl9iAFLdKx21iF0E/g==
X-Received: by 2002:a17:907:97c9:b0:96a:1348:7a27 with SMTP id js9-20020a17090797c900b0096a13487a27mr8677329ejc.12.1683827214066;
        Thu, 11 May 2023 10:46:54 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm4291188ejf.54.2023.05.11.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:46:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] nvme: host: hwmon: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:46:50 +0200
Message-Id: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct whitespace (Christoph)
2. Add tag
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec9..6aa153f3178a 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.34.1

