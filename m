Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70975738AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjFUQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFUQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:15 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EFE68
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:09 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yw-00CSar-IB; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4m-0c;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 5/5] i3c: dw; add print if cannot get resources
Date:   Wed, 21 Jun 2023 17:20:05 +0100
Message-Id: <20230621162005.473049-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_reset_control_get_optional_exclusive() call does
not print any errors, neiterh does the clk_prepare_enable
or devm_request_irq() call.

Add some basic error printing to make the probe failures
easier to debug.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i3c/master/dw-i3c-master.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9332ae5f6419..ffc84ff6225c 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1429,12 +1429,16 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								    "core_rst");
-	if (IS_ERR(master->core_rst))
+	if (IS_ERR(master->core_rst)) {
+		dev_err(&pdev->dev, "cannot get core_rst\n");
 		return PTR_ERR(master->core_rst);
+	}
 
 	ret = clk_prepare_enable(master->core_clk);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable core_clk\n");
 		goto err_disable_core_clk;
+	}
 
 	reset_control_deassert(master->core_rst);
 
@@ -1446,8 +1450,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	ret = devm_request_irq(&pdev->dev, irq,
 			       dw_i3c_master_irq_handler, 0,
 			       dev_name(&pdev->dev), master);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "cannot get irq\n");
 		goto err_assert_rst;
+	}
 
 	platform_set_drvdata(pdev, master);
 
-- 
2.40.1

