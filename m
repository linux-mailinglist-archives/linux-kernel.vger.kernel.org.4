Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D16E8BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjDTICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjDTICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:02:02 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 22087213F;
        Thu, 20 Apr 2023 01:02:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5377518014D2A8;
        Thu, 20 Apr 2023 16:01:58 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Suhui <suhui@nfschina.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suhui <suhui@nfschina.com>
Subject: [PATCH] clk: Remove unnecessary (void*) conversions
Date:   Thu, 20 Apr 2023 16:01:54 +0800
Message-Id: <20230420080154.2356480-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct hlist_head **).

Signed-off-by: Suhui <suhui@nfschina.com>
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
2.30.2

