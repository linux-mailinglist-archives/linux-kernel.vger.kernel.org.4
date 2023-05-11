Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921106FF8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjEKR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbjEKR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:56:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37EE9EC8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso13324062a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827792; x=1686419792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7FN5EFH4KBac4/ZvODbt2chzmKokVJu41Eq2V61hww=;
        b=Ckoxt4MXbiGzc3oJKuG/KM6YiFy3QeFI/+dQye6TbeUSU4EleyP5YK2Gs78/LMYVV4
         DL8/q40nETC8NkyT8FDKbHWqDhV2vLedB7mVNbs5LQLRTXfWrlFbOWQ2gkO+HjRrdv/H
         tfXPgC4kjGs0432uMf/DX236CX8mRPDNNcet7VxUQD0P4x1tbb5xidJOaPLAOquKUXgn
         S3sqD30iDEdFLlc6KqJ1hyMWI5puJqzhdcyYRjCWgeKIVlnOywTifGlp6ZDqD6Ak4nZJ
         noHX93f2c4qJLRlh5VfbnSpUkziRwobZOB9D7xhF6IW1+dDxbzA0o3vi0rHd5unQ4lem
         JvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827792; x=1686419792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7FN5EFH4KBac4/ZvODbt2chzmKokVJu41Eq2V61hww=;
        b=JkmE4d/UvqtwTsNnKnZG0BVkGJOtj9dq0JxjrTvR19k6gaC4NpXj7iuKFdOAj43v36
         rlKZBb09V+Eg19/d3qVKLIQwXMnD2cWuTMdzvuquKSF5AFqOLHfWFZUfRDRUv9pQDkGN
         gAdIQT1SjLk/xMDMwJJXk3bjoNjE6TRp2TYt/fuFYLlDn7R1WlJExJCqGc5/2BQbAerH
         nwnv2uJhcbPiJ5PXV6pPKjnxKTWxWrCR3INra42y25fu9aEppXm5nT9hny4INsSomzSo
         q8QWibErOIjfyI7UwCRYuXQPmBvjldS8xU5fBqGweCU5yYfaPF14UHJ9bpbn26BzLXf8
         +BWw==
X-Gm-Message-State: AC+VfDwjuWmzuk5mgiEXMnWbjeVmDFncQxs3Iq+JUS+/Nst/QCBxy9LZ
        CIby8Khk4Fn9nDu+q32PNfHRtA==
X-Google-Smtp-Source: ACHHUZ7JgTc7lzRjs6O7KBEfpdv2k+JY52kFwpFw3tfal7pz8tnhnl5OdOTt4XulMNGQBoAaBl44hA==
X-Received: by 2002:a05:6402:1358:b0:50d:f9b3:444d with SMTP id y24-20020a056402135800b0050df9b3444dmr2316628edw.21.1683827792436;
        Thu, 11 May 2023 10:56:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id l14-20020a056402028e00b00506addaaab0sm3099202edv.32.2023.05.11.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 2/4] platform/x86: hp: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:25 +0200
Message-Id: <20230511175627.282246-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511175627.282246-1-krzysztof.kozlowski@linaro.org>
References: <20230511175627.282246-1-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 2749433b713f..7eb66cfef208 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1536,7 +1536,7 @@ static int hp_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static const struct hwmon_channel_info *info[] = {
+static const struct hwmon_channel_info * const info[] = {
 	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT),
 	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_ENABLE),
 	NULL
-- 
2.34.1

