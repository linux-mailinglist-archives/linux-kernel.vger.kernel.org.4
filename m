Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD216B479A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjCJOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjCJOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:51:19 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA96FFCF;
        Fri, 10 Mar 2023 06:48:24 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3037300otp.6;
        Fri, 10 Mar 2023 06:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa7CRQ6qwJpAL4dvFhydbZOoyyqtxEnlsxzPDMFkS9c=;
        b=otvV/u2kTG4c4h3H7LKNN33lLzdMGWX/RtDHd2T/ijMQRP6WUuCYJM03+kie+U6PvR
         rOAlVP2sy3wbTLc3eQctnsyrF1XXM184x7cWIFbWYopJV56Yp2qPN8PIo2aQRHE9LW7u
         df6A2y/EzK6L3PlWSj3J6ckcfWQjHxjJ8Rd+SoTRW6YD3M90tUWf9UlRZpsFaY2feHol
         G2HdF4/8/EUbrnseYAsy/eg3LsXrrFcJwwEGaGYKN+eur0HYQRI+0YSO0ybA5h5bSDbb
         lU2UgNDo3JiGXWYwmNN0SWkF9SXulMGaisif9G7sP2i6tYMPyj2QZS7ProobRcTV1OSi
         DWnw==
X-Gm-Message-State: AO0yUKWBRLF9gotK0r2BgsyLsO/Fr/6MoSbi7trSCN1fNpiqAObvF8W7
        kmXokws7GK/LkvORpQqzdfMA7/Kh4A==
X-Google-Smtp-Source: AK7set+kcBCHF1q6aSuSHt3zob40kvtLCg9iU4XywgttHrD7f5mhHYBQrOhjUrF2t2OpitLBx3REeg==
X-Received: by 2002:a05:6830:1007:b0:690:eb17:89f4 with SMTP id a7-20020a056830100700b00690eb1789f4mr1168130otp.3.1678459679278;
        Fri, 10 Mar 2023 06:47:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u26-20020a9d4d9a000000b00686a19ffef1sm91712otk.80.2023.03.10.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:58 -0800 (PST)
Received: (nullmailer pid 1546285 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:31 -0000
From:   Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virt: fsl: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:31 -0600
Message-Id: <20230310144731.1546259-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/virt/fsl_hypervisor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index f8b4389d60d9..b4c72ecc0489 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -796,7 +796,7 @@ static int has_fsl_hypervisor(void)
 	if (!node)
 		return 0;
 
-	ret = of_find_property(node, "fsl,hv-version", NULL) != NULL;
+	ret = of_property_present(node, "fsl,hv-version", NULL);
 
 	of_node_put(node);
 
-- 
2.39.2

