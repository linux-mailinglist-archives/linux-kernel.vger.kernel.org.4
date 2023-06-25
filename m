Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51573D159
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFYORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:17:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766FE4C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:17:43 -0700 (PDT)
Received: from sobremesa.fritz.box (unknown [IPv6:2a02:8010:65b5:0:bbb0:f8ec:7bc9:dbe4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66B026607117;
        Sun, 25 Jun 2023 15:17:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687702661;
        bh=DxqtcNgHx6hoDKk2XdG/IolUBA1mvNJ/4G4qGWj7gtg=;
        h=From:To:Cc:Subject:Date:From;
        b=bfXlEusYSiypBVOTQo73/JrfKbD5abbFJeLoRPCtK0pol+LLvfQ3MEwmH93H5QY3v
         EXBnDEyxZtL8WRfWXXiF84jXhGM4rRxlntNAGYfC2Exdg1JESIsyw1Mv2vBdJoWum0
         etn4CCy+ZPbs4uaJOoywFr7BCIuzp6iM2M5Jv0IFV2zopK972nG0cd+9WiNZDGzEEM
         /z/3dpzQYfRDpUkIJbNhd7gpF6QOadpHlv4nZxC+XXFRbHLyySNtnDlUYS7dJ1szNe
         DHuK2V9NzPpXAOTPAlssqofbbPpj9kTjlCpEcwarBKtM/I+MqY3M298tjIw2BmJ/MK
         JQkcSJm3gxxbA==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] Add additional YUV420 bus format check for dw-meson's bridge enable
Date:   Sun, 25 Jun 2023 15:17:14 +0100
Message-Id: <cover.1687702042.git.adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a belated follow-up on
https://lore.kernel.org/dri-devel/20220515204412.2733803-1-adrian.larumbe@collabora.com

Commit e67f6037ae1be34b2b68 ("drm/meson: split out encoder from meson_dw_hdmi")
broke 4K display modes for me, and I discovered it was because the right
pixel clock wasn't being chosen in dw_hdmi_phy_init. I misinterpreted the
reason as a problem in figuring out whether we want to enforce YUV420 mode,
but it turned out to be a mismatch between what dw-meson code is doing and
the way the bus format is being picked by the dw-hdmi bus output format drm
helper.

I fixed it by bringing back dw-hdmi bus format check in dw-meson.

The second patch makes sure YUV420 bus format is the only one being
returned by dw-hdmi's output format bridge function when that's the only
drm mode allowed.

Changelog:

v3:
        - Change commit message for all three commits to accurately
        reflect the modified files' subsystem.
        - Add v1's Acked-by tags from subsystem maintainer
v2:
        - Add commit message to patch number 3 in the series

Adrián Larumbe (3):
  drm/bridge: dw-hdmi: change YUV420 selection logic at clock setup
  drm/bridge: dw-hdmi: truly enforce 420-only formats when drm mode
    demands it
  drm/bridge: dw-hdmi: remove dead code and fix indentation

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 35 +++++++++--------------
 drivers/gpu/drm/meson/meson_dw_hdmi.c     |  4 +--
 include/drm/bridge/dw_hdmi.h              |  2 ++
 3 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.40.0

