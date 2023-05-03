Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66AF6F5C15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjECQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:33:36 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492473ABC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:33:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B39E4BFAE6;
        Wed,  3 May 2023 18:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1683131611; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=Wz6v8uYHo0LpPLKMPt437X8+F6WcxC2BzkAFGOrZAgE=;
        b=kCsPK1lkPscu8mHpVGaYjIMrkL3Y83hjOX6nB9DD7tu1cwu3wWw0muGYyEtIyH/4FGSyI3
        C3Ecep97lekr8IM+q0c4bvhyS+1u1rm3zVwCjgAaCXDc+wIOx7EuO8bzhkvNOZL3kHkLp0
        9kK+LiLno6Ubc9jHuYFT/0HrkmuYiFkcT/hZu8xZ4qY/N0pRA8945fPA2ZcE0YZUb7gR9m
        LGwRG+9WFcEat7g8s3jIohGYOyKlVI6z6JkzOLTq2CaHlhGJzuzn1mv2OlGchR+2wyPuWW
        zqlXv4S4uOS1mBYHIoY+8velaBjdmNKR8TGKTAfN6i8lJeJz13x2pumlrPJTNw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v2 0/2] Init flow fixes for Samsung DSIM and TI SN65DSI84
Date:   Wed,  3 May 2023 18:33:05 +0200
Message-Id: <20230503163313.2640898-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This patchset contains a proposal to fix the initialization flow for
the display pipeline used on our i.MX8MM Kontron boards:

  i.MX8MM LCDIF -> i.MX8MM DSIM -> TI SN65DSI84 -> 7" LVDS Panel

Without these changes the display works most of the time, but fails
to come up occassionally when booting or doing on/off cycling tests
with:

  echo 0 > /sys/devices/platform/soc@0/32c00000.bus/32e00000.lcdif/graphics/fb0/blank
  echo 1 > /sys/devices/platform/soc@0/32c00000.bus/32e00000.lcdif/graphics/fb0/blank

All the changes intend to follow the documentation provided here:
https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

Changes for v2:
* Drop RFC
* Drop non-working Exynos cleanup patch 3/3

Frieder Schrempf (2):
  drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec
  drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

 drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 19 ++++++++++++++++---
 2 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.40.0

