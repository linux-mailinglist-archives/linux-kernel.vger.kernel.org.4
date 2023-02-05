Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80468ADDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBEBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBEBPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:15:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CE25BB2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:15:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so8869039plg.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 17:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AVlyEHbyyemXbCCJ04JjX0BL6y1QGd5zwSvkdXtPJQ=;
        b=FgqKEoOoZgRolw5POmyvUXh/mijLkxb5w8TApP3igblrnHfvRSgyoplkkkftOHr4Rq
         l7Zg++CBz0jZhffhS0C6w+LPoH3o54NahnXJHB2o0PXKKtnYf9RY6umvZHARXD3dszmo
         5ThlZqjAJpvWGBusFG/ESsmLdhTmMu377wyF8Z1rS2wc8LTEpR7Ut935sHHvInN9SVRP
         OA6JnM9xlFdZjpmfmc6MuqvTqlkZYEdioFKf6asTNfBsIEqUQv0pG4C7TsLPiQfL9lsg
         DaQCYRik/B40basr6055LhqqFRJWEPksw9vSIsQUvjhWfqlcWh7f1ia3s8VOT+ujs6ek
         RKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AVlyEHbyyemXbCCJ04JjX0BL6y1QGd5zwSvkdXtPJQ=;
        b=FaODUEcpjWYfTJXTJuozmyeYcqTgbWlHmFSziVMa3vvTN/HkKvIpCcZk+b/L0pXXDJ
         wskvNR9OISC8EQ6B6CDJkVeIQaaB2BdjIdh14f5GtqHvM7FHQR0xYPc9wkZVEZjPVP2n
         +l1EMoJ4g01Lq+vGixo7zVj7EGlZ4g99DivHIcC58tL0tudBatovx/TRJ2AgWIo8XCs6
         1Z30lWi8GThDAGb5OZx0EH679hx1XTlD3MNVCBAP9ukoerBbc7PpYfADIHpykymmSmbQ
         UZvlrlzulc77q6LbCbNIR6ZaG4Piph6PBKIxKU8fEymFR4FbpEMIUoJVIDIWB/u0MxZJ
         gdLw==
X-Gm-Message-State: AO0yUKXE/HpjdQhWf2OMNcdf91e1N8TMUZcsdiK1jdmA/oN5oU15C95U
        H2i6ikk5GkllCRQHSPNhTm8eK3IxaXghSZvn
X-Google-Smtp-Source: AK7set/oi9xtk3D0Eq1rYz/SuC2Pba9Hx3SWd9xHCM5mD1XcAcOr4gEozd/X8WGb0NofSI+eOtU1NA==
X-Received: by 2002:a17:90b:1bc6:b0:22b:e75f:8502 with SMTP id oa6-20020a17090b1bc600b0022be75f8502mr8558170pjb.9.1675559730788;
        Sat, 04 Feb 2023 17:15:30 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b0023080c4c3bcsm2721917pjc.31.2023.02.04.17.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 17:15:30 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 09/14] RISC-V: KVM: Make PMU functionality depend on Sscofpmf
Date:   Sat,  4 Feb 2023 17:15:10 -0800
Message-Id: <20230205011515.1284674-10-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205011515.1284674-1-atishp@rivosinc.com>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
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

The privilege mode filtering feature must be available in the host so
that the host can inhibit the counters while the execution is in HS mode.
Otherwise, the guests may have access to critical guest information.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 4919255..6d09a6f 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -79,6 +79,14 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
+	/*
+	 * PMU functionality should be only available to guests if privilege mode
+	 * filtering is available in the host. Otherwise, guest will always count
+	 * events while the execution is in hypervisor mode.
+	 */
+	if (!riscv_isa_extension_available(NULL, SSCOFPMF))
+		return;
+
 	ret = riscv_pmu_get_hpm_info(&hpm_width, &num_hw_ctrs);
 	if (ret < 0 || !hpm_width || !num_hw_ctrs)
 		return;
-- 
2.25.1

