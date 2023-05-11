Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E86FF8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjEKRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EF6EB6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9659f452148so1595167366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827689; x=1686419689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dlq4sG4E5pm3IY25Wn3oaOLMVxj4Utoc+XwNq0SQeU=;
        b=zcF1/Ws/4OoXcXk4fyWJoA+pbPzNn3xXFNF4A413OtzkLWT5PZ8gZwpLZ9jODIBrui
         4eTCb2LdiYr0snJDq06pgsGHfZg0pNINWFo6wTn44LrmXXtRccq9jhq5WkSyKn8zz/Gj
         jP7ZnlTVVHF5ecKGBI8yX0AchTpPBgNamj4qfDepR8Yi8PnZ8bQ/uMLon7Op/XxgAIfI
         GhasOTJW0jKy/ByTZ8d7D42hCrkbp9pitXSturWxC7EbvyPGtzZTB4ltLQu/55Zyujhn
         c4bUTF8L6wchp1WLjH09rwm4uvtdlKoBwhEs73KMxxTSE8/BNSG6o6UPk+ttqRinUn1E
         Q+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827689; x=1686419689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dlq4sG4E5pm3IY25Wn3oaOLMVxj4Utoc+XwNq0SQeU=;
        b=UutA3vawB7loFgejT1O8qBl+4BhIHIkRiX8j/IFVe5pUrQseURFPPx3+wgpz71C6SF
         h6u3VL2wDXPiurn402fBBCfkczVjEjJWe3ykEsL69ha7979bc3Dk7AUYe8Mc//hB43/X
         ZW1T4ambAtXgDbu47liilVsQ5tqdWs5ha7LETIdn+Qo+hdzhmmXqqlBcVT0oCKAeJJQ6
         csutlyxliMmvM87vi99pgoRSW9fVclVRgjvvclwMUs6+KDTaSL3pt1bSksZnUZg95V11
         138Rjaf4XSetOTS8/PN/DHq/SJnuxqT+ia6Y0rl/XpPq6bf7/1JgiE9Ju08Bp6FZwWWV
         wWtw==
X-Gm-Message-State: AC+VfDwpfJTIML6pvKNnggzkPfP14azhdvsZlXUk/WSvzppCrzgQmCj5
        gssHCCJT0vMeKb1+D5ow0zhI8g==
X-Google-Smtp-Source: ACHHUZ6VoNaYXYwmtaJVqGTE2wbH3xSQkdxOFLD4+Wgd02+VwN425gTuigk39B2BJgNqhyiz3/j2DQ==
X-Received: by 2002:a17:907:5c5:b0:959:af74:4cf7 with SMTP id wg5-20020a17090705c500b00959af744cf7mr19074641ejb.70.1683827688874;
        Thu, 11 May 2023 10:54:48 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id i24-20020a1709067a5800b00965aee5be9asm4392763ejo.170.2023.05.11.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:54:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [RESEND PATCH] drm/i915: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:54:46 +0200
Message-Id: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
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

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/i915/i915_hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
index 8e7dccc8d3a0..e99e8c97ef01 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -267,7 +267,7 @@ static const struct attribute_group *hwm_groups[] = {
 	NULL
 };
 
-static const struct hwmon_channel_info *hwm_info[] = {
+static const struct hwmon_channel_info * const hwm_info[] = {
 	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
 	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_CRIT),
 	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
@@ -275,7 +275,7 @@ static const struct hwmon_channel_info *hwm_info[] = {
 	NULL
 };
 
-static const struct hwmon_channel_info *hwm_gt_info[] = {
+static const struct hwmon_channel_info * const hwm_gt_info[] = {
 	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
 	NULL
 };
-- 
2.34.1

