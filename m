Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D45EE107
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiI1P44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiI1P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6DDED51
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D43DFB82107
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A3AC433C1;
        Wed, 28 Sep 2022 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380547;
        bh=AsSGtp1hkzL8NIS4nEw2a0/D7oTq6NL/9e+KpV8EKDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snJXPE22Q+fZfmdwH4NHVDl7njmUHnNXM2B7nQfKj+VFJqDIAtYYbJb23aY+eiKdN
         iIFRY0YgU5Ew78HtggwgHTTleUlLTRtbJNU7rBvgNciioeGXQRfPlR0k33nlwJjlUE
         GdNQGbDbFNKZjswPp26HRuyVcV+Rhhvhq2FZ3y9D+chLbtTu8278VzAgE2qNMOI2p3
         Ewznlh4iFH1dGWHYXtLKng+3d2deAWB/14nFDC/xB5G6gk++bwFCqbv1ZFZrjcRN2r
         yUaAcMYBshpUrkwaF4iM07/ifllXNeb+OBst5cBwtNdWgK0ZO+6f6hTD6dk6zMyMWV
         Ko4p3fBaC92bw==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 8/8] soc: mtk-svs: mt8192: fix bank data
Date:   Wed, 28 Sep 2022 17:55:19 +0200
Message-Id: <20220928155519.31977-9-matthias.bgg@kernel.org>
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

Values vmax and dvt_fixed are not changed at runtime, set them as needed
in the svs_banks struct.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 drivers/soc/mediatek/mt8192-svs.h     | 4 ++--
 drivers/soc/mediatek/mtk-svs-mt8192.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mt8192-svs.h b/drivers/soc/mediatek/mt8192-svs.h
index 6571ebcb2c0f..bf8c6030428f 100644
--- a/drivers/soc/mediatek/mt8192-svs.h
+++ b/drivers/soc/mediatek/mt8192-svs.h
@@ -16,7 +16,7 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.turn_freq_base		= 688000000,
 		.volt_step		= 6250,
 		.volt_base		= 400000,
-		.vmax			= 0x60,
+		.vmax			= 0x61,
 		.vmin			= 0x1a,
 		.age_config		= 0x555555,
 		.dc_config		= 0x1,
@@ -41,7 +41,7 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.turn_freq_base		= 688000000,
 		.volt_step		= 6250,
 		.volt_base		= 400000,
-		.vmax			= 0x60,
+		.vmax			= 0x66,
 		.vmin			= 0x1a,
 		.age_config		= 0x555555,
 		.dc_config		= 0x1,
diff --git a/drivers/soc/mediatek/mtk-svs-mt8192.c b/drivers/soc/mediatek/mtk-svs-mt8192.c
index 838a94834741..183acf2829f0 100644
--- a/drivers/soc/mediatek/mtk-svs-mt8192.c
+++ b/drivers/soc/mediatek/mtk-svs-mt8192.c
@@ -40,8 +40,6 @@ bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
 		}
-
-		svsb->vmax += svsb->dvt_fixed;
 	}
 
 	ret = svs_thermal_efuse_get_data(svsp);
-- 
2.37.3

