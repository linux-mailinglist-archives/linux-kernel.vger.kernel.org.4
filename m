Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F975E62D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiIVMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:52:49 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9292E11FC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:52:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYFLr1PmfzMpvN6;
        Thu, 22 Sep 2022 14:43:16 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYFLq2MC1z3j;
        Thu, 22 Sep 2022 14:43:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1663850596;
        bh=z7Nwkz4f2nnqgpQRo0kF4EVkY9iPrvs7qh3XJsxIRM0=;
        h=From:To:Cc:Subject:Date:From;
        b=xTlau66oGWLT+Sq2Lsc4CdpYpW+0Mt8ScE0kWcKruIbALEKsW1wFHw2UhslmvNt7/
         nAnArJugwSNn4FAlM97WB/PZ4QEES9YAV5mU98DvmfCBTvb4ODfs3c81iHjzaKeae4
         jK06Kjlvrw1lyLXBXw654NY0/LE+CeEH+GVinj08=
From:   Philippe Schenker <dev@pschenker.ch>
To:     dri-devel@lists.freedesktop.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 0/4] drm/bridge: lt8912b: Fix corrupt display output due to wrong bridge config
Date:   Thu, 22 Sep 2022 14:43:02 +0200
Message-Id: <20220922124306.34729-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This patch-set fixes the lt8912b driver that currently does not take
care whether or not the attached display has postiive or negative syncs
and or reports on EDID if it needs HDMI mode or DVI.

This series addresses also an issue where the LVDS startup sequence was
written to the wrong I2C address (the lt8912 has three). This caused
writing into reserved registers and causing an unstable HDMI picture
that manifests itself only sometimes and depending on the monitor with a
flickering and a repeating of going black and coming up again. While at
it move also some sensible comments to the sequence.


Francesco Dolcini (2):
  drm/bridge: lt8912b: fix corrupted image output
  drm/bridge: lt8912b: clarify lvds output status

Philippe Schenker (2):
  drm/bridge: lt8912b: add vsync hsync
  drm/bridge: lt8912b: set hdmi or dvi mode

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 39 +++++++++++++++++-------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.37.3

