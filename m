Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263556871B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjBAXNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjBAXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:13:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F01274A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:13:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j5so239400pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=7TLtW5CODtHh/vA5HmpEZpfnI1B260cDfOCTny43n9BCs4bcIQY0ohtJ9r6Z1d0zLR
         AQ1Ps33WkBnV/jcy+F5QHHDHW1bfTgc5n/mqBkPxDw/KFLCJpKOpOWy1yR5xeMxKBZNb
         i9ugyDG4WX7NjSgEu59zFlhnxmlR4cKgvFxvDYO9PLW3jsP9W9n4Y5C/kIv8XuzrJ8cd
         t92JgC6M6ckmnZ6t6VcmUvuJP/VRlRD6rlSM47oLUVWXRomoU14CQzntUjr8ITq12qCi
         tf1s6m5oRb4AgiIiT+4SpO00ITFwO3udgoHBoLpkRLfRgJT0Hmg8oKTEkttrshPneMXN
         /sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bBrWzpq7M02ECVIO9gyLMkgsYGf96qlJ2xLFArrFiw=;
        b=Nw2CFzGAUGkJXM2P1GDHIp6IfawdGdGdOvDXqAk356nQE03SeHcIrelP0l4HJ/+raT
         uqqsc4BQ2djP5CnuKhAG/OZ2Dha7Uxqg4mFmFOcZltX87s+FjnsUb3x9KIkWEHCdXH8I
         yM/Agj/YO1PYTj5tBSsqWK78f6nvaXha5ZXVEBUP4glEb655lNrmGuyBog9SXfY+fl8p
         fgxDTn/eGh9vRD/6yItPlvyHLJxSSiIC+x7LixoBusnoDDA94/op78EcvI8nR0ueIPxY
         bRzUicyRsxgD5QLNyy92YRQ8u0XLl78V7OI8nVVDDK4k27dV3duB5BzbocrCZVtT0pQY
         I1Yg==
X-Gm-Message-State: AO0yUKVsZh+OgGyTaWFVI5/Yjt1KGMflFUQd+ZunbUKYcqt6i50i940M
        pZsmraG9gft8RM5U8NUxhsTPq++k+K1Jl49k
X-Google-Smtp-Source: AK7set9BcpmyXgQko2MEIaMm4BP0/xEocNmPG21oITCLGZTFp/ad13WuJnsyVzCwkS+ZTGiGLRLXwA==
X-Received: by 2002:a17:90b:4a50:b0:22c:891f:5753 with SMTP id lb16-20020a17090b4a5000b0022c891f5753mr4169223pjb.40.1675293182071;
        Wed, 01 Feb 2023 15:13:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a510300b0022bf0b0e1b7sm1861774pjh.10.2023.02.01.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:13:01 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Eric Lin <eric.lin@sifive.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 10/14] RISC-V: KVM: Disable all hpmcounter access for VS/VU mode
Date:   Wed,  1 Feb 2023 15:12:46 -0800
Message-Id: <20230201231250.3806412-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201231250.3806412-1-atishp@rivosinc.com>
References: <20230201231250.3806412-1-atishp@rivosinc.com>
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

