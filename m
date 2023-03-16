Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913716BC803
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCPH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCPH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:59:27 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69223B853;
        Thu, 16 Mar 2023 00:59:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 58BFC1A00AC4;
        Thu, 16 Mar 2023 15:59:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nqss6Lz1i7jM; Thu, 16 Mar 2023 15:59:15 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id EC7F91A0079E;
        Thu, 16 Mar 2023 15:59:14 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] clk: remove unnecessary (void*) conversions
Date:   Thu, 16 Mar 2023 15:58:26 +0800
Message-Id: <20230316075826.22754-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588..9410a4e1b04b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3194,7 +3194,7 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 static int clk_summary_show(struct seq_file *s, void *data)
 {
 	struct clk_core *c;
-	struct hlist_head **lists = (struct hlist_head **)s->private;
+	struct hlist_head **lists = s->private;
 
 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
@@ -3253,7 +3253,7 @@ static int clk_dump_show(struct seq_file *s, void *data)
 {
 	struct clk_core *c;
 	bool first_node = true;
-	struct hlist_head **lists = (struct hlist_head **)s->private;
+	struct hlist_head **lists = s->private;
 
 	seq_putc(s, '{');
 	clk_prepare_lock();
-- 
2.11.0

