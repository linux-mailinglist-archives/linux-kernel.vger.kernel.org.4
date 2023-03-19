Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A86C0313
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCSQbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCSQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:31:40 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2EC1CBC2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:31:39 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h11so5391030ild.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw5CAGPFONZEAhyqY84+LOi8v69hjMXriBK96mcuDDk=;
        b=vfGMhat0uzlCYYcjzUxFs8fx3GAurNqbKYfPx8xMxeFt4xOn0bHXBZwYrOkYwTrt1e
         m/oa3VnX0SiKfQa1Juh+qQFtMh++OwHfnkphc9SbUGYDhom8AGz3G79yC3JQcy7AT3Qw
         3fJFeFqe0YprBSI/7vNTfZL39kzYaimHjbCC0d/tpjNrSdmLAkkeq2MtJC6EX+jyNoLY
         uc4nL+u+UKTRNRHe6kixBWdRl6MhPw2UmYZ4JcXc+bh2vh+C/Jvd4w5N8fgUPNYkdqp0
         38aHOy2Fl7TvdWyz69WGu/kNjz1nP/WK81x1ijJppFLOgCjwamgZZw5yDmkdhdLSOncp
         uxwA==
X-Gm-Message-State: AO0yUKV8L5TJdlFLAbRdPMNXfazm0gaJ/mpKsu2LqqkmOff214ecEM4v
        uu47NSIYKEgvD8/iPwgrpBRqf88XYQ==
X-Google-Smtp-Source: AK7set/MpMVQ7EQFB7nhMDZe1DCOVy4MPhpGUoqiwKkhY0F96+ZljO6aB6dmdffFzjKMCv65P0acUA==
X-Received: by 2002:a92:c682:0:b0:310:9c85:9db6 with SMTP id o2-20020a92c682000000b003109c859db6mr3500430ilg.24.1679243497880;
        Sun, 19 Mar 2023 09:31:37 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id t131-20020a025489000000b004063510ba19sm2605739jaa.101.2023.03.19.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:31:37 -0700 (PDT)
Received: (nullmailer pid 225033 invoked by uid 1000);
        Sun, 19 Mar 2023 16:31:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: bcm: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:31:25 -0500
Message-Id: <20230319163125.224833-1-robh@kernel.org>
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

Replace open coded parsing of "reg" with of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-bcm/bcm_kona_smc.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 185335843bbd..f236e12d7a59 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -31,34 +31,23 @@ static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
 int __init bcm_kona_smc_init(void)
 {
 	struct device_node *node;
-	const __be32 *prop_val;
-	u64 prop_size = 0;
-	unsigned long buffer_size;
-	u32 buffer_phys;
+	struct resource res;
+	int ret;
 
 	/* Read buffer addr and size from the device tree node */
 	node = of_find_matching_node(NULL, bcm_kona_smc_ids);
 	if (!node)
 		return -ENODEV;
 
-	prop_val = of_get_address(node, 0, &prop_size, NULL);
+	ret = of_address_to_resource(node, 0, &res);
 	of_node_put(node);
-	if (!prop_val)
+	if (ret)
 		return -EINVAL;
 
-	/* We assume space for four 32-bit arguments */
-	if (prop_size < 4 * sizeof(u32) || prop_size > (u64)ULONG_MAX)
-		return -EINVAL;
-	buffer_size = (unsigned long)prop_size;
-
-	buffer_phys = be32_to_cpup(prop_val);
-	if (!buffer_phys)
-		return -EINVAL;
-
-	bcm_smc_buffer = ioremap(buffer_phys, buffer_size);
+	bcm_smc_buffer = ioremap(res.start, resource_size(&res));
 	if (!bcm_smc_buffer)
 		return -ENOMEM;
-	bcm_smc_buffer_phys = buffer_phys;
+	bcm_smc_buffer_phys = res.start;
 
 	pr_info("Kona Secure API initialized\n");
 
-- 
2.39.2

