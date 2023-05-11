Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAC6FF900
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbjEKR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbjEKR5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:57:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF39EE2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so5803322a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827793; x=1686419793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4a17TISsnqon0g+WQRIQyVdDs2e1Fg+Zm3O/wPYErY=;
        b=GXsjlxueZtUNIfkf6oGD/FcTZpnCIjbTcTERLvsQtrBLOTgy+z00Kf8zmc3vdJ5IyF
         iLI5pnYBycGu2HGO6bzBCvbdeIFnuRzVAQuadRA+rheeMI4XdeSyH+eShOoutBlnDy7x
         o1MusSHhMG/B+wdui0JSKDCPZ5Xkp7w2CiZy46wwRNn0VWPp0OlUjO7oReLD+p6gniR3
         XSeN88X9viE8Tvvzt3r6WwHUls3nlPi0kVmE8CCV+av6Hv8ANf5pKPr78b7dTnEmbaCo
         MVZN9Jh1Z/pnOpjPjajGaMgy5iytYG4nN0aU91fO7965QW6ApT2FB8b0zHI2B1XM5sIA
         ABcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827793; x=1686419793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4a17TISsnqon0g+WQRIQyVdDs2e1Fg+Zm3O/wPYErY=;
        b=kHEZQxJ+dv/ycYKRPu6Gl+dq5a/goKGDpBM6Ew2vcPbCTLZGaV6imqXMfHEtyfW5X4
         hTD4FAk7t4g3tIe6QXpl2JXPnuTJ5K6V3/Seu/se4K/5jg4D33SgvQM/4iJJm9Zp7Wdf
         hDm4Pf+rCWvBEMkfUORylzwaDayDlsLZw8PuGK9GbiN1C2nFDqIbbNFK7F31Z3n8eLZ/
         mi/3lVBlez37lKZALB3ZBFuO848qAAyYe28Gd+V07XAHRr9HAZGMfZMkdgTnumBexjLy
         ELQGPb/9wk3fbfTFywRZdfxGraYDLvDIHXrKyIxfbpj3TnDUDZxEbN6s0QqE51CpzTWi
         kZ7Q==
X-Gm-Message-State: AC+VfDwpzRTm3x5x86PPM90bQ71nKiyWcQ+V8fTvXp8EYBAGOvhA5Tck
        nhBjjQjZyICSywf3FnXFWiCE1w==
X-Google-Smtp-Source: ACHHUZ5+FmyIrDIqqTRU67HCD6b2QlxHjV4nlIKuXreLQBx9kRRffDYvkGECXqF2AdYS+nDXNDKedA==
X-Received: by 2002:aa7:d945:0:b0:50b:e1d1:91cb with SMTP id l5-20020aa7d945000000b0050be1d191cbmr18072796eds.8.1683827793643;
        Thu, 11 May 2023 10:56:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id l14-20020a056402028e00b00506addaaab0sm3099202edv.32.2023.05.11.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 3/4] platform/x86: system76: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:26 +0200
Message-Id: <20230511175627.282246-3-krzysztof.kozlowski@linaro.org>
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
 drivers/platform/x86/system76_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 97f5a8255b91..fc4708fa6ebe 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -581,7 +581,7 @@ static const struct hwmon_ops thermal_ops = {
 };
 
 // Allocate up to 8 fans and temperatures
-static const struct hwmon_channel_info *thermal_channel_info[] = {
+static const struct hwmon_channel_info * const thermal_channel_info[] = {
 	HWMON_CHANNEL_INFO(fan,
 		HWMON_F_INPUT | HWMON_F_LABEL,
 		HWMON_F_INPUT | HWMON_F_LABEL,
-- 
2.34.1

