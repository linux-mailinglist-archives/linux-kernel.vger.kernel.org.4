Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86808735C78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFSQzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjFSQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:55:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A456115
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-763a2e39b88so63192485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1687193734; x=1689785734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7c41/bHT5/tFLz1vS2dSA0XEpnWz70oHsIq3qIfRkDg=;
        b=S9h89TIICRrr9urRyxkGPxg0pQMos+Ew4eyrnlhGAsTdrj9u8CsXILBMHfxlU7CPRA
         MlvBX16u/Pe5p+tRlks2G3BeNtr8MSkOlCdEduf+udO69nQpBqWdvZm7vfzyiJKtXCKm
         +m/FKU5TZTwkArCuraEa9SXh2BfvfGOdigDtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193734; x=1689785734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c41/bHT5/tFLz1vS2dSA0XEpnWz70oHsIq3qIfRkDg=;
        b=CF2A3WwI8ZJcoIS2rvr7dFo9kQ4Sqx1SbprsXg7iyAuvlcsjb6QRNjX8a/iyJwjeiN
         4+u2Z4IOMB0b9r3Wm8ek8oYXJmZPnZmdRkfKZ45l4CsD4F+Bk8Wfdxvgp73wDpG6ngs5
         DXd88MB2mMSRmNYvxvRmzQSrQ0v7+jkuPgnjkB4hJxaTf4q+ut9RCrBJ+i36DGovDDoC
         89V1WebI07LgIg2IwSojnD6aPc9DGxtzO7afuS8SrvCNap/sNKe3/5PovfwjLBYMzJzw
         4L7eIzikc67/n8UgqEPYD7w+IdZxkAS90HweIUnuUfFIflgH1+hiOe9Lb+s3iyS7UDb2
         CcxA==
X-Gm-Message-State: AC+VfDwLw1eMh7zgncv5dxfuqwHzflS/ORcHQy9IzI8oJI5ThzQixUdI
        nvjQSfhngzHEvpxwpsw6e3hC2z85VyRL5mamFF4=
X-Google-Smtp-Source: ACHHUZ4sTAr3fMXBOvSLg9lwFYSVkTHAYf5eM0y/vpSON2lPB1hmZtTUmjdP6o3pvxtzCVlRsK/uFA==
X-Received: by 2002:a05:620a:8e04:b0:762:55f7:7105 with SMTP id re4-20020a05620a8e0400b0076255f77105mr4382806qkn.28.1687193734044;
        Mon, 19 Jun 2023 09:55:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-25-27-4.retail.telecomitalia.it. [79.25.27.4])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a15f700b0075d49ce31c3sm109103qkm.91.2023.06.19.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:33 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 0/6] Add display support on the stm32f746-disco board
Date:   Mon, 19 Jun 2023 18:55:19 +0200
Message-Id: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board,
along with a generic patch that adds the "bpp" parameter to the stm-drm
module. The intention is to allow users to size, within certain limits,
the memory footprint required by the framebuffer.

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

Dario Binacchi (6):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board
  dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
  ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
  drm/stm: set framebuffer bit depth through DTS property

 .../bindings/display/st,stm32-ltdc.yaml       |  6 +++
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi        | 35 +++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts         | 52 +++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi              | 10 ++++
 drivers/gpu/drm/stm/drv.c                     |  6 ++-
 5 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.32.0

