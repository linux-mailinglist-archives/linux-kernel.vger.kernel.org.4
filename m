Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82CA6164BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiKBORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKBORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB327CC7;
        Wed,  2 Nov 2022 07:17:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a67so26645786edf.12;
        Wed, 02 Nov 2022 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Tx9qzuOwx4JUlHp6FkZ/5WKZ4d6lYz+D1HQa2LD1tA=;
        b=EsCUjDCGvuVNc+ZigO1adhkMaFllrxPwJiMmH/+MVP0eLnT14RddOwiZVy7TvY1/qS
         TzksJ+8HrWbW4EVKdWXNmisIHRooHPtEA6sn7edEUQan2h5aE6kGfmye558mnGqb490m
         mmNXHOBMMLIS9MGKcRcVMIpIryB8zXz7brhX4cSYbY8bvBL3nBA2HtJDiP9yJjz603Mc
         ZzzgTlKg6SFs29tlhcNttEaAdWKteOQ9lUF89bGqD6ApUTgKQvTTivquO3oDYSIyFm+f
         IzVGEV+lJt7hVD2uSnsrHzTNwmqdZjEM8xsU9Q/RVATUb3MJZtio9IiyFqQvnoaFcDHv
         sANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Tx9qzuOwx4JUlHp6FkZ/5WKZ4d6lYz+D1HQa2LD1tA=;
        b=BJvZAg9GRtj1MJgsYISBu8YMEgmATz3a7B3fRwx3H1dVZrrbkdVsWD0gjnBilHiyNi
         PqGUsLQW1D74L0+pVBzQhGbQCDhRwAAfTyN5Pfpa9RhF7Pe/cHyapGlKhcPxmX5Ip8C8
         2wF0ySCPbXRzuOjulnE5+V+woVyWFGkJY0zIxUvs736jsJfymnAB8Jn92D0mpfZxgxwb
         VuQxuQ1mSKh9Osl6rwHOaNVBoZGa6FitHdAYmwhgVnMVWP0kfDhW9tCbJTjoxRmfkWYX
         7TU0OtiXSdqWtkolau0/LB5fdHoMZXtRqYqJvS2Xni0ZZ4eDDlDecuf5ixaIOkywWgjG
         OfMg==
X-Gm-Message-State: ACrzQf2+QKSlGCHPnCS2AfNKNY2zXxmZ35t1Ty0HPWFqsKkquASIWNGA
        cv0wlpe5Dp0CY+qDofo917k=
X-Google-Smtp-Source: AMsMyM7uhvWm2LP2gaUwQPtrSbRrlDUn+5GMSQB+lMctsBGZd4XE5wBj+rMs0BWRyxi2RkLDFicCMA==
X-Received: by 2002:a05:6402:2937:b0:461:32aa:32da with SMTP id ee55-20020a056402293700b0046132aa32damr24299542edb.78.1667398631862;
        Wed, 02 Nov 2022 07:17:11 -0700 (PDT)
Received: from localhost ([88.227.60.86])
        by smtp.gmail.com with UTF8SMTPSA id my15-20020a1709065a4f00b0078d38cda2b1sm5376305ejc.202.2022.11.02.07.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:17:11 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v2 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Wed,  2 Nov 2022 17:15:09 +0300
Message-Id: <20221102141513.49289-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v2 of the patch series to add PWM and keyboard backlight
drivers for ARM macs. The changes from v1 address the review
comments on that patch set.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html

Best Regards.

Sasha Finkelstein (4):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  20 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  20 +++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 ++
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 127 ++++++++++++++++++
 8 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.37.3

