Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297A6E8481
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDSWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDSWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:17:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C821718
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:17:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-524b02cc166so64221a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942658; x=1684534658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur77tHINwX+qbUdlSGnRNMwUnwDaAVVcewhgSBhFUx0=;
        b=c18b6HjhB6xZTijYQX2nimbdoBlIXr9qBNm2sHraX79sumJ2mnHyyAF4iUwGRyqfEL
         BhG5ZneVkTF9bRo5tCCiGvsNVcpWUKCNmPy0vd1ZqJvuNoQxq1qR6f9cnB7vi+C19Hpt
         5xUpfFR1k+6B8FbGHFbFXaZtvW/H2sqgRRevhtG9hluShqAQzpot/WQd/qsXuDNgOnpx
         pk3tmGjn1iUOEgqZ0Ek3rQdbQ5Ky98ttJ9TAom0YVfPe7HTavUoUAmMw/LDuEdRosyc4
         CHRnQ9rCEYyXJCmVNUHBEGkpIQ2ljog3inmdpJcdTAOUNGgtwJP32aGziItUDdOFTV+8
         kKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942658; x=1684534658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur77tHINwX+qbUdlSGnRNMwUnwDaAVVcewhgSBhFUx0=;
        b=fLMJ2VtdZliSRcJ4JmEFRare4caZIk5hSSto2Evw/0ZbLPXL7Da8iyHG4fsqO6OzkQ
         3Da4immakuz1Ee5JO2ASqqh1Qy4iUD9b8HR700H7AhObf16GOsONzULnQybAzFgwLyoQ
         6kxw4ZEUG8HYqySAIT20K7L4D0niAsZWf0k/BsZ0IQomhWhbfxhFiuPA7EO/xCCuEb39
         gdQWXcPIqqf2zIOhwpj33Li4g0Yi3PpUtO86fYmz4TB3kq7uTVlWi2QqfcZazlana83D
         US9iAkunXCHFwCW8sFNJCLB0TfDzQZpd6G7ucs8qfUYBsrH1xs/mv0z0kv0zNy35y3ga
         wpvw==
X-Gm-Message-State: AAQBX9dpS0gaVQ+IEjdAg3AO000k6RvWE5BAjbaFNqrj42N0yICPjFmQ
        VQEUruW6hq7+DF5xH5DpHgQVnW8ptufUoEYYq8Q=
X-Google-Smtp-Source: AKy350ZqgGYrfhLdHBkYHvd+cLv1LSY5KY8FQdwstau4aKvHx0NnJWKbJ8fq3mAaGG3s8B2dSOXS2Q==
X-Received: by 2002:a17:903:1210:b0:1a6:4a64:4d27 with SMTP id l16-20020a170903121000b001a64a644d27mr7782580plh.40.1681942658444;
        Wed, 19 Apr 2023 15:17:38 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:17:38 -0700 (PDT)
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
Subject: [RFC 04/48] RISC-V: KVM: Add a helper function to get pgd size
Date:   Wed, 19 Apr 2023 15:16:32 -0700
Message-Id: <20230419221716.3603068-5-atishp@rivosinc.com>
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

The cove support will require to find out the pgd size to be used for
the gstage page table directory. Export the value via an additional
helper.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 8714325..63c46af 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -313,6 +313,7 @@ void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu);
 void __init kvm_riscv_gstage_mode_detect(void);
 unsigned long __init kvm_riscv_gstage_mode(void);
 int kvm_riscv_gstage_gpa_bits(void);
+unsigned long kvm_riscv_gstage_pgd_size(void);
 
 void __init kvm_riscv_gstage_vmid_detect(void);
 unsigned long kvm_riscv_gstage_vmid_bits(void);
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index f0fff56..6b037f7 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -797,3 +797,8 @@ int kvm_riscv_gstage_gpa_bits(void)
 {
 	return gstage_gpa_bits;
 }
+
+unsigned long kvm_riscv_gstage_pgd_size(void)
+{
+	return gstage_pgd_size;
+}
-- 
2.25.1

