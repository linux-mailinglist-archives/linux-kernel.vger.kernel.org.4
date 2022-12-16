Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245CF64F4CC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLPXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiLPXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:51 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBE72628;
        Fri, 16 Dec 2022 15:09:49 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m2so3712599vsv.9;
        Fri, 16 Dec 2022 15:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UugoAidNNYW+/CXvjRvb99KLwBcAHRyGStJd35EDpa4=;
        b=YXIJ5oGh1anfAjpXkOlz3FbnDTLc7H3yDdpRZSCiF3MEYRn1G9tTNvNS7jwuq4++9J
         FVNLmMIK6eF6Cx/gLLiwT7HBPKv7+sEbt39hBC+Sen6GqlnarPA1Afxd/BtV4rf0bDb+
         dARNG03mclHQpABHjAXM0IqRcWiqRYp8eqE3DAbYv377QuNBJva7TTDbxZTaAeP3SEfu
         PI20Ewyz/BcmzRZC+8+rDxT0fR5uWGlQlGHki86f4otgbSjdyOMobtpPEc/5ZKI1a95u
         CW92TN8NXIwTiKTsUbVPqoBwOcaTFRHk4J6tKKhIef533JU4Et8LN53wunSJgb4tsQ+D
         Kodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UugoAidNNYW+/CXvjRvb99KLwBcAHRyGStJd35EDpa4=;
        b=G5GH+6Y0bZ5a4t1g45EgTC7MZ6fAw2biD1629YlVQNLN91OVfXoAP6nBK+phk8lgbH
         MtJcahYFbfxZKVDAx9wlhyPDVDNHjuuy2VbBo8KIl9VGkr3sYlbFlK2h1fa+mTkfQvIK
         ob9ao1CKcGMh1+f+I1pHYVkYk0cciST2j08zJ528vktU1P0mlbtGPKkK0LQr+9gUUUtV
         XwIa69b4xuYw+nD4UHbSg28AUT2juP+gOsseTAacZfymxnuOapMEwqbcJmfj1usqCIlz
         zxoKOw3YH/6CBvHNJJ2P5WkaESAx5AxeMRI9dukn5kt3zZyKavpCTqxaMku53v2v71hb
         rCEw==
X-Gm-Message-State: ANoB5pnwB8VzOdYmkV6VyHgnTVqOoOFdrKuyTNzuHVsdDMHDQYvqboMN
        QmO0qHDSjzyrVvLGX8TP20nd58g8CMF7PA==
X-Google-Smtp-Source: AA0mqf7YWMdE5+FRRrmCXAiUUsi4Fude82YkaiUSqrzg2MMcyinrGQtF07VN4i1hPVrFhv1+ULpWrg==
X-Received: by 2002:a05:6102:4ad:b0:3b5:1c66:8462 with SMTP id r13-20020a05610204ad00b003b51c668462mr11414787vsa.12.1671232188367;
        Fri, 16 Dec 2022 15:09:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm2360386qka.66.2022.12.16.15.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:09:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 2/2] irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts
Date:   Fri, 16 Dec 2022 15:09:34 -0800
Message-Id: <20221216230934.2478345-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216230934.2478345-1-f.fainelli@gmail.com>
References: <20221216230934.2478345-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for the interrupt controller was added with a5042de2688d,
we forgot to update the flags to be set to contain IRQ_LEVEL. While the
flow handler is correct, the output from /proc/interrupts does not show
such interrupts as being level triggered when they are, correct that.

Fixes: a5042de2688d ("irqchip: bcm7120-l2: Add Broadcom BCM7120-style Level 2 interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index bb6609cebdbc..1e9dab6e0d86 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -279,7 +279,8 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		flags |= IRQ_GC_BE_IO;
 
 	ret = irq_alloc_domain_generic_chips(data->domain, IRQS_PER_WORD, 1,
-				dn->full_name, handle_level_irq, clr, 0, flags);
+				dn->full_name, handle_level_irq, clr,
+				IRQ_LEVEL, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
-- 
2.34.1

