Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B046D8C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjDFBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDFBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:10:24 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB57281;
        Wed,  5 Apr 2023 18:10:22 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so2539423ooo.13;
        Wed, 05 Apr 2023 18:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680743422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFesBBHzxWYkEFkum0aSO7GPX9U9Sjvp2fw545n6LzU=;
        b=j4fD+ppDMpm3QSjq+Jr8yxpVOyIZRkZ2Bhwq/s3OUHSdGB1SmrioEY+jo1Q0Ua8oqm
         QgKoPwwgl09FODQbpaNQS9PmzYT10qTbCfZtfXratpiApXyobRpTOnspEjqDJdcXEAdZ
         gY66kywJDleAWxrFsriYWGOxgpxTJ7SSXxXI4g7myTNJ54+en9tPf4T4lVVPZ7NbIKT+
         cZMSL9ksWeHNTtaUgu+sNTklCOmZfuTm0nOIFAvvaf1TjIdAxMfqMPhxRgkAI7UNmeo8
         3PW994sls3I6WcS0XNpxqI9cVEhyCYabiFNvqj2siGl7Q1ug9eSn/NMeQKm7xf6EyIr+
         It2w==
X-Gm-Message-State: AAQBX9dvwWw32DUPUlFV9UDt4CPLiKwGevFyNL3ygrpATp4hfr0DhprU
        b2B3e1rqCCVv+iJmwzh7G+YrCDFhmQ==
X-Google-Smtp-Source: AKy350YufB0TmW8MSkABr7bePEAyAYrEhMD25kHeSFMvJDktSVM+1U+1hLzbkaUAJZjOf6Ky2ey5Ig==
X-Received: by 2002:a4a:4542:0:b0:536:a65c:12d0 with SMTP id y63-20020a4a4542000000b00536a65c12d0mr3768416ooa.8.1680743421844;
        Wed, 05 Apr 2023 18:10:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a4aae44000000b00524faf3d2d7sm7344838oon.41.2023.04.05.18.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:10:21 -0700 (PDT)
Received: (nullmailer pid 1296695 invoked by uid 1000);
        Thu, 06 Apr 2023 01:10:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mvebu: Use of_address_to_resource()
Date:   Wed,  5 Apr 2023 20:07:38 -0500
Message-Id: <20230406010738.1269781-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_property() and of_translate_address() calls with a single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
One more to add to the prior series[1]. Though there is no dependency 
and this isn't for cpu nodes.

[1] https://lore.kernel.org/all/20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org/

 drivers/clk/mvebu/armada_ap_cp_helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/armada_ap_cp_helper.c b/drivers/clk/mvebu/armada_ap_cp_helper.c
index 6a930f697ee5..e7005de66327 100644
--- a/drivers/clk/mvebu/armada_ap_cp_helper.c
+++ b/drivers/clk/mvebu/armada_ap_cp_helper.c
@@ -16,15 +16,13 @@
 char *ap_cp_unique_name(struct device *dev, struct device_node *np,
 			const char *name)
 {
-	const __be32 *reg;
-	u64 addr;
+	struct resource res;
 
 	/* Do not create a name if there is no clock */
 	if (!name)
 		return NULL;
 
-	reg = of_get_property(np, "reg", NULL);
-	addr = of_translate_address(np, reg);
+	of_address_to_resource(np, 0, &res);
 	return devm_kasprintf(dev, GFP_KERNEL, "%llx-%s",
-			      (unsigned long long)addr, name);
+			      (unsigned long long)res.start, name);
 }
-- 
2.39.2

