Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B516B46F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjCJOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjCJOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:23 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01E11F62D;
        Fri, 10 Mar 2023 06:47:05 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id bk32so4375272oib.10;
        Fri, 10 Mar 2023 06:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1eVLNFIYFl5A4F8DTR5Ylb8kOn6AN1OaneTlD5zRxM=;
        b=VmBPoxoPFSJcnmRFw7AlBEBqXivZd0FazEv/MUpU4PESrTBr2Fje8K2yvsWBQasmMs
         CGC/3XtJ0o3jJqTbvPZa34KjSw7D0Dn/znOlLxZbJHaNKhQCOvgeQektY4ZnBdYMAfdG
         ZwVbIwGVh2Be9Nz2aVkdXrdU0hJp5/X4l9PLQihYhtBkCxzfF/ci5GnFMNAwb/ImTXk2
         ZpdpxFD8egmbTicjQ7S0iLqcY8ABF5TSYZMVVppptnfmPDkw9LbTPEaHiBdC297oQhcw
         BkuTC/+8euY+zdzee+UTTG+O40KR46C5IMbYp1rqz9BBtawxbzGKYP9E05eqOIcUF1pq
         5ppg==
X-Gm-Message-State: AO0yUKUPyEDE4SKLcggVWKHIU+Ssf0SfOpK1ioA26YYKTO19vFdm+Zwe
        lE0BuIgdP3bK39hodP20+xk7DBQ8jg==
X-Google-Smtp-Source: AK7set+rbymJT+LVV612H3qBJ3i/+wvvOThf9Jxmp0gTYmTYHJX6a0UKvKZgGO/ca7aaJY/7m1X3gA==
X-Received: by 2002:a05:6808:146:b0:384:2536:2867 with SMTP id h6-20020a056808014600b0038425362867mr4428958oie.12.1678459622081;
        Fri, 10 Mar 2023 06:47:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y14-20020a9d714e000000b0068d3f341dd9sm102063otj.62.2023.03.10.06.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:01 -0800 (PST)
Received: (nullmailer pid 1540907 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:46:56 -0600
Message-Id: <20230310144656.1540881-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-pxa/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 96f33ef1d9ea..a9ef71008147 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -257,8 +257,7 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 	}
 	pxa_irq_base = io_p2v(res.start);
 
-	if (of_find_property(node, "marvell,intc-priority", NULL))
-		cpu_has_ipr = 1;
+	cpu_has_ipr = of_property_read_bool(node, "marvell,intc-priority");
 
 	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
 	if (ret < 0) {
-- 
2.39.2

