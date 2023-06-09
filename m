Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E03728FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjFIGVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjFIGVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:21:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62641FE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:21:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso2120512a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686291662; x=1688883662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0KsiO4chph33S79F9ENBTiIdHIAq8Drk63634LLZQs=;
        b=kbV4G7FpeyKX8vqSKQVxCHgnfKl+l276t269BAHAwJ23WxJ7nO/Oasy+9J5YumKyca
         T0uhyyudNLhM+w7pc9FA736CWqmxTkyTSsXqXOdfoQrYeO1IEHkoZSz4uKQsYCPrsTwM
         ULacDwUYyqRuKtDEU6r//KnkwN3AFNWxWIfls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686291662; x=1688883662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0KsiO4chph33S79F9ENBTiIdHIAq8Drk63634LLZQs=;
        b=i78FQOOHf0wE1eL1ZnxwtJ65Etyxjofp3oEeIbZr2oaALKBKh5YCGBjW52C8l5IGC9
         oK6txk9i1nVQjX7QMxMUTXJS/0GsnlhVeSluRTcdGyS5PrgClg26hJ1cHDP5EHAsBEY9
         t9eq+/f5O1UF5HgU7qiDZCFqYltPBjo/lK4optWb+G4qUApBNg1EYD8t0r4ftZUt5zqS
         bpse0kKPfnHkLd6NXmjR+NT4zi9d09gi1F6zByg4jb93flWt/RhfqkUoLedSWwF+DuR9
         aCepyHzwq/pwYWGRQbYzmaX9n6c9JAxQe2qUJhkH/M2UDnrxRsWr6EGUN1u7+pjLHN30
         N4jw==
X-Gm-Message-State: AC+VfDy5inc8EVkEzxo+b0bqoWrpirFmPF9/F/X4rgzRAbFw/oT08LuX
        WScfPdiYHFZxSsIs9MUhUMxXOS9f4HzHFbXntJn14g==
X-Google-Smtp-Source: ACHHUZ6l4dLtGlhnWIwTWUWwtNlYtOyR1yl1ptA5SoQD+GUUgf1U2scpLgKXakdx81uLNojiuXQ7iA==
X-Received: by 2002:aa7:c44a:0:b0:514:bc92:8e1d with SMTP id n10-20020aa7c44a000000b00514bc928e1dmr392209edr.14.1686291661889;
        Thu, 08 Jun 2023 23:21:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b005149461b1e0sm1380058edr.25.2023.06.08.23.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 23:21:01 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/4] Add display support on the stm32f746-disco board
Date:   Fri,  9 Jun 2023 08:20:46 +0200
Message-Id: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board,
along with a generic patch that adds the "bpp" parameter to the stm-drm
module. The intention is to allow users to size, within certain limits,
the memory footprint required by the framebuffer.

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

Dario Binacchi (4):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board
  drm/stm: add an option to change FB bpp

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts  | 51 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi       | 10 +++++
 drivers/gpu/drm/stm/drv.c              |  8 +++-
 4 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.32.0

