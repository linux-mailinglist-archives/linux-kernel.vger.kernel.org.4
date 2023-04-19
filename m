Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B16E84F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjDSW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjDSW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:29:10 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A0CC1E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:27:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-541b5cfa9d8so162095eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943195; x=1684535195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a40XLfKnT38y+rtkL3pdG8Ux1IFfCO6rS0FTBqpEPf0=;
        b=b5p8uEhRQ4nHHaGD7FDYL9bayZFvh+ZSiw4gleR3vDNTcJIxFCMoxolE2fojPHtHHm
         tQmxaQhOVI8s62S0VsDN5Ly1XuD1FKe2lvmQNH9EBtcXdU+AJ1YZyfalOr0pxLfJagSE
         eb/UBLcuqguWt/jX0x6sLt3MTZxY09F5LbwoLr/CQ5gJv70SVG1MQwMGwrWCr7YcffsI
         QilqcQGZDmTWxNVcyHXZbsIbG7Dd3p+ig0JcF/eRRgbvuISUlDxRcHdj0/iM8UPH9QA5
         AeJqvm/0z8hvPng8Zv5V+D+7Xginl0HOwjCO8EoJwjssggptjRHedLBTj7Gc9ixC7IAT
         Zjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943195; x=1684535195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a40XLfKnT38y+rtkL3pdG8Ux1IFfCO6rS0FTBqpEPf0=;
        b=cD1eUJBkGlTHm2CgZbSRmW59L8kybLu09QBiQE0NlBckYnF9Ez7s5kk4xZm6NTLO6v
         5lPjGjtMC8RCR3Uk2V2D+et6sccZRYG1T5+OaKMDTqkXg5jn/tENLnTgJfVqGEX9W2WO
         kvxLJ55SHGiHxNNaSI5cWMsUg8cgP9ziHQzDCDjetJ9fOS51ipqKYHxOxoK/KONPOiBh
         KtVzXDkrMGBgcgjPEejxz5nHJNAYAgiKvsmUwWdyEDt1G9sRfKsSfEnvUjNRa3Xb3ETl
         lo2R7BQlbadMc7CxrGXXVG/QbmEcvBugb1HhfOO8yzPuo9YrEq22N9vELEpSi99UQ8j+
         zM4A==
X-Gm-Message-State: AAQBX9drH4g2wrUuXH9xrYiyRapZaxjIR+zB9IdA+HxqkkFaCE1/Gka3
        EOLTH6lo3QU2kbh9vf8hoao3elW0AXziq/m+s1g=
X-Google-Smtp-Source: AKy350YLjqHMzW16SB61ZrKO34D3/TlmDW2rBvoLEyn4qa6+KyWVGCYv7MHLqblqPruYYQP5o2V7iQ==
X-Received: by 2002:a17:902:ea0e:b0:1a1:ee8c:eef5 with SMTP id s14-20020a170902ea0e00b001a1ee8ceef5mr7846112plg.7.1681942742761;
        Wed, 19 Apr 2023 15:19:02 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:02 -0700 (PDT)
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
Subject: [RFC 42/48] RISC-V: Allow host to inject any ext interrupt id to a CoVE guest.
Date:   Wed, 19 Apr 2023 15:17:10 -0700
Message-Id: <20230419221716.3603068-43-atishp@rivosinc.com>
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

Ideally, host must not inject any external interrupt until explicitly
allowed by the guest. This should be done per interrupt id but currently
adding allow-all call in init_IRQ. In future, it will be modified
to allow specific interrupts only.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/irq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index eb9a68a..b5e0fd8 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <asm/sbi.h>
+#include <asm/covg_sbi.h>
+#include <asm/cove.h>
 
 static struct fwnode_handle *(*__get_intc_node)(void);
 
@@ -36,8 +38,18 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void __init init_IRQ(void)
 {
+	int ret;
+
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 	sbi_ipi_init();
+
+	if (is_cove_guest()) {
+		/* FIXME: For now just allow all interrupts. */
+		ret = sbi_covg_allow_all_external_interrupt();
+
+		if (ret)
+			pr_err("Failed to allow external interrupts.\n");
+	}
 }
-- 
2.25.1

