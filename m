Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AF72543B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjFGGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjFGGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45D1BC6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6839993f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119503; x=1688711503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3q0SzVmGHZSYA8dRUVFZwmu0+tSDXCd1K6OkYFYtOd8=;
        b=M7Y9qbOgr2mCzPYbaTG2gTTgpe758R7rQlGfASKS5JQv7ihIt9vNrw/L7whQ9Ujgb2
         5OsGaVMznTABhT+h2tEiJSyBIK1GlpO7P/n1vVgeBxLFIDtwRjdHE6vLDhT7+BWdpFMj
         WG7dUZTg9+7/DB9QL5QDyO4hDjtU6LePF3u9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119503; x=1688711503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q0SzVmGHZSYA8dRUVFZwmu0+tSDXCd1K6OkYFYtOd8=;
        b=e9Zije0ph0pwC5OQoLkfD1iF9e1ChzzoFHjtvmp6K03Kq+kb4VXKcp6NdJOInSO7og
         cJtthpN01/o6wUNzt06TnQLrpIRbyDUgeycRe42ryctva/l2fPylnmCrtl6nuEUysEzH
         qmo5Ks78ROIYGNwFXVJtvLWboV7eS59JiTlVeMRkUDKcjtlqH4gq5IVSHOI0QfEY0lOh
         zhIJzUYmEicYWg64Su63KmLMhCC7pLc8BJ9y/2Cc4swMZgPM88OyQtAVgQvhA7gtFC09
         sydB/A5ttoHZC2n2iPPvYNGVPhBr6i4uOM0IlSZsQBDwI7VgTJww52I68fid5YorSrCx
         UO3A==
X-Gm-Message-State: AC+VfDwKEyd/NiO8z3bkPcRhWrkkOaKJ5chw5txUF+47h/ORNZlDNXBU
        lXUAHUqMwYvGqAoKZfO20k6sLvylFyLtTBQvdOLMRA==
X-Google-Smtp-Source: ACHHUZ7EBKC8ivl2FMOsG5mX9X/Fuw2ks1BSOq8ZukumLjV6wxbR5wx5KRK++ZkvEZChP06D2V6KKw==
X-Received: by 2002:adf:f0c8:0:b0:30a:dd26:63cd with SMTP id x8-20020adff0c8000000b0030add2663cdmr3825382wro.5.1686119503550;
        Tue, 06 Jun 2023 23:31:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.114.163])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm14385127wro.57.2023.06.06.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:31:42 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 0/6] Add display support on the stm32f746-disco board
Date:   Wed,  7 Jun 2023 08:31:33 +0200
Message-Id: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board,
along with a generic patch that adds the "bpp" parameter to the stm-drm
module. The intention is to allow users to size, within certain limits,
the memory footprint required by the framebuffer.

Changes in v2:
- Add 'Acked-by' tag of Conor Dooley.
- Fix build warning reported by kernel test robot.
- Add 'Reported-by' tag of kernel test robot.

Dario Binacchi (6):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board
  dt-bindings: display: simple: add Rocktech RK043FN48H
  drm/panel: simple: add support for Rocktech RK043FN48H panel
  drm/stm: add an option to change FB bpp

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi        | 35 +++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts         | 51 +++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi              | 10 ++++
 drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++
 drivers/gpu/drm/stm/drv.c                     |  8 ++-
 6 files changed, 134 insertions(+), 1 deletion(-)

-- 
2.32.0

