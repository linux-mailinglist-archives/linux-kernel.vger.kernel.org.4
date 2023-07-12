Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340274FF39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjGLG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGLG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022F1997
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:29:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992b27e1c55so797178466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1689143362; x=1691735362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yG02hGmRFX3YN1rDfl25zcD+fatvJq2guzcIO8Dwka8=;
        b=nde+wEHEDGU4f5RbKVdti+mGl+/lFbpfUVStmcklOCtPDXdig/Wwt0AZGTdgJyDf4x
         Vjfja1f6zKMS6BQIUTMJUwXlg0sC+3w2mCw/tDKRVYuZySIXgKzuaDOuOvSsAP9DLaiS
         KU8nVvXmEDHBpEL/gT6r4oR6Z/NOF0F/m/Xrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143362; x=1691735362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG02hGmRFX3YN1rDfl25zcD+fatvJq2guzcIO8Dwka8=;
        b=Edv5dRGE/rCle3CEKoG6rI36iw7dSksvPmiEGLwIWHT3xLYrIjlV4ciiaEUPt2YKwY
         SIyFzCKF5tHQF41OxW7H3/o7pwqD/eO8FLQh6jl18eVFJGpaZUFDKSFis31OgHcfEj6b
         yTFnRhv+j0oqX2ifzMxHIZfCdigbxkOyZHIqnapGoj+b5z3eGj9SRoIYgGNfgnVBEY5k
         okf26xdreRKg+b6pTIg2bHj09mpkr092+rmGOYI694jr4qFLZl2pGtWG3zx5swSts+Dz
         pXhYwUK1k/tpUAGqzhm+wBbA6TTWUrut3bM24CXFrKXXo90tqlumofCqOq3O+Qaxw+f7
         2CvQ==
X-Gm-Message-State: ABy/qLZ68h1manEWjLZ7XckJgx5/hAQEkqix5zMfRHhti/dkHf8rZ2op
        /0VDo/IWlXMxSIpCLcthdLnBQaZebDj6i/caIJukmQ==
X-Google-Smtp-Source: APBJJlFKwpWGlraWmRLur+WCheXKHsV7RlRykuzp+cw+/a1UVZKrUnLjNOHWxPXq679jqjDQNiGQdw==
X-Received: by 2002:a17:906:13:b0:993:d536:3caf with SMTP id 19-20020a170906001300b00993d5363cafmr14821054eja.4.1689143361957;
        Tue, 11 Jul 2023 23:29:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-58-49-236.retail.telecomitalia.it. [82.58.49.236])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906371500b009890e402a6bsm2065390ejc.221.2023.07.11.23.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:29:21 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 0/3] Add display support on the stm32f746-disco board
Date:   Wed, 12 Jul 2023 08:29:15 +0200
Message-Id: <20230712062918.2248573-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board.

Changes in v6:
- Remove dma nodes from stm32f746-disco.dts, they are not used by LTDC,
  so there is no need to enable them.

Changes in v5:
I am confident that framebuffer sizing is a real requirement for STM32 boards,
but I need some time to understand if and how to introduce this functionality.
Therefore, I drop the following patches to allow the series to be fully merged:
 - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
 - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
 - [6/6] drm/stm: set framebuffer bit depth through DTS property

Changes in v4:
- Use DTS property instead of module parameter to set the framebuffer bit depth.

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

Dario Binacchi (3):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board

 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++
 arch/arm/boot/dts/st/stm32f746-disco.dts  | 43 +++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32f746.dtsi       | 10 ++++++
 3 files changed, 88 insertions(+)

-- 
2.32.0

