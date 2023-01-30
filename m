Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF9681904
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjA3S0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjA3S0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:26:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1FC47416
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so16362952pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkGE01Mpgd0zQdA3GENSlYo9eU6sEMItLJR0OaGMyjQ=;
        b=jbIhshr5uVfA86th0bcTdtMzr9oS1VyqbMLYF5ZGlBRXNpHrcs8DWHf/D9IgTeFh1F
         Y5e11T4Vvtref1QDKQ+XiHXojUg0e+i+S38peWV4Apx94P0NKRcB0DAmJRk0RrJle8Fm
         3awc1GpI7w1j7MnnGL3ciDCIf90r85C3QXXXCK0L3ojt2238HEnvWEsLTfjYhakRe3hG
         wbMlKcmEJuWJHEPilJoudPQPRUa6ARXhJ98TEnIkJtu3FyXxlmD89cMv78BzfLFR5kYy
         Qc3rHv2CCGYsIixWXWQgdM+5g+FKaEJDGviWmeoLzOH5zJk9RSqhHAdf13vmHvrp3x82
         1r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkGE01Mpgd0zQdA3GENSlYo9eU6sEMItLJR0OaGMyjQ=;
        b=yYB5ig1Zl4dhu8Mes1JNBDXyXoXc6U8QgxSWmcnERpRlLTbhiKocrOvb5+VfxCKflZ
         WrWe8Td3pQO8nMzzDGwXwbXtkT9s7NWWi0x0sE48jMb5b/6XIL5reGK9G1RsqkptAhhL
         6OJymMEnmaSTZJaS2RshJ9+dE3zhQC1ekZdtKhIPLHlFak5L7NONVGkV9PT2/RZRIYZ6
         L7sfw6KUNqJJAmE+XxFWsNHDpzoK/FIeQF5MQ4iUaSGPw/qTrMwxdYnTY6gchiGDtxBo
         Nr058gKv6AeWjy/sZLFQXMKibXxmF0C0j+BHC/Jp8tx+pp9qOUqfG8zfX4SKPaX39X6+
         3tsQ==
X-Gm-Message-State: AO0yUKUcBvZ+OKRcQF9xeN4lErf9hY5CrVds+fTL1avbEVjXRZrr56Oi
        U922OeBuLHmGR8PFGYKzq29RwQ==
X-Google-Smtp-Source: AK7set9Pnqr1BTxPCJQr0H6gTIG5Wj6YCKgECl1AdrucdYZkfWDBH80CoQiA1a+eIyoZ5cYvuPNGpQ==
X-Received: by 2002:a17:90b:3909:b0:22e:5ffa:2a34 with SMTP id ob9-20020a17090b390900b0022e5ffa2a34mr1813190pjb.36.1675103055398;
        Mon, 30 Jan 2023 10:24:15 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:14 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 22/24] RISC-V: ACPI: Enable ACPI in defconfig
Date:   Mon, 30 Jan 2023 23:52:23 +0530
Message-Id: <20230130182225.2471414-23-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to build ACPI subsystem in defconfig.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 128dcf4c0814..8ce06fb0dde8 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -218,3 +218,7 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
+CONFIG_ARCH_SUPPORTS_ACPI=y
+CONFIG_ACPI=y
+CONFIG_ACPI_MCFG=y
+# CONFIG_PCI_QUIRKS is not set
-- 
2.38.0

