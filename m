Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDF6FAF24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEHLxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjEHLx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:53:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5E4033E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:53:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf70676b6so30382475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546791; x=1686138791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3BRBVSL8Q8oMs51cYTt5mS52il5fOg1fDJihGv43qY=;
        b=ES80Pxi/On81xqzn466VvCtk334hOGfLr3xn3NTzV4apgRB6RhbwKVZIBTo1IalSBU
         lVcmcysxZ/p/60nF3RQX8UI1koHmb+gb7F5LJZjEVSoVIGSHNIZ9O+CQQqq/ou8vs896
         PsjSxFkz+JnUtxrFW3Jc29Ds2qTuysCBuEk2ac+MWgL1rEcleqYXwdECBvL5XAcvB/Wu
         hGnV8U+fIXsSHGY1953OB4LCCRDAP4Dd+fG/2c0eFv5FtPnxQujLOUpF86J7i47XEM3m
         1YKonECds2h4NnmW4jdkgHVQz2gvVlcClU0sfnJgFqdQkSIDsEQpi42essJJz1Rx3DXZ
         MKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546791; x=1686138791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3BRBVSL8Q8oMs51cYTt5mS52il5fOg1fDJihGv43qY=;
        b=WLOi1uCYoZxWqoGfXQuIQDIxHWXj65P0DGf6W7EAaKNQqPNC4h4UK/k5YYDn8X5TIS
         Sn/6wUbeLEbiW1FEPymy4RWCCYs0B+hqooRA2AjuOCLbKRrxj3bq2gVzDv8b7nvpvEuG
         l4sm/o1+JgVq8Vq5lQWHgazDHI9oLasLkfnh+8SHz/FUyLaBPyPW2SRf9r7NVtK9O41G
         N7vwSFNN7qZfK/QiU1AZJ6acRxaR7OFPcfJdHE8SykJacYfoaFlCQP7nZq/FVIpDKFka
         da2+wA1pXyUDR3ofDUkJdfk7RY4WMwEEiBC5SldiEUkqOQKbv2duqJuV5+q+guO6NVVG
         TDpQ==
X-Gm-Message-State: AC+VfDzUIvAUwJg1bMKVBMuT4qhhL4UlIZ2nEPQnKIMRQ4c8Aa9QOKqa
        eY4pAvT4IEMl/1vzmU7u43Y7vA==
X-Google-Smtp-Source: ACHHUZ53NJaW+sZlrm12uD3x0j9cg0hxSH1iCIdCk/a3op4cRVXeGuLCDkrlAFFwOkN/WoP8UHY5Cg==
X-Received: by 2002:a17:903:2312:b0:1ac:656f:a697 with SMTP id d18-20020a170903231200b001ac656fa697mr6858328plh.21.1683546791698;
        Mon, 08 May 2023 04:53:11 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:53:11 -0700 (PDT)
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
        Tom Rix <trix@redhat.com>, Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V5 02/21] platform/surface: Disable for RISC-V
Date:   Mon,  8 May 2023 17:22:18 +0530
Message-Id: <20230508115237.216337-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
in allmodconfig build. However, RISC-V doesn't support sub-word
atomics which is used by this driver. Due to this, the build fails
with below error.

In function ‘ssh_seq_next’,
    inlined from ‘ssam_request_write_data’ at drivers/platform/surface/aggregator/controller.c:1483:8:
././include/linux/compiler_types.h:399:45: error: call to ‘__compiletime_assert_335’ declared with attribute error: BUILD_BUG failed
  399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./include/linux/compiler.h:78:45: note: in definition of macro ‘unlikely’
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
././include/linux/compiler_types.h:387:9: note: in expansion of macro ‘__compiletime_assert’
  387 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:399:9: note: in expansion of macro ‘_compiletime_assert’
  399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro ‘BUILD_BUG’
  335 |                 BUILD_BUG();                                            \
      |                 ^~~~~~~~~
./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro ‘__cmpxchg’
  344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
      |                              ^~~~~~~~~
./include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro ‘arch_cmpxchg’
 1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
      |         ^~~~~~~~~~~~
drivers/platform/surface/aggregator/controller.c:61:32: note: in expansion of macro ‘cmpxchg’
   61 |         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
      |                                ^~~~~~~

There is currently no plan to support this driver for RISC-V. So,
disable this driver for RISC-V even when ACPI is enabled for now.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index c114f9dd5fe1..88afc38ffdc5 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -4,7 +4,7 @@
 menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
 	depends on SERIAL_DEV_BUS
-	depends on ACPI
+	depends on ACPI && !RISCV
 	select CRC_CCITT
 	help
 	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
-- 
2.34.1

