Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07B6E84BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDSWVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjDSWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:20:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D36A4E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5465fb99so383353b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942718; x=1684534718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2nJhanY2RyrdzmZ5jdtnkafHRmAptwnMC5XRsCTn9I=;
        b=JS7pXfcL0uZWhUdoeqJLjU0060h+zlTyFU4Xu6hWHx+bZXgxY7ubdU1X9NVau3JlX9
         +7CYbRRwlIc3Vqq9APC8BsBuJn4DTncbkzqKnldPV32jiP3HmMEO6Gpz0Jpg3E8ecp/b
         7UYaf07kCninwBHQ2YB/t4GOxc2RYZ1XD5frQZDPWtSV2zmt3BBqoNXrrBa8O/2uay1U
         9Q5+GXI2CSH6c4nCaey/IdmivSR/XDL19JFooIN8hV4UeXZUf4HW7Tq4P1XLc0glmzvp
         cJ6OAEWscVYWk70eywtGuEoxadALFsAZYFXB+jt15zlHvhhj3dquE05TC9qY1zNQuLog
         DNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942718; x=1684534718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2nJhanY2RyrdzmZ5jdtnkafHRmAptwnMC5XRsCTn9I=;
        b=lKbdqQlv3fPyuGAFY8l6YtUL3cH1u6MfCPmfJNYKKe5pCKwZuONl1A3j6tgZOGGBFH
         NWKj9fqwAnFpyDmqd46FowTQNYlrMOXc23/as/0TE4W3TqwLRATgPItCll1JKQ1dVcxv
         HPuLVk0dJ5351WToTSYDLy4MVI8V4aUCErMHtDaPj6Fwu8feUKvJmxclZHym1iCJxYQj
         WMeLz7qzJnQOzi1tMsHL664PJCgb9MZQZtEhS2CuBYupvcehK/9Qtoosp+7/EevFe6JM
         mr4RbQLWFtqroCamWu90Ge/rWFad45Y60I6QR3tWjboUv4H4w4PW4Nr85c5Fc6RouO9u
         yGvw==
X-Gm-Message-State: AAQBX9eC+5OM2VV7pxOvFdqYFXchqyA1E20Rd4gwxdeXCBOm58njXGKa
        KmMmSjW6iOZjy4L5pAOxHi7QtOerlriahyyQmpc=
X-Google-Smtp-Source: AKy350Z7HNgpp/rz6oeri9oovBKao1xAaHX/MXTw46NfVQFmX/yVtIUB1ewCw+YJMzwOiUfVeGRvZQ==
X-Received: by 2002:a17:902:e0d3:b0:1a2:8770:bb17 with SMTP id e19-20020a170902e0d300b001a28770bb17mr5706306pla.9.1681942717994;
        Wed, 19 Apr 2023 15:18:37 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:37 -0700 (PDT)
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
Subject: [RFC 31/48] RISC-V: KVM: Indicate no support user space emulated IRQCHIP
Date:   Wed, 19 Apr 2023 15:16:59 -0700
Message-Id: <20230419221716.3603068-32-atishp@rivosinc.com>
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

The KVM_INTERRUPT IOCTL is used for the userspace emulated IRQCHIP.
The TEE use case do not support that yet. Return appropriate error
in case any VMM tries to invoke that operation.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 20d4800..65f87e1 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -716,6 +716,9 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 
 	if (ioctl == KVM_INTERRUPT) {
 		struct kvm_interrupt irq;
+		/* We do not support user space emulated IRQCHIP for TVMs yet */
+		if (is_cove_vcpu(vcpu))
+			return -ENXIO;
 
 		if (copy_from_user(&irq, argp, sizeof(irq)))
 			return -EFAULT;
-- 
2.25.1

