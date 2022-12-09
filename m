Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE63648599
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLIPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiLIPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:30:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE048F70A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUr5nGjxc+b90ljVLd9eIXOVWRTwlS2fejPnyUptxZ8=;
        b=LAZ28H7CuafDG9I+QfTI8wHZ4q+9cL20bY01da1s5tb/MaOimVM4v6sJ0qAvbbUoCEaRL8
        UPDHko1He+eT5aATopSQ08EGAtPUhV/mD43gMx20fVhtNbXbWe57/Csv2hHWw4OwCChwAE
        /xy0SsrxJii6z2JdSfir9FBGxaEhQ6c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-C9a3L82FO6Wp3Wtubq2EGg-1; Fri, 09 Dec 2022 10:29:24 -0500
X-MC-Unique: C9a3L82FO6Wp3Wtubq2EGg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-40306a5a42cso53482267b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUr5nGjxc+b90ljVLd9eIXOVWRTwlS2fejPnyUptxZ8=;
        b=RerroyEGl9Il403VgNRcBvaCDpOg/9lpK4Agw0dBZCOlZJvb24rPzREfMRnc/IQ7/d
         nB0YZ19Gviu/LLG961Q44dwS/TFNcHDiUwNb5jnsAmefWp6QRkRgtsfIuXdUNcCjz14d
         EQ/E6iEJUtNWx9WOccSgQVgqS/Z4Y10Qqd4tXapHLq+FNV8LmBpepPBgbhIJks8LVF5v
         CZ1FVfFuE1Vr2/Lo+c6fDDItIEy2MbGs/j1ZeX8uYTyZN/gZaM63OxFEEO9Abxsg9P8q
         3og2K6ozcSVWnFb7vUr0OZzFTnujRJDrELwIksfWeHj05J211B1wklt9dEdyrsVWAl1o
         hrUg==
X-Gm-Message-State: ANoB5pm2KfnRiSEhAu3P4FE21qdD9SxMpZi2gI9wCWU086g4hXDTXlmA
        MpS2loqMboV+roIoPuOImcLRprAmNvE4AxXGCiy8sKo/RMLTBc3vp2oJihcit9LAI5cDh4vYRkI
        xeUNfR30nnKkCXcUO2xQl3+o=
X-Received: by 2002:a25:b943:0:b0:702:61d3:e1c7 with SMTP id s3-20020a25b943000000b0070261d3e1c7mr5582490ybm.16.1670599763166;
        Fri, 09 Dec 2022 07:29:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MOTzDuvvF0acz3hXFcA35QT0x6Hsu7ZE46UCVYvG+2oKgWd/AIf2yB6AiYrkT7BbIK6k3dQ==
X-Received: by 2002:a25:b943:0:b0:702:61d3:e1c7 with SMTP id s3-20020a25b943000000b0070261d3e1c7mr5582469ybm.16.1670599762887;
        Fri, 09 Dec 2022 07:29:22 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm29484qkb.77.2022.12.09.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:29:22 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
Date:   Fri,  9 Dec 2022 16:29:09 +0100
Message-Id: <20221209152913.1335068-3-marpagan@redhat.com>
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

The indentation of the init function parameters has been aligned
to match open parenthesis, as suggested by checkpatch, and the __init
macro moved before the function name, as specified in init.h.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/clk/socfpga/clk-periph-a10.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/socfpga/clk-periph-a10.c b/drivers/clk/socfpga/clk-periph-a10.c
index b9cdde4b8441..64cc70b970b7 100644
--- a/drivers/clk/socfpga/clk-periph-a10.c
+++ b/drivers/clk/socfpga/clk-periph-a10.c
@@ -57,8 +57,8 @@ static const struct clk_ops periclk_ops = {
 	.get_parent = clk_periclk_get_parent,
 };
 
-static __init void __socfpga_periph_init(struct device_node *node,
-	const struct clk_ops *ops)
+static void __init __socfpga_periph_init(struct device_node *node,
+					 const struct clk_ops *ops)
 {
 	u32 reg;
 	struct clk_hw *hw_clk;
@@ -106,21 +106,25 @@ static __init void __socfpga_periph_init(struct device_node *node,
 
 	hw_clk = &periph_clk->hw.hw;
 
-	if (clk_hw_register(NULL, hw_clk)) {
-		kfree(periph_clk);
-		return;
+	rc = clk_hw_register(NULL, hw_clk);
+	if (rc) {
+		pr_err("Could not register clock:%s\n", clk_name);
+		goto err_clk_hw_register;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
-	if (rc < 0) {
+
+	rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw_clk);
+	if (rc) {
 		pr_err("Could not register clock provider for node:%s\n",
 		       clk_name);
-		goto err_clk;
+		goto err_of_clk_add_hw_provider;
 	}
 
 	return;
 
-err_clk:
+err_of_clk_add_hw_provider:
 	clk_hw_unregister(hw_clk);
+err_clk_hw_register:
+	kfree(periph_clk);
 }
 
 void __init socfpga_a10_periph_init(struct device_node *node)
-- 
2.38.1

