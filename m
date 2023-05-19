Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00F709D28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjESREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjESREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:04:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B49B9;
        Fri, 19 May 2023 10:04:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965c3f9af2aso533926066b.0;
        Fri, 19 May 2023 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684515842; x=1687107842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yI0mSQ2DqrJBtVhWBqNt4YE0D9y7Ke3r1TEApfK+Y8s=;
        b=pc+bPFnBQMB5DdWWjfCASoCdssIXgIseNm/bme4RxwHXpQ4TaWDUvSVpTf3RPBeboV
         qNcfs5L9zfpuxwRLfzN7qNreUCKxHt481E2PyzeUB7zqpKhg0Ie8LELEO8K/QKfCijk7
         8A+0NXv/5f6zcp2Q7RPXVke2pK1H7WeEDXHpCZIMincmuYMZEPSWWHuIMT6TEkZy1Y3Z
         YXXYTQavMUGtAm08XKJnY95ENuOuBPVKeQEzhpuhG+IlFW+hOFKwtrS2QWKTAVQZ/7q1
         dGgtjuzA88F6tprCjOGqOoMkQJys6wIRyXT2IvzHFip2XnW9VgQM8UZox5gUGQq8pbGw
         2gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515842; x=1687107842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI0mSQ2DqrJBtVhWBqNt4YE0D9y7Ke3r1TEApfK+Y8s=;
        b=G8Y6iQ3HmjUpDoYCedbSEJZiA+xpapXgsBKJmE2r5AZ72idRGdQMdFQNyWyDtpTyIw
         jRKl9/Wkmxwt8+Nk16QeNOPrrUSpaUDZLhpLP7lgOrqre62llesQVIwf3XrqtUjJWmDU
         GoFB5e8PQwlGxvWL2+lQwRlYRC4BS5e+i78PYMBCovEVbYVMlBGiwamyWylzSHgQo1nU
         jLESX7tlfMsIurub2MH/lOz9BqZp8ti0UKxlD1s01JLZEU//OhEQqDs7h7PCCEjhy2Kd
         Gni21rhQDMCrWkNhfRBdPBKmljP8bk1XLIsv17cQeTHdrLmluNpfmvflzmhT5Y6fXZ4D
         Y2bA==
X-Gm-Message-State: AC+VfDxtJk/yldWN2vP/m0uCRgRQVlZ0vbMdGag763xXwXye/BtR1PpN
        lh3mE9By3qXUnbxvfgCKX4U=
X-Google-Smtp-Source: ACHHUZ6ITQoFmFv4vzlQeUk4c4DPVUrLLreopFxWyIzHGlMWscdmlLm+iMcBUWcK7gbNYfSx6rkm1w==
X-Received: by 2002:a17:907:1b24:b0:96f:2b3f:61 with SMTP id mp36-20020a1709071b2400b0096f2b3f0061mr2536267ejc.7.1684515841784;
        Fri, 19 May 2023 10:04:01 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id mf13-20020a170906cb8d00b00965ffb8407asm2489988ejb.87.2023.05.19.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:01 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v5 0/3] Add Samsung S6D7AA0 panel controller driver
Date:   Fri, 19 May 2023 19:03:51 +0200
Message-Id: <20230519170354.29610-1-aweber.kernel@gmail.com>
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

This patchset adds initial support for Samsung S6D7AA0-based panels.
Currently, the following panels are supported:

 - S6D7AA0-LSL080AL02 (Samsung Galaxy Tab 3 8.0)
 - S6D7AA0-LSL080AL03 (Samsung Galaxy Tab A 8.0 2015)
 - S6D7AA0-LTL101AT01 (Samsung Galaxy Tab A 9.7 2015)

Changed in v2:
 - Added commit messages for dt-bindings and MAINTAINERS entry commits
 - dt-bindings: Applied suggestions from Krzysztof Kozlowski
 - driver: Removed unused panel_name property from desc struct

Changed in v3:
 - Correctly applied patch for dt-bindings

Changed in v4:
 - Added support for LSL080AL03 and LTL101AT01 panels
 - Added DSI-controlled backlight support for panels that support it
 - Added vmipi-supply
 - Dropped s6d7aa0_bl_ctl_on function (not universal across all panels)
 - Removed MIPI_DSI_MODE_LPM flag

Changed in v5:
 - Changed compatible to avoid concatenating compatibles
 - Removed '|' from multiline descriptions in DT schema
 - Fixed DT bindings license

Tested-by: Nikita Travkin <nikita@trvn.ru> #ltl101at01
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (3):
  dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
  drm/panel: Add Samsung S6D7AA0 panel controller driver
  MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver

 .../display/panel/samsung,s6d7aa0.yaml        |  71 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 585 ++++++++++++++++++
 5 files changed, 670 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c


base-commit: ab87f558dcfb2562c3497e89600dec798a446665
-- 
2.40.1

