Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DB6EA54A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjDUHxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDUHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:53:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2029004
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:53:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34a14a54so217927166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1682063589; x=1684655589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njOMebupF1nfguyxa2HVeQ44xxQhsRp/Byzj17JlSeo=;
        b=SiRwBt6/PH4AkBNRp3X3mI7Vdejak84wcvbF9wKaNnDdhl/35eO94s2T0IwsZ2U9QI
         ShTKJvRE8kCEttdris04yYqTLjhq1MC7Thuc76WqfWUcuVORwyp4dtonXFWBftQUYzl4
         Kd9/KiI6TgmcQfljVGloP8kWRo/OJ2s8QIduoXhRhKs95wkkujbDciTPf+U6qgbUBEFO
         7EmejfxUO0i7OIGjjcuOBvR3Y89acDZSjNRZ4N/37YDZMXmEqsb8h5tRGrQrr/eirVaJ
         Uehk+aoQFt0SYluRqNccehZ+DbT81wOcfT5Leh+8/2N39xbW+DDt6zj4qdvEGsEd0rmo
         b3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063589; x=1684655589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njOMebupF1nfguyxa2HVeQ44xxQhsRp/Byzj17JlSeo=;
        b=BE0qmBcoH2FXsMJjKzOuHvrz4fJ2or7//qVxLT03A/s7Gl1tMHspYxBtt4FLeUGmKu
         U+4FQA232nOImMSERnYnn60WVvFaslQOM3+1aEMHI+KlbmHSqsGWyazTHxleQopJykhP
         kcqE0er3bD5MjHQAqcf+qYikws7FILI/jyMPUrjZlqvdf8HttuTju1CexX5it9+oSfpz
         cHlIgGbeRTbss2o7hNegCLHbaSfEZvRY44JNvUhQ13yPPxif9rVGxFzMg21JTXCx2w1/
         wPFs5fXzyHhNfjK00dCZBaH8Jgci72l3kt31nxDBINOjHwuOEFF+T4BPujjTJgK0CKKX
         Qrig==
X-Gm-Message-State: AAQBX9e3yYdTGsNShtINfNkZ9pDSVY12AaNtQoKhhixh2gRbZZt9lNyC
        9M+R3/bucUMCSsYZ1nQBbHEHwQ==
X-Google-Smtp-Source: AKy350ZrPOyb5gNqJDCECrzhUNI+s0cndb1LmsWNk9uyVe6i2HFgL1SS9e2xdOpAxGc2SwfEA3auVA==
X-Received: by 2002:a17:906:34cb:b0:953:42c0:86e7 with SMTP id h11-20020a17090634cb00b0095342c086e7mr1478572ejb.4.1682063589337;
        Fri, 21 Apr 2023 00:53:09 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id vp3-20020a170907a48300b0094f14286f86sm1716329ejc.48.2023.04.21.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:53:08 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] leds: lp55xx: configure internal charge pump
Date:   Fri, 21 Apr 2023 09:53:03 +0200
Message-Id: <20230421075305.37597-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new option in the devicetree "ti,charge-pump-mode" allows the user to
configure the charge pump in a certain mode. The previous implementation
was "auto" mode, which remains the default.

v1 of the patch implemented a bool to disable the charge pump and had some
issues in the yaml binding.

v2 implemented all options of the charge pump as a string which was too
complex to parse & check.

v3 replaces the string by constants.

v4 resend with changelog (notes) in each patch

v5 dual license in dt header, change property type to u32

v6 change license type, simplify DT parameter check

v7 formatting changes, adapt to max 100 char line length

v8 devicetree binding documentation: add default & maximum constraints

Maarten Zanders (2):
  dt-bindings: leds-lp55xx: add ti,charge-pump-mode
  leds: lp55xx: configure internal charge pump

 .../devicetree/bindings/leds/leds-lp55xx.yaml      | 10 ++++++++++
 drivers/leds/leds-lp5521.c                         | 11 +++++------
 drivers/leds/leds-lp5523.c                         | 14 +++++++++-----
 drivers/leds/leds-lp55xx-common.c                  |  9 +++++++++
 drivers/leds/leds-lp8501.c                         |  8 +++++---
 include/dt-bindings/leds/leds-lp55xx.h             | 10 ++++++++++
 include/linux/platform_data/leds-lp55xx.h          |  3 +++
 7 files changed, 51 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

-- 
2.37.3

