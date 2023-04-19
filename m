Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A566E78FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDSLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjDSLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:53:23 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57298AF16;
        Wed, 19 Apr 2023 04:53:22 -0700 (PDT)
Received: from localhost.localdomain ([10.21.35.93])
        (user=u202212060@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33JBphtt020757-33JBphtu020757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Apr 2023 19:52:05 +0800
From:   Li Lanzhe <u202212060@hust.edu.cn>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jon Lin <jon.lin@rock-chips.com>
Cc:     Li Lanzhe <u202212060@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-rockchip: Fix missing unwind goto in rockchip_sfc_probe()
Date:   Wed, 19 Apr 2023 07:50:29 -0400
Message-Id: <20230419115030.6029-1-u202212060@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202212060@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_request_irq() fails, then we are directly return 'ret' without 
clk_disable_unprepare(sfc->clk) and clk_disable_unprepare(sfc->hclk).

Fix this by changing direct return to a goto 'err_irq'.

Fixes: 0b89fc0a367e ("spi: rockchip-sfc: add rockchip serial flash controller")
Signed-off-by: Li Lanzhe <u202212060@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and remains untested.
---
 drivers/spi/spi-rockchip-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index bd87d3c92dd3..69347b6bf60c 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -632,7 +632,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "Failed to request irq\n");
 
-		return ret;
+		goto err_irq;
 	}
 
 	ret = rockchip_sfc_init(sfc);
-- 
2.39.2

