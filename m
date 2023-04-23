Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF206EBC9E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDWDZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDWDZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:25:45 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFBF1986;
        Sat, 22 Apr 2023 20:25:43 -0700 (PDT)
Received: from lnk.. ([10.12.190.56])
        (user=lnk_01@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33N3On8T017117-33N3On8U017117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Apr 2023 11:24:57 +0800
From:   Li Ningke <lnk_01@hust.edu.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Li Ningke <lnk_01@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
Date:   Sun, 23 Apr 2023 03:24:46 +0000
Message-Id: <20230423032446.34347-1-lnk_01@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lnk_01@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that
drivers/spi/spi-davinci.c:915 davinci_spi_probe() warn:
platform_get_irq() does not return zero

There is no need to check whether the return value is zero as
`platform_get_irq()` only returns non-zero IRQ number on success
or negative error number on failure, removing them to solve this
problem.

Signed-off-by: Li Ningke <lnk_01@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and the patch remains untested.
---
 drivers/spi/spi-davinci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d112c2cac042..fdb241e3a7bf 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -912,8 +912,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	init_completion(&dspi->done);
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret == 0)
-		ret = -EINVAL;
 	if (ret < 0)
 		goto free_master;
 	dspi->irq = ret;
-- 
2.34.1

