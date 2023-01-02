Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0465AE77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjABI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjABI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:56:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC8289
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:56:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so27676860pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RM8oIGfMWpApShjFHib1CmVTv++qNr1Lw9sTv4BtaVA=;
        b=V9ypSvZ98gXL/PrKDa1RGlnpbLcL1VjaZuZ5Adl/U6mRPQ4gDH1S/hySpgBm2eNPLt
         Y8f+BIa7gfiuZCQU8vqF/tsBa1WyMMzEleXv6rojrP78BFCKJo7NVQaN8fkxrmWOvPMz
         KU/HismQqUH8T81DPJdtrJdx0aT7niW5LDGFGLYtwP85uNJ1MaZjmYShozBwoxisis+Z
         B4os0aIgCF4h7wQp+Wg7dRBrqZm8vCKFGBtGo/YZQ2xJB9mxkSemu95Wn4bx7NGcUPst
         EA09LTtbDD1IsDYv66gE3lQd49zWqYZ7kh8Q/UQUvjqm1HWcdIBx+NiyYSZyV6RRX75U
         dkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RM8oIGfMWpApShjFHib1CmVTv++qNr1Lw9sTv4BtaVA=;
        b=N4NmVE9ganeoH9wjpINBq5qjE61xjCpBJCF9nKXLj+eGp/skVNe7Fpo/9Y6/utRoCM
         n+jMVCrzG8LMOkmDTp6McdR2ZYxhxFBDVHA++V8+X0mUU1XwaazI4pGHxMWsYNZTVwpG
         d+2wHeVorGGVQYfSykvIJ1yKlOmKjfqNtg9b57RDPbX58Aa67KWv1MNG13b1sU4Zv9R9
         HynRNVd8nVrsDbj7pL6km/5FQegZo2Yfg0zKS5ZMZxcu7aNROVcI+V7dOXJEiFykjM0x
         P36mSJtUu9+yT6D2m0elUR30br6xMenBmnAU3vJufMBXB5rs5o9FGbTt2i1RQtr6VY3p
         mNsw==
X-Gm-Message-State: AFqh2kqZoCgki1umAqEUB3U3DKVoszHjU4eA4JD1eUXXNS/Pzy33D274
        JvkjIN48fBhXO1927Y6V36o=
X-Google-Smtp-Source: AMrXdXuFB/vgOIi+voy9S2CaZE9FNISrdfrdKC4DSQrkF9VlXL1hqCx6CpKLUZUe2DGsbSvyTPK2BQ==
X-Received: by 2002:a17:90a:bd95:b0:225:a202:5fb5 with SMTP id z21-20020a17090abd9500b00225a2025fb5mr43073574pjr.44.1672649780366;
        Mon, 02 Jan 2023 00:56:20 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id pf18-20020a17090b1d9200b002260b06befbsm9896028pjb.16.2023.01.02.00.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:56:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip/ti-sci: Fix refcount leak in ti_sci_intr_irq_domain_probe
Date:   Mon,  2 Jan 2023 12:56:10 +0400
Message-Id: <20230102085611.3955984-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: cd844b0715ce ("irqchip/ti-sci-intr: Add support for Interrupt Router driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-ti-sci-intr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index fe8fad22bcf9..020ddf29efb8 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -236,6 +236,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
 	if (!parent_domain) {
 		dev_err(dev, "Failed to find IRQ parent domain\n");
 		return -ENODEV;
-- 
2.25.1

