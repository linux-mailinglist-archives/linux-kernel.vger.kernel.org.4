Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C865B69CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiIMIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiIMIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:45:07 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E81CB09
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:45:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 793671A3289;
        Tue, 13 Sep 2022 10:45:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 426311A3279;
        Tue, 13 Sep 2022 10:45:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 06C72180219B;
        Tue, 13 Sep 2022 16:45:00 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     kuninori.morimoto.gx@renesas.com
Subject: [PATCH] ASoC: ak4458: Add ak4458_reset in device probe and remove
Date:   Tue, 13 Sep 2022 16:26:34 +0800
Message-Id: <1663057594-29141-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixup this warning when CONFIG_PM not defined

linux/sound/soc/codecs/ak4458.c:631:13: error: 'ak4458_reset' defined but\
        not used [-Werror=unused-function]
  631 | static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
      |             ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixes: e9e7df88996d64 ("ASoC: ak4458: Remove component probe() and remove()")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index b534212096ee..626310859814 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -781,12 +781,16 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 
 	pm_runtime_enable(&i2c->dev);
 	regcache_cache_only(ak4458->regmap, true);
+	ak4458_reset(ak4458, false);
 
 	return 0;
 }
 
 static int ak4458_i2c_remove(struct i2c_client *i2c)
 {
+	struct ak4458_priv *ak4458 = i2c_get_clientdata(i2c);
+
+	ak4458_reset(ak4458, true);
 	pm_runtime_disable(&i2c->dev);
 
 	return 0;
-- 
2.34.1

