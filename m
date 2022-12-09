Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5764859E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiLIPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiLIPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381C6300
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78ekr5iKDc85J9/69t3GPkuuIlp1L5lRDkKcFj8Hw1M=;
        b=AuaCXJ2DWcXa5wttcxjJ2h07eyUZwnecU9FjiML8k0wLsbmmrdTnXnQopHTRU+QnQEgnvL
        xhGL9pfZNWSwaVvvvWgQDKkQLuL6O4sQ+L2vs15saEiJhk3yQyGRKXSANcPloqrrqWecT1
        iu1xiBTow8SacjhB8bDw/4BJ/ywb7QQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-S6JZRdKfOMSJwZ7DsVklBQ-1; Fri, 09 Dec 2022 10:29:29 -0500
X-MC-Unique: S6JZRdKfOMSJwZ7DsVklBQ-1
Received: by mail-vs1-f72.google.com with SMTP id n129-20020a677287000000b003b0e74e6491so1338133vsc.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78ekr5iKDc85J9/69t3GPkuuIlp1L5lRDkKcFj8Hw1M=;
        b=wFrWfITfk2tIh1ukE9+Imw/zZInQODVwMplOB8DU38Jv5UeZ6ZTjf/5sIyqUMXlRoZ
         +SV3q6VpFmwtQNARWM83K1u9tTvq7Lgz25BI9Es0LoQV4Gp4O2DjVStl2qeyuwiUitZA
         2RwfhnTk8Txn8Yg994CPKZPJPT1vkIm3VRXTr9dkatIcsmPuuiwPvSZqNacr3RiMAYIg
         j+hQDTXHM6QKBCKBvlWQ9lzzd+2oeyhYYWDFWbiixytirO8uejbF3T4zHz9DJBoR9DnV
         Z0jZI7fhOyQjNO8Y2fF1r6xj3NjqVNdPCCFfDJlzS0i8t3flR7tEDQK56wnUHtyDBMWA
         qGdA==
X-Gm-Message-State: ANoB5pmw6LQqpEPm0w719MUuIJP/qrMnNCfiiVYVYcEquXl6k4X8IHlf
        EFiQ1BlYYVz6z0qI/e8esgzYHlDwqDxi/RYxPbPgs8nqX4HnyptYGJrD63dwftcu6lYItpsnucv
        CxHtYORhNkQZANA3T+PdUfBM=
X-Received: by 2002:a05:6102:21a6:b0:3b1:33e5:5acb with SMTP id i6-20020a05610221a600b003b133e55acbmr2993341vsb.13.1670599768581;
        Fri, 09 Dec 2022 07:29:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ky2MlNa+sAz8KiDk6t/+IHaam2m3wqWx48VWywN86MEjgWnUkOfnKKO/ivSY7bjn+JM5uig==
X-Received: by 2002:a05:6102:21a6:b0:3b1:33e5:5acb with SMTP id i6-20020a05610221a600b003b133e55acbmr2993326vsb.13.1670599768371;
        Fri, 09 Dec 2022 07:29:28 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:27 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:12 +0100
Message-Id: <20221209152913.1335068-6-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209152913.1335068-1-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

The err variable has been renamed rc for consistency.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/clk/socfpga/clk-pll.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index 127cc849c5ee..9dcc1b2d2cc0 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -70,8 +70,8 @@ static const struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
-	const struct clk_ops *ops)
+static void __init __socfpga_pll_init(struct device_node *node,
+				      const struct clk_ops *ops)
 {
 	u32 reg;
 	struct clk_hw *hw_clk;
@@ -80,13 +80,13 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
-	int err;
+	int rc;
 
 	of_property_read_u32(node, "reg", &reg);
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
-		return NULL;
+		return;
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_base_addr = of_iomap(clkmgr_np, 0);
@@ -108,13 +108,25 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 
 	hw_clk = &pll_clk->hw.hw;
 
-	err = clk_hw_register(NULL, hw_clk);
-	if (err) {
-		kfree(pll_clk);
-		return ERR_PTR(err);
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
 
 void __init socfpga_pll_init(struct device_node *node)
-- 
2.38.1

