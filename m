Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455E6D6BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjDDSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjDDSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:22:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6C6592
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:22:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u38so22038718pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOfAYG3XRnm+elp9Rz4INSxNTdbKknHW/6eObzO7hi8=;
        b=L8YECRNq9zHfdajtfyIxGzHpmgAu+8AIVFW1slPJBQJ6rehzKPbVARoQnJZcn0eLo4
         MZJwlkBXNWwUdUTfaNSKkrkxTTu4KyG2qGOMUv/QmEqqV/DRdXVfjGa7HoDimM+6d0Kg
         y44bdJ5lRuCVCZ3T+qr98D9JJokhrxPqVeAEAv1arA8yLOHyPwK8xWkKJ3OcxXDmqC5V
         H7brCz+RrTXiJPi9Lxx2SXxvCy/V3plJ/cxF8IDBy4naSeNVcIgT7e3QC0gr8GOJkO6s
         ryRvuYpFL1C2f4FEG39wrbBR1+mNGg+skArfvu24iysSkTM4p9nW7XTd1b93qfcYm83d
         3Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOfAYG3XRnm+elp9Rz4INSxNTdbKknHW/6eObzO7hi8=;
        b=z0d7uJZgy4bnCh98etaOIr3akyYIq1BIhmicK9WXB2osEQBjUZiPS67RKLl2HLefdt
         SxrQiP1wMhDsDfhKiidYRAEke58vLlArY5k5PrgxfNnLMQnt/jwRGVlGYEXEO7fdY/uN
         Gak/0BVFTniYkvMn2cR00ENl8KoAv4NNLgIZ5TIVTIUJVdhgGEMEutcPPEINGQib6rHq
         IWcmIiTBCBl7FkLRaWgHG7uG27zqyLQjv81+PbsDOu5qcW8GQaEe/zAlHf3HcTSPpV7A
         vWzu0jnYfjB8GWImay395yLiogFNjQLyndLLymvPj/3cNTMHc1GOA+iK4FpQxzaHUfrI
         mFoA==
X-Gm-Message-State: AAQBX9cvWOz1KbhE1ofpoTg+dIgJG6P9uEF6MbvVOrXYbpnGNUf42NhQ
        U3o6AOL1AVLfsW7ZlQl99pbVAA==
X-Google-Smtp-Source: AKy350Zpp5mXd1sQHCpB7UZIOcSKdFUPpz/zileQuMF0F72Lgc9d9QGQsq6GZKBUg3PXCt3oMIPvzQ==
X-Received: by 2002:a62:7b8a:0:b0:625:1487:f06c with SMTP id w132-20020a627b8a000000b006251487f06cmr2926744pfc.29.1680632531143;
        Tue, 04 Apr 2023 11:22:11 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:22:10 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V4 12/23] RISC-V: cpufeature: Avoid calling riscv_of_processor_hartid()
Date:   Tue,  4 Apr 2023 23:50:26 +0530
Message-Id: <20230404182037.863533-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv_fill_hwcap() finds hartid of each cpu but never really uses
it. So, remove this unnecessary call.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpufeature.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 59d58ee0f68d..63e56ce04162 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -91,7 +91,6 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
-	unsigned long hartid;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -109,10 +108,6 @@ void __init riscv_fill_hwcap(void)
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		rc = riscv_of_processor_hartid(node, &hartid);
-		if (rc < 0)
-			continue;
-
 		if (of_property_read_string(node, "riscv,isa", &isa)) {
 			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
 			continue;
-- 
2.34.1

