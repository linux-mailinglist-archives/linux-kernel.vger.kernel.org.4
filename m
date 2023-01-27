Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ABC67ED74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjA0S0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjA0S01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:26:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8F7F6AB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so5845052plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYOVEt3jt/KSlQQ1kq4H/LNDYTWOBqHX+UHxFdJqK+A=;
        b=kmh1lQGUzNyTV+SJvoAKXkHkMGjivjZAJea6T5Hr7EIlrPYBaMWMvcEiaLpqyM/KtS
         ePUoVDqeA8FMW6jaejIY4R3VgjOlyByf9TehWXCybvPMj+3uRjKWKop61ca/PFAC6MT4
         u3APAiin9cC4fpcKBa+GtGHu3seYOHxtbVJgMIUBvfzxemER3gL+mJmlsb0jlsOtQ+oS
         uOR1c9hgmjpmrfdg2V/+etjez1klBx34/ATu64GSwu4Arvg8fJLRv0JOESyyZq5JJ4hV
         TMtYAzqqBm3p15eDA0DYzPXUxJxBvUsdN3ACp+QtTe86hJ8JnVWhd0xd34wW7zvkSCt7
         3xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYOVEt3jt/KSlQQ1kq4H/LNDYTWOBqHX+UHxFdJqK+A=;
        b=VUrX+ancO7YXE+ZCa1yGq4OioxrO90Uw2GqSFi7yhM0IEnetaNk5iA8RfBuCziJa6y
         RzHO8Cs5mEmWBXbERloHO3miSh+hT7Sl/qPCQOenxk1G8b+xmaqunZcbbPxZbAmc1OWs
         WtcGDy+1+qyBq8aBEtPEwoce1dCP5hVx8YKsVveNyP5hxu5qXE1opawnCr/z+7V5CTiq
         1jX4O6u0Nk+/DaZqhtp5V3CoZkKDQ5Il6vMvsWdqsu/jF5+XpPb5OvMZQXKG5VslmNy7
         oxrjaXUOtnVOGd3P+izUILhhBhoeJ92b9gUtFBrGVIsU8s8dbLpZxT0tn3LD/L2k3KwI
         uleQ==
X-Gm-Message-State: AFqh2krkU6EzHtx3g69kcl9aINX95ce4wvW4JLwLns0zXgenETy/ydFe
        6pFUq9/bIJVSfLJ25BO3Jvx4fH5HWfLigm+D
X-Google-Smtp-Source: AMrXdXv28M1C5TJfJZfYHoZMjXL4lC3hCwkbE2KMfgzJPjpOMAP1NeiIdUKuchXc6Zc48jYRIYXapQ==
X-Received: by 2002:a17:902:e811:b0:194:5066:fc20 with SMTP id u17-20020a170902e81100b001945066fc20mr51140337plg.40.1674843981856;
        Fri, 27 Jan 2023 10:26:21 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00189d4c666c8sm3195219plb.153.2023.01.27.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:26:21 -0800 (PST)
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
Subject: [PATCH v3 09/14] RISC-V: KVM: Make PMU functionality depend on Sscofpmf
Date:   Fri, 27 Jan 2023 10:25:53 -0800
Message-Id: <20230127182558.2416400-10-atishp@rivosinc.com>
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

The privilege mode filtering feature must be available in the host so
that the host can inhibit the counters while the execution is in HS mode.
Otherwise, the guests may have access to critical guest information.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index d3fd551..7713927 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -79,6 +79,14 @@ int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
+	/*
+	 * PMU functionality should be only available to guests if privilege mode
+	 * filtering is available in the host. Otherwise, guest will always count
+	 * events while the execution is in hypervisor mode.
+	 */
+	if (!riscv_isa_extension_available(NULL, SSCOFPMF))
+		return 0;
+
 	ret = riscv_pmu_get_hpm_info(&hpm_width, &num_hw_ctrs);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

