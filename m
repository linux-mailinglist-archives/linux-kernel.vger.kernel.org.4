Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F46E231E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDNMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDNMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FFBB769
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681474978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yPCGffG6qbUGI7F6FTErQ0LH3cHGPkEEbnsErQvfFxw=;
        b=VxDNuOmb7VxXsybndgVT2rHYevuRpQ2TWuIeHX4Klp/+Ut8vUHUeVAlru9ScMZ7Oaj7NfI
        zzu27G1j0zEtEWjrNynXGCl/BHFMV4eUt0NVNvV2ITjXi+GP+cwib+geSyv2f328nsBR/t
        kqWV6dlJUZFc3IC+Uxu0AvqpUrQVOK8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-jKD2-NPYMxSMrRLBwR7aaw-1; Fri, 14 Apr 2023 08:22:57 -0400
X-MC-Unique: jKD2-NPYMxSMrRLBwR7aaw-1
Received: by mail-qt1-f200.google.com with SMTP id o4-20020ac87c44000000b003e38726ec8bso12823764qtv.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474977; x=1684066977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPCGffG6qbUGI7F6FTErQ0LH3cHGPkEEbnsErQvfFxw=;
        b=huA9HxnWu6Na4bmBOjkrTF8rzEOq+K60CimdUeDDOVOHKM6d3jGYaK+aLhQN6rP0pO
         bTJb+3u6dQt8P/8hiYZtsCr1j5tQr6wH4i94mx8zbdVPEacDtihBFVLwKX8PkyWNmIhF
         X+GMgGbPcxjgpGl+e5A946MbOmHKg6cP0qoHsvqGyGO4D+hgo3osZUZUSzB8cM5ds72a
         FfN/b9GSEwKAKuxbDyI/tlfTYKg5yb8Xibpl/2p7joNj1ock6znz6MelRROtjg0xn3mt
         F1ghcNS+UBpSulqivWht/4cKg4jA4N1d0mfXH0/3oBMMSjugZwtoZLyzm9jWYrDIlyy/
         DIKA==
X-Gm-Message-State: AAQBX9c/s+hdqcivFPK+He8iFEZsgnKCm1Syb/gkxqN2hW85KGOAl2Zm
        SMsm9HRdk0tgYwGLj6FV/BAst9ru1+InJBGiYQQVuzmQ5bsdp0WXu5XHSMskM7ueOPZq3sLn0Wt
        U4nvUCbceMCtmq+gPa0rcFbb+
X-Received: by 2002:ac8:5945:0:b0:3e4:e2fa:66b0 with SMTP id 5-20020ac85945000000b003e4e2fa66b0mr7771650qtz.29.1681474977143;
        Fri, 14 Apr 2023 05:22:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrFNjLa1K+ogArho3OQ0SXUeh36MSY9HRSMAimwdY9UWoY7qElQIx2CPz+MS7Z6iLrkNomrA==
X-Received: by 2002:ac8:5945:0:b0:3e4:e2fa:66b0 with SMTP id 5-20020ac85945000000b003e4e2fa66b0mr7771633qtz.29.1681474976909;
        Fri, 14 Apr 2023 05:22:56 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r4-20020ac85e84000000b003e302c1f498sm1193420qtx.37.2023.04.14.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:22:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        nathan@kernel.org, ndesaulniers@google.com, granquet@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] phy: mediatek: fix returning garbage
Date:   Fri, 14 Apr 2023 08:22:53 -0400
Message-Id: <20230414122253.3171524-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang reports
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
  'ret' is uninitialized when used here [-Werror,-Wuninitialized]
        if (ret)
            ^~~
ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.

Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index abfc077fb0a8..c63294e451d6 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -292,9 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	if (!(digital_div <= 32 && digital_div >= 1))
 		return -EINVAL;
 
-	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
-			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
-			    txposdiv, digital_div);
+	ret = mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
+				  PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
+				  txposdiv, digital_div);
 	if (ret)
 		return -EINVAL;
 
-- 
2.27.0

