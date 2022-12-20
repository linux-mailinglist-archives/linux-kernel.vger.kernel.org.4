Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FB652016
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiLTMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiLTMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:01:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8ABCE0A;
        Tue, 20 Dec 2022 04:01:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso8615397wmb.0;
        Tue, 20 Dec 2022 04:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeemBtPg6mOFyQLgVazTDdJ9OFj3WHLHd2wy3KkmqpE=;
        b=QrmME4+fTy6zjhgfdY8ufn8YD77vsf9+1M5FA8g4J6BM5/9tjyrg34mwunw0qTAC0R
         ST/IRBaesxka9oidLucP9jQ2EyQ5TgdUqFBfYXlh/1PaLXVbVMHt6bHDubMCaJOYrp95
         CaD+A2aWL/Dyk+8Dx3wxifYTVZzy+WKkYlTSEaU9yr/OuLn9Ncpw1ujDU9pnXTkLQYFD
         4BSklOcqsm/aHXhefi2/eh1vt+GhQGaGAKcrIY3b4bRe2hijfdUw7mHkZ2O8yFHPKL7s
         y0U5Rf7dbizRkMFEXdHVaKlfZ+DZuWxzUbMSFC1NKuPrczDmhqebZsom1ykYGB5i/jIJ
         CN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeemBtPg6mOFyQLgVazTDdJ9OFj3WHLHd2wy3KkmqpE=;
        b=pkzLCjIWrcFwY17V1qBpbm09YLhu9Z0S0a+AIz74iRzNL8f0rlqwmugqeGpIKPXKfX
         3dAahSbbeWQIuoGJvbqHAofzS0kW6+otjwNGTa5aqEc8f4pKIDhW0qJ8Y+y+I01oqVQu
         MDFb3VrbIexTWccGnxdlLb+nB6CCVmIuwvQYxRTDt0rV2oiHKP3jFX5589Ob6oHjjSlg
         4slkx0f5ygIMV3+XVpkoahe5pnQVhMfopriNafRSHv8TlkeynXKex6YrTeDjp0cLIE5I
         +Hzms4l2HEzPiShPrroDIZEDhK0FhSFOe3kiKw/YfJKZ/8sSpxHmNd2QxZp5ymQlksul
         Qmuw==
X-Gm-Message-State: ANoB5pnWPvTaoD/Wj8eLh6+d/RLYPac9IwEymeVlCcycZWT30brZJC3j
        MRYKo7n1V7AZ00UzgUJZV7g=
X-Google-Smtp-Source: AA0mqf68tRpxDGSZYOVUGM3XS0vay0E9GCiXB4tqPRGnQbRdjUp6Hak3m0UunuiZW6MKtiXq+qHQfQ==
X-Received: by 2002:a05:600c:1ca8:b0:3cf:7dc1:f424 with SMTP id k40-20020a05600c1ca800b003cf7dc1f424mr35762717wms.3.1671537674890;
        Tue, 20 Dec 2022 04:01:14 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b003d04e4ed873sm22843188wma.22.2022.12.20.04.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:01:14 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 0/2] Add support for the AUO A030JTN01 TFT LCD
Date:   Tue, 20 Dec 2022 13:01:06 +0100
Message-Id: <20221220120108.481554-1-cbranchereau@gmail.com>
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
 - added macros for stanby mode (untested, please review @pcercuei)
 - added SPI table_id
 - changed description in the bindings to describe the hw more

---
Changes since v1: 
- fixed the dt-bindings maintainer email adress
- dropped backlight, port, power-supply and reset-gpios as they're
  provided by panel-common.yaml as pointed by Krzysztof Kozlowski
- changed reg: true to reg : maxItems: 1 

Christophe Branchereau (1):
  drm/panel: Add driver for the AUO A030JTN01 TFT LCD

Paul Cercueil (1):
  dt-bindings: display/panel: Add AUO A030JTN01

 .../bindings/display/panel/auo,a030jtn01.yaml |  54 +++
 drivers/gpu/drm/panel/Kconfig                 |   8 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c   | 307 ++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-auo-a030jtn01.c

-- 
2.35.1

