Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227896EBB4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDVUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDVUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556292697;
        Sat, 22 Apr 2023 13:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA466141C;
        Sat, 22 Apr 2023 20:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B98C433D2;
        Sat, 22 Apr 2023 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196630;
        bh=qucudSlPchI3svnOIhdFV9BiouDXG/kOilDZtzG2V8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdtXJEch7BT8FPzNbIzVkdDmmBN2p3kL10NBU5moWj61DTwmx15WvtMOgLtFRT4Nc
         j0NuC+dNOZghYWBXTiRsfswdEwu0zp8Q2YkSOVlLuspQsRBQ8KKWMV1sNGbIjESE0+
         shqLCVXQfdjzEH/fZgLTNBa3ehTuZ/F0WEr2MVBkpyCE+8xxl1gM4PerEry/t4qg2F
         k7MzN7tQw+uf+0qt9q9RdI3zZUkPy0l2k4smddLZe8UquDZWV5NopOLJdn3bKFPSzi
         JHQPQeXcgWQQm510KcncwLOFQ7A6x1ZubWPp5nVkNkb2mlz2XHJZ4pdH5dvwJJkVWl
         GHz6/Og4WB9uA==
Received: by mercury (Postfix, from userid 1000)
        id 14A471066CC6; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
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
Subject: [PATCH v2 06/13] drm/panel: sitronix-st7789v: simplify st7789v_spi_write
Date:   Sat, 22 Apr 2023 22:50:05 +0200
Message-Id: <20230422205012.2464933-7-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st7789v_spi_write initializes a message with just
a single transfer, spi_sync_transfer can be used
for that.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 1d43b8cc1647..6290bd49d055 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -129,17 +129,13 @@ static int st7789v_spi_write(struct st7789v *ctx, enum st7789v_prefix prefix,
 			     u8 data)
 {
 	struct spi_transfer xfer = { };
-	struct spi_message msg;
 	u16 txbuf = ((prefix & 1) << 8) | data;
 
-	spi_message_init(&msg);
-
 	xfer.tx_buf = &txbuf;
 	xfer.bits_per_word = 9;
 	xfer.len = sizeof(txbuf);
 
-	spi_message_add_tail(&xfer, &msg);
-	return spi_sync(ctx->spi, &msg);
+	return spi_sync_transfer(ctx->spi, &xfer, 1);
 }
 
 static int st7789v_write_command(struct st7789v *ctx, u8 cmd)
-- 
2.39.2

