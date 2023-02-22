Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65C69F33E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBVLMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBVLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:12:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1572F798;
        Wed, 22 Feb 2023 03:12:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z2so8499213plf.12;
        Wed, 22 Feb 2023 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJZ7Q8q1Rspu6OpozNaxV8ZPYxzYDs5O0iNAPEWEK4I=;
        b=lBPXUSkEpAFpCERG1+1cfQ5FTHcnkvXbCxTw/L5zqKb/GDoFKSivBMB2XXONUnP9Fz
         YKy8QVYCbvDneoBTLBoch5C88jiMJjjr5g3YWcA9zxsqGxXNhzN4JdS6nOo/QUZPbF2l
         J72rlAoHsviB3wWPFxCVZHL6/T9gSsRqttJh+omiFA7GtdoNHC58oSPMGlYFyChLU580
         6DIfK5QLZTCjAVfpjoWhSHdlXgJ5ML0dcYgRCd5DBYuNpvt0O4FwimpgBhZiWh8SOE0Z
         Sc3A4KP4jH47GbgGUwFBf/RrdBp2dQBu+4oe15sXkS+8azTS0Py+b4RZhZ3rUQGrGOy3
         ly+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJZ7Q8q1Rspu6OpozNaxV8ZPYxzYDs5O0iNAPEWEK4I=;
        b=iITzr+4tzzNoKZN/dZiOVvDyXS7KNf+GPZLDGCAjuo3Q3YOUjNs2Ps2qhMNQ+pem8u
         248Nz8/rLeE5mM280rofJ2LvTh9a1P1DwwTt/WDV8G/AKw9aamtTlKjUNgEkGa7AWSZj
         TEVQXNBBKhPKpBpENlfb/D8u4OifYYFYkasqldN+lKUr2c74AtW4naxGmzjv0NwoY+nP
         eorotvjdnvpZxXjEAkvRVnFmicQM5pZSScMOH8/78iTJQo8Sq1DfTJmJqdE+Y5SvMRN6
         0GIxuJ1rdPjloloyWK5RRKbRciAMo1g2RNrKhcubrMxmsUrZ+LgkOPbJYPbV4CSSgppb
         HHDA==
X-Gm-Message-State: AO0yUKUSS5/SBTSont3gzA8ujjvIMILaA8354qkrWe/PUo3RJwA3XUc2
        QK2JTC2VFlDwBmajpdCX4JC2OWyTt9tuKQ==
X-Google-Smtp-Source: AK7set9UUZS8ulmlnzwdgNHv+szYZ9YDhgBUWhGhgzWC8HLcm7t2QAQMage0/pZhonjzaI51HJ71hw==
X-Received: by 2002:a17:90b:1c10:b0:230:fac8:d7e7 with SMTP id oc16-20020a17090b1c1000b00230fac8d7e7mr7187585pjb.2.1677064343988;
        Wed, 22 Feb 2023 03:12:23 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm4763228pjf.28.2023.02.22.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:12:23 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/4] Devicetree support for Loongson-1 GPIO
Date:   Wed, 22 Feb 2023 19:12:09 +0800
Message-Id: <20230222111213.2241633-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the driver to add DT support and dt-binding document,
along with other minor changes.

Keguang Zhang (4):
  gpio: loongson1: Update copyright
  gpio: loongson1: Introduce ls1x_gpio_chip struct
  gpio: loongson1: Add DT support
  dt-bindings: gpio: Add Loongson-1 GPIO

 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 60 ++++++++++++++
 drivers/gpio/gpio-loongson1.c                 | 83 ++++++++++++-------
 2 files changed, 115 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.34.1

