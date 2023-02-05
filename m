Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0D68ADDF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBEBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBEBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:15:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12025E09
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:15:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so8249367pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 17:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=F92is3Mh+/4hyhAyWsahqTmK7UARQNYPMeHkiY7mZovc6cBrMgoqpEGCk4R52vY1O8
         Vug8Bko93PzM2rTs6vqEAC37cpCQDLMPZmo6vWBsvVt9fZcm1rXW/WgXEMjNTaVD62qA
         CmnjLxgFsOCoDDMBPj/n4FzGO85igcfP4jwKYx986iQ3/3QVnPBrYT0zNbYjZhzpWE8f
         56DPDbP0Zb5jdVJoHGWOdrb2tE/SFattmiGe7ptXlhBDqOVM9o79TGl2m3KjwkTdA0om
         A8CXSYOrnovno9n6FCXWHTqXlnea782esyGgDBFrKrCv+04s+VZynG38dO9eYKqS0VSK
         4bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=D5WohD3jlvR240ygbsjsmkNv+PCLnmXsrNdmNuahLIPtU5fZE95zy0INWbxZP568zy
         Y+bhIYlVzjyASdmCxp25rJyXA9QRPV54RmE1YrvcVD+Mjy0qR1DOul2h1ZLgv+x7SWML
         BNF8XXWlfqHX+z+cVNUVyRz08JTRsdnYMXyXxgPeZoaiVQYfncDKdM5LqfWbyrSpL0P+
         csS97METeVWprSnDGdKL/l9lVyk9dwrguwqKCQn5LdxTls1voHOlVpzDHLyqS1Y2ElFu
         KAdJCsdXxCf5XRtZfKFLt/8W+8wVuWjlXyiSsKIMD6i+pXld//J1KT0AFswqXDJQttac
         7dFw==
X-Gm-Message-State: AO0yUKWyfEJTxcM36jz+hVRahkCk+b3Xvzg9EChXLt87QC9Od//pldw5
        /tkV68CWkb4u83Ll/Vau/l2WZAvZVSTE5ONZ
X-Google-Smtp-Source: AK7set+4ln0bAKYwNgoY25DxxnEGxsM2e8kkFPWgYYSDouGuwrBrJINrymy3FaBtdnt5yOLCF66RaA==
X-Received: by 2002:a05:6a20:1590:b0:bd:7ee9:e77c with SMTP id h16-20020a056a20159000b000bd7ee9e77cmr20145173pzj.48.1675559731634;
        Sat, 04 Feb 2023 17:15:31 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b0023080c4c3bcsm2721917pjc.31.2023.02.04.17.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 17:15:31 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 10/14] RISC-V: KVM: Disable all hpmcounter access for VS/VU mode
Date:   Sat,  4 Feb 2023 17:15:11 -0800
Message-Id: <20230205011515.1284674-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205011515.1284674-1-atishp@rivosinc.com>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
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

