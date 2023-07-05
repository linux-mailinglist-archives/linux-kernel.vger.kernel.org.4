Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22799748CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjGETFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjGETEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170D1FEB;
        Wed,  5 Jul 2023 12:03:40 -0700 (PDT)
Received: from p200300ccff0adc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mi-0017Xe-Bk; Wed, 05 Jul 2023 21:03:28 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mh-001UQk-36;
        Wed, 05 Jul 2023 21:03:27 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting fck_src
Date:   Wed,  5 Jul 2023 21:03:22 +0200
Message-Id: <20230705190324.355282-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705190324.355282-1-andreas@kemnade.info>
References: <20230705190324.355282-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 349355ce3a05 ("ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp")
dropped prcm_fck for omap4, so the clk_src might not be available making the
clk_get(src) fail. In such cases, rely on the devicetree to assign
the correct parent.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 sound/soc/ti/omap-mcbsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 21fa7b9787997..f9fe96b61852b 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -70,8 +70,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 
 	fck_src = clk_get(mcbsp->dev, src);
 	if (IS_ERR(fck_src)) {
-		dev_err(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
-		return -EINVAL;
+		dev_info(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
+		return 0;
 	}
 
 	pm_runtime_put_sync(mcbsp->dev);
-- 
2.39.2

