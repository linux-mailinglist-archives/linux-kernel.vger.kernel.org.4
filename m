Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86DD648597
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLIPaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLIPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986E1E3C8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLUYz9gKiHY3ndA68I5cW74nts6kf3HnnSAI7CDyETY=;
        b=dYIQ3XzWmwC+AzjFzcO3lS9fD1YTx5k63ME7n5BVhRpcQdiZfrnA6SVcaRvEC2upUyu1Z/
        oIOsQm+eq+WIbzkCmwV9yRJjIa/q8oZklz4MfgkD8Gekrw8yeGy/izC2EjLOPzXZlKnwEd
        3tct3b1EWrLf9XQuGo4Q4pJkmc49Itc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-YveCQ8BnOKWSlsd-qdT_gA-1; Fri, 09 Dec 2022 10:29:30 -0500
X-MC-Unique: YveCQ8BnOKWSlsd-qdT_gA-1
Received: by mail-vs1-f71.google.com with SMTP id 190-20020a6719c7000000b003aa14ac75f5so1321656vsz.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLUYz9gKiHY3ndA68I5cW74nts6kf3HnnSAI7CDyETY=;
        b=ZNcEUNRC1JZVZ6oNEAQmMDsb2geG92PHfoxDZXSwufmpQ/0K+gpWWlxkk1XFbXKHkA
         rNsLjju88Z7eFj+qxu6wN0EHv2D+APnN5dvC0Fynhep4mYOSUEfoODEmmURRj6r015fP
         XVYOlqTbsd3nI6kwfK5ztw0Y/pFyClNM6y6FqK+IHbl90Yw19ykcHdSg8djafrtE+72r
         GwTpShpprc2SnzFs4SmhiQuUHeLlrbEhT6nzaPB+rM2M2sWZCPB0+hl65vEviz0wmIHK
         CCnT5cs8bNJ5okywZNCz6xIxbrXTUhhqRt6QoojEO0RJMjV/oc8PDAiv/fZ2+E10lu7g
         I+gA==
X-Gm-Message-State: ANoB5pnt9ZOwqaLId+8yYYwNaoj6A2maixc95rArKp+LZROTEascD9kK
        LgA+zs42/5c25kkdjqtM6SOoOPJkR/BH02bMRxwgsnaelRaAMjm8BtsUKlWwshOhdA04WHnKlHS
        +1ShF52gX6GkSAPiU0wP7eHg=
X-Received: by 2002:a05:6122:2c5:b0:3bd:b78b:102b with SMTP id k5-20020a05612202c500b003bdb78b102bmr3298744vki.5.1670599770344;
        Fri, 09 Dec 2022 07:29:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+U2uhioAWISnye3Qoub4LCzfeuIPe70H/84a6MC+WFWRbN5P56LHkPbSWwOlcP2wVGqB3Mg==
X-Received: by 2002:a05:6122:2c5:b0:3bd:b78b:102b with SMTP id k5-20020a05612202c500b003bdb78b102bmr3298723vki.5.1670599770101;
        Fri, 09 Dec 2022 07:29:30 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:29 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:13 +0100
Message-Id: <20221209152913.1335068-7-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209152913.1335068-1-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_clk_add_provider() has been deprecated, so use its
suggested replacement of_clk_add_hw_provider() instead.

Since of_clk_add_hw_provider() can fail, like of_clk_add_provider(),
check its return value and do the error handling.

The return type of the init function has been changed to void since
the return value was not used, and the indentation of the parameters has
been aligned to match open parenthesis, as suggested by checkpatch.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/clk/socfpga/clk-pll-a10.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index bee0f7da5b6e..b028f25c658a 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -63,8 +63,8 @@ static const struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static struct clk_hw * __init __socfpga_pll_init(struct device_node *node,
-	const struct clk_ops *ops)
+static void __init __socfpga_pll_init(struct device_node *node,
+				      const struct clk_ops *ops)
 {
 	u32 reg;
 	struct clk_hw *hw_clk;
@@ -73,13 +73,14 @@ static struct clk_hw * __init __socfpga_pll_init(struct device_node *node,
 	const char *parent_name[SOCFGPA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
+	int rc;
 	int i = 0;
 
 	of_property_read_u32(node, "reg", &reg);
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
-		return NULL;
+		return;
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_a10_base_addr = of_iomap(clkmgr_np, 0);
@@ -103,12 +104,25 @@ static struct clk_hw * __init __socfpga_pll_init(struct device_node *node,
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
 	hw_clk = &pll_clk->hw.hw;
 
-	if (clk_hw_register(NULL, hw_clk)) {
-		kfree(pll_clk);
-		return NULL;
+	rc = clk_hw_register(NULL, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock:%s\n", clk_name);
+		goto err_clk_hw_register;
 	}
-	of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
-	return hw_clk;
+
+	rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock provider for node:%s\n",
+		       clk_name);
+		goto err_of_clk_add_hw_provider;
+	}
+
+	return;
+
+err_of_clk_add_hw_provider:
+	clk_hw_unregister(hw_clk);
+err_clk_hw_register:
+	kfree(pll_clk);
 }
 
 void __init socfpga_a10_pll_init(struct device_node *node)
-- 
2.38.1

