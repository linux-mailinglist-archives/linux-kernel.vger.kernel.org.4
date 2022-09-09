Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261D75B3937
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiIINk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIINkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:39 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B148C462;
        Fri,  9 Sep 2022 06:40:30 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E01401C0003;
        Fri,  9 Sep 2022 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662730829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzDRiNxlngXMkep4VlkVbmP7SB6g960sXKbI90dfLZ4=;
        b=hGtcLJPqM6oYiVcr1WZyCzBbTYzH6GqgwUSJpWEVhLJj54xhH2+gf6jNPZ5lhKogjzqxMz
        M4+Rh08pagsRVtaGzmKC/MmFVBOJsrUmg+6wDlc3QXZi2YNnFAXmkeg0gLLSUtUkBY/Gdn
        vLppwZCqwWJVX6DEQlRuFeHgpNx0Ovtgyx2292NAtRRO+Ycnhx0PbuGo3WRuqd/9ea8Jhp
        nIIAaMYBdHhhu+zsg0JExUKGfajlOgZqeBWyvDCIIEhDmQ78fEiaEV8T6aiND8FR5WQnir
        AIgZ1j2wJXmSYCu+1FaZqbzyK/eeaGPkkQhnMDbZzubKyFg1tD7NbBtPWNgFpQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/4] media: sun6i-mipi-csi2: Require both pads to be connected for streaming
Date:   Fri,  9 Sep 2022 15:39:51 +0200
Message-Id: <20220909133954.97010-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
References: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge needs both its pads connected to be able to stream data.
Enforcing this is useful to produce an error when no sensor is
connected.

Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 controller")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index 30d6c0c5161f..340380a5f66f 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -519,8 +519,10 @@ static int sun6i_mipi_csi2_bridge_setup(struct sun6i_mipi_csi2_device *csi2_dev)
 
 	/* Media Pads */
 
-	pads[SUN6I_MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[SUN6I_MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+	pads[SUN6I_MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK |
+					       MEDIA_PAD_FL_MUST_CONNECT;
+	pads[SUN6I_MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE |
+						 MEDIA_PAD_FL_MUST_CONNECT;
 
 	ret = media_entity_pads_init(&subdev->entity, SUN6I_MIPI_CSI2_PAD_COUNT,
 				     pads);
-- 
2.37.3

