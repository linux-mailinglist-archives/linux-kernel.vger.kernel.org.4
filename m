Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81379648598
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLIPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiLIPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037078F084
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBPZbzsz83JkmUujCQ8aIAfFvAeW6uUPjs+rv+f/Muo=;
        b=WloBNJWLoF1GTTYvEjln8rp/aBcYNX0DpItdY7HbK+REzv0dLFOZekrltDqmLIbEM1FUX/
        Zur/swzIJpx4Zlaq72OKypmIboxMkN31Ha5QAz1P8aoUeEm+4KQaRc71xOBF6/dmvZFyv9
        iGUsKnoIwaj8b7p2bAzZ3fSSDSI6VCM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-S5V3bL1GMYaWbKcfDHhKDg-1; Fri, 09 Dec 2022 10:29:22 -0500
X-MC-Unique: S5V3bL1GMYaWbKcfDHhKDg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-360b9418f64so53299837b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBPZbzsz83JkmUujCQ8aIAfFvAeW6uUPjs+rv+f/Muo=;
        b=RtnMjhEO6/cLQkJvdaXe/vc4mIVsMsxOPRQwUeBohpXIBzSBUl1QT/0Ehx7qeMevWt
         g2r2noVm2GI0XmW61KmLrgGSfFXVlbVptJ9NahPp9644EdRS7klEHPOvQGeRK9lMg3UG
         GLTedld8MMGeLqXCODCSAaNYjl+5jJZ4l17foO0ToF7K7IskHipK/hMnTY/BBGgml1dQ
         SMfSuF7u+/+V6sn4fMoXhbf56odhO1KbWIevM7xtf/5yj0Xib8pRjiYFlwWK46uISsKg
         ulvdp5WKx4o06UGBj2Hf120bcugfjSdKEq1jo9J3/MTdBi4cUoxt/3tOq/GaS3lOFWyE
         SBMA==
X-Gm-Message-State: ANoB5pktQ3Huizt+xNeL3KwY/UKNFQ2IAX9ZQtyzeFLrKF72tnhkWGsk
        Emh/0P8YB2hBSAj/dLm0BECOgc4jMCc2uQ+A6hx/hFEO+tN7N94G5XnIFBH+hJ3LTRQ/BZkYOAB
        /9zHW8P7235za0/QDxxzcqzk=
X-Received: by 2002:a25:5686:0:b0:70a:59ae:36ff with SMTP id k128-20020a255686000000b0070a59ae36ffmr8722597ybb.30.1670599761359;
        Fri, 09 Dec 2022 07:29:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6TPwDlYmGMeDa9q2sZerKMd6y8QUbQ8X3Mt0EEoZ1YwxEOk2JIXziIk2hEwywlYGIehhJh0A==
X-Received: by 2002:a25:5686:0:b0:70a:59ae:36ff with SMTP id k128-20020a255686000000b0070a59ae36ffmr8722568ybb.30.1670599761127;
        Fri, 09 Dec 2022 07:29:21 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:20 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:08 +0100
Message-Id: <20221209152913.1335068-2-marpagan@redhat.com>
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

The indentation of the init function parameters has been aligned
to match open parenthesis, as suggested by checkpatch, and the __init
macro moved before the function name, as specified in init.h.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/clk/socfpga/clk-periph.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 43707e2d7248..6a4075147b9c 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -47,8 +47,8 @@ static const struct clk_ops periclk_ops = {
 	.get_parent = clk_periclk_get_parent,
 };
 
-static __init void __socfpga_periph_init(struct device_node *node,
-	const struct clk_ops *ops)
+static void __init __socfpga_periph_init(struct device_node *node,
+					 const struct clk_ops *ops)
 {
 	u32 reg;
 	struct clk_hw *hw_clk;
@@ -96,11 +96,25 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	periph_clk->hw.hw.init = &init;
 	hw_clk = &periph_clk->hw.hw;
 
-	if (clk_hw_register(NULL, hw_clk)) {
-		kfree(periph_clk);
-		return;
+	rc = clk_hw_register(NULL, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock:%s\n", clk_name);
+		goto err_clk_hw_register;
+	}
+
+	rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock provider for node:%s\n",
+		       clk_name);
+		goto err_of_clk_add_hw_provider;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
+
+	return;
+
+err_of_clk_add_hw_provider:
+	clk_hw_unregister(hw_clk);
+err_clk_hw_register:
+	kfree(periph_clk);
 }
 
 void __init socfpga_periph_init(struct device_node *node)
-- 
2.38.1

