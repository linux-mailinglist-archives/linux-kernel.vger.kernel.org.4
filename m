Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3C709ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjESSJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:09:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D405C107;
        Fri, 19 May 2023 11:09:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510dabb3989so5415495a12.0;
        Fri, 19 May 2023 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519754; x=1687111754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8o05QKrR9i4VTufIFRtl+AkR5mq9b5z62LFHT8IgVfw=;
        b=aNrpVUMvMUZrfYK8lfSebmNQYE99vsyydV1N10nkuzsz9DUJKm80hRtutMT81CQ/v1
         erlLrLCFEXvUHu/3uUhhbpbghSv5bwZ+8TMFNzun5FCWpaWmZjOnmptTd3qkUrwhmt5O
         FfhqPY8IcOd1FM9R/q00TxXX9eAQbHmNXSwp32D8gjp+kN/FOrHK8Cxr3Uvm5ux5dGsY
         ExChZOjnPNs28nvEl7HsDVYGM4eXf5T6jZxxneuqtn5Q7p1mkSenltRNq0ufI8Pj9YWv
         zxkaJ6UR+/j+X5Z0VlaIjleiwsjCvChv0Uv/YqSkgyWNsjYs0Qq4Z2N7Ryxx9mzHG/0P
         bqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519754; x=1687111754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o05QKrR9i4VTufIFRtl+AkR5mq9b5z62LFHT8IgVfw=;
        b=TvWQilo/16Zu8bETHM15cGMpuYq2dI1YAefj0bPxfZWR0crygEaIp9buG709u51u9/
         ZtOtVpy2t18kewJdJSiMi+S9woG4O8QtwkwaMlAH5S0MZfP/xivENxa3oaRs5EApP08j
         kCrCVv0ROrkGCaOeVHKaXxkTl8dZA3KXtB3V+oyJIytLhpm1QnLMzT3av0HIfKJmpjP9
         318H7FQR11u4vEfXbdCQYe3yvlcxqvH2lugwgG/p7BYQpzRguMwCPhseue2+8v166gFC
         Zy0b7gbDQRzEuKV+sZntkp9htlkd3+ipF9BYJoe0fJb2+yO4EK1BXk/hPIbOB5LjEB5S
         WXqg==
X-Gm-Message-State: AC+VfDwGIC7vhKU43+Cluc3yw1AH70HqPdR0WLjJZ5IFdvlYOmWZLhRA
        MuZ9zKPpK3McylEVan3g4Ag=
X-Google-Smtp-Source: ACHHUZ4QuWMsmHNjfxTEGVqbmvSkwEgThKA2QEo9J/htJiK0EVr0kMRbpREmzY4yQ1LotTfnAwMbxQ==
X-Received: by 2002:aa7:d9c3:0:b0:50b:cae1:d7a3 with SMTP id v3-20020aa7d9c3000000b0050bcae1d7a3mr2639608eds.14.1684519754252;
        Fri, 19 May 2023 11:09:14 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm19824edt.18.2023.05.19.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:09:13 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/4] video: backlight: lp855x: modernize bindings
Date:   Fri, 19 May 2023 20:07:24 +0200
Message-Id: <20230519180728.2281-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI LP855X backlight controller bindings from TXT to YAML and,
while we're at it, rework some of the code related to PWM handling.
Also correct existing DTS files to avoid introducing new dtb_check
errors.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Changed in v2:
 - Added additionalProperties to ROM patternProperties in DT binding

Artur Weber (4):
  dt-bindings: backlight: lp855x: convert to YAML and modernize
  video: backlight: lp855x: get PWM for PWM mode during probe
  ARM: dts: adapt to LP855X bindings changes
  arm64: dts: adapt to LP855X bindings changes

 .../leds/backlight/lp855x-backlight.yaml      | 149 ++++++++++++++++++
 .../bindings/leds/backlight/lp855x.txt        |  72 ---------
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts |   1 -
 ...-msm8974pro-sony-xperia-shinano-castor.dts |  23 +--
 .../boot/dts/nvidia/tegra210-p2371-2180.dts   |   6 +-
 drivers/video/backlight/lp855x_bl.c           |  48 +++---
 6 files changed, 189 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt


base-commit: fb200218b40b7864f64f1a47de61e035d8934e92
-- 
2.40.1

