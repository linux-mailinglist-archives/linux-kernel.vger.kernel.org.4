Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44526D6BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjDDSXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjDDSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:22:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FA5278
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:21:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id dw14so22050378pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pi8xH0IxXrFGj4CxsC9boyEOiTx1Qa4CmKA7c/Mr88=;
        b=NrI6ACm7UZOJVCJyBc7mGJGBLfdlM/PTYp6L1vM45ahDVRivroqAt1FE0VHGOEA6E6
         80auVy44DFfVDm1tzMTK6mVz+Jlugq9sYp5hzIoM7XQr7unFo44/VWi2WLq3y8UPCnjZ
         T7oz5OeLMLXiQXUo2ZYgOJ3jQzLVq4z6Z80U3D+fvhU5arvqAPwfwFuONY8dWxgFahDr
         aiwy5PM+qx3mahRPtLj0zuXUwGdgcUPzLxiSXBW7+4RUzVr09/9rUtmt81/t75mueG5t
         yTMGMn5wiW6RERH+pnqQAqUsMYQh8ESCsnkuTVukq1xoZhVaG+3NZq8dZ92Om5J54M2B
         P/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pi8xH0IxXrFGj4CxsC9boyEOiTx1Qa4CmKA7c/Mr88=;
        b=O2OKIxuguLdoG6jpzGH2ViZEtMXAwjDAHuvpuU3n2AMDKv2C1I1++KANu/EdqaPODm
         3Hkbdq2kNi5IXbfFfDVNzAlVpRuZ2uNAZlmMZs3Y514X49gnD5PshoyAoX8zPdRwepPA
         0uF+y60reTk52iWUXUGxFIRByA5+9cCPPAy4YGylZwkNUIRWAWgJY/FVSHNlpsB2nRFU
         mX4wwStwnnXPDDzeNGV2O211NX3DWh6jPhajD+5O1zaYYfLUquDBA7xGbdvGqfaeeF3Q
         dUq6xQ5cauAMp+KD7J/PiWKeyCyIEcfCZIQBWgvmxk7XZOZjRmTKCtOv00R3Vmul0dP8
         LXdw==
X-Gm-Message-State: AAQBX9d6tOqoTlhuP3YwczSxxiyn11eDZqa44y47GeeCqaz7p4VKXDyx
        7SmL6XBLcawhRaNWELeIn+Y6nA==
X-Google-Smtp-Source: AKy350ZrQVyDLMzwqmQeO3KOVb6JBRZ2K0v5xylw2uRxzU82JnTGfnCZ5VoqlPFlxj3azLCOP54Dfw==
X-Received: by 2002:a62:1cc7:0:b0:622:dd9b:e2d8 with SMTP id c190-20020a621cc7000000b00622dd9be2d8mr3363135pfc.3.1680632517560;
        Tue, 04 Apr 2023 11:21:57 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:21:57 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 10/23] RISC-V: smpboot: Create wrapper smp_setup()
Date:   Tue,  4 Apr 2023 23:50:24 +0530
Message-Id: <20230404182037.863533-11-sunilvl@ventanamicro.com>
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

smp_setup() currently assumes DT-based platforms. To enable ACPI,
first make this a wrapper function and move existing code to
a separate DT-specific function.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 00b53913d4c6..26214ddefaa4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void __init setup_smp(void)
+static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
 	unsigned long hart;
@@ -116,6 +116,11 @@ void __init setup_smp(void)
 	}
 }
 
+void __init setup_smp(void)
+{
+	of_parse_and_init_cpus();
+}
+
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
 	if (cpu_ops[cpu]->cpu_start)
-- 
2.34.1

