Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A973639BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiK0RYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0RYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:24:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6463BD;
        Sun, 27 Nov 2022 09:24:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4761860pjb.1;
        Sun, 27 Nov 2022 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y1qNNd/rnLboER7671YJEja2V7agUxEto42Sj8dHEo=;
        b=I/mF4i5yCr1yCDooGqgCD7bW8IXqPfXbxV4De9ZrH/9OVDJ4xT0NYINRuVtuDPIpWa
         vOrO+w96CtT7QiKZ1WiuCRXNPwDQXOhcB/A4o0X7vRce0mpkx7c1R900QgQpX8Xkyemd
         Ydh2TiXxW0ekJrHI5NRA4xLKQXZ5lbfM2xLqyerfU91FJ6JDIlIMTDdCjS6hw1DD5oza
         NUSSTIkQ2IpN+WoJqJ+0D7VO7cwwb6MVxCx3p8OdX3ZZUaE87w5a5O0nq7lLbrtPXl/D
         sEfSbC2CHpxfjQMPa4UCk6ZIZjdKdX/9RQgcuhlRiVjCDApslmXwYUk9OgAuiNCPPki4
         msPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y1qNNd/rnLboER7671YJEja2V7agUxEto42Sj8dHEo=;
        b=q9pgwy8ja1mXdFp8E8K2otXX2tNp8stiZQ9BtzzQ+hhbH1TmEGlbPA5DOPiersiFxI
         n8L238xb+d9uIwVAETgrYeVlX2zEkuiF1h6zfGwlu5zXoIvG6x6TnhbEx0L6VYdu2rJR
         X5tRSSfTRt8tZdVhdz09K1ko/HfTmdW6eXZouRFjqZoRwnSUmg2b0sSiBYu/kg54q01p
         jEImlBcCAO9tdli/shPEBLVqenLGgu1nrbbtj4AO9pNZcG6DUqe28UFfrcnimccdM2Im
         z0T9nS7RQSZUYOs3pQO2PQTbPIzDQGie1xLm6BvDA7GL4wqX1LpmtDf92IbjOnWQY7Yd
         h9YQ==
X-Gm-Message-State: ANoB5pnsESH0ey1R4Du3WODc2VhrKr7tyh71qSiLsM9ApiTChQytOP3Q
        b3Pcd4DedkoFU+nEjAke5NQ6hBJrnYQ=
X-Google-Smtp-Source: AA0mqf7qIGfYWx8LgAjZi8RMfn8Li5+7aZGdpvFxCPA46/9bXrndFQptSWd5keaCKYlQe9aOi0wobg==
X-Received: by 2002:a17:902:cad3:b0:189:8b52:cee7 with SMTP id y19-20020a170902cad300b001898b52cee7mr996908pld.62.1669569882822;
        Sun, 27 Nov 2022 09:24:42 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1cc4:c66e:6c75:d2b8:130e:c9e5])
        by smtp.googlemail.com with ESMTPSA id r1-20020a635141000000b0046feb2754e5sm5439407pgl.28.2022.11.27.09.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 09:24:41 -0800 (PST)
From:   Vishal Badole <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        mintupatel89@gmail.com, vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>
Subject: [PATCH v5] Common clock: To list active consumers of clocks
Date:   Sun, 27 Nov 2022 22:53:19 +0530
Message-Id: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature lists the clock consumer's name and respective connection
id. Using this feature user can easily check that which user has
acquired and enabled a particular clock.

Usage:
>> cat /sys/kernel/debug/clk/clk_summary
                      enable  prepare  protect
                                                                          duty  hardware                            Connection
   clock               count    count    count    rate   accuracy phase  cycle    enable   consumer                         Id
------------------------------------------------------------------------------------------------------------------------------
 clk_mcasp0_fixed         0        0        0    24576000          0      0  50000     Y   deviceless                     of_clk_get_from_provider
                                                                                           deviceless                     no_connection_id
    clk_mcasp0            0        0        0    24576000          0      0  50000     N      simple-audio-card,cpu           no_connection_id
                                                                                              deviceless                      no_connection_id

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
---
 drivers/clk/clk.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bd0b35c..c4aa3b4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2952,28 +2952,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
 	int phase;
+	struct clk *clk_user;
+	int multi_node = 0;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
+	seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
 		   level * 3 + 1, "",
-		   30 - level * 3, c->name,
+		   35 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
 		   clk_core_get_rate_recalc(c),
 		   clk_core_get_accuracy_recalc(c));
 
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
-		seq_printf(s, "%5d", phase);
+		seq_printf(s, "%-5d", phase);
 	else
 		seq_puts(s, "-----");
 
-	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
 
 	if (c->ops->is_enabled)
-		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
+		seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N');
 	else if (!c->ops->enable)
-		seq_printf(s, " %9c\n", 'Y');
+		seq_printf(s, " %5c ", 'Y');
 	else
-		seq_printf(s, " %9c\n", '?');
+		seq_printf(s, " %5c ", '?');
+
+	hlist_for_each_entry(clk_user, &c->clks, clks_node) {
+		seq_printf(s, "%*s%-*s  %-25s\n",
+			   level * 3 + 2 + 105 * multi_node, "",
+			   30,
+			   clk_user->dev_id ? clk_user->dev_id : "deviceless",
+			   clk_user->con_id ? clk_user->con_id : "no_connection_id");
+
+		multi_node = 1;
+	}
+
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2994,9 +3007,10 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
+
 
 	clk_prepare_lock();
 
-- 
2.7.4

