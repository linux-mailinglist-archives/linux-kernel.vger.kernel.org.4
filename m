Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF01E6E84ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDSW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjDSW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:28:07 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657CC143
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:26:34 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-63b8b19901fso453982b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943055; x=1684535055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTLerH+RJ52lhodOQfma/DJulVaHZ1rN37E2HPQ1gqk=;
        b=a1bnzxGWwIOEAkq+19MIVfBP/ZCFCZqLmC1UeQSHZvEerwM1InrDlC+CNQjLasRYNY
         TG6B+BEbccXViq3GxUGM1S1bKt08GMbNh8cu2/7uvz8TADG5izCLZidY7kyXryOk8Cc+
         amepc4YX9EhmwedHzdpQaI6iQRwH2jqt2DPucE98CEAfI6Pi8SQBLcJ1U0kFZji/jcS3
         poVKHT9OeJbpVpJ3SjBehUYSR58tbT8ZMpTvtdSUCQHzPMMVlmcC1HTTyDhFywITeMq2
         sEJhC6uIWIrcV3571Eqlwgn/Fm+q+fD6bbuTOkEai1g6rHX8oYaeAhJEcO5b4iPV/t6d
         oGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943055; x=1684535055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTLerH+RJ52lhodOQfma/DJulVaHZ1rN37E2HPQ1gqk=;
        b=CeCP21L96sPWFFlm6v7s/7xViI6nL1f6/BVcOA/8Hqm/dXcKUbu21B5caFrTrqXzSg
         kdForErWmMxvK9wWQg4KrMVbzhCAGjlOF0grOxzPuGus9hgC3LlOst5FEO7Zk7xQ+2cq
         b/dGbOph9MGypu5n7RkMhWN4xxcKhPz8iDQxc3qwcssm7dT3Quawk2YLTJq0f9Pwfpxq
         5aJkBuR80jhhbpmH1qJ+DfDf+d9qRYJX5CgtAf5lMv020BCKorB3MInLeuXWgkhXwkDx
         sVC9LnELgFxsT56i96b3gCC+TjIOIPlpRtETavXFiAutgc4vbfjbdtqxVrPOHxXredd3
         pfXQ==
X-Gm-Message-State: AAQBX9fvNwRGGvT5eDaaxA/ZLeovliQ6T8Jh5Alp4bjHrBtdA96Hqi/B
        7unyQH3qCWkJ7tExnxTXZaVX8gJDHX4hD2X2X0A=
X-Google-Smtp-Source: AKy350biCI2sFr3cWCmld5tDykr7Z5GZPcCxF2zAi1qUg8p1jfhx7EqRslonbApZT3U9aoxz+Y7avQ==
X-Received: by 2002:a17:902:e5c7:b0:1a8:1436:c892 with SMTP id u7-20020a170902e5c700b001a81436c892mr5044406plf.14.1681943055547;
        Wed, 19 Apr 2023 15:24:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:15 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC kvmtool 07/10] riscv: Define riscv specific vm_type function
Date:   Wed, 19 Apr 2023 15:23:47 -0700
Message-Id: <20230419222350.3604274-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V supports CoVE VMs now. It needs to setup correct VM type if the
user requests it.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 riscv/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/riscv/kvm.c b/riscv/kvm.c
index 5f9b0d5..e728790 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -39,6 +39,18 @@ u64 kvm__arch_default_ram_address(void)
 	return RISCV_RAM;
 }
 
+int kvm__get_vm_type(struct kvm *kvm)
+{
+	if (kvm->cfg.arch.cove_vm) {
+		if (__riscv_xlen == 64)
+			return KVM_VM_TYPE_RISCV_COVE;
+		else
+			die("CoVE VM is not supported in RV32\n");
+	} else {
+		return KVM_VM_TYPE;
+	}
+}
+
 void kvm__arch_validate_cfg(struct kvm *kvm)
 {
 }
-- 
2.25.1

