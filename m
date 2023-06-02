Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD85C71FEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjFBKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjFBKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:21:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD0118C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:21:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so14988361fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685701293; x=1688293293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3q0SzVmGHZSYA8dRUVFZwmu0+tSDXCd1K6OkYFYtOd8=;
        b=pjzDmVWrmpv8bNLYLxvaZYL6mxAG3qQGOPJ8xm++RR5BxeesRsXpGhpys5eIzcxcHB
         rxgB6q/xLenJIRNPnwkVkDzsQhtNqR1+AzfiU/SbEYotGzou+QdALXAT5+qDdwLxo+tz
         xcdp4bFWejnRiySMy3kFESCse7L+7H5XqwxHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701293; x=1688293293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q0SzVmGHZSYA8dRUVFZwmu0+tSDXCd1K6OkYFYtOd8=;
        b=j7at9IuMwXtXQtquHvebA7DXN3zeBPdOcpgf2Rp4k2T3CNsTL8hAcMbUBbYTZTfLx6
         WcREJCEiE2s1K32CpxEHP0tFxEx1sNHIZdUSQFhVpXfswGV/5/Io3QPN/+Z3sEhBzFzQ
         PWmAiSn9HIMWVlZCPwMpK0tl44NZnxOq0liDgUgy8ThPbG7dxKNNENPNO/bPOueBRqWL
         QaJhoI55BKeBVkeVAsnvzizYU1n+xzZY4uwSbnpsjxV6gMYq+JgX7AibBx363qrj9hOQ
         zxkhqsZ3+/onDYZE3ouX2uLHqsqnOZ9ERSWaDMwqcaHf0CZpmLxlp0auXezlPkGmtE6o
         319A==
X-Gm-Message-State: AC+VfDwlGJKWFFUGpHKv0TNfynRmqratsttqad1WCOZj3SJ250kGhQEY
        F0yq8kO/KT8ym58mNqlQ2BujMFtaS2+yp2u9xm8xUQ==
X-Google-Smtp-Source: ACHHUZ6co4uO+gVLS2iC+Vv8IBfeCfrH5pWd6DF66wUFf3puiaOUh6G/ryC64nR6uuVEL69eEqSvqw==
X-Received: by 2002:a2e:9944:0:b0:2ad:8623:a97e with SMTP id r4-20020a2e9944000000b002ad8623a97emr1104584ljj.50.1685701292883;
        Fri, 02 Jun 2023 03:21:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0051499320435sm528887edq.14.2023.06.02.03.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:21:32 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/6] Add display support on the stm32f746-disco board
Date:   Fri,  2 Jun 2023 12:21:16 +0200
Message-Id: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
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

