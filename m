Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6871F038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjFARDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFARDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:03:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7718D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:03:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so5052753a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685639024; x=1688231024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CktwIDz8iQqFve40BtvAwOOr5PjVMSEqWCcs9KU57A=;
        b=fkg0EKdAjxwuFw+ApM6W/plP+tXu+eZpr9jZfh3mm69cAf7gyFHd7D+i7CTiq3i7Tp
         bnXachRnfNjh91+5nuM9DfYwtLjF5b0JsT4G9Hm9y/Nn+NpOHREBHP7ibsWBTlhrSMkM
         MR1dXNqpdI+hnBE3aN3k3EIhmqMcuDXwykx7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639024; x=1688231024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CktwIDz8iQqFve40BtvAwOOr5PjVMSEqWCcs9KU57A=;
        b=UfDXl+UpBQ7rWO912bd+o3q557lqIpsOuQPDd8s0tjEWj/APHiSqeUFzYDK0E5QPAa
         6aQBBZytAIZiE1011ug+YKPoQSYRGdEn+azoPmQP5b9fVMoAnQ3RI4M56C4qlX0aLFPT
         FcQGaRaaxiSB0TTRn9uDWKHF1SnB4GJbJbT7jQozOdwXXjYhAALOWCuo0yhksGBWb07r
         mjUGzwVIpxGlm4pidr23zLvCNyiLNSTPjWgzFrpwBo6TemEwXNRw07WTMC/dN++uxJBO
         IUKj1jWUnS0vK4eHc9vVQgY80jcG/1WisIfHsCoARZmjfQ5cKWwprUifE5R7zIC8CdPG
         gJ3g==
X-Gm-Message-State: AC+VfDzaDyBlZ0ZnUXaGEumoUTuLxWXs6140qaD55fid0LsRvVHO9CGV
        cb7rPlAsyCwqFIiVhGtCleIfUmnr96Ey6+qntLEtpA==
X-Google-Smtp-Source: ACHHUZ5jWPn15sUETnU3sOiLA3ZEq58hqtWA/qPY8dV5vu8echz75s4Xk6xBQQXlIDs32fWSNQEHHw==
X-Received: by 2002:a17:907:d13:b0:96f:8d00:43be with SMTP id gn19-20020a1709070d1300b0096f8d0043bemr2133110ejc.0.1685639024540;
        Thu, 01 Jun 2023 10:03:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b0096165b2703asm10658522ejb.110.2023.06.01.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:03:44 -0700 (PDT)
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
Subject: [PATCH 0/6] Add display support on the stm32f746-disco board
Date:   Thu,  1 Jun 2023 19:03:14 +0200
Message-Id: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

