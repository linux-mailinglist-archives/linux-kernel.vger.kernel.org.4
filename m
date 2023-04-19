Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD06E8560
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjDSW5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjDSW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FF113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5191796a483so253846a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945023; x=1684537023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg6b8cGZHL+pVn4pi0Hug3H2RUvB+6MRfIbO+7gLzcE=;
        b=jml0A+YBM31SG+rDAonJMUrKfrrIt55mbpsWtgNCyXMIWmjzfv/o4jpFfFquF6UXo1
         I6EgJ9hPVhRV4TLTZ8VOOHUCQt6oX4g21Hq1gCVptL17Sya7ZZw7Ww5KCkwOn2Nmq3T3
         lL9Y1XrKFMdUbBs+gi8/8eqFeWW2Bei/rZ9Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945023; x=1684537023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg6b8cGZHL+pVn4pi0Hug3H2RUvB+6MRfIbO+7gLzcE=;
        b=GXG7AYCEvzTt2iam0xSQxkCgVZlGBvXWCHcBM6mBSzJzvZeCEt7hpR0asqMLCyaAbC
         0iCST3EUyMvsYbHWvpy8Ca+JlZrvKi86lghckCwjYmdx740ex+WPjTzn42E+5tlZ/GY9
         6czHu0Tu6HYzsAeOzZzIhefLY9MmHg1gKdlQn3cPCE2l4VdHCztyKfBtK8FSxCY3EOxc
         oavWwqsn929dMH7EQ2oXe+ZrQ0tATNDfHkWhBlWGG3yHKPeH5KZ6KUyAyI/d7Wb27l5r
         g72QSuKdHgrWjrWpMPE0A2OvyQB1AFVURkycTjYVi8Pfn+V1Z+LVP3+YrLbaXQYvVpcw
         SvTw==
X-Gm-Message-State: AAQBX9cLVR3cl845IWai8/5QxvMnke1apy0xchwMW47I/+0xPLA+XR0v
        5XsRt/lPGW80d+w13G6o1Fd0/a+TqfNXM5JEKOA=
X-Google-Smtp-Source: AKy350aAjm17NyJt9u6u07WIuXwqL08ZcMCu896J/GWuqct9Fs8YJNCOryDeLQLc1GRBoepzk36L4w==
X-Received: by 2002:a17:902:ea06:b0:1a6:fe25:4129 with SMTP id s6-20020a170902ea0600b001a6fe254129mr7353893plg.0.1681945023507;
        Wed, 19 Apr 2023 15:57:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/10] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Wed, 19 Apr 2023 15:55:56 -0700
Message-ID: <20230419155341.v8.2.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd134e1f481a..b402a81fea59 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -482,6 +482,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (!gic_supports_nmi())
 		return -EINVAL;
@@ -499,16 +500,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Setting up PPI as NMI, only switch handler for first NMI */
 		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
 			refcount_set(&ppi_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_nmi;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
@@ -519,6 +526,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 static void gic_irq_nmi_teardown(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (WARN_ON(!gic_supports_nmi()))
 		return;
@@ -536,14 +544,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Tearing down NMI, only switch handler for last NMI */
 		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_irq;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
@@ -1867,6 +1881,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1879,8 +1894,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.40.0.634.g4ca3ef3211-goog

