Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16226F2C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjEAC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjEAC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF651992
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682909841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T0ZkpApH9Uyl/XYPLTJH+Oty+sLxkUjSVHrKn2yb7ns=;
        b=COMFe4VyR+AuULFo/o/q2buVnJhO4ROuY+OSpvRJG+l1tyl0yoR6QRGzekUmaGsQq+wDbd
        4vE75NjXq2NQBpnikoBwEKNOOtl6ylpNY3Vrt9irvHMA/VNvEXpf7pPexQ8MQZLjq1ZMKm
        2TqZozQklLeGITZtBETZqc2DmRix5bo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-iyyR27rAPuiBldPIR9optg-1; Sun, 30 Apr 2023 22:57:20 -0400
X-MC-Unique: iyyR27rAPuiBldPIR9optg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74abf3c979eso277888985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682909840; x=1685501840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0ZkpApH9Uyl/XYPLTJH+Oty+sLxkUjSVHrKn2yb7ns=;
        b=evl+2pAcrfSax7ObNUBFRnOSGhtzHLgbNoO94bnNrdc/MXSzQqIHITKjjA6cvRs9ZR
         Y6gmLOxxRBNMwSkdz9AZluiVlYGOQDFV6ewAy9He0aqVEmVgzevL5r68x4RCU8DWQ9va
         GtvSYXobHiHY86dfJuIuf/3xPzH48PkUOwAl1sSjzDlrUnA0M6z4P+o09JKpngPxMciJ
         bYUCWkK7qapfQ7HsJI8sGh9Yrgw8vtuCJG7UDlXHYNeNILoH+NXWJCyEMmXrd4aO5up4
         nVPMBF92EYqbKU/QMXxRd1+gjYvTc3AjfDlwV23WDtp0T9BdgfMsaTWPyBoNL9/WiqY7
         nfng==
X-Gm-Message-State: AC+VfDyBfkgrWGi9eEuuV78/uhEP5H0MHetFY26TGLI9YyEgEznaa8PP
        3Ks1D8I00A3kJujrWn4wD/8Su2rhEsXGiuJkeSwz3a9RiO0g5JflGfKdqHGf7SHlB4KuGI5MbqV
        2YY2NNrQ+923FCBA6rKJwhK6D
X-Received: by 2002:a05:6214:c82:b0:60e:98be:8694 with SMTP id r2-20020a0562140c8200b0060e98be8694mr16050589qvr.46.1682909839882;
        Sun, 30 Apr 2023 19:57:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/ljLsU87nCmXWBl5vPSzg7xYiesizXksCYmzOcSH/wrxt2VTaDcOJnMVYcKodfsqf+KRBQA==
X-Received: by 2002:a05:6214:c82:b0:60e:98be:8694 with SMTP id r2-20020a0562140c8200b0060e98be8694mr16050578qvr.46.1682909839687;
        Sun, 30 Apr 2023 19:57:19 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b005eedb5cebd1sm8307482qvu.130.2023.04.30.19.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:57:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] phy: mediatek: rework the floating point comparisons to fixed point
Date:   Sun, 30 Apr 2023 22:57:16 -0400
Message-Id: <20230501025716.2905609-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc on aarch64 reports
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c: In function ‘mtk_hdmi_pll_set_rate’:
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240:52: error: ‘-mgeneral-regs-only’
  is incompatible with the use of floating-point types
  240 |         else if (tmds_clk >= 54 * MEGA && tmds_clk < 148.35 * MEGA)

Floating point should not be used, so rework the floating point comparisons
to fixed point.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index abfc077fb0a8..c9501a3d90a5 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -237,11 +237,11 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	 */
 	if (tmds_clk < 54 * MEGA)
 		txposdiv = 8;
-	else if (tmds_clk >= 54 * MEGA && tmds_clk < 148.35 * MEGA)
+	else if (tmds_clk >= 54 * MEGA && (tmds_clk * 100) < 14835 * MEGA)
 		txposdiv = 4;
-	else if (tmds_clk >= 148.35 * MEGA && tmds_clk < 296.7 * MEGA)
+	else if ((tmds_clk * 100) >= 14835 * MEGA && (tmds_clk * 10) < 2967 * MEGA)
 		txposdiv = 2;
-	else if (tmds_clk >= 296.7 * MEGA && tmds_clk <= 594 * MEGA)
+	else if ((tmds_clk * 10) >= 2967 * MEGA && tmds_clk <= 594 * MEGA)
 		txposdiv = 1;
 	else
 		return -EINVAL;
@@ -328,12 +328,12 @@ static int mtk_hdmi_pll_drv_setting(struct clk_hw *hw)
 		clk_channel_bias = 0x34; /* 20mA */
 		impedance_en = 0xf;
 		impedance = 0x36; /* 100ohm */
-	} else if (pixel_clk >= 74.175 * MEGA && pixel_clk <= 300 * MEGA) {
+	} else if ((pixel_clk * 1000) >= 74175 * MEGA && pixel_clk <= 300 * MEGA) {
 		data_channel_bias = 0x34; /* 20mA */
 		clk_channel_bias = 0x2c; /* 16mA */
 		impedance_en = 0xf;
 		impedance = 0x36; /* 100ohm */
-	} else if (pixel_clk >= 27 * MEGA && pixel_clk < 74.175 * MEGA) {
+	} else if (pixel_clk >= 27 * MEGA && (pixel_clk * 1000) < 74175 * MEGA) {
 		data_channel_bias = 0x14; /* 10mA */
 		clk_channel_bias = 0x14; /* 10mA */
 		impedance_en = 0x0;
-- 
2.27.0

