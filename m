Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0D6B5B06
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCKLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCKLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:17:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FE3D0AE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so30726399edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rh0AaE38tztpZM2ohnPgfuHoOSFhJbbw1ifzopWRWTg=;
        b=XoOgVoywU/dkNX1q0aTUOIShgGQRC5OxdFExXoreSYkP0YFnLNt8WLyfaT32qIaQjB
         oJS0J0TAKEksWavBxE+5AlvUVBRtQ8jQPBo7TTwVC2lOHyn8d3gLgtpgRwH00PMJf4nk
         Cs3x43nWKwVVFD8WVjzePRK5LljXiDZ7ocpyUweJLPbuMVUZuPkO8udraDQ1zOzS1lsk
         3wXqx+PSa2zJLwAGzHZxYbj8ttM1m/28uYyTHtHVHSKVyrL9GPt4Wwjz0Yi0obQ0qtxw
         ft7xIjMpnCrgRzEsttWzo4D9TQ3+lDRd/ZFJIUe4oeZ+AawCOYSBFIg0IGGBfW/4W+j8
         ksfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh0AaE38tztpZM2ohnPgfuHoOSFhJbbw1ifzopWRWTg=;
        b=Q0jrh+xp+memDHNTqGTTiwU6FwHqEtrR1xRbvFAW/4H4XAqDy2Tvr5hdauz1P+cCsA
         VxgbcS81mDgC9NVecFzfO4GVk/9yLc0WikH5qI4WuT/FQ5rskA/tYScAplQOK5gHhSLl
         7pOdidiL0rdd2gVbxLWoOomw/89owjcd3/Hty3ijd46+H4sWVj4k4qoN9WsQugjvT9ue
         uGNineRTqZy7zS5Kl8z1djyShImytTZDB8l7Jl4BTeb3XHx2bP32i5/vzkLfN4G5wLAJ
         QpKY7mSfkJVOQU51xsADJiVidYqYCY1uuaRr6LneiRiTA13C+ZLDDO0CfYL9nm1N2qt+
         vhww==
X-Gm-Message-State: AO0yUKVefvlKguAKmIXErRg2rOV7QxiyKK9GD4DwmE6RG+6tJiTKnILl
        9EV6gMlRqqp97uC4ZpxYV5In+gCFoT2cRR6GP/c=
X-Google-Smtp-Source: AK7set+GSlHcs/+VM9aTKOQkAIk2VfsnWGS7BFmgvL5vGUzzF28rmCh8Gvha/tuzJZKekbGGKPInsA==
X-Received: by 2002:a17:907:7244:b0:8e7:916f:193d with SMTP id ds4-20020a170907724400b008e7916f193dmr35472905ejc.28.1678533353349;
        Sat, 11 Mar 2023 03:15:53 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id qw30-20020a1709066a1e00b0092178941cb6sm475847ejc.39.2023.03.11.03.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] nvmem: stm32-romem: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:51 +0100
Message-Id: <20230311111551.251675-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/nvmem/stm32-romem.c:271:34: error: ‘stm32_romem_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index ba779e26937a..38d0bf557129 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -268,7 +268,7 @@ static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
 	.ta = true,
 };
 
-static const struct of_device_id stm32_romem_of_match[] = {
+static const struct of_device_id stm32_romem_of_match[] __maybe_unused = {
 	{ .compatible = "st,stm32f4-otp", }, {
 		.compatible = "st,stm32mp15-bsec",
 		.data = (void *)&stm32mp15_bsec_cfg,
-- 
2.34.1

