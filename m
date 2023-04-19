Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D946E84B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjDSWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDSWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:20:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711EDA5EF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b46186c03so455443b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942707; x=1684534707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WztMTyUU5RnTeRMzQjXOG7tTAHmGJecGpWKfqq8b0LY=;
        b=JM/4VdTUHWchd0agtBcZMVxlzWz+xlNHvW3+YRV1BgFp8SzvOalMG8gKSVRQwN23lF
         /HaZUXiHN5WGp4Li2ns1uHUPekHEfh3C+xw1tqVd+IJGR2EtpE3yOA/YQtJ1ZYeUVJ/l
         7gjUeS7TILHwQHaL9l5Fnqsci5dyPD6ZQhESjL0jYTR+yEk6eIszpIH5SlasnHwxJ7Ky
         wlJDpXRoqS0jyG2/jEwfH6PNHHxv4wzD8drzVC/Q8h9ghskwb1QRJA40nqZUrBtk1qK0
         ooViUN4xyDeEoBWE1iz1aXlci22pk9Oc7YzeXphdmUjkGiDah9tsQrhCdZR8NGP6os1O
         4yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942707; x=1684534707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WztMTyUU5RnTeRMzQjXOG7tTAHmGJecGpWKfqq8b0LY=;
        b=lYLt3+G1jG1Ndnf4ZeYcTs7rCw6XBUMu1i5Vt7WH47kWd6r+tox+2lRQtDQHFBU13W
         VgxUuQ3D5GNm/Us5VFeNffhUoXQ47RUoAr4lufdlZtnYFgQVdaBvSsHNjgjZsH097oQN
         KSaXrELHFynhP2cSSI9V6bFtTOtx4E50gkmGl6Ye7mtAwWiWjJSj1pc9uHu4jjQqNs69
         G5v5nRtDy2CcL+gITjqIEhbmb7ZcdujGhF71g2mRgdanVYNT/CkbcPDFyGh2NAIdZvdP
         iNE2XP6F7KRd1i4l1bw28WZjkzcJZT8vopldDL0ulpmBiIPT5sEhHNFxK6/29qroRw0e
         8O7Q==
X-Gm-Message-State: AAQBX9e5nUrQsih6BmruMVSIiFXcNg5w27ovIB6RQvSjCWaxXRgQ+4eQ
        HJWbmOe0Wda6RplVSvhrRZlYsdM3IUPS9tEWsjY=
X-Google-Smtp-Source: AKy350am1y3CAd0kzsPnqccpnVuquygqNjOFE27i75PzlAcwaRULYItnkTY6+2qQuafZtBMoWXv5YA==
X-Received: by 2002:a17:902:b087:b0:1a6:9363:1632 with SMTP id p7-20020a170902b08700b001a693631632mr6436484plr.25.1681942707075;
        Wed, 19 Apr 2023 15:18:27 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:26 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
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
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 26/48] RISC-V: Add COVI extension definitions
Date:   Wed, 19 Apr 2023 15:16:54 -0700
Message-Id: <20230419221716.3603068-27-atishp@rivosinc.com>
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

This patch adds the CoVE interrupt management extension(COVI) details
to the sbi header file.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index c5a5526..bbea922 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -33,6 +33,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_COVH = 0x434F5648,
+	SBI_EXT_COVI = 0x434F5649,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -369,6 +370,20 @@ enum sbi_ext_covh_fid {
 	SBI_EXT_COVH_TVM_INITIATE_FENCE,
 };
 
+enum sbi_ext_covi_fid {
+	SBI_EXT_COVI_TVM_AIA_INIT,
+	SBI_EXT_COVI_TVM_CPU_SET_IMSIC_ADDR,
+	SBI_EXT_COVI_TVM_CONVERT_IMSIC,
+	SBI_EXT_COVI_TVM_RECLAIM_IMSIC,
+	SBI_EXT_COVI_TVM_CPU_BIND_IMSIC,
+	SBI_EXT_COVI_TVM_CPU_UNBIND_IMSIC_BEGIN,
+	SBI_EXT_COVI_TVM_CPU_UNBIND_IMSIC_END,
+	SBI_EXT_COVI_TVM_CPU_INJECT_EXT_INTERRUPT,
+	SBI_EXT_COVI_TVM_REBIND_IMSIC_BEGIN,
+	SBI_EXT_COVI_TVM_REBIND_IMSIC_CLONE,
+	SBI_EXT_COVI_TVM_REBIND_IMSIC_END,
+};
+
 enum sbi_cove_page_type {
 	SBI_COVE_PAGE_4K,
 	SBI_COVE_PAGE_2MB,
@@ -409,6 +424,21 @@ struct sbi_cove_tvm_create_params {
 	unsigned long tvm_state_addr;
 };
 
+struct sbi_cove_tvm_aia_params {
+	/* The base address is the address of the IMSIC with group ID, hart ID, and guest ID of 0 */
+	uint64_t imsic_base_addr;
+	/* The number of group index bits in an IMSIC address */
+	uint32_t group_index_bits;
+	/* The location of the group index in an IMSIC address. Must be >= 24i. */
+	uint32_t group_index_shift;
+	/* The number of hart index bits in an IMSIC address */
+	uint32_t hart_index_bits;
+	/* The number of guest index bits in an IMSIC address. Must be >= log2(guests/hart + 1) */
+	uint32_t guest_index_bits;
+	/* The number of guest interrupt files to be implemented per vCPU */
+	uint32_t guests_per_hart;
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.1

