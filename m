Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B0C5EE0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiI1Pzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiI1Pzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA098FD72
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7638BB8211A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F31CC433D6;
        Wed, 28 Sep 2022 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380530;
        bh=qtQPDKCYZ/wlqIizvS08i9p0N53rArTptfBEo4YTjjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtJko+sP0l0i1L7qt5nSiIXQ7KCikEp9nlQq1hW4glAT8r0Wrd/lFgQoTZvKAFltN
         +yTfMIWZvMGxdXhEjNencg4ev0p7eOzXg6ELU0/iVUCiqmhC5MHlJyMR4Uzho6Ino0
         KxVIm51HDEoxEb+ZRPlzO5oEeu4OSkYQpu2TFsrnnb8YXG7x92quvl3Ql3Ly9JIrPM
         JVabcTgsJn1KlrrMe2W1EpWZHwimZUC1E5zZc9pJSFO6PeTqN/35XY7D1QUf3GMwsF
         pQnyt/FFcEqwCvnQRbiKBDHddDTMzOXyFdrfdxrVpqlmery+MejCnkHlCgDImM3Khc
         9gJiiacg6YZWQ==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/8] soc: mediatek: mtk-svs: clean up platform probing
Date:   Wed, 28 Sep 2022 17:55:12 +0200
Message-Id: <20220928155519.31977-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

We only ever call the SoC specific probe function from
svs_platform_probe. No need to carry that function in a global
datastructure around.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 0469c9dfeb04..fd0f636e8644 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -319,7 +319,6 @@ static const u32 svs_regs_v2[] = {
  * @banks: svs banks that svs platform supports
  * @rst: svs platform reset control
  * @efuse_parsing: svs platform efuse parsing function pointer
- * @probe: svs platform probe function pointer
  * @efuse_max: total number of svs efuse
  * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
@@ -336,7 +335,6 @@ struct svs_platform {
 	struct svs_bank *banks;
 	struct reset_control *rst;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
-	int (*probe)(struct svs_platform *svsp);
 	size_t efuse_max;
 	size_t tefuse_max;
 	const u32 *regs;
@@ -2347,11 +2345,10 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 	svsp->name = svsp_data->name;
 	svsp->banks = svsp_data->banks;
 	svsp->efuse_parsing = svsp_data->efuse_parsing;
-	svsp->probe = svsp_data->probe;
 	svsp->regs = svsp_data->regs;
 	svsp->bank_max = svsp_data->bank_max;
 
-	ret = svsp->probe(svsp);
+	ret = svsp_data->probe(svsp);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.37.3

