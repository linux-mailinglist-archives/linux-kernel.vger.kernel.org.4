Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05476FAF58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjEHL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjEHLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:55:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C944BE8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:54:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so29589485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546875; x=1686138875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XDEVfXqS4FP0KdGTx6jL5yfIe6/oO8gDCIQfJ1eWZE=;
        b=NcufZwwvsj6/Boyj1pZX9SDoMFX3Dm2oty/qRNBJOjRjuNJFqKfLDuz7KnZhPMErND
         hzMLFmmVo206PCVp9d7A+QuEFdVAvPQsbM/vMN5sifyGfmgdxW3gVzHHSWPvKPArOvik
         YIAfNdCYYluT2mdY/5ynJqUWZ6Juz4WRIwj6Ip9TdigxU8k/hWnFJqi14QGEMNF80tah
         vQYIR/at9zkw9K58cy2JXFTG0ONm0RMZMBw0iyqx5FimbSkg7TOJEWNpDfjK345YX5Ji
         3dFtlaLRzMTCuxo+IZaZKoQXFtXhTHUQyNbLjYPc2TgTkRFaX+pOViv/azy0VTr/QdHk
         snAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546875; x=1686138875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XDEVfXqS4FP0KdGTx6jL5yfIe6/oO8gDCIQfJ1eWZE=;
        b=PXPss4Ou7bNJ5xiqIaSn8jBOpyg2W3QPUpII/8rrFm0Xcm8RhWk3/4o03swtQ9UfaC
         JkGVbvHOtQdNhoCBCL9BkWSyCE79dg0AA737pZ0/FaUqM0Noz5CGKOnNvwaKnl6HvNBl
         +p2StFh2IAO7DSeKUoYyAvrpUb6yWLZGOhy4F8bazVkAaNJX1LxnfJGBHbPDyMoPUrIJ
         uVQMnQi/w4JRw6csNx5rxTOqhLZOX1r3PWMEf76d7hVI9t249Htw96hQ2ODb9/Nsny8Y
         l/YazTaz1vtn3Hjt3ZwijGwHw9TUZgIVVtzNPN0a8H7kx26fadixXhw3hVbnoKmrrEUW
         7e1g==
X-Gm-Message-State: AC+VfDxcIMZbe58Ydb7+ikjk1EiJ4Ra13nJQ6KDGfDKilKJRTOzmntOk
        D72gg+MM5pESc8tN24YrX8eL3A==
X-Google-Smtp-Source: ACHHUZ5hMTFJTQPYhgpNKN39ORLnHJpWwdogloO8Lwo1VmnXnF01HpatA+Awvt6a3JK3sbEX6Ku1xg==
X-Received: by 2002:a17:903:2308:b0:19d:778:ff5 with SMTP id d8-20020a170903230800b0019d07780ff5mr13151647plh.15.1683546874762;
        Mon, 08 May 2023 04:54:34 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:34 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V5 12/21] RISC-V: only iterate over possible CPUs in ISA string parser
Date:   Mon,  8 May 2023 17:22:28 +0530
Message-Id: <20230508115237.216337-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot we call riscv_of_processor_hartid() for each hart that we
add to the possible cpus list. Repeating the call again here is not
required, if we iterate over the list of possible CPUs, rather than the
list of all CPUs.

The call to of_property_read_string() for "riscv,isa" cannot fail
either, as it has previously succeeded in riscv_of_processor_hartid(),
but leaving in the error checking makes the operation of the loop more
obvious & provides leeway for future refactoring of
riscv_of_processor_hartid().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/cpufeature.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1d6b7e4b829..c607db2c842c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -12,6 +12,7 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -99,7 +100,7 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
-	unsigned long hartid;
+	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -112,16 +113,20 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
-	for_each_of_cpu_node(node) {
+	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		rc = riscv_of_processor_hartid(node, &hartid);
-		if (rc < 0)
+		node = of_cpu_device_node_get(cpu);
+		if (!node) {
+			pr_warn("Unable to find cpu node\n");
 			continue;
+		}
 
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
+		rc = of_property_read_string(node, "riscv,isa", &isa);
+		of_node_put(node);
+		if (rc) {
 			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
 			continue;
 		}
-- 
2.34.1

