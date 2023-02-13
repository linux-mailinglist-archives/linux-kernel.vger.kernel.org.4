Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55B694EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjBMSDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjBMSCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:02:52 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0D15CB6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:02:44 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id z12-20020a92d6cc000000b00310d4433c8cso9768333ilp.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5yslkEpatxEcn+ZjK5j+e94Zo++KRDXawZarevQP94=;
        b=lcEuCEa97ssf+wWD9q1X2jC8NG6WwfI+HwutzvJgCa6Uq+ZlQvO6nZ4fTZ1DOuWvCH
         QYfQMES86DFpGnJNaCKSYUITRt/fnbFRlV24rRk/9s+HJOK4uK3HUoXbUfKpYuWWbdGM
         JAkmmiPtglLKasxoEqGau0AV+ap1NMUKKv6f9Q0J6+GYYOqy5tXTw0cA3vI0PsY+8Ti9
         6DRHzCp9lRTmscj+OMpjzyRj19bIqkMSdns7IbL4DdWskvbfqjdhHYeYx/pEtPAC/xpy
         7SX2rfvXEDyQVkwgmKnDgLQKOy/Rc39ynIF8Wwbekx9vLgo9IWDVOMuK3NLGvfW1CAvj
         N/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5yslkEpatxEcn+ZjK5j+e94Zo++KRDXawZarevQP94=;
        b=GL6FCZb97yA2DqMpSOKsOhEZpgTMQtUmIDo518zyLFFXbEqy0fNjGL7mL4bdrnn6Bu
         W57dN9P+nIn/Cj9Irr5Zm4rlYbycvGAtnGJh/8fli0p8pxz6DQPeaAiOhrY1iLN2TGYw
         tmNh9U7g3X21JTj5JxWijUimo7Rn4QOgKPGBEzZFPGCf49bjVNU1y/1GBKrALaxvDks9
         Fd6ot7MRnwsj3UNhpjk+CtOuG3dj8Zj9n7Wa0n/xj2HYlHT2lWv+fPxpM1kJhP7GBAUw
         pUX8dd/Grm4/KEo3XiXzxJmNwl0ENpbnwY3h+b/nNb/tVPRB73SBqOJndwXYADkTLsKo
         sKlQ==
X-Gm-Message-State: AO0yUKWsRxQBJqFi28YECtsS3N2XyIwgkg5eti031xYc5/GQKEkpJtrn
        +yl1dIfX5MolK4G3GdV0+5E1lSqr+hNk
X-Google-Smtp-Source: AK7set/0edXrdMAO+nSquBaytN7bLQuBx2MZ7S0viOK1DwWUM7ZNzi/YO3vgRtPP1oEgxZM2YSawlRvX5KHR
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a02:854b:0:b0:3a7:e46f:1016 with SMTP id
 g69-20020a02854b000000b003a7e46f1016mr298jai.0.1676311363803; Mon, 13 Feb
 2023 10:02:43 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:02:25 +0000
In-Reply-To: <20230213180234.2885032-1-rananta@google.com>
Mime-Version: 1.0
References: <20230213180234.2885032-1-rananta@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213180234.2885032-5-rananta@google.com>
Subject: [PATCH 04/13] selftests: KVM: aarch64: Add PMU cycle counter helpers
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

