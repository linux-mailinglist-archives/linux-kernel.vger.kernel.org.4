Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5386D5348
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjDCVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjDCVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F53A86;
        Mon,  3 Apr 2023 14:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79B162B48;
        Mon,  3 Apr 2023 21:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81BAC433D2;
        Mon,  3 Apr 2023 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556714;
        bh=ucmhwRX47uXO0MlZH7U9zOFpYmMj48MklJqZ2TW68Lk=;
        h=From:To:Cc:Subject:Date:From;
        b=VyNjo4ikVA6/7LcoEe3jRN//x86B6gZbYMzYSdmQcs5PW5XgtWoCWdFc0D5eC+SnB
         Ig8e5JpBl7oWkxqh+Uv/Q/kfv0/rGQ4Z9DlFd6FswtqEjtlBx9APyiwmLIc5+Rfulh
         gMLTPAqg9HaAlPHRIXpbGu/A74JjBbacT36jniopMjYngyc+Ey93YU/bgk2DBX5j0c
         mD3eoY4KgI5LNUDd87iB0KPBl/yTZHVYhKtlys8E8aV31rUqtr8M5Zi9iXlSt2QJ/m
         HgL0raKmdw6OmUQ8563SvSc61gRZZyPl9XdXAQPUMn+ick2a8dUwKOUoTUW5u/oAtI
         eXavevm2JxqKA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        "Garmin . Chang" <Garmin.Chang@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: mediatek: Use right match table for mt8188-wpe
Date:   Mon,  3 Apr 2023 14:18:32 -0700
Message-Id: <20230403211832.1019605-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is copy/pasta from another file. Fix the match table pointer.

Cc: Garmin.Chang <Garmin.Chang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304011039.UBDX1UOT-lkp@intel.com/
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt8188-wpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-wpe.c b/drivers/clk/mediatek/clk-mt8188-wpe.c
index 5abded13cece..c372ff703f9c 100644
--- a/drivers/clk/mediatek/clk-mt8188-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8188-wpe.c
@@ -88,7 +88,7 @@ static const struct of_device_id of_match_clk_mt8188_wpe[] = {
 	{ .compatible = "mediatek,mt8188-wpesys-vpp0", .data = &wpe_vpp0_desc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
+MODULE_DEVICE_TABLE(platform, of_match_clk_mt8188_wpe);
 
 static struct platform_driver clk_mt8188_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

