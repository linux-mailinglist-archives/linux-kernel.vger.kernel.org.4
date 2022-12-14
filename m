Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD864C95B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiLNM6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:58:38 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62598B98;
        Wed, 14 Dec 2022 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022715; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=sGAjnNepMrCgYWT6mOSCtwJtcZMS7t4JmZsZFydq0BA=;
        b=MO8HbhoMBh88PRegjcQluAqZmQBvadj4N0dK2mpqcA3WRr3b7E7bj6iRhEQie1GwHmSZ2e
        8qWKIxc05ATjxJcLZD2wCUCUejfWK5lNXu9wD4RZb3XUnW+zf+k0RMoDB75mfz+9aPPKG+
        I0UPzWivmdBvQFcrI5bRWBpdmpzi0KY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 00/10] drm: bridge: it66121: IT6610 support and cleanups
Date:   Wed, 14 Dec 2022 13:58:11 +0100
Message-Id: <20221214125821.12489-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds a few cleanups to the IT66121 HDMI chip driver, and
most importantly adds support for the IT6610 chip.

The driver was tested with both chips, but as I only own a HDMI monitor
without speakers, HDMI audio may not be working on the IT6610.

Cheers,
-Paul

Paul Cercueil (10):
  dt-bindings: display: bridge: it66121: Add compatible string for
    IT6610
  drm: bridge: it66121: Use devm_regulator_bulk_get_enable()
  drm: bridge: it66121: Use regmap_noinc_read()
  drm: bridge: it66121: Write AVI infoframe with regmap_bulk_write()
  drm: bridge: it66121: Fix wait for DDC ready
  drm: bridge: it66121: Don't use DDC error IRQs
  drm: bridge: it66121: Don't clear DDC FIFO twice
  drm: bridge: it66121: Set DDC preamble only once before reading EDID
  drm: bridge: it66121: Move VID/PID to new it66121_chip_info structure
  drm: bridge: it66121: Add support for the IT6610

 .../bindings/display/bridge/ite,it66121.yaml  |   4 +-
 drivers/gpu/drm/bridge/ite-it66121.c          | 315 +++++++++---------
 2 files changed, 157 insertions(+), 162 deletions(-)

-- 
2.35.1

