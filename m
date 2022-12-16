Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EE64F13B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiLPSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiLPSu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:50:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F549B6C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:50:25 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x6-20020a17090a46c600b002190cdd7bcdso1672210pjg.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjZwbpxLn3gByaRwvryxHTkFqJNY30wsjieUWfidJPs=;
        b=VWqUuN5rbvErYZowCg1/pmfZgfIIFDthapPPmMM20S7mNNliYmfwqee9p9fOJUaxZj
         ucLeFdbB9AC0M2uySkphj4QpW+A4ZTbTqv34xMMUGlGBIlSc+JYY2cxnhPJwxLyXSmzV
         56U4Nhm5hCu8a1QuQUy0C2nY23Cuo+QqeKQGMaw4hiCqzVNn8Sm55eD8pJNyaBrtRr0d
         ZH9VH/fVODDAF/TPIBQS6TRnQzmCnYsWasklGnjkuuYMzELuTp2Ixl93+Qa1gXEsvlYf
         8n+2pYpCRFmz4GkycOJanAVLVNh1oS+s5LhfUrS0fC/mZ3+pljNI1uCtTHq1vIr7H6Qm
         jzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjZwbpxLn3gByaRwvryxHTkFqJNY30wsjieUWfidJPs=;
        b=5AF+HDfeEL/V0ToSYK4MI00cKwCmRO0+wNxej51WcGPCPGJkweJdojsh5PdnM9i1A/
         NLp3GbcYg6YY5wi0UjbHr3fujmop64HVoshXPRf8zfKx/o3KpfBYiEos/9vTTXoqb2ee
         eD3dAqWpYe8yM1Nk6GGj0RanfSk5oNCVAjcifPgar5hhbC4EdmmpwgKg7UwtJBw2Sysg
         j1KFPuEKuLHmqrAsp3DvMuR4J088F+zhkeSQ76pEBcpnYha5zWC4/E4oelM3JOmEDtYj
         L5HrxHw4FjxPRku55Sw9rX8SbUIZ1/qcnfM1t2mnrmQZ1c+OpvhMWE4Fw+P7L7LjsB4Y
         pmZg==
X-Gm-Message-State: AFqh2kqzG00vczKYTQjxC3ikD6SeTZ1cUcr3F3gbaP9hTDgiV3ra9IGH
        v0U1U/STC/ngr2u+8altbSqkyJoBl7OK9A==
X-Google-Smtp-Source: AMrXdXtbTY4wcZoIq66QjNNVaFSRGJXlhFBTm/CgZNQ6XIoYuHltWbT2VVPUyzr6dSnWuzA3EKE98ARxdrpjIw==
X-Received: from abdulras-llvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:219b])
 (user=abdulras job=sendgmr) by 2002:a17:90a:9501:b0:219:1d0a:34a6 with SMTP
 id t1-20020a17090a950100b002191d0a34a6mr22237pjo.1.1671216624664; Fri, 16 Dec
 2022 10:50:24 -0800 (PST)
Date:   Fri, 16 Dec 2022 18:50:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216185012.2342675-1-abdulras@google.com>
Subject: [PATCH] riscv: avoid enabling vectorized code generation
From:   Saleem Abdulrasool <abdulras@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saleem Abdulrasool <abdulras@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is free to generate vectorized operations for zero'ing
memory.  The kernel does not use the vector unit on RISCV, similar to
architectures such as x86 where we use `-mno-mmx` et al to prevent the
implicit vectorization.  Perform a similar check for
`-mno-implicit-float` to avoid this on RISC-V targets.

Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0d13b597cb55..68433476a96e 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
 # architectures.  It's faster to have GCC emit only aligned accesses.
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
 
+# Ensure that we do not vectorize the kernel code when the `v` extension is
+# enabled.  This mirrors the `-mno-mmx` et al on x86.
+KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
-- 
2.39.0.314.g84b9a713c41-goog

