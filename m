Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A171F4DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjFAVhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFAVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6E19B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-65292f79456so414788b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655427; x=1688247427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjRakdb30yszASmxf/wTOyUnLRsbS0tBSqMyHI/mgmg=;
        b=BuG16CgsJZuRqklwqhtraGtO9mDBkjKRduhSYXiCHYmDshIggjlraGD2H9A4z6yorm
         wBu2dEQorFkxnRHLq3Cn+M+LkZWex3ajMYBEgSEujM238OkqShSG0aa2MrkveBlrCXC5
         p6NW7FtAcuIScDFj5KSELcmbgvEEVbSabk3PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655427; x=1688247427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjRakdb30yszASmxf/wTOyUnLRsbS0tBSqMyHI/mgmg=;
        b=i9Kd6y9nYYJi94gxAISYewPWIy5HSmm33S2QV8Q3RLEzO7lWH4Yrbn2BtQdXshMOwH
         +KAb9zHKYqSwyIG1jlkCvLnPbPNGRi09ixmjsR8c1xDpNl2RchKA9zAxqVrgJpfNgaoG
         1HttAbunsSW6bXL0Enn/F28/1jYPkf2DmnGAqKVVT4uesfuG/hQsnf94hOrW3CJznI+y
         g+hvpa3yrH8oaaH0qpDtmrR1OzZpXAWCKEkaTu9jeHnk/wkSuda9ldJ4rBv5kp2o7hod
         47+V9+D5YmQuK1WzYHqW72auoUda+dS79TKnLa0fcjyGb9RFSL2ACLZ1xvT7nmJl8okn
         Ccug==
X-Gm-Message-State: AC+VfDzSANHt6dZc74+pkklc4rBd9gyJXwvuNicZK6ePs8/hKHSGOuKu
        FLR5OR3k7tngwyQrCkiiO8DkLW3Y0IzUkvOpLgs=
X-Google-Smtp-Source: ACHHUZ7X4JWk69pwtWfobliPNOJVZLyvG8aXSBcL3S43aA7yIba6lfLCLzZNDwufKt9JnCsD52RTZQ==
X-Received: by 2002:a05:6a21:1647:b0:111:6a14:7d0 with SMTP id no7-20020a056a21164700b001116a1407d0mr6606398pzb.60.1685655427621;
        Thu, 01 Jun 2023 14:37:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Thu,  1 Jun 2023 14:31:45 -0700
Message-ID: <20230601143109.v9.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 0c6c1af9a5b7..ed37e02d4c5f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -525,6 +525,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (!gic_supports_nmi())
 		return -EINVAL;
@@ -542,16 +543,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
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
@@ -562,6 +569,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 static void gic_irq_nmi_teardown(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (WARN_ON(!gic_supports_nmi()))
 		return;
@@ -579,14 +587,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
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
@@ -2001,6 +2015,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -2013,8 +2028,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

