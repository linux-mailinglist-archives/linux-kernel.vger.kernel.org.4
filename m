Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D3686477
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjBAKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjBAKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:14 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45F7D8A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:04 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso797405wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkxKzYtJyLBnk6YaWLdXcrP+huEFDCptixA8sQJDrTA=;
        b=Cgj3iAnktqlF5j/X2Zs/AvWwSuC377hgw3vsTJuLls35Ku4dcC9GOC8s5WkGAsylPx
         8AD2/jIoyM8KmqnlJl59pnaJQeBFva/t4Qkup7aDeVurYyMFaO8bHtgpv6AV3plLPdQ4
         VCLJ7+3S1j2wHgTZcZVoLoIOnxREru4FkIT04NnLjyfs2ZAI+CoC22iK7KKmdYDbZBEZ
         A7JU0AkOvPaLeskvPozEUdct2hwGx13diIFSZTkyz7MbnZCeqMX5U/yK5A59yhC5ukaQ
         Ho7EhcjY2SG2hUizVbhCRUNeOMprPoAbyuf60umZEht/F//XRPeLdP5kQyxywilKLbBP
         xWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkxKzYtJyLBnk6YaWLdXcrP+huEFDCptixA8sQJDrTA=;
        b=JvGuVS9daUyBBxVarS1KxtYluug6djZXvBhbLolGlcyF8gTzT39VjEzZF9lW5mqINr
         LuooP8RRkHYDDHx5C/A3u6GJTTVehbuXPQeipGdCy0WzoOTjJltU7L1T0auCdKLgTU6P
         Ii4HZUh5ZPFNGa3JnitOR1BQYYj3yBgPKZaVGa+NXgfAK0C3/OTExUo4pq8L+JI0Bgdt
         wF+5nOC1RK4XLt9vMlJqBlKG4m+zZeFXpfa/zUIYaCx3gtIJ3N5ApzvmtIqLwrPRWTZZ
         0EGXF+B8f1sMPCL6olHklfTGiVw5aJrj2ORCD6xzkAkGqq9pvMGzIwIWYMvBCtl7xG2J
         ap5w==
X-Gm-Message-State: AO0yUKVkZPOpK2C+VFnKskvn4dDMcFyO2/P5YbLNoQWeuYCxyghDvTRd
        3561Hio1NMvZSpyO11a6lw8San+zPFJJ
X-Google-Smtp-Source: AK7set+4dyT64Ybcc5I/aCMrcw8Vd3S+aCXtsLCGbugPPvCPuVOfo5Ea5wI/nh9/m6q+UBsRN/El5Os2d/wi
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:600c:4f0e:b0:3dd:f488:4a87 with SMTP
 id l14-20020a05600c4f0e00b003ddf4884a87mr67576wmq.54.1675247882739; Wed, 01
 Feb 2023 02:38:02 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:37:51 +0000
In-Reply-To: <20230201103755.1398086-1-qperret@google.com>
Mime-Version: 1.0
References: <20230201103755.1398086-1-qperret@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201103755.1398086-2-qperret@google.com>
Subject: [PATCH 1/4] KVM: arm64: Provide sanitized SYS_ID_AA64SMFR0_EL1 to nVHE
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, Quentin Perret <qperret@google.com>
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

We will need a sanitized copy of SYS_ID_AA64SMFR0_EL1 from the nVHE EL2
code shortly, so make sure to provide it with a copy.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h   | 1 +
 arch/arm64/kvm/arm.c               | 1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 6797eafe7890..bdd9cf546d95 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -122,6 +122,7 @@ extern u64 kvm_nvhe_sym(id_aa64isar2_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val);
+extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9c5573bc4614..d9c6ec650b42 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1887,6 +1887,7 @@ static void kvm_hyp_init_symbols(void)
 	kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 	kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+	kvm_nvhe_sym(id_aa64smfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64SMFR0_EL1);
 	kvm_nvhe_sym(__icache_flags) = __icache_flags;
 	kvm_nvhe_sym(kvm_arm_vmid_bits) = kvm_arm_vmid_bits;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 0f9ac25afdf4..08d2b004f4b7 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -26,6 +26,7 @@ u64 id_aa64isar2_el1_sys_val;
 u64 id_aa64mmfr0_el1_sys_val;
 u64 id_aa64mmfr1_el1_sys_val;
 u64 id_aa64mmfr2_el1_sys_val;
+u64 id_aa64smfr0_el1_sys_val;
 
 /*
  * Inject an unknown/undefined exception to an AArch64 guest while most of its
-- 
2.39.1.456.gfc5497dd1b-goog

