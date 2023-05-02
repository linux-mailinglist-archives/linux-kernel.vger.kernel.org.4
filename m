Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84336F4657
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjEBOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4AA10E6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683039029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XhmeR7C2zfghm/IL/as+Y+pN51ISJ3AaRZIBkHirVVA=;
        b=ERAMhrv3lSDVezXotdGhSK033aFoiZCby3cyuxxhgoJ5TCOWLeWADjX6BffvRmnVZM3x4y
        PcUkqN9wSLwS+NHQeXMplGU6dzkqde5EORc42Av4apwGWLcYDlkpxZ+jsOnx+OxD24kvcb
        pU+aNHbphUtKELKEu2GHvI4Kkl6smxs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-KxmTO5b7OkGYToXrjecDlw-1; Tue, 02 May 2023 10:50:27 -0400
X-MC-Unique: KxmTO5b7OkGYToXrjecDlw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7515a759676so189514385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039027; x=1685631027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhmeR7C2zfghm/IL/as+Y+pN51ISJ3AaRZIBkHirVVA=;
        b=Uy2qgsEhqhyv22kk3Yyd5i17yrjpR96qjk/YOMy3zj/fTMAVjhGXYm034J13Y/jM5R
         c/0BOJb2PzxxeFpu/BsK8UZXFVwySd4RqP+zDuuDhrE8gTTqd+QAi05YVu03uxGA/+mZ
         XMrmMVEP/kZdi62WAENRSTDk9fXpinF5PVwJCivoq38KqSY9oMRHkdSrp5rbdYPevC3p
         mcCky5Fw33B7uP1mUdQL9pnGeB+VLBfFVHAXNUcPkxn42Y8fWZSCDp+BFuUE5AkOCst8
         EZHWUyef6h9clKdO0993gdrqUphATXdqJHIm/kQC+LINFmigv+qGP9HeeumTeosrYLAb
         nHCQ==
X-Gm-Message-State: AC+VfDxZe05bVHpiU1dHLwUdKQCxAKH1sddvK68B40D2n6uVczNkF2qp
        Y6Lb9nYY0C893tARZFdnE2nQo+jX4HaECvVtoI5CMe5TQuKY8oW07/lCIZ2ZOiCnuvE3Pb9ig3r
        KKW6bu6vRPUDYpcxd2ZPTQBeH
X-Received: by 2002:a05:622a:143:b0:3ea:bec4:ef57 with SMTP id v3-20020a05622a014300b003eabec4ef57mr28954466qtw.13.1683039027420;
        Tue, 02 May 2023 07:50:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dHp9unnIVk0+Doy1XuqLSB0Po7DZSJ94Ylm3eZ5tLIvbR2wMADu2J7HkOiAWMy91uB3Mwgg==
X-Received: by 2002:a05:622a:143:b0:3ea:bec4:ef57 with SMTP id v3-20020a05622a014300b003eabec4ef57mr28954428qtw.13.1683039027172;
        Tue, 02 May 2023 07:50:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g7-20020ac81247000000b003ef3bbd242asm10343812qtj.32.2023.05.02.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:50:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] phy: mediatek: rework the floating point comparisons to fixed point
Date:   Tue,  2 May 2023 10:50:05 -0400
Message-Id: <20230502145005.2927101-1-trix@redhat.com>
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
v2: silence robot by casting types to u64

---
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index abfc077fb0a8..093c4d1da557 100644
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
+	} else if (((u64)pixel_clk * 1000) >= 74175 * MEGA && pixel_clk <= 300 * MEGA) {
 		data_channel_bias = 0x34; /* 20mA */
 		clk_channel_bias = 0x2c; /* 16mA */
 		impedance_en = 0xf;
 		impedance = 0x36; /* 100ohm */
-	} else if (pixel_clk >= 27 * MEGA && pixel_clk < 74.175 * MEGA) {
+	} else if (pixel_clk >= 27 * MEGA && ((u64)pixel_clk * 1000) < 74175 * MEGA) {
 		data_channel_bias = 0x14; /* 10mA */
 		clk_channel_bias = 0x14; /* 10mA */
 		impedance_en = 0x0;
-- 
2.27.0

