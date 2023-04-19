Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B906E8498
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjDSWTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjDSWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:18:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112C55B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:18:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a68d61579bso4143585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942680; x=1684534680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvoLTFH11lm+jG4OLKr6/L5S3PiYUonU+A7E1tEIRKo=;
        b=N4XtdIUPBSqsJPJi86uCyaF35SsvQqKIOljuRP/nM3GeL5PnC+sHwcgW+t5y7DrxbF
         5TpNpwBssHKlVMD0+rR0V581oyy3Tas3sY/32xO2PA8Waej/gLWBYShGPmuxBhpf6re5
         DdBOslqLXNOPSWtzW2KMHDPcIh6b83lTPIBfFraWIh9OIpnFYzRRhBid7+FKOFDAgg76
         TSEZFYh5jipl2xgrex0+4e/qWmzQSgGTsJyLQHLHYVjRsdnpfnSpQ74r0gthMKcWw1bC
         bNIhm8IsywbFNoO4sfJHPMRDxwvnuXKEz2kBcBAbp8YppTYmN0JgS+/GNdHTRqrvAGAB
         SHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942680; x=1684534680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvoLTFH11lm+jG4OLKr6/L5S3PiYUonU+A7E1tEIRKo=;
        b=P5d+iZoO0mJDZVkkab2nkUeRQncZ1H+1i15GYGbsmsw/h0ze1TQ1HvNktOhJ0nnj70
         IFpPvJTjHBMSTJWcKQL3CTTwhTeMjI60cj5ih+TvQqRcpUlYg6qjPyqZtI7Vs0okd013
         AVh1R/tCs0HDisJz26CubJBfzayG9ZlCwQDjxCIMb1Aa7LxXemPYge9nxu3S+1HAf+5A
         lYtdF9qPhRjWGlAuJOq3QjKDBYHN4W2s0cZkTF8bdUzek1jogeIsGwn6mQZFCJ0c4xiv
         Xq4TW+MfgJmjNoTvwJlfCnTP1MTHl9YxKFvBCgXdkFDrHfhXp2PIfMxL6M6xHkVk2k7e
         XFxQ==
X-Gm-Message-State: AAQBX9eRKoo7edVOoJP00oa/+uQYJLVe2MGWBy2qxKYKEejXbBJC4zbG
        o2gG9P2numOyJr0GaDpfnTapPZsRuT2pIwfRwB4=
X-Google-Smtp-Source: AKy350Z88ZumXUVLTXNRcg1zbdln/2qU8CAI5Xlijd5PgR7U+e9fUdXEuzGKHFP/DBsSEjOZB75l1A==
X-Received: by 2002:a17:903:2287:b0:1a9:2951:7753 with SMTP id b7-20020a170903228700b001a929517753mr1272548plh.45.1681942680495;
        Wed, 19 Apr 2023 15:18:00 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:00 -0700 (PDT)
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
Subject: [RFC 14/48] RISC-V: KVM: Skip dirty logging updates for TVM
Date:   Wed, 19 Apr 2023 15:16:42 -0700
Message-Id: <20230419221716.3603068-15-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoVE doesn't support dirty logging for TVMs yet.
Skip for now.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 9693897..1d5e4ed 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -457,6 +457,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	/* We don't support dirty logging for CoVE guests yet */
+	if (is_cove_vm(kvm))
+		return;
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be tracked while
-- 
2.25.1

