Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F130690E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBIQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBIQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:24:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AF622035
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D397AB82212
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E3C433EF;
        Thu,  9 Feb 2023 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675959858;
        bh=ylKCMMud2Zsh10OZZ6A3WtVHDEvxQmFf8psavqmf5og=;
        h=From:To:Cc:Subject:Date:From;
        b=Sny2gS7ZYNfyI4GtLmyH+FcNKMId23prYAZLOUStaE3eMwh+J2MfIfdo3ms3wZh+U
         QtI8VFiTLOemvDMhLt9s/XnHGvp7Npxj8OoJjy99++imPHPj6CK7f3S9S1MFB6tlzF
         Ae1itnhlSaJH/szbTGshwlx9uVtBMb3ccBGe0vS5WP+gMTIhjeG7kcAQ0OWRAB2kqG
         L4m1Do7Gxwbqps57FO1yDF6cpZ5YYkN0F7KUokdbBdlGVSH0JxzRnDUgh3ifo42NpR
         6MwFXsNoyIZEQdctQcYa/09b6rNo6/GwegaB6zCviJPzuBeC2EhJLC4ArsMggEgDHc
         0t4+FZWvCmP+g==
From:   matthias.bgg@kernel.org
To:     matthias.bgg@gmail.com, roger.lu@mediatek.com
Cc:     nfraprado@collabora.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH] soc: mediatek: mtk-svs: delete node name check
Date:   Thu,  9 Feb 2023 17:24:03 +0100
Message-Id: <20230209162403.21113-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The function  svs_add_device_link is called only internally from the SoC
specific probe functions. We don't need to check if the node_name is
null because that would mean that we have a buggy SoC probe function in
the first place.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 299f580847bdc..a7eb019b5157d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2027,11 +2027,6 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	struct device *dev;
 	struct device_link *sup_link;
 
-	if (!node_name) {
-		dev_err(svsp->dev, "node name cannot be null\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	dev = svs_get_subsys_device(svsp, node_name);
 	if (IS_ERR(dev))
 		return dev;
-- 
2.39.0

