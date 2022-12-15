Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5264564DF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiLORCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiLORBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:01:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD827CFF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6789795pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7O8/7ogKx8WzzRgxh6e6gC9a0ALFnBxrPW4Tv+K91E=;
        b=rx5/T0r+M+q8zEdlugSYmMVCXj3c21Bm2FfgOzoyHwc+8Jl8/RpTpMXSOEzG+i62mg
         Q1KskwJXn+ytDChd+aW75GbgLkL9lr70oeZXw6iqxWVXLlJZ9QMX6IEBdLU8qjdheZi3
         E/uQ7AHH53sLZrdrevjBMOJNz9LhgJdFhOdIyvFy7ij4O2/UJ9CmNY7ueRA2DnuIRIZ3
         aDo7Wwzp6f5FW2tJPVGUnUOKyhoekaAsmy9mE/pPzTZWEye66pJitiioktZEy9TWx8Hv
         ql+fLIg7uF8vcCxW8MEjrangKuAIhb59R6clhGfh5qluqS2StQzO4YrEf9LVbGyXHgKe
         iPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7O8/7ogKx8WzzRgxh6e6gC9a0ALFnBxrPW4Tv+K91E=;
        b=6Utt7hxYhD+8B3g7j6ImKsZrNHtkjdZf5oMoq12TM/b1oA7Z4YPfSO28dT4tFST0A+
         F3eeQAJ7VduPWHDrs7848I0GM9qq5hzrNxGDx5TczS0dlVFwIhBUSQdCUcbg2auMppp7
         s2uHuPU04LY6MLf8sXaR48syXjJbJJLi1YGmZwCA0XKsXBRb+8yUfrmU7ep/HkyOWrbv
         VUfpgy8d/thIo6GxFgxqikyqIJ64qfMR/25Tdt05W5xMHpuliRs+S3/7KSHICfbifZvg
         ZjKjeNebtbIpeiqxVsUv0c+1aurT1Y5b4QYB5fAa9i9mpgWqKH7n3CHEQjYjiY0iuqYZ
         96kg==
X-Gm-Message-State: ANoB5pmf2MEP7pYm80Y+VK3zINQHVpN/D928ccdINHScAOmkE85DLQHG
        BJyOY4JPoFc0dFWzpIUzUd6oRHBw+/jTk0kf
X-Google-Smtp-Source: AA0mqf4TLyGoJXHjVVtP4w82MegmT9LdD5zX1zlasjVB4tCX+Jv61apQFV8x8y6zeXa83IWHB2TgoA==
X-Received: by 2002:a17:902:e54c:b0:189:c1b4:8fe6 with SMTP id n12-20020a170902e54c00b00189c1b48fe6mr40417449plf.53.1671123680764;
        Thu, 15 Dec 2022 09:01:20 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b001897bfc9800sm4067449pll.53.2022.12.15.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:01:20 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Eric Lin <eric.lin@sifive.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 08/11] RISC-V: KVM: Disable all hpmcounter access for VS/VU mode
Date:   Thu, 15 Dec 2022 09:00:43 -0800
Message-Id: <20221215170046.2010255-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215170046.2010255-1-atishp@rivosinc.com>
References: <20221215170046.2010255-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any guest must not get access to any hpmcounter including cycle/instret
without any checks. We achieve that by disabling all the bits except TM
bit in hcountern.

However, instret and cycle access for guest userspace can be enabled
upon explicit request (via ONE REG) or on first trap from VU mode
to maintain ABI requirement in the future. This patch doesn't support
that as ONE REG inteface is not settled yet.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 58c5489..9c2efd3 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -49,7 +49,8 @@ int kvm_arch_hardware_enable(void)
 	hideleg |= (1UL << IRQ_VS_EXT);
 	csr_write(CSR_HIDELEG, hideleg);
 
-	csr_write(CSR_HCOUNTEREN, -1UL);
+	/* VS should access only TM bit. Everything else should trap */
+	csr_write(CSR_HCOUNTEREN, 0x02);
 
 	csr_write(CSR_HVIP, 0);
 
-- 
2.25.1

