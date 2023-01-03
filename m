Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593A65C1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbjACOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjACOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:14:57 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011E1182F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:14:55 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h192so15369686pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=195vKHGR+QakKYu5xEQ6bJmupoltT/5fZUVnyxT/JS0=;
        b=bJSAHr4quvhyCBCcMOee2hkHJrxJWiPH0TiFcKcUx6zEBGO4/nhdtcWPMD2IpjnROZ
         PyQaBBpPodBYpT6wCf79SU6hylJMOcugKM2f+zbOPerQGKaDKbEszQ7D6MxnOtF3vGlA
         1he26shoOo4EjTS4RLWUTnA1fBfHOW22CTeVq5KdkAae1LMSCcF3Scf8r/N8kcSM/wwv
         NFi24qFJPgGSkxRZ8PSTIGReMJCph7ryWq6G2o0vTCZ2siHVbz5/bBErm31yrdTs9gJP
         49RwUqzcP2HV0/LUgFlWGYuHoLLVdPZdQOvHxtp7W8BFojgkCuRZv/SEhCv+chU9keX9
         uJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=195vKHGR+QakKYu5xEQ6bJmupoltT/5fZUVnyxT/JS0=;
        b=geuy42jd+lWbqQFCrSTOblYw2c1YWTAp+U4L4cIDcov+uWpbDp6O7jEooMlAOmqMc7
         jO+yKlZIt0a3keYZdBom8vRdKr5jmewSKWoQ4I3C1wxhwI9HMZJJ++TuxFQLkcyzHGcO
         RsrKUx2Sg4itR4MT64GYeEIle4ftSjCVr01wFYy3mTQebkDf+f9j2LrMpFGqUTBhdqDl
         Hbm44lyq7SPL3tbQiJ5iTWyM09GLqEybR/KKll+1NIWACet23mHLR6PC5zFhd8IQvqNh
         ifVya1DQKGH8wQT5Uw/PRcJ/7cUJNJk3CBvn6/gBU2z84AdwDeXgQjMn3IJE+ZbVvVOZ
         KVbA==
X-Gm-Message-State: AFqh2koAI3iD3m94AskeHkRTnaMlCsAG+4np68XiLeKJOrCfZg3JnCln
        c9s+zU/fT9NuBdDa65pnWYSE/w==
X-Google-Smtp-Source: AMrXdXuIbWO6Ed/ZM9fAR5Tl3UhF7v8lrhmEy+hu1Tl0m3zImIUpzgFLQe+RTWo7etI4V9mqPpMYaQ==
X-Received: by 2002:a05:6a00:2164:b0:581:2f69:87ed with SMTP id r4-20020a056a00216400b005812f6987edmr27557486pff.34.1672755294609;
        Tue, 03 Jan 2023 06:14:54 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a628301000000b0056be4dbd4besm5936035pfe.111.2023.01.03.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:14:54 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 8/9] RISC-V: Select APLIC and IMSIC drivers
Date:   Tue,  3 Jan 2023 19:44:08 +0530
Message-Id: <20230103141409.772298-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141409.772298-1-apatel@ventanamicro.com>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d153e1cd890b..616a27e43827 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -127,6 +127,8 @@ config RISCV
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

