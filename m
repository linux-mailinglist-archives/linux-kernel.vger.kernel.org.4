Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69098697326
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBOBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjBOBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:07:32 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551930E9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:07:30 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id t6-20020a056e02010600b0031417634f4bso9911612ilm.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5yslkEpatxEcn+ZjK5j+e94Zo++KRDXawZarevQP94=;
        b=ej58N8ysN78T8KDIyhj11kncochsRhNrA7Bi1OZuap4Gcpp106AW/WAmUpics1Lde9
         kGvkmrs+EJ/ITG/iLFxr7BlJjVCMrCfMydCohpT3IMM3duvIOEbBca0NDCaC9k5vDekp
         oSGROHd7tFDelb/YWizk3eyN9FziTr642Viat9eIJun84G/gs2Ps603ZiGKb0x4DcJUq
         JPJjjkUK7GP8EWJpE6UWuTqBYHACKRbI8Zig0XQV2X3ztZEdAu7mL8LKQbKdggWvU4wS
         cjsXmnc2IAS3tO4RpRViCgFmrjyChCrnV62EEUw563Wsig3C9O/Zj+Wk8TLLCEZrt2hN
         fkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5yslkEpatxEcn+ZjK5j+e94Zo++KRDXawZarevQP94=;
        b=w0sBRjyMV0QNYWS7g0kGErDEsQ3qJHdXOUjGtZ+C74+hoS2tV35lgM4v6L4kA2OI3Y
         1mXSyBHIXIiwXU4SRgyMmR71ngjiWji9mm2Zkq2/ynfidwK5iPGV8UO/9Ub4tFqRh3nX
         IrMECDrftBWhCHv3yhfS7/rop5rt5EECP2IUWBfz4TESB6xTNKDZJ/rgbVMi2Zw/42LT
         s+t0ybYMTC9Q1uZcl2ySiXLL+7qSLaeT18wfewjoBkZUL+MWxdfVpQaYw9348eVhOSzZ
         ohLIocgXVMUQW+w447JvioeAk7dbupEMCERJQNT9Q+Xc10LJruJ9uhRbMXuvl4cbiQjT
         0ODA==
X-Gm-Message-State: AO0yUKVxv5zrDtEKjw6bMuwKaSYSIs/9boCSYjYzEivaEd09oa2mfIbx
        Ks2TL96eXvDK5DZqMqH2BVgi5UDeNRk5
X-Google-Smtp-Source: AK7set/cu+50CTo8tUd6eYrVsq7uo+6UvW9Awlq764pXwqJwlSlmlCFOjle5EQ89W8sHdvl4KibNwCJJu8LF
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a05:6638:3e0f:b0:3c4:a4d1:cc49 with SMTP
 id co15-20020a0566383e0f00b003c4a4d1cc49mr359864jab.3.1676423249641; Tue, 14
 Feb 2023 17:07:29 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:07:08 +0000
In-Reply-To: <20230215010717.3612794-1-rananta@google.com>
Mime-Version: 1.0
References: <20230215010717.3612794-1-rananta@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230215010717.3612794-8-rananta@google.com>
Subject: [REPOST PATCH 07/16] selftests: KVM: aarch64: Add PMU cycle counter helpers
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic helpers for the test to access the cycle counter
registers. The helpers will be used in the upcoming patches
to run the tests related to cycle counter.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../testing/selftests/kvm/aarch64/vpmu_test.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_test.c b/tools/testing/selftests/kvm/aarch64/vpmu_test.c
index d72c3c9b9c39f..15aebc7d7dc94 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_test.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_test.c
@@ -147,6 +147,46 @@ static inline void disable_counter(int idx)
 	isb();
 }
 
+static inline uint64_t read_cycle_counter(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+static inline void reset_cycle_counter(void)
+{
+	uint64_t v = read_sysreg(pmcr_el0);
+
+	write_sysreg(ARMV8_PMU_PMCR_C | v, pmcr_el0);
+	isb();
+}
+
+static inline void enable_cycle_counter(void)
+{
+	uint64_t v = read_sysreg(pmcntenset_el0);
+
+	write_sysreg(ARMV8_PMU_CNTENSET_C | v, pmcntenset_el0);
+	isb();
+}
+
+static inline void disable_cycle_counter(void)
+{
+	uint64_t v = read_sysreg(pmcntenset_el0);
+
+	write_sysreg(ARMV8_PMU_CNTENSET_C | v, pmcntenclr_el0);
+	isb();
+}
+
+static inline void write_pmccfiltr(unsigned long val)
+{
+	write_sysreg(val, pmccfiltr_el0);
+	isb();
+}
+
+static inline uint64_t read_pmccfiltr(void)
+{
+	return read_sysreg(pmccfiltr_el0);
+}
+
 static inline uint64_t get_pmcr_n(void)
 {
 	return FIELD_GET(ARMV8_PMU_PMCR_N, read_sysreg(pmcr_el0));
-- 
2.39.1.581.gbfd45094c4-goog

