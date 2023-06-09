Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC36B72A253
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFISdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFISdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:33:01 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94F3AA7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:32:44 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77a1cad6532so91956739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335563; x=1688927563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnZjmUhUHC5WzRiQVce8eotoya7iaXZahSL1XR1JRyA=;
        b=Bdst1AIrtFrCvGXgjI5a0DADc/NxvzK6oeUm1ZdRravNddCL88kEhZ6plu2piDeEEh
         bl7U5TXndk/0QV7yP6EqlJ/c6/dO+l3SpV26MqDpcTb5lW2VnYmxHC0CtNU39lUHalmH
         bye5M70mbwuW+OakNjL2vwGr2GgpKxVbPvwRZL/chqur/lNO3SGMkzbeqmDtyNV48OgS
         omAHbmsO9b43IKq7fKkdWNjU8QvKt3/ZTFqBkXr/V2Lbw9PEBCwGJw2K7VNP4tU2km4P
         64GE/UFEmm2G5Cc8yUpVZxMhTuRRXU2WB2gPuKUx/JgLUpdg4C6IxgG22+KNA4DHuByL
         658A==
X-Gm-Message-State: AC+VfDzOVa5ThFfQsGf7KeoXaX16YQQTogH3wuMQYk1FwqQ02RmrJ8OE
        Gj+Rp+e7aRmrMp7tAJLR5Q==
X-Google-Smtp-Source: ACHHUZ7E+AJAkw1qTBSn1r7TWOknh6JTmYsfRB0r/52+w0ltiXbOtHquEX8LzWfF8UsWHnr8J+ghwQ==
X-Received: by 2002:a5d:9d1a:0:b0:776:bfbe:a72b with SMTP id j26-20020a5d9d1a000000b00776bfbea72bmr2493921ioj.14.1686335563510;
        Fri, 09 Jun 2023 11:32:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i19-20020a02cc53000000b0041408b79f1esm1096848jaq.111.2023.06.09.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:32:42 -0700 (PDT)
Received: (nullmailer pid 1767271 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fsl_soc: Use of_range_to_resource() for "ranges" parsing
Date:   Fri,  9 Jun 2023 12:32:38 -0600
Message-Id: <20230609183238.1767186-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property with common parsing functions. Users
shouldn't be implementing their own parsing of it. Refactor the FSL RapidIO
"ranges" parsing to use of_range_to_resource() instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/sysdev/fsl_soc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 6ebbbca41065..68709743450e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -51,18 +51,10 @@ phys_addr_t get_immrbase(void)
 
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
-		int size;
-		u32 naddr;
-		const __be32 *prop = of_get_property(soc, "#address-cells", &size);
-
-		if (prop && size == 4)
-			naddr = be32_to_cpup(prop);
-		else
-			naddr = 2;
-
-		prop = of_get_property(soc, "ranges", &size);
-		if (prop)
-			immrbase = of_translate_address(soc, prop + naddr);
+		struct resource res;
+
+		if (!of_range_to_resource(soc, 0, &res))
+			immrbase = res.start;
 
 		of_node_put(soc);
 	}
-- 
2.39.2

