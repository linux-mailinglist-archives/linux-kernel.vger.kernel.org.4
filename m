Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEF69529D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBMVDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMVDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273D1C7D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c8e781bc0aso140078567b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+/r8w47ezdbqn4obku9AZqaEdNgvykOL4WGX2LN1Kg=;
        b=ERCzMVux74HzWzgzB1sZxys1cCbBCdjOVP5F5vzxcViBKV2/byFexqdOacXcb/qxBZ
         NJm+QdCD2ZjEnxtyObsER+RPP4GXqh21KJW2V2oF6Uy04llqsKL2ptzQLOO3BPYB371/
         yuCDi5e/gYanXGRq4MkJHBabhYSAt8aXMNfOtjsSjco55pCwSbPI3T030WeL0bcWqs98
         n4Uideta2zo24729kzmrz+0Q9YZ0peyODMDY9Vh+mZy90LtVsZnEnTg5QoDqS7rPTgPf
         jl2MdaJPKLerlmHeiT+8nC8xi+w+oNFnSBu0weLrLNAicEH0u6S6MNABHFogBJ8rg2fv
         sWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+/r8w47ezdbqn4obku9AZqaEdNgvykOL4WGX2LN1Kg=;
        b=sZytQdxv/iqaJAeSObZzuhrCP8zklBGq7vHq7o32zHvRQZtbF69M2nFmU/KRVuBvQ2
         T2NEnx313d6frHPMkfgDMIPOpIhABGkewluarfuiejuLr8zuedghmI+hrG/3Xc5gbFeL
         5nfJnijDVZpWmMyT/oScJSG6JGQmrlTGWUSTGWdJA30FWEsydpZuSBw0fBAfup06xYVm
         wF2Akfl9BC7c1rLEaWn/44VhJkEjyBAw2PA2nXR7D1J5e3jLIkTvmMXTd/RoM6WF8XJE
         HmIiRSPgbJqEaUxq4tDgMGPofTABqS/nRSHXVB3z4wLEGWFP1mdGozoSIOK0aWPF5eII
         dBiw==
X-Gm-Message-State: AO0yUKWaPso6DILlcPqy5h7RPgrpMrnNyocbJkTx4S8bfofhNRYb/Uq2
        e5Ht9+okavN507WC5O8gHtW11H3R0HUQA2c=
X-Google-Smtp-Source: AK7set/pDvOL39SP7d/SsYm/NX9JdQjgXIlZka/dA8IDnHCDkD3my+B0zdVzm1OqTKOPjfSN6P9D0jja+edR0+I=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a05:690c:dcf:b0:52f:23f5:4079 with SMTP
 id db15-20020a05690c0dcf00b0052f23f54079mr9ywb.4.1676322219141; Mon, 13 Feb
 2023 13:03:39 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:15 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-5-zalbassam@google.com>
Subject: [PATCH v3 4/8] perf: pmuv3: Move inclusion of kvm_host.h to the
 arch-specific helper
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM host support is available only on arm64.

By moving the inclusion of kvm_host.h to an arm64-specific file,
the 32bit architecture will be able to implement dummy helpers.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arm_pmuv3.h | 2 ++
 drivers/perf/arm_pmuv3.c           | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 80cdfa4c3e88b..d6b51deb7bf0f 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -6,6 +6,8 @@
 #ifndef __ASM_PMUV3_H
 #define __ASM_PMUV3_H
 
+#include <linux/kvm_host.h>
+
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 46e89e92f8236..b3683fdf8d0b9 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -16,7 +16,6 @@
 
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
-#include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
-- 
2.39.1.581.gbfd45094c4-goog

