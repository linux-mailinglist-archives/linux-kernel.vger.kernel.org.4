Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB49E6E5F05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDRKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjDRKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:38:53 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 03:38:50 PDT
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA6D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:38:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DF00C02F8;
        Tue, 18 Apr 2023 12:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1681813861; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=7rqfhs3lrBiS0Wr56mg5vWQczZCmYWMaWRtwjvTDXLU=;
        b=Rzqu+xZRmSjK7mxneuXkIcsQIqc7QMlQJAJLtz5ao9e890mi95HohRfDILQ0z/pX5uI7bB
        +lCg28lC3wlBp1nVfNeAhQ1133mpofYtVchwe76+/NAGQLRIJHdhl8ScQNxSpUBthBmC5d
        hrV8+ddNvFbPKqgrl5O7v5WPGK9gkQ3qz+N/bGCHFbWkohUaJ4GOUsP/lADOCI1XUcERD9
        jWt7ffo+dK+W0us0Bu1NcSwmg0lp5D6xXXLKy2xgSS/anxxtehZSCnrjrBztwRU9LPxWWd
        hee6AA4/SXEc8ps/ayR/rVDi+MK+f9z0zozmVzmb0EQCcIvlLY/5zl6m3VyZmw==
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
Subject: [RFC PATCH 0/3] Init flow fixes for Samsung DSIM and TI SN65DSI84
Date:   Tue, 18 Apr 2023 12:29:36 +0200
Message-Id: <20230418102947.876621-1-frieder@fris.de>
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

I also added a bit of a speculative patch 3/3 for cleaning up the
Exynos init flow, which is the main reason this is sent as RFC as
I have no idea if this is correct/working at all.

Frieder Schrempf (3):
  drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec
  drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec
  drm: bridge: samsung-dsim: Remove init quirk for Exynos

 drivers/gpu/drm/bridge/samsung-dsim.c | 34 +++++++++++++++------------
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 19 ++++++++++++---
 2 files changed, 35 insertions(+), 18 deletions(-)

-- 
2.40.0

