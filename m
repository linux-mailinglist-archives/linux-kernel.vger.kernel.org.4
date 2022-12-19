Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E33651379
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiLSTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLSTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:52:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A52BE5;
        Mon, 19 Dec 2022 11:52:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso9604777wme.5;
        Mon, 19 Dec 2022 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wM5eORbXs9xHp9Nzr+xVNrJWic+DOQMMiAtYKX4dMVc=;
        b=F3IPUUVYhwFAZkxY3WfwX9CwFv9W91edyXBLF65RdxskKWIHz2CIWQZMJGx2zMswjx
         6TwZfQOPbFv7of0rCSUSUkevvsjoPoKRrLMofBJ3P/UJwEQOdswhVQZxy/3jYXF/MCOt
         me4rYb9sV98LcCVY7ogZ95zWD7R+hOInxcaFzwuO9ksT40lgQuZnCBBc+XAtHjrXAgmr
         US0zSwiEPWJ/N3BjtIjz7e9+1wVHjpukHdEJBmecNVKwKR3usyYQJt4yI1VWhviYyM55
         PYIV9uFxnrh9qB1xvb6xxf1Vnw+llGmfBKoFmNA5hOXrSAxu8ajGr1nEXatck/KFKtnI
         yT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wM5eORbXs9xHp9Nzr+xVNrJWic+DOQMMiAtYKX4dMVc=;
        b=PNSGxYof4iJUyx7gBXrxFisdOpA9jJwyEZQApnz4F89afo8ZImpxLYeoe59pL1qs45
         G9/M7wIzengk0HZ+7fcr5IKxTlva7lgWsbdiTmvIQKA8TajiW9AvP6yU60UC+qafg3m1
         sC5x7+/yuA54xVKzVq6U/yfyOoLhg7ZJFYHPPi91Av+jQRFHb+SVQ306YoPDqGP7AuOc
         5U3Vdd0hz2jRyiYedXRDjadZcnqE+P4ZCNL0E9LSiif6AeibDRZ4AhqXgWb7Bs5OqUiN
         gRddtUJTM+I70smmqqbc+F58dnhHn91q2tI5Hj9tQBAMW2pd3CSfRMMoQtRonAlxQYv2
         3yMg==
X-Gm-Message-State: ANoB5pmMK2maRbrfpHUvAk2AmyzW0mx4BLbYP5Mgr6MOqVzVKrM4Bk9l
        MvTMbPhw0WON4DWuzGVEiNM=
X-Google-Smtp-Source: AA0mqf5ebwfR8R/cCNYMXcdI/7o+HSI33zGO2ZQqU6dF15DNBFHYksCD7lOFmwqHai7rUFKa83TAog==
X-Received: by 2002:a1c:f315:0:b0:3cf:a5df:8bb0 with SMTP id q21-20020a1cf315000000b003cfa5df8bb0mr34027155wmq.37.1671479557040;
        Mon, 19 Dec 2022 11:52:37 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003b47e75b401sm24469142wmb.37.2022.12.19.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:52:36 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, linus.walleij@linaro.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 0/2] Add support for the orisetech ota5601
Date:   Mon, 19 Dec 2022 20:52:31 +0100
Message-Id: <20221219195233.375637-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Changes since v2:
 - Documented the registers to the best of my knowledge
 - Used macros for on/off panel registers
 - Added SPI id_table (non-requested change, fixes a warning in dmesg)

---
Changes since v1:
 - fixed the dt-bindings maintainer email adress
 - dropped backlight, port, power-supply and reset-gpios as they're
   provided by panel-common.yaml as pointed by Krzysztof Kozlowski
 - changed reg: true to reg : maxItems: 1

Christophe Branchereau (2):
  drm/panel: add the orisetech ota5601a
  dt-bindings: display/panel: Add the Focaltech gpt3

 .../display/panel/focaltech,gpt3.yaml         |  56 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-orisetech-ota5601a.c  | 364 ++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-orisetech-ota5601a.c

-- 
2.35.1

