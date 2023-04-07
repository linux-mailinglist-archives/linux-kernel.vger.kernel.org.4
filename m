Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01056DAB78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjDGKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbjDGKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:23:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB17282
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:23:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qb20so7434913ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680863013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Io/udqwHbpHqltZDGsqHtMrnMLw8T2LHE6nGOqTi4=;
        b=IDQF/IZMULmO/cBIi2eyVVIX0vYzczJRuzsvLdgzNsutudW/0miN3xwrGvJ2F3JM5L
         bA5LuApl4uJb0cwp1dAcoRMf5/m6E4VfDBgVJ5r2Biu9CYpyDDTZfH77Sm4dC/WxVNwG
         lgghVGRXftQNxVvXgeq4Zs4ujvfanMYWl+9Krx68FP1BR8UuXZM706fb1t8dxqr+DLyJ
         NFqtX6evFC/qHgE8UzqnDF0s6MuPDLXGFvCiZTIrkXo3+BhSSYyhsqXA5IIsMntU8G56
         eTKmsgHW688Iw2JFmC/Ut+PnDNsu+cGrCk5LR5FlzzOkE+/R8JZ6Zfh3GxQvtoaH6iFN
         uUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680863013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Io/udqwHbpHqltZDGsqHtMrnMLw8T2LHE6nGOqTi4=;
        b=3DD9Ae2X/EwU0BLARZNUkuj2vVICnEOZJ4ErmkSd0elPB+cjnLbRf2lvSjf9WIi02V
         k5U0DSSVO4jUmMeVvTH03czIpHBD42fxMUr0yke4jxgf7++Psaya8Qn2GKWzxAUVGm+y
         TejZd4CQNA4WV+zKSQJgq6pPSoepu/WUTKypYQXeNML9kDdw/PfTOA6zdrIUl8pE+mu6
         4b+fdySDvdeym6YJUhwmdOwNkwK5tFdFpVHotw2igcRU0JUEIcXM+mpwDPH7HM8Wku8A
         v6oZbB1K17nflkD5lCkuHHZSqH1QKtzQKgB/BhI5ELTB8iftif37psP5eR11xmYyvGTA
         qg6Q==
X-Gm-Message-State: AAQBX9c4645cDAI64VQC82vU0jUoIGecT4GITs2O8K1DCoU+OFEwZ8Zg
        6rgHp9OHfvbdv+QV/yPu/M2CFQ==
X-Google-Smtp-Source: AKy350b7/j4aNjhcfwWnIRIf0CMTwsVF7i3ReOYvra2kPJFMctNcwfTwKpssHq9qgDZAR1bOxrlhDg==
X-Received: by 2002:a17:906:6ad9:b0:923:c55d:efd2 with SMTP id q25-20020a1709066ad900b00923c55defd2mr1687962ejs.68.1680863012988;
        Fri, 07 Apr 2023 03:23:32 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906014700b00932fa67b48fsm1892612ejh.183.2023.04.07.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:23:32 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] leds: lp55xx: configure internal charge pump
Date:   Fri,  7 Apr 2023 12:23:22 +0200
Message-Id: <20230407102324.42604-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Maarten Zanders (2):
  dt-bindings: leds-lp55xx: add ti,charge-pump-mode
  leds: lp55xx: configure internal charge pump

 .../devicetree/bindings/leds/leds-lp55xx.yaml      |  8 ++++++++
 drivers/leds/leds-lp5521.c                         | 11 +++++------
 drivers/leds/leds-lp5523.c                         | 14 +++++++++-----
 drivers/leds/leds-lp55xx-common.c                  |  9 +++++++++
 drivers/leds/leds-lp8501.c                         |  8 +++++---
 include/dt-bindings/leds/leds-lp55xx.h             | 10 ++++++++++
 include/linux/platform_data/leds-lp55xx.h          |  3 +++
 7 files changed, 49 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

-- 
2.37.3

