Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915AA6E84CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjDSWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjDSWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:21:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7357AA0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:20:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a516fb6523so5318295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942747; x=1684534747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bezt4nspa35ZRqzRaZmY422b4QR0Mn7woQKzr9+0N8=;
        b=cFqy/7hM+Ny4fP4WIxs4wAIEAjRhQmifvh65+m0WDOJ/jYCumQJdB1BJZNu5ucVQLt
         vHeOX9JqsZJsPoOkvbrleSPo5GRulHiShRoX7tLw/Bo3NH2vnqKu9FAh7Id3Frv2QuNE
         +weDjwOUG7PuVaf0Q8I8065eawPZBUZF/IBP3CPxafiXKLMpIPqIxJCnZC8Rka6I13Pf
         MlvlahxQGVeNZnlElGB4Hwi7P8WFIaVtZscNXzvS3DDLN30pdgEiwWgQCtnYC84qh4Gj
         EUi0u8wk2hWEG92QVESAvb05CMVa66rE4mAeYWrE7046KCBAGXIObMS7PVHwhD5fW9N7
         Ltcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942747; x=1684534747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bezt4nspa35ZRqzRaZmY422b4QR0Mn7woQKzr9+0N8=;
        b=YMyiqvW9qDpHzKmfcxcD0LXpliRSWuop0jrtTDRbLCJhjlLy+p5AZzGfcLZWku6IQ9
         LDXLqyEiRXu98HAqxNrdYwQ0y3sZck6L3t/CI48WoOVqCGlM4a8QmbuXVbQfbaUJYAI3
         9x/zu0sppNzUteiohMbZMJNqE/E/hLULf4fZf2/ablPuRw9kqB1rK8EEl/wRNK7tBomx
         BiL8Kvr4Z7yRjsN/rDExa2lKtwWjUN5pmcHAHbZOiOaEKE9kVPho+LI9+xZN9l61tQNo
         rEcPM7weZEXoiNOEfno5lFBbYSUoOU5nl3h+r0ksMQo5r/q6mcWJr878Hr5Kz+dT4Fpv
         aHJw==
X-Gm-Message-State: AAQBX9daod0OUP1kPncJwxgnn4yoq6LXDcJkdVpzzmrvkbQeTbHInvvJ
        URNT9LufGZ/7CgWKgxZE9tQXLcTmrR2UVEqk+Ws=
X-Google-Smtp-Source: AKy350bB8ZklTkd1MwNIad8/q9PvIlAh0JulWMyK+P713MLjTnxYs1KPIh7Umu4fPlJwkV2KzfaSZw==
X-Received: by 2002:a17:902:e5c7:b0:1a8:1436:c892 with SMTP id u7-20020a170902e5c700b001a81436c892mr5030556plf.14.1681942747426;
        Wed, 19 Apr 2023 15:19:07 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:07 -0700 (PDT)
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
Subject: [RFC 44/48] RISC-V: Add cc_platform_has() for RISC-V for CoVE
Date:   Wed, 19 Apr 2023 15:17:12 -0700
Message-Id: <20230419221716.3603068-45-atishp@rivosinc.com>
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

All the confidential computing solutions uses the arch specific
cc_platform_has function to enable memory encryption/decryption.
Implement the same for RISC-V to support that as well.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/Kconfig     |  1 +
 arch/riscv/cove/core.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 414cee1..2ca9e01 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -522,6 +522,7 @@ config RISCV_COVE_GUEST
 	default n
 	select SWIOTLB
 	select RISCV_MEM_ENCRYPT
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Enables support for running TVMs on platforms supporting CoVE.
 
diff --git a/arch/riscv/cove/core.c b/arch/riscv/cove/core.c
index 7218fe7..582feb1c 100644
--- a/arch/riscv/cove/core.c
+++ b/arch/riscv/cove/core.c
@@ -21,6 +21,18 @@ bool is_cove_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_cove_guest);
 
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_cove_guest();
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 void riscv_cove_sbi_init(void)
 {
 	if (sbi_probe_extension(SBI_EXT_COVG) > 0)
-- 
2.25.1

