Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE206620C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbjAII50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbjAII4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:56:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE34165A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:49:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso6543024wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=siKssN7+BF3Ar6NiC2raZr/JKgYRNMaZsKu5TqC452k=;
        b=EC/NPgVtbD08ltPavscFWrbUcdb3WKJRO9+7MBtwuDiJpWSTCaW2tCiKJS3WJ+qTEe
         6CxnoZxnTuKGnr2htzGg1N9XS6AMjDGeLocixjAh85WdaMv65j7CxwZxFHflW5iVwPJ8
         iBx+XDyR22q3otFb0mgocpE7DPBt268TdbsPqBc5PcBeFeKFDiX6bp6EBo7v7tFAE2Po
         ry3L+UEPAtQJcsL2lfKliUZGeZVBD6YV8JOOXm9b9A6k6kQuT4Y3ILnFvP1Fnd79FJ7H
         zZ4utoAJ7/lKKKqZZzOiK2gQQ2c8yDsC35b4/f8Ri/0pXfYoMrO8p42a/eR8ePa6r/Z8
         B0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siKssN7+BF3Ar6NiC2raZr/JKgYRNMaZsKu5TqC452k=;
        b=oCiBJkcTxOMiDn++uKXS8Uvb0+R2LApAtiH8PK56iW4dEgYoHmSMGzS8dqUnMS9xG6
         E+YiPV21OwbcflwY5/DQObRCoF9+TmuTvbmteqTAMgAGd68ES5bQMfkPae4R78KtkcE2
         02N6Jct2QcFTuinffkCKbfVZ1pjWJfmuRPn/szrpV9Zl40nRs0wvzqLQTsIw0cGdcaqO
         5Y5TmlvFKAtIoGX3KbS/0IqK1tHdbiAKBw9bbp3+vOyKJ/tEvrMN3XgwUBtuG0QuNqSs
         +ot663ubktJ3ZDg4ZgzPJgAU5iRMYuIPFwSBVWOmvdiENpsauaRgBNtl2L9Gesf2A7IH
         p2/g==
X-Gm-Message-State: AFqh2koqXDitklIP8A0USbTbdeJjAWGWx/+XlDVty5axy1lfnuYwKObq
        jzHEiBbf/kL+WARFp9wmtMOSIw==
X-Google-Smtp-Source: AMrXdXtggGQz2GeaqMHJwAE7OigHbI53wsmzvKbRmQJ7N5AfmYUMNKMjZ9SpOtKFIfznz01xmqva4g==
X-Received: by 2002:a05:600c:15c3:b0:3d1:c8e4:48d7 with SMTP id v3-20020a05600c15c300b003d1c8e448d7mr55302643wmf.40.1673254174810;
        Mon, 09 Jan 2023 00:49:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm15039619wmb.14.2023.01.09.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:49:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] drm/panel: add support for the Visionox VTDR6130
 AMOLED DSI panel
Date:   Mon, 09 Jan 2023 09:49:29 +0100
Message-Id: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABnVu2MC/5WOQQ6DIBQFr9Kw7m9AqmJXvUfjAgSVRIF8kLQx3
 r3UG3Q5s3jzdhINWhPJ47ITNNlG612B6nohwyzdZMDqwqSiFaeMckg+2AHiKuqawhZiQiNXyElj
 wziFIJ1ZYBRMS921jVSalCklowGF0g1zGXPbshQZ0Iz2fbZffeHZxuTxc17J7Gf/rGYGFDrV3hs
 lasFb8Vysk+hvHifSH8fxBQniiRfuAAAA
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 1080x2400 Visionox VTDR6130 AMOLED DSI panel
found on the Qualcomm SM8550 MTP board.

By default the the panel is configured to work with DSI compressed
streams, but can work in uncompressed video mode since 1080x2400 in
RGB888 fits in the 4 DSI lanes bandwidth.

While display compression is preferred for performance and power
reasons, let's start with the uncompressed video mode support and
add the DSC support later on.

To: Thierry Reding <thierry.reding@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Patch 1: Added review tags
- Patch 2:
  - Fixed includes block grouping
  - used mipi_dsi_dcs_write_seq() instead of custom macro
  - Used MIPI_DCS macros instead of hex valuex when possible
  - Dropped first DCS write which was enabling DSC, and so removed DSC disable
  - Fixed width/height
  - Dropped calling mipi_dsi_dcs_set_display_brightness() and direct DCS write to avoid double swap
  - Fixes MODULE_AUTHOR & MODULE_DESCRIPTION
- Link to v1: https://lore.kernel.org/r/20230103-topic-sm8550-upstream-vtdr6130-panel-v1-0-9b746b858378@linaro.org

---
Neil Armstrong (2):
      dt-bindings: display: panel: document the Visionox VTDR6130 AMOLED DSI Panel bindings
      drm/panel: add visionox vtdr6130 DSI panel driver

 .../bindings/display/panel/visionox,vtdr6130.yaml  |  53 +++
 drivers/gpu/drm/panel/Kconfig                      |   8 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c    | 358 +++++++++++++++++++++
 4 files changed, 420 insertions(+)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230103-topic-sm8550-upstream-vtdr6130-panel-f81dad976abd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
