Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA364859C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLIPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLIPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445F880DE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnfSWneK8MGkHTJmldzwfHxM+WYStFYZRT9qyOXWyWc=;
        b=OEbQ77Igr6O9Sv1Zu86BhJEK0GVztdbR9EyYp9tjI0SC3yESCUiSO4ax5EHJxzXqHVDVN2
        ETTufZ8E0UnvXxnwES5P2BO08MSowlXbfHEhu1GRVeuM+j4CrYy47Els4ig0telaSgt6hg
        Jc+Yyz6YqyI0bX5wNll0DEpzrCoucfA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-nisF4oQhOVesOeIlhtTr7g-1; Fri, 09 Dec 2022 10:29:25 -0500
X-MC-Unique: nisF4oQhOVesOeIlhtTr7g-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3d3769a8103so54229347b3.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnfSWneK8MGkHTJmldzwfHxM+WYStFYZRT9qyOXWyWc=;
        b=1vk9+o3X6EHvwQVhY7DS/IBKz6z7XztVZdK/HOH1TE4APSW/baGUIiZlnzHynjmXZY
         lULHdsVCMrl5UcYzzer1xFK9qQs+kqbcAi68D63kcQZQnvjbRBHF/NC5SBhV4fsoRQmh
         40jpaygVsLkPmN+LGOncGbtPqOZQOQBDtQaw+UPBaqec0hNh4bwHVUABvDymKtMAyuvp
         IJP9SxKWgQ7oJsTX5N0/csd390H3B2BuKwcNGllUcDehJwU/OKoSeu1EQcHTPXgRfZwZ
         7S+tZXG48FPZn5G0IcPkpHr/kS43ituhZ3LJhmaoHJbBMVOucTspMwQZnWBOndbOFMIs
         PgcA==
X-Gm-Message-State: ANoB5pkyKRKJ0u+eW7MZ3pZRgcq6y3sMwy070YDYdYi29z9Z3N+F8CnU
        cQXEvxgykytvJQX3bPkhyTDZREKYBi5SbAdCG4nfFxkrDHLB936jWBOgIzXqyGZUvZDGrLk6aK1
        LGQ79ACt+VPpYIHwi1992fA8=
X-Received: by 2002:a0d:db14:0:b0:369:942d:a53a with SMTP id d20-20020a0ddb14000000b00369942da53amr8672042ywe.24.1670599764996;
        Fri, 09 Dec 2022 07:29:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JeaOR0EfyY6wPKPH/FTeHYYzcfDIr3yr/PW7r9pEn+HIxT/Holis14oc7KZyf68d2nCBYpw==
X-Received: by 2002:a0d:db14:0:b0:369:942d:a53a with SMTP id d20-20020a0ddb14000000b00369942da53amr8672022ywe.24.1670599764793;
        Fri, 09 Dec 2022 07:29:24 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:24 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:10 +0100
Message-Id: <20221209152913.1335068-4-marpagan@redhat.com>
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

The err variable unnecessarily duplicates the functionality of the
rc variable, so it has been removed.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/clk/socfpga/clk-gate.c | 35 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 0c18c55edf8c..32ccda960f28 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -126,17 +126,14 @@ void __init socfpga_gate_init(struct device_node *node)
 	struct clk_init_data init;
 	struct clk_ops *ops;
 	int rc;
-	int err;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
 	if (WARN_ON(!socfpga_clk))
 		return;
 
 	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
-	if (WARN_ON(!ops)) {
-		kfree(socfpga_clk);
-		return;
-	}
+	if (WARN_ON(!ops))
+		goto err_kmemdup;
 
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
@@ -182,13 +179,25 @@ void __init socfpga_gate_init(struct device_node *node)
 
 	hw_clk = &socfpga_clk->hw.hw;
 
-	err = clk_hw_register(NULL, hw_clk);
-	if (err) {
-		kfree(ops);
-		kfree(socfpga_clk);
-		return;
+	rc = clk_hw_register(NULL, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock:%s\n", clk_name);
+		goto err_clk_hw_register;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
-	if (WARN_ON(rc))
-		return;
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
+	kfree(ops);
+err_kmemdup:
+	kfree(socfpga_clk);
 }
-- 
2.38.1

