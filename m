Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269666EBB34
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDVUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDVUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1C26AC;
        Sat, 22 Apr 2023 13:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836A26141C;
        Sat, 22 Apr 2023 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE25C433EF;
        Sat, 22 Apr 2023 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196627;
        bh=bc966mPuHp6GXalMrFKC71SEtTQR845SWL1piWdHfRM=;
        h=From:To:Cc:Subject:Date:From;
        b=ukQ3ghS2bhWNPG+kTcJ4OQsFpLEBnGAsvMfE9Wv/HiOOCo3cDlLBxp4NxJLUFZfBD
         +ABayrKwFI4DaNErTFD2p49gvSGYkLQGFEFQI3L0XclQ5ZsegMTOdsDGXF1KnqmMp8
         m/6A7IpyvoSBSOSwTBHYVz/kdL8iD6EUwBWvFrCwa0H2bIY12wKsfOyUWVgztVry3A
         BJhn/ElsydXFG/j9/vttsVVcPvwgdlVZic407vipfF/ZgL26NYQ05vyNvsHNElaALb
         Gl/ayClkk4cRwdvgRigGnQPUQgLU9dxnyLMH/z+jD7goCxgVV/H8WgY4MXBoHz0pVZ
         HLAof4xenMt0g==
Received: by mercury (Postfix, from userid 1000)
        id 0939F1066CBD; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/13] Add Inanbo T28CP45TN89 panel support
Date:   Sat, 22 Apr 2023 22:49:59 +0200
Message-Id: <20230422205012.2464933-1-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds panel support for Inanbo T28CP45TN89, which I found inside of a
handheld thermal camera. The panel is based on the st7789v controller. All
information is based on reverse engineering.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230317232355.1554980-1-sre@kernel.org/
 * Apply DT binding changes requested by Krzysztof Kozlowski and his Ack
 * I changed the driver patches to avoid code duplication and splitted
   the code a bit more

-- Sebastian

Sebastian Reichel (13):
  dt-bindings: vendor-prefixes: add Inanbo
  dt-bindings: display: st7789v: add Inanbo T28CP45TN89
  drm/panel: sitronix-st7789v: add SPI ID table
  drm/panel: sitronix-st7789v: remove unused constants
  drm/panel: sitronix-st7789v: make reset GPIO optional
  drm/panel: sitronix-st7789v: simplify st7789v_spi_write
  drm/panel: sitronix-st7789v: improve error handling
  drm/panel: sitronix-st7789v: avoid hardcoding mode info
  drm/panel: sitronix-st7789v: avoid hardcoding panel size
  drm/panel: sitronix-st7789v: add media bus format
  drm/panel: sitronix-st7789v: avoid hardcoding invert mode
  drm/panel: sitronix-st7789v: avoid hardcoding polarity info
  drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support

 .../display/panel/sitronix,st7789v.yaml       |   5 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 148 ++++++++++++++----
 3 files changed, 120 insertions(+), 35 deletions(-)

-- 
2.39.2

