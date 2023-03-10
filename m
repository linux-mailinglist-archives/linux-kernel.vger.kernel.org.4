Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B216B47D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjCJOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjCJOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:54:05 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39C12B97E;
        Fri, 10 Mar 2023 06:49:54 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso3047994otk.3;
        Fri, 10 Mar 2023 06:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJLH54G0xZR2QPR83pgINzDI6/oeVXhYquad/wYfr3w=;
        b=wL0l0FiE4TaD7pRGKSbWlTTl6eYAog52NKdlfQhJuzBZX09v9A+7lnPtGHsqXBqcH+
         Vw2QxzhOmgJSZD6LqumX0M1pUi1BhEkchKFjxqWrr74ZeDaPCIGg4CLnBZO1kAuBybWU
         jSDebb0SaicyYRLCtuRM+XyRsUwEuiiAQ2XtskWdTUfhmYl6LGJEKlwzjafQO8VYy4of
         BeFfxMB9998au/o6VZQ644p1l81SCK3olawOSq1D766BsN4cMKGy8duu0P2js4X2pxJJ
         m9PPwd8jnUOztT25ZOV4jY7UW06fj7QCWLgDN8UrNZnD+JBmGpKXz/wPTj+0818RVZRl
         MqVQ==
X-Gm-Message-State: AO0yUKX/lJBHhvqg8VwLLQHgIgMtcQr8ebinW6HwP8Gc7170NerrQk1M
        6V9lCn+mmTj1xynizxaBP8sdm40Q8w==
X-Google-Smtp-Source: AK7set8P94LdlHKjvd3L1aYb9KPxDTwPY3mkWNaqUX9P15sUo6JhvjleX1N3LSOHL7bRva2A7nLYBQ==
X-Received: by 2002:a9d:3e14:0:b0:68d:972c:478d with SMTP id a20-20020a9d3e14000000b0068d972c478dmr10205744otd.16.1678459684055;
        Fri, 10 Mar 2023 06:48:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e6-20020a9d4906000000b006884c42a38asm118555otf.41.2023.03.10.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:03 -0800 (PST)
Received: (nullmailer pid 1543952 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand: qcom: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:15 -0600
Message-Id: <20230310144715.1543926-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 198a44794d2d..6b52ed8c6178 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3054,7 +3054,7 @@ static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nan
 	struct device *dev = nandc->dev;
 	int partitions_count, i, j, ret;
 
-	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
+	if (!of_property_present(dn, "qcom,boot-partitions"))
 		return 0;
 
 	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
-- 
2.39.2

