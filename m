Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A1625461
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiKKHST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiKKHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:18:17 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FC71F05
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:18:16 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id FID00010;
        Fri, 11 Nov 2022 15:18:10 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 11 Nov 2022 15:18:11 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] clkdev: Supply __printf(x, y) formatting
Date:   Fri, 11 Nov 2022 02:18:09 -0500
Message-ID: <20221111071809.3440-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221111151810a5d0e498c2970590af15f454dcaae59d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
  drivers/clk/clkdev.c:173:3: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
    ^~~~~~~~~~
  drivers/clk/clkdev.c:187:2: warning: function 'vclkdev_create' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    cl = vclkdev_alloc(hw, con_id, dev_fmt, ap);
    ^~
  drivers/clk/clkdev.c:278:2: warning: function '__clk_register_clkdev' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    cl = vclkdev_create(hw, con_id, dev_id, ap);
    ^~

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/clk/clkdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..07f5cd49f830 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -153,6 +153,7 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
+__printf(3, 0)
 static struct clk_lookup * __ref
 vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
@@ -177,6 +178,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return &cla->cl;
 }
 
+__printf(3, 0)
 static struct clk_lookup *
 vclkdev_create(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
@@ -265,6 +267,7 @@ void clkdev_drop(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_drop);
 
+__printf(3, 4)
 static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 						const char *con_id,
 						const char *dev_id, ...)
-- 
2.27.0

