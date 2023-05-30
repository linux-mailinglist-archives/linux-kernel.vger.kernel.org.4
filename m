Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76377164CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjE3OtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjE3OtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:49:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4055107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:48:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso5740340a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458136; x=1688050136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iV7Orb1i2HT8c6ntLQeDsScnfo8QsjoWIKrRpD+mlDM=;
        b=q6DaxHgqELE2tu8Q1AxgIsCDpH+TNAJJHJp6Q7g8/Fkd/88Tk4TUy/ri0mT4Ktg5Mo
         8loUDrV8rgOV4A6XNocbQ8st6LPKLPsCoM9M7NfuJiiPgFmWodAuWDMcEhGTqfI+4Tzf
         71FhpeXfe33npOU4xXk8C/+4upzoWtXD+5OuR9V4CwEY+McHM/HpsrVpr/f2HM5wwk11
         q6ItDg0BTxwcfJWB6uZBQGx+4pwaP2uzwuVXxHf91dLVKqsCTNfh3dg7BgyEkITCyOjh
         IHl3EJehb7WHjyFD+D9eQjjetOZhYahUl2+MIzDnN4ovGk7najQrxWq/MU940DgRFDiZ
         Y5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458136; x=1688050136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iV7Orb1i2HT8c6ntLQeDsScnfo8QsjoWIKrRpD+mlDM=;
        b=iDdQ6wbPXf+WBc9DYv1yneeWgQWh0pPYLCsWfg9OPDOCHcXJwwlfFXnpTQ13VwS+bE
         M78D9WQxVV9oXVIoi57i5TNtARpGh93F5muu2iuqYAHSEnHrwUtL3SofcUtPh5hibpiY
         vAzJ4elGuq/JK3KkoI5ULMreVSZgqs+2qGsA3Cx0r4fRjGzHYWomaxCgNRo9sMkjn1CJ
         B3LZM7ruMJ/dEYlMto4W3bHcMyJj11XIdKpqhnCisL1zpE9xrkBcWI0e4MEwBJPjl+bu
         ANjHihSv6FQj6j8+Z01I7fANEK6eRssSW97MhOMyOVDEVq9iG1P/bqLJXx/x3izmecVb
         zNLg==
X-Gm-Message-State: AC+VfDxc5A3qh9vgEm5Xfg43KNGjwxyJhKEx4iUjK5FycFatDjJRwX8o
        a7UwQNz56fGAgt5jfdDEilxCIg==
X-Google-Smtp-Source: ACHHUZ57600gdJ8fZghoBNthDb/ZJ2da044/ygwaZp54+5w2nAm+4l+5lOMfpN+gAlzBZIyE3wXFJQ==
X-Received: by 2002:aa7:d9c4:0:b0:50d:fcfb:861b with SMTP id v4-20020aa7d9c4000000b0050dfcfb861bmr1926404eds.0.1685458136376;
        Tue, 30 May 2023 07:48:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:48:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 0/7] dt-bindings: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:44 +0200
Message-Id: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tree-wide cleanup of DTS node name suffixes "-N", e.g. "pwm-5", so we allow
only decimal numbers.  In few cases narrow the pattern to also disallow
multiple suffixes, e.g. "pwm-5-5".

No dependencies, can be applied by individual subsystems.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>

Link: https://lore.kernel.org/all/20221127182232.GA128974-robh@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  dt-bindings: phy: intel,combo-phy: restrict node name suffixes
  dt-bindings: pwm: restrict node name suffixes
  dt-bindings: rtc: restrict node name suffixes
  dt-bindings: slimbus: restrict node name suffixes
  spi: dt-bindings: restrict node name suffixes
  dt-bindings: timestamp: restrict node name suffixes
  dt-bindings: watchdog: restrict node name suffixes

 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml    | 2 +-
 Documentation/devicetree/bindings/pwm/pwm.yaml                | 2 +-
 Documentation/devicetree/bindings/rtc/rtc.yaml                | 2 +-
 Documentation/devicetree/bindings/slimbus/slimbus.yaml        | 2 +-
 Documentation/devicetree/bindings/spi/spi-controller.yaml     | 2 +-
 .../bindings/timestamp/hardware-timestamps-common.yaml        | 2 +-
 Documentation/devicetree/bindings/watchdog/watchdog.yaml      | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1

