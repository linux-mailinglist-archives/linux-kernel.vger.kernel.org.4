Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327463120A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 01:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKTAjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 19:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKTAjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 19:39:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4978B31;
        Sat, 19 Nov 2022 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=h1esYPTYICzVqS5zAnG6MaCABy6Ms8LkfzyARU9oPIY=; b=gKLzyG3B8UGZAqDl0MeoZVyvbi
        tQL2LouaZiHMmUT0e3ZW1B8ZZxGUN/utMa5sk9hpERle6VBqxug5xD7PC3WaoGXEcpAx6eUUVolR7
        NWWLZFcvfK4w/gcctHit4V5Ojj/7lKyea1ZJ2lO5ha67GYhhUo/8cOyIbm6BFvertlVqX8qSAhtzR
        4odCN9QYFcg1MhG7vwy7CstPOuHG1KcrBdPzyYRuirWjeGH5nMzs1+VEyuvcjQM9TF+tR8K6qg636
        CCOXu1cJS5eSivisuSKRPg6PLO1483+htVc/H8E8hSRlXCrE51gyhcWetuqQGmDd//Zx0hsZXshQO
        V6C5qoMQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owYN4-003hNr-95; Sun, 20 Nov 2022 00:39:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Qin Jian <qinjian@cqplus1.com>, Arnd Bergmann <arnd@arndb.de>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] ARM: sunplus: use %pap to print resource_size_t
Date:   Sat, 19 Nov 2022 16:39:30 -0800
Message-Id: <20221120003930.23846-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

Prevent a printk format warning by using %pap, which is designed for
this purpose and can handle any size of resource_size_t.

../drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
../drivers/rtc/rtc-sunplus.c:243:33: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
  243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",

Fixes: 0aa94eea8d95 ("ARM: sunplus: Add initial support for Sunplus SP7021 SoC")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qin Jian <qinjian@cqplus1.com>
Cc: Arnd Bergmann <arnd@arndb.de>
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
+	dev_dbg(&plat_dev->dev, "res = 0x%pap, reg_base = 0x%lx\n",
+		&sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
 
 	sp_rtc->irq = platform_get_irq(plat_dev, 0);
 	if (sp_rtc->irq < 0)
