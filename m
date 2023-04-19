Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFC6E8565
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjDSW5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjDSW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9E5FF7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-246bb512038so217977a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945032; x=1684537032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpO6xBr8GRTIiZAwOhR7DhqHQGx50IOyRoOo/b42ur0=;
        b=kscE08GAAWK411hIe/AlrpkEs4LuqorOLSZXU62OFqZbcuwAzAR8cxaFEQzLrqNjma
         eIM4oARZaGkVYYFo7UShuM6mT3sodkflb5QAh7j0/+pCO1fujDsTYb6Cdq4h4L7LheLe
         LvW+QGq9VdNSHMlXNHrY28CT0AZxYFUZ4elQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945032; x=1684537032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpO6xBr8GRTIiZAwOhR7DhqHQGx50IOyRoOo/b42ur0=;
        b=AjxwhUKzkbHvJD8sU3g1TnyOvjQgVIenfxNCzEHmJRWJ7HQ/L0YQ7lbMiLy3rWX8RX
         wzhJWUf0EL7fHB9ElNCQz58rUa8Zvg1x8+7uilHoI7/h8+Na9JutP0VPK9Kq0p8fbSmS
         B+1Py7+EQETGDcsBgzcVcPfS5y9XAzqXNR1kj93tPTrb7Yw1M1yFU+Mni8VkfgQ2Qxfd
         yEyRbAuLu8wz86Oz70Or32qSFXY/ZzDmJyFq9trjsafTzJGdymvw0szh/HSCwdXbEF+N
         yOE66qSFdFx1KdtWk6fKQko6Vqo18mLuavRwliLTDr7DKB6QKNeq1pghhKc/bMqxTtDx
         smYQ==
X-Gm-Message-State: AAQBX9fCjrA26OR5fIMCQxImzMmAW54ps5arNJVQO5FojFQUpxiXf5fj
        2khf99PLr1PxrQbs+8V+dDoUuA==
X-Google-Smtp-Source: AKy350aK5ae5EGORUG+NerzBv8kCtz8aZ4AMVRXzvnaMvPW39Dl9faoU7w/z73Q50CZOVchx5jXuaw==
X-Received: by 2002:a17:90a:c297:b0:240:3dc7:4939 with SMTP id f23-20020a17090ac29700b002403dc74939mr4439076pjt.27.1681945032562;
        Wed, 19 Apr 2023 15:57:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:11 -0700 (PDT)
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
Subject: [PATCH v8 05/10] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Wed, 19 Apr 2023 15:55:59 -0700
Message-ID: <20230419155341.v8.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Enable NMI backtrace support on arm64 using IPI turned as an NMI
leveraging pseudo NMIs support. It is now possible for users to get a
backtrace of a CPU stuck in hard-lockup using magic SYSRQ.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP

 arch/arm64/include/asm/irq.h |  4 ++++
 arch/arm64/kernel/ipi_nmi.c  | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..dc35b9d23a81 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,10 @@
 
 #include <asm-generic/irq.h>
 
+extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 struct pt_regs;
 
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 712411eed949..c592e92b8cbf 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -31,11 +32,24 @@ void arm64_send_nmi(cpumask_t *mask)
 	__ipi_send_mask(ipi_nmi_desc, mask);
 }
 
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	if (!ipi_nmi_desc)
+		return false;
+
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_send_nmi);
+
+	return true;
+}
+
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	irqreturn_t ret = IRQ_NONE;
+
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		ret = IRQ_HANDLED;
 
-	return IRQ_NONE;
+	return ret;
 }
 
 void dynamic_ipi_setup(void)
-- 
2.40.0.634.g4ca3ef3211-goog

