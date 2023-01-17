Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E0966D5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjAQFmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAQFmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:42:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB318B0D;
        Mon, 16 Jan 2023 21:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/WKOGoBxBJ7e9eHs1d/Wh7HfUyq9RNCraETWyfvIuN4=; b=RERJfXS4VIkaB3Go+ku9pr/fo5
        6+TYiTA2e6th8ndw1sLQ2VFzq51ZTp9I55eF1kqXd+SsQ92OTY/hU1dquGLvf5Gx09tOJjRA3kw6Y
        1pubaq+16KKv8jFjE6bLj9sVyy9FdianTkSAFu30W/5fGbTguX6iWQwv1XX6L/co9xjiOLfLPVZxW
        1ehDLrCV+bzSuZcVXcWF5HYBXPwjJkI/6FTTevATBM7qrOdcqBdFSUU38ieTVZQ+mipMdwaMoHts0
        3PytaHowkV6c3EFF0sq81+IRMjGzNDHKe+dSma1HH1wjVzL6kaW5FFca0tGBssR0n0X2TDbNRDlFE
        +Q4hdnGA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHejy-00Czpc-PB; Tue, 17 Jan 2023 05:42:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: sunplus: fix printk format warning
Date:   Mon, 16 Jan 2023 21:42:32 -0800
Message-Id: <20230117054232.24023-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %pap to satisfy the printk format warning:

drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
drivers/rtc/rtc-sunplus.c:243:33: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
  243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
      |                                          ~^

Fixes: fad6cbe9b2b4 ("rtc: Add driver for RTC in Sunplus SP7021")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Vincent Shih <vincent.sunplus@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
---
 drivers/rtc/rtc-sunplus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
--- a/drivers/rtc/rtc-sunplus.c
+++ b/drivers/rtc/rtc-sunplus.c
@@ -240,8 +240,8 @@ static int sp_rtc_probe(struct platform_
 	if (IS_ERR(sp_rtc->reg_base))
 		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
 					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
-	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
-		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
+	dev_dbg(&plat_dev->dev, "res = %pap, reg_base = 0x%lx\n",
+		&sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
 
 	sp_rtc->irq = platform_get_irq(plat_dev, 0);
 	if (sp_rtc->irq < 0)
