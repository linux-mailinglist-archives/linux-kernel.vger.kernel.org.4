Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214D5BD5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiISUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiISUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:24:53 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA8AE7E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:24:50 -0700 (PDT)
Received: from terra.. (unknown [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 3044C321013;
        Mon, 19 Sep 2022 22:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1663619088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrgHUHvJPHIHHDv2IK7wVIWtkYvTyvbl3TkWoppu+cY=;
        b=PxAZNtGgcveZ46LwXZ/te7XK+182yVDcoeS+NOK8b1xsdz567dn2BhAEyh3glLAQ405f9e
        0rRTZF7mbSPL5sT8aNDAIyStZbs1AAo1MqwSa1jGhu4tugO91alV8syBMZIrN6XHRUNenO
        MhKs7Go+0Ca+FGK0B9YAv5Lxhybl+YszRTpX5eKYkKSrrPwFVPTSw0t3owk4zn+oXmtEpV
        IiA5gEQCT2moNHmY5rjl2bmajbDVJAwXJNhNo7gNPbPwyTlnEh9rmhIDT7Oz5BTDVt7JHC
        BzPct3EUBg9SsVDuSarvcfseJU8eVuXmW2wQsXukJlsp8rpbKuZdMjquKwan3w==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 1/3] irqchip/realtek-rtl: use irq_domain_add_linear()
Date:   Mon, 19 Sep 2022 22:24:41 +0200
Message-Id: <0c4cd9f7661a30a4cb7ab9881c4a94bc8a379162.1663617425.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663617425.git.sander@svanheule.net>
References: <cover.1663617425.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using an offset of 0, irq_domain_add_simple() is identical to
irq_domain_add_linear() on DT-based systems, so use the latter instead.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 56bf502d9c67..160feae0ded7 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -171,8 +171,7 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 	/* Disable all cascaded interrupts */
 	writel(0, REG(RTL_ICTL_GIMR));
 
-	domain = irq_domain_add_simple(node, 32, 0,
-				       &irq_domain_ops, NULL);
+	domain = irq_domain_add_linear(node, 32, &irq_domain_ops, NULL);
 
 	ret = map_interrupts(node, domain);
 	if (ret) {
-- 
2.37.3

