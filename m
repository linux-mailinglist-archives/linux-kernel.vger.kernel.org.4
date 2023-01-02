Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA165B1D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjABMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjABMN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:13:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3996354
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:13:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so25647797pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOHpSkBMQSjxH/7Gvdbef5wpYOsp0C1EIvdKSOvHDlI=;
        b=Jc6o/DbHFrkFNZavt/k9J0jeswSdRO41lcqqhOC6gql4ZX1g40pefxkv9uBgF0FbEG
         MppYjMAZ2jNMlv1xFugf/Q8OlztPeboXhQ0fOyT2nOHb3y2+vJCQQAZ1qXS2A3nyr20d
         X9PZi3RBk55/oMdT1kA+vfMxduY/PPkfXbRhxxFQJ8J+MPKPsJJfwxaau266ttSS7G8M
         PASQnElYWNdHQgDm7xnd7FSJnnM7RSd1D2uofd1vgfwtuW1iq73XxOjc3aBhjL45KIuI
         Vju2tWVd7GE/S/MND29tN2Fm+QXaesXw3SeZbGZPAgvYdHKlQe1dc/C9Xs1axKPrphty
         OP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOHpSkBMQSjxH/7Gvdbef5wpYOsp0C1EIvdKSOvHDlI=;
        b=rPeBckZva/ZgvxW6R0RL9N38KYQoVU8XubcnVxuVo06OuE8Gn44EzdV5/rPqCEouSn
         c4fA/O36+T3H/Gp8MIGZEZn4kHWuHlhbeaWUDIl+yYDvfOzda7NPVGmkRVKSuwk7zNju
         996/9Ytwf67Odq5BtIMbPoq/Hf3aga/QnhuRgq/dtnDLgDOcZeqpV99ks1Xf42XoWu4j
         ljfvFOZE4b8C9r1VEBJOsWCi7DShSDTaOySCLWj6tSsB1pZ6N8c6zcfHO9lvZ779jcsd
         b/OIKbLZQeQwb8lnWmkgFoOd/7W+9qSNzYh6uCVaIOHoP2p6KDjho+GeUPbO/cvuEp+g
         DD3A==
X-Gm-Message-State: AFqh2krxCI2LmTx11fX/sx4tcv0WM9JPLMbcJkXp7kW4rdkl9lBRsu9c
        YF1clck+huw8nvAV1BHqsSA=
X-Google-Smtp-Source: AMrXdXv7C5g0BtkI1wNQVklaBuigvdBdmvXRx88hRxKyMzSlZBP+wdQAwU4hoWCIAQ+hz2hI4giNMQ==
X-Received: by 2002:a17:90a:a28:b0:223:f78c:15d with SMTP id o37-20020a17090a0a2800b00223f78c015dmr44701725pjo.41.1672661606198;
        Mon, 02 Jan 2023 04:13:26 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id on16-20020a17090b1d1000b0020b21019086sm33242949pjb.3.2023.01.02.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 04:13:25 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip: Fix refcount leak in platform_irqchip_probe
Date:   Mon,  2 Jan 2023 16:13:18 +0400
Message-Id: <20230102121318.3990586-1-linmq006@gmail.com>
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

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irqchip.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 3570f0a588c4..7899607fbee8 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -38,8 +38,10 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	struct device_node *par_np = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
-	if (!irq_init_cb)
+	if (!irq_init_cb) {
+		of_node_put(par_np);
 		return -EINVAL;
+	}
 
 	if (par_np == np)
 		par_np = NULL;
@@ -52,8 +54,10 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller. The actual initialization callback of this
 	 * interrupt controller can check for specific domains as necessary.
 	 */
-	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
+	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
+		of_node_put(par_np);
 		return -EPROBE_DEFER;
+	}
 
 	return irq_init_cb(np, par_np);
 }
-- 
2.25.1

