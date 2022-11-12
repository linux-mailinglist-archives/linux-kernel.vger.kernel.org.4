Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BC626A64
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiKLQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiKLQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A2E0CE;
        Sat, 12 Nov 2022 08:04:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d9so5486991wrm.13;
        Sat, 12 Nov 2022 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzftkJ+4gAzALNOFNlR0ynkJ89pkyFUm1wKevHfbpdU=;
        b=Dd+3stiS49wu3yR+maof3xzekVzhFVNf9ABzYShA4b7Rsw+ss9XG1zwCAd7YReERQk
         e9xfFAOhjJnisioz/LlJyxoNP1GHixqnoG/3b6T2qQsoo+OGcRyfAX/WGwFFYKnKkVgD
         gYZGedX5/KUbcIjMOaMKlkM7j6OoD2mUEHejC95B0/XuhR9sM3oEOo9fUCU2ThNWiXA0
         4yOLgP+ttiZPTHRFyEc/s7pTtmhtbyAv1oefKswsUFvvOYlep5uf4ANQ9a8cJma4McmI
         ScW9R8H3B5ks9f6DuSgUYbV84SsIHRD7HTn/vR+qy7J6sI+yAdUIjKo4XhWedfG0xyKo
         2ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzftkJ+4gAzALNOFNlR0ynkJ89pkyFUm1wKevHfbpdU=;
        b=5PsqxGqYHCHNFNNjJQE9i8iAfAKmChIowl3O8HglR5BBPFc2h+bNtjPr1oP0NXqKGl
         aXQCa2qrFD3ReuOYplZFcHLTBYa+aSK3iYCEEBpzAnSCcFsNtq9tS2tgeeQL9Hma+3R6
         rvl7mPQGNFil8VW+MuRMaKYKB41kE6RCcd8PgVnJMjhjeOzU2rglyHvH8YEe4x1rfQS6
         gA4e4yQx2pTHrHaaKSiUZd+glmpVvzq+tUtxBtB3k5SzNPqlv/HVXtZEPi0y0JuAFVtk
         6PhC4PUGW+5jr1MB4sbqSsBqXPS3P6Kqe1DjCh5v3OUAWre/GF7igSB/H5pfyfj7Xq7t
         QCiA==
X-Gm-Message-State: ANoB5pkmAkTW2quZv4Dk/LtbiCqSx4OXV0WtwX3Wg/j9KtOawnSxD2Qj
        cHYd7aQfjTWcpgeAWaJJ20M=
X-Google-Smtp-Source: AA0mqf42xObJGVx93xSxumkmGRbcuB2yKXMO/ZP07kz+rokHYiwbXDZYbIbfdLeqG13BNCt1UvAGZA==
X-Received: by 2002:adf:e302:0:b0:236:76ab:c986 with SMTP id b2-20020adfe302000000b0023676abc986mr3895551wrj.379.1668269057389;
        Sat, 12 Nov 2022 08:04:17 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:16 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Misc SOQuartz Enablement
Date:   Sat, 12 Nov 2022 17:03:57 +0100
Message-Id: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This series enables the following functionality on the SOQuartz CM4
module:

 * GPU (patch 1)
 * Video output (patch 2)
 * HDMI (also patch 2)
 * HDMI audio (patch 3)
 * PCIe2 (patch 4), CM4IO board
 * SOQuartz Blade bindings (patch 5)
 * SOQuartz Blade device tree (patch 6)

In V2, we also add the SOQuartz Blade base board and bindings
definition. The Blade base board allows mounting a SOQuartz CM4
SoM onto a 1U-rackable board with PoE and and M.2 (PCIe 2 x1) slot.

Changes to v1:
 - added pcie-clkreq-h to soquartz pinctrl
 - added blade base board (by Andrew "neggles" Powers-Holmes)

Andrew Powers-Holmes (1):
  arm64: dts: rockchip: Add SOQuartz blade board

Nicolas Frattaroli (5):
  arm64: dts: rockchip: Enable GPU on SOQuartz CM4
  arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
  arm64: dts: rockchip: Enable HDMI sound on SOQuartz
  arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO
  dt-bindings: arm: rockchip: Add SOQuartz Blade

 .../devicetree/bindings/arm/rockchip.yaml     |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3566-soquartz-blade.dts    | 194 ++++++++++++++++++
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts |  11 +
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    |  75 +++++++
 5 files changed, 282 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts

-- 
2.38.1

