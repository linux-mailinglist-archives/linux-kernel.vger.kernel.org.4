Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E046E84C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjDSWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjDSWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:21:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9F8689
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a682eee3baso4404995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942725; x=1684534725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V944izAfHfvPXt2SodYy8axfAv3FUhh/YjA49qCII3Y=;
        b=WToiBYM90+kXSHR4f4lcMC2do7CnNE609AkBJ9ILRsQSAqLQhvGE4fka9RZc7XkmOV
         nVSgbPgR0g26+R9aOz7prZ0ZYw39dV9KxvmHBGDvRgR8MR74QfL1ZHIt8XSWqAKcLN8r
         0f6Tq006zXgK2g4OuuillctnBCZLY1xVWuRZMqYQdfd3ybKvutxZLqu19QqqHmXC8ODS
         KoYa4jRQnyk9O92MghnQdSKIAU/AWL4fTpgXKATBvPLDFP59BwJ0oeGTqTbRTShwnDj2
         1+Ojob0S1CfD+/Tznk4BIbXVZIp9qmP+FcBhkm6vxxe63VSq5U1n2NJ31boDb5/Auf9y
         qI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942725; x=1684534725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V944izAfHfvPXt2SodYy8axfAv3FUhh/YjA49qCII3Y=;
        b=jp22FV3CYZZWjxpvmWzotzlDsJ4cbvq7rcHqVIl6xdtdi+s6uuQvkj/Os7kyGfU0bO
         8kNY2UoKqMuzopeWBlbsruzKneLbeLjz9Vp5q1tFay1rum54L8kMgPLHHs24jp7xENfE
         aFCmA3TNg1etFPfmN2xbrZ0XAcmPp0CbIEg4y81e3csA0euVjpG/UXRRTuzc+aUEJ5cD
         iMYYhu91rgODY5juPTXFqsMaZmreGHkdVAaQH2pmzpfIJE8dLGhCURBqL+UDn+RRIG8j
         WHWB/zk1AsVXWF6dexmTCDZ+QJa+JQLT/kgc0chshfTE2FWfvfIAyZqmLrihbufUBVze
         6h3A==
X-Gm-Message-State: AAQBX9eXQuKdBmO7QE80qSDVh2m90syr0f1bxwRoq6YDTLpsIb7KXhA5
        boEZAqI1SPwESBfX/RUfyj4oIIVa246Xlp4Z6LE=
X-Google-Smtp-Source: AKy350Z1qByMTGJhiqV3zdWqTg/zhHnUn1VfTimSG0DF0as79Rscca2Gz4ZKZ2NL/Pi2zbK61ibEFw==
X-Received: by 2002:a17:903:2409:b0:19e:839e:49d8 with SMTP id e9-20020a170903240900b0019e839e49d8mr6224177plo.59.1681942725072;
        Wed, 19 Apr 2023 15:18:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:44 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 34/48] RISC-V: KVM: Initialize CoVE
Date:   Wed, 19 Apr 2023 15:17:02 -0700
Message-Id: <20230419221716.3603068-35-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoVE initialization depends on few underlying conditions that differs
from normal VMs.

1. RFENCE extension is no longer mandatory as TEEH APIs has its own set
of fence APIs.
2. SBI NACL is mandatory for TEE VMs to share memory between the host
and the TSM.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 842b78d..a059414 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -102,15 +102,12 @@ static int __init riscv_kvm_init(void)
 		return -ENODEV;
 	}
 
-	if (sbi_probe_extension(SBI_EXT_RFENCE) <= 0) {
-		kvm_info("require SBI RFENCE extension\n");
-		return -ENODEV;
-	}
-
 	rc = kvm_riscv_nacl_init();
 	if (rc && rc != -ENODEV)
 		return rc;
 
+	kvm_riscv_cove_init();
+
 	kvm_riscv_gstage_mode_detect();
 
 	kvm_riscv_gstage_vmid_detect();
@@ -121,6 +118,15 @@ static int __init riscv_kvm_init(void)
 		return rc;
 	}
 
+	/* TVM don't need RFENCE extension as hardware imsic support is mandatory for TVMs
+	 * TODO: This check should happen later if HW_ACCEL mode is not set as RFENCE
+	 * should only be mandatory in that case.
+	 */
+	if (!kvm_riscv_cove_enabled() && sbi_probe_extension(SBI_EXT_RFENCE) <= 0) {
+		kvm_info("require SBI RFENCE extension\n");
+		return -ENODEV;
+	}
+
 	kvm_info("hypervisor extension available\n");
 
 	if (kvm_riscv_nacl_available()) {
-- 
2.25.1

