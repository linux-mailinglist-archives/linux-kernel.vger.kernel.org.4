Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF88D6DAF24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjDGPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjDGPCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:02:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7ABDDA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:01:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l17so8979782ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680879685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GsW0sBmCGPIKi4ldnuiVceYA0T8GNC0mMQclPw5Yuc=;
        b=SVAOqSpYUGg+ycC7+a+b7gK9ANWd39GdaJIxR+0wlqJafKFgOyaPrxUGqg0+O1H3R2
         Hq5hE05D37A+QIktWpUwrTn//N2YzCg5/8ZqxN+EkoLl2fG2BvhUJpY8XYHwj+wPukXR
         SN4TU+LBiRrouHEEsUdS7+JXQIWW3TcrXwfSvVuVw17KC6EvAZCNhOJWQLNWIkosKvdu
         fep6yC1MhWEOCbC6iJnVcYHY2T51Pyw86cmVOZ9CtEfjyZmuH/c83BhOsVVHuhnJWNFZ
         l3g7yjIiaV+3krQ2AGpSkAinCu+i1YSMzWDYh/wROq181NTkUO2v9dkuim85QtbMytXf
         tqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GsW0sBmCGPIKi4ldnuiVceYA0T8GNC0mMQclPw5Yuc=;
        b=uQmvAKpncEVlFMpHEEyD5Lf0LE7ZFuUB0rovrS0ej3A0kkaG4DyFu/uFPLdEg1PBXZ
         4JjsLNS5YoD8n0Gc0x67SUOUsVmB/nB2ocewvEZ6GWS4M8g62o+AzXf5aPZ0Yw0KSRkR
         DZca7m26+zhrc+9wRSQw2sLZS3TIkj7SciCTls9hDKIJs3NYCgnlUJMjYl/G0Up8Z566
         GEKAqqQa3OxqZ8oTk0KQSZM/klVDfj1LVls+uzTcNnrRNLb4VOCZ9vKc5IZXsuDhoX2i
         r/yjl255U9Dh1oGZQ7GA2+QcB3MiZcRvASZxD5tr2WTkL2iQpwnRflIc12/q/DLdCrbY
         ry+A==
X-Gm-Message-State: AAQBX9f5e5iJdzRfSE4tEt3f69TQ+mrXbJ8w5XT2S1emFhpDPZXykGrK
        72GQGbt5LBgdRPd628hUyqu+bg==
X-Google-Smtp-Source: AKy350bmqzFCrsiSFpiUC9iuHlbqOA+CLNisE5dPc18hHHA2B7zXpA3byBEqZlnTbRSSY2TIIAFKCg==
X-Received: by 2002:a17:906:3ad3:b0:84d:4e4f:1f85 with SMTP id z19-20020a1709063ad300b0084d4e4f1f85mr2250057ejd.59.1680879685362;
        Fri, 07 Apr 2023 08:01:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id ck23-20020a170906c45700b008ca52f7fbcbsm2144907ejb.1.2023.04.07.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:01:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] w1: therm: constify pointers to hwmon_channel_info
Date:   Fri,  7 Apr 2023 17:01:21 +0200
Message-Id: <20230407150121.79887-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on hwmon core patch:
https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/

Therefore I propose this should also go via hwmon tree.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/w1/slaves/w1_therm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 067692626cf0..1385cd142c61 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -454,7 +454,7 @@ static const struct hwmon_channel_info w1_temp = {
 	.config = w1_temp_config,
 };
 
-static const struct hwmon_channel_info *w1_info[] = {
+static const struct hwmon_channel_info * const w1_info[] = {
 	&w1_temp,
 	NULL
 };
-- 
2.34.1

