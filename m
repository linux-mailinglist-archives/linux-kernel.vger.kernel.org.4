Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488756F9C01
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjEGVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:41:01 -0400
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3E7EC8;
        Sun,  7 May 2023 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=xuCzk6DqyZ2fCjPccft51jSbkGYvG1zx5q2m3ZeEIiA=; b=EMpeMXaoM3PTi/AWcqlqN4Vo+1
        GtwN/vl+G7Xo45snqlEQUsMovgZKPeNAJtrXwgKZqnya3SNbtvq61PkWDCJEthVoC6h0xJWXpvh/Z
        UyCWAS/GxSDxaBNLoKZ2ZU/xh5jvwbJJQqMzPNznAqucDdLNvlQglAFK1rekGp93vKS+8808PUoxw
        POvUq0936evFcMk+JzCQJurx7o8XHEt9PqKjQo6p0ks7S8bg1XKw5Nashdxq1Kn4+zPcxtp4eJgoH
        gj9kllXFbxcEiRqmD30K6kXtYYlrSx+inhW42RWx0wo4raAyvR8WkWXVliN5fgmnD7YXUF/B27b9o
        mZldzv0Q==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pvm7U-000fES-32;
        Sun, 07 May 2023 21:40:40 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] net: ethernet: mtk_eth_soc: log clock enable errors
Date:   Sun,  7 May 2023 23:40:35 +0200
Message-Id: <20230507214035.3266438-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently errors in clk_prepare_enable are silently swallowed.
Add a log stating which clock failed to be enabled and what the error
code was.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e14050e17862..ca66a573cfcb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3445,8 +3445,10 @@ static int mtk_clk_enable(struct mtk_eth *eth)
 
 	for (clk = 0; clk < MTK_CLK_MAX ; clk++) {
 		ret = clk_prepare_enable(eth->clks[clk]);
-		if (ret)
+		if (ret) {
+			dev_err(eth->dev, "enabling clock %s failed with error %d\n", mtk_clks_source_name[clk], ret);
 			goto err_disable_clks;
+		}
 	}
 
 	return 0;
-- 
2.39.2

