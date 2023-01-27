Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2467ED67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjA0S0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjA0S0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:26:17 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B07B79F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso8743492pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYWMw/n0BP2d3D/fZxV/dnS4sydraPBd1hVs+eTWwR0=;
        b=5SsgMGoBXHhIzD23Jk2Wrz+EZw8bMtxXJLNk0wFmsOJBSWE7hahtcntSP1xluks06q
         F4tpREigjqJsBQUZsoDI0Fp/bMW5RTjXukaW7hdzjzL0MuyLhW7Jj91PTJ33Y+Op6Cq3
         YaFCkgVMTVfM3UAp/CxpiOJX28RufdzQ8BFAh/P4zkQhBZdFsQc7LSy7eQOmm0W5tcVn
         mQyCpzl66nFnLyhVaXR8gRnQ+qnIOUjheSOJ+TWasvJvxcNsLJrTagTVV5e3TtFCkiAO
         QRkPrt4gPmKNuWt4IJ1Zpidq8ApG+FbV/pS9F/NdjeQuWwVOQNizjoqWj/5jh3B4rpDD
         hjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYWMw/n0BP2d3D/fZxV/dnS4sydraPBd1hVs+eTWwR0=;
        b=ivyZPI9tUNb7thPTPY2HKEIaC9oOuQAAS3yrSscYv+KM4YovxRcSzoM5uO0quoHT2/
         rWubseC2Gie+CEqH2df/Dwh4ZxbtTV5vujmS3AzRuC88mXdERFkmhiDkl5vMOLgFKXYL
         cW5kYPBowy+Y+233ZhdzEaUG6Hl+/Qe3+s5aSksPcJHziPSGReySU1+2hxhD8HWYPBhs
         2+1lxCjE/J65OK/nXww/s4kin5mhdCEDQw4LMpsLRYkjb5Q99b64V9DUyXisiwh/gizy
         wYBMMl+daGXWLhYpw0uF9+eSO6aQtjQ1xV7j9LFWcxpy3cO2NOnNRsGjCMqF3H3+jibv
         HBWw==
X-Gm-Message-State: AO0yUKWdZ9adSLTxUbLlTC/Om3P1mH9U9QI8mnihFjN7ap+gsX+rqdAF
        2QuCWr6k5dP76IWH8B9rkNMpC/zb54phfqrI
X-Google-Smtp-Source: AK7set+80tZlWEazZJQny1V/H72lavqxOnKlR5PW19ig21vuw4w5xUFIWAyoQtK6XmA8YOeUdGzgiQ==
X-Received: by 2002:a17:902:d2cc:b0:196:5cfe:70b2 with SMTP id n12-20020a170902d2cc00b001965cfe70b2mr1873451plc.52.1674843975472;
        Fri, 27 Jan 2023 10:26:15 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00189d4c666c8sm3195219plb.153.2023.01.27.10.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:26:15 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 02/14] perf: RISC-V: Improve privilege mode filtering for perf
Date:   Fri, 27 Jan 2023 10:25:46 -0800
Message-Id: <20230127182558.2416400-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127182558.2416400-1-atishp@rivosinc.com>
References: <20230127182558.2416400-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the host driver doesn't have any method to identify if the
requested perf event is from kvm or bare metal. As KVM runs in HS
mode, there are no separate hypervisor privilege mode to distinguish
between the attributes for guest/host.

Improve the privilege mode filtering by using the event specific
config1 field.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 27 ++++++++++++++++++++++-----
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 6b53adc..e862b13 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -301,6 +301,27 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
 }
 EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
 
+static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
+{
+	unsigned long cflags = 0;
+	bool guest_events = false;
+
+	if (event->attr.config1 & RISCV_KVM_PMU_CONFIG1_GUEST_EVENTS)
+		guest_events = true;
+	if (event->attr.exclude_kernel)
+		cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VSINH : SBI_PMU_CFG_FLAG_SET_SINH;
+	if (event->attr.exclude_user)
+		cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VUINH : SBI_PMU_CFG_FLAG_SET_UINH;
+	if (guest_events && event->attr.exclude_hv)
+		cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
+	if (event->attr.exclude_host)
+		cflags |= SBI_PMU_CFG_FLAG_SET_UINH | SBI_PMU_CFG_FLAG_SET_SINH;
+	if (event->attr.exclude_guest)
+		cflags |= SBI_PMU_CFG_FLAG_SET_VSINH | SBI_PMU_CFG_FLAG_SET_VUINH;
+
+	return cflags;
+}
+
 static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -311,11 +332,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	uint64_t cbase = 0;
 	unsigned long cflags = 0;
 
-	if (event->attr.exclude_kernel)
-		cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
-	if (event->attr.exclude_user)
-		cflags |= SBI_PMU_CFG_FLAG_SET_UINH;
-
+	cflags = pmu_sbi_get_filter_flags(event);
 	/* retrieve the available counter index */
 #if defined(CONFIG_32BIT)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index a1c3f77..1c42146 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -26,6 +26,8 @@
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
 
+#define RISCV_KVM_PMU_CONFIG1_GUEST_EVENTS 0x1
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
-- 
2.25.1

