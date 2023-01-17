Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2566E4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjAQR0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjAQRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6046706;
        Tue, 17 Jan 2023 09:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5BD6B8166E;
        Tue, 17 Jan 2023 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BF1C433F0;
        Tue, 17 Jan 2023 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673976294;
        bh=KC6Cqdox5PMT4Fg/LqX4+EbIIxzPEvcJfLC8UsQ29qQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nnCHEsqnLTKVK0s2IzoHZ1KqwB/vrMDGIYRPqOp+liW2QDONQWlvWr7QX3K1dT5q6
         JDLAGl9sAdNNM/nx2X+CAdLuhTyc35r5uUsFhfqtkDgcv+S6s3PXM0nNZ6zCyfVxCF
         TLTF+tyJqxZKNTPtQfWghB7rjmurg/g/CreZUkRa62PFT7tA5Uk3rpr2iwSA5QwxoM
         tohtfWoqcio12ZeOGfb0bu6nJNtuxutut0mPGtuTjuo5VnPwkWj1pdd3vA1Ox2ELnJ
         m41soeFDoZZ2hEzbgZw828LjtVXb7dMpY8351sBJKKyszX3OYtXijswjE5sn55Wcl8
         AGWhH3lcUYvBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: sunplus: fix format string for printing resource
Date:   Tue, 17 Jan 2023 18:24:44 +0100
Message-Id: <20230117172450.2938962-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
causes a compiler warning:

drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The best way to print a resource is the special %pR format string,
and similarly to print a pointer we can use %p and avoid the cast.

Fixes: fad6cbe9b2b4 ("rtc: Add driver for RTC in Sunplus SP7021")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-sunplus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
index e8e2ab1103fc..4b578e4d44f6 100644
--- a/drivers/rtc/rtc-sunplus.c
+++ b/drivers/rtc/rtc-sunplus.c
@@ -240,8 +240,8 @@ static int sp_rtc_probe(struct platform_device *plat_dev)
 	if (IS_ERR(sp_rtc->reg_base))
 		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
 					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
-	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
-		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
+	dev_dbg(&plat_dev->dev, "res = %pR, reg_base = %p\n",
+		sp_rtc->res, sp_rtc->reg_base);
 
 	sp_rtc->irq = platform_get_irq(plat_dev, 0);
 	if (sp_rtc->irq < 0)
-- 
2.39.0

