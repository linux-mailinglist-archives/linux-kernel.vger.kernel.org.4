Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2868D357
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjBGJ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjBGJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:56:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED7EFB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:56:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o13so14440510pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=RZdqDs25xResS/KYEDi/LtQFjek0M+Plb/4s7ffMGS3hx5ZzV4nC3lSe6hphmBNMYc
         ohPhw0Hffp1TF8CvnrZbYI/IGviC7OKfGm1gGf85RcIKMMXUZbZheC3Prsz1oF4E0ZH5
         hzKTtIm4AXANG8W8gUKbQjrizR36Dv81M5mOPqk36sqOn5CjoP+bGmdiMwB5ZL0MwJXa
         J8JFKBnNKaZhAVAuWAVBKa+RkPkutzJL5LSsjz5MBsRfYEpnV6mIhFhV2/WDSAND/Cwl
         xtwXLkLb5JFo34JL15qk7gNKbbTQh9mJZi0xNfBZMYhE8ZTrDtCYQ9ltix3keZw8CjJs
         oSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=biFlTwouVxyqW8qM/TvfWm6BT2IZEJI2gkCdWaIuU8M5bHhCqDs7GFWEQTcEsfzcde
         MvyUEaoSdONoIIe8Tx8cJCqSpg8DGS2H3bCILGp6++xCn0QOlT1H+cNX88zgP2rg2qQc
         Zxx4so3WQ1uucdOU6KgdFpSorD90l79jNwRPt539VidDAPrdeSdXDGeATZiGyVKlrV+k
         Qd+SuQQcwuBTkp7eS1HAZx5JGR0eZfRAtPWYEbNHcn1o+Orz5S4YlF/r4xI17Bxjr0Mn
         u7NMN7Rg9b9pBye7CI/Rcu5FKp6CPZZcMtmuRBO+qAySAaY+VUTNQPj67vSsj8EHrsD2
         iJOQ==
X-Gm-Message-State: AO0yUKWBVnI2F2rS0S6xd6SQGYlTrEYolg/kfNVbpF09ipWYFca6Gai+
        JiNyE20otuf2sUAwu8IjNjBMSyhWI/klqsAn
X-Google-Smtp-Source: AK7set+yWUejKGqKbCenoyjAhUDv3HTfD5iunwTnaUqSClL1mPUrIF1mJqLBV0a3M9F3PPfyImKdPg==
X-Received: by 2002:a17:902:e88d:b0:196:433e:2384 with SMTP id w13-20020a170902e88d00b00196433e2384mr2470244plg.57.1675763791523;
        Tue, 07 Feb 2023 01:56:31 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b0019602b2c00csm4030598pll.175.2023.02.07.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:56:31 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v6 4/8] RISC-V: KVM: Disable all hpmcounter access for VS/VU mode
Date:   Tue,  7 Feb 2023 01:55:25 -0800
Message-Id: <20230207095529.1787260-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207095529.1787260-1-atishp@rivosinc.com>
References: <20230207095529.1787260-1-atishp@rivosinc.com>
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

Any guest must not get access to any hpmcounter including cycle/instret
without any checks. We achieve that by disabling all the bits except TM
bit in hcounteren.

However, instret and cycle access for guest user space can be enabled
upon explicit request (via ONE REG) or on first trap from VU mode
to maintain ABI requirement in the future. This patch doesn't support
that as ONE REG interface is not settled yet.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 58c5489..c5d400f 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -49,7 +49,8 @@ int kvm_arch_hardware_enable(void)
 	hideleg |= (1UL << IRQ_VS_EXT);
 	csr_write(CSR_HIDELEG, hideleg);
 
-	csr_write(CSR_HCOUNTEREN, -1UL);
+	/* VS should access only the time counter directly. Everything else should trap */
+	csr_write(CSR_HCOUNTEREN, 0x02);
 
 	csr_write(CSR_HVIP, 0);
 
-- 
2.25.1

