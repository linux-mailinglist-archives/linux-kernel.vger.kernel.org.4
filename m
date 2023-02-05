Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209568ADD0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBEBPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBEBP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:15:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944025976
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:15:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso2375159pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 17:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPkrRraxSxPO8Bas1c93CWcZiwYxt6lnwNFP5o7eW+0=;
        b=PnGxq0Ksntq7Itg+YeOS+4xtHTpJRfRn2qVKZXOSX9aCT1nDbSCO8tSNH3Ss9Z6RYJ
         rMHRuCxYPNEAWYlW0U4uPOHGt9f9N01MNHKtkemgQlgRmL3SvhjxWZ7rlGBlRSPmLVIB
         ugtYUzXjgSiiTjJeOvco4hm35WuvFfwTZuOQ/RUOtloUVpB2gH+7k52WMi+p1BOtS/dl
         92QlI6l5gjud3L4agFG4BGQBIrP6DJVlekXnjHkoSsAOSXFvRUPj13p5nAehIXxicszg
         2Z6cvzHr6ouSB+nfLlG72leoJAsSfoMSaPA843qFsqgWGIyV1tlzqeJHre4+3NKVhRN0
         wYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPkrRraxSxPO8Bas1c93CWcZiwYxt6lnwNFP5o7eW+0=;
        b=QZt6wauxqf3gwFWQu5mHDkO1VoEz4VspY+xP52n1se0JWOC5D0HpGkic+eQFX2eXcr
         tUSV9b13mpBnk2JtUGxFt+jjXhKrIsnv/O6Rr2uteRBACP4de5uEiIqFxhwfSprffgqQ
         aCFvy8tqQVwj+QvxFPp+UQ/hkPo/kBl33P8tZHHEz04jJCFKiLN5PXJdTDF7VOf8mXKG
         xFOkoE+hkre7EnrRVkBXjszD4f45v4HKrfwqIydrjWWvZfITLMhMRai2vO19z+ugr+2s
         5kVyxR08pe7RJKTw20CflO8c1ceZDigHRQIKN80iAtdrpPvQ8XSjcr4fJFwvOd3MHg9r
         35Bg==
X-Gm-Message-State: AO0yUKXXT1dpiMoogyISV/1vqlrBuiXmpoBrY9+NkcTXIk03FGg88oIi
        YhfqtmX0sLBBP6GD+11BFldo5TXltP74llVc
X-Google-Smtp-Source: AK7set+y355g8GXNv7L+yDXV6nynKVR2hWweLQHKUUCN1zPTxPUe/D4Kdpqr4IkICqzkOYVxiR7GGg==
X-Received: by 2002:a17:90a:e7c2:b0:230:1acb:191c with SMTP id kb2-20020a17090ae7c200b002301acb191cmr15877237pjb.14.1675559724666;
        Sat, 04 Feb 2023 17:15:24 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b0023080c4c3bcsm2721917pjc.31.2023.02.04.17.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 17:15:24 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 02/14] perf: RISC-V: Improve privilege mode filtering for perf
Date:   Sat,  4 Feb 2023 17:15:03 -0800
Message-Id: <20230205011515.1284674-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205011515.1284674-1-atishp@rivosinc.com>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 27 ++++++++++++++++++++++-----
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 6b53adc..71174fa 100644
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
+	if (event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS)
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
index a1c3f77..43fc892 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -26,6 +26,8 @@
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
 
+#define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
-- 
2.25.1

