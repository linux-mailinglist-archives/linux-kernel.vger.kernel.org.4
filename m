Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AE6870C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBAWAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjBAWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:00:11 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD37728D1;
        Wed,  1 Feb 2023 14:00:10 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id r28so526977oiw.3;
        Wed, 01 Feb 2023 14:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj0b1ZK3fckZ4VvFRyf/KYc9WA7HNMJVi8mYiiJF7CM=;
        b=76Rsq/LOlR63GR1MYsDQgQIpjiF5+3AzXL3Jwn1bOKh1AyhoSwr/f4A5trlASv4xtB
         6BsupJrwVBcI0zmNfPIW8xtRGr8ppItP1bmjPf4UMDoDZ6WV7IvamJjJ1VUNm6ALjd60
         xpCN1ViuY9p+LmriynCivUFSaPN/jY3j6D24mBd1mjJV5Kw/VFm9nI825AxOgk4dQ1ij
         gHm3FSqeinskWywT+BAew5uiM19xhMLoHpn6BQW7H6AABp5A2dlMrrDZWS7ykVujvdTF
         peNoxCeFhaBwXR6q5HsUD8uY64i+LidYz7xDn6foWUnWNeZukYxPOPi9gHl5su7SOXaO
         gYEw==
X-Gm-Message-State: AO0yUKX71hT96W+6EbtrlkvzLtH4+Dubd8DqRsJZVH6xWCNORchEDxFN
        hl3EhTzr0TivLWT2RgIpmJqa1kh6Mw==
X-Google-Smtp-Source: AK7set9RqCkO37nOMZk3VE97UdW3F6KdrsVcaoBbY/5KlonMFk7VdUFXJJ19kcx9oQ0CM4FAcLhnYA==
X-Received: by 2002:a05:6808:f0c:b0:378:6396:13cc with SMTP id m12-20020a0568080f0c00b00378639613ccmr2286307oiw.56.1675288809257;
        Wed, 01 Feb 2023 14:00:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id my11-20020a056870698b00b00143ae7d4ccesm8331600oab.45.2023.02.01.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:00:08 -0800 (PST)
Received: (nullmailer pid 247042 invoked by uid 1000);
        Wed, 01 Feb 2023 22:00:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: Remove open coded "ranges" parsing
Date:   Wed,  1 Feb 2023 16:00:02 -0600
Message-Id: <20230201220002.246907-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property and we have common helper functions for
parsing it, so let's use them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!
---
 drivers/bus/ti-sysc.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 6afae9897843..9c8985515376 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -648,43 +648,20 @@ static int sysc_init_resets(struct sysc *ddata)
 static int sysc_parse_and_check_child_range(struct sysc *ddata)
 {
 	struct device_node *np = ddata->dev->of_node;
-	const __be32 *ranges;
-	u32 nr_addr, nr_size;
-	int len, error;
-
-	ranges = of_get_property(np, "ranges", &len);
-	if (!ranges) {
-		dev_err(ddata->dev, "missing ranges for %pOF\n", np);
-
-		return -ENOENT;
-	}
-
-	len /= sizeof(*ranges);
-
-	if (len < 3) {
-		dev_err(ddata->dev, "incomplete ranges for %pOF\n", np);
-
-		return -EINVAL;
-	}
-
-	error = of_property_read_u32(np, "#address-cells", &nr_addr);
-	if (error)
-		return -ENOENT;
+	struct of_range_parser parser;
+	struct of_range range;
+	int error;
 
-	error = of_property_read_u32(np, "#size-cells", &nr_size);
+	error = of_range_parser_init(&parser, np);
 	if (error)
-		return -ENOENT;
-
-	if (nr_addr != 1 || nr_size != 1) {
-		dev_err(ddata->dev, "invalid ranges for %pOF\n", np);
+		return error;
 
-		return -EINVAL;
+	for_each_of_range(&parser, &range) {
+		ddata->module_pa = range.cpu_addr;
+		ddata->module_size = range.size;
+		break;
 	}
 
-	ranges++;
-	ddata->module_pa = of_translate_address(np, ranges++);
-	ddata->module_size = be32_to_cpup(ranges);
-
 	return 0;
 }
 
-- 
2.39.0

