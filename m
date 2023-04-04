Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19FB6D6BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjDDS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjDDS0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:26:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C127289
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:23:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o11so32174808ple.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQY7IsXlYzYdPvbtAuGQhW+vz7kmikxb6Hsl9qnqiJo=;
        b=SIAlskABjXHJXgba+lu7R2T7GFAtUq29s7yTNteHrnjrRREnu/xfZzyK9AUbLub4UK
         OLevFJEkggs/7Las41GW3kOI9I0FbvaO/b1X4vW1T9Nqb/5dgHdvbBlCt4kJaRuyzOJP
         5DO5UZ4mgBvY0/bjKpTLrHD2ZT/64XlWo9QjLPheIFMQeFiXMeVDHb2T8Gj12+6ixTqi
         JCpYKfxf/H/dO6Iehr15B5nWCst6ZMA+J12yAIa9JygFJJNFZ22V/Fvf8sJbgyIZa92u
         3vXDVcm+fZTnZDGc6Osgee5Mxo83Hf/3/hhAazhj7e3hI24w4Z944ntBwybmg0bZtph9
         w1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQY7IsXlYzYdPvbtAuGQhW+vz7kmikxb6Hsl9qnqiJo=;
        b=mTN0eT/Nh9oJGFJtmS9rUnqziIT09k0XHlWencdv9UEI1+gHDAkcsJNPhCVRESrRPE
         AAiTV57T3bwqbJ0XLVsZiGLNR/S9+YR2bryMfkYmSjvYhU3Py87F5ItG4WKZrHP/+cWg
         vNeI6Svr1lXdmm90GmSOuZt+kia13dKuTz5g/VYkOO3BiggS7xOqLRFLcgOC5f+chY2k
         FBjE1H74CwrxBlh9KFBjy3uHs48ry0Hmgvqg+kYtsrTBUs1eEopFkZc6LO9kHVqJACL7
         evNRvO2ry+2Lr98UrUhh+BVh/auM5JzKFFyZLyJMBwCnvop8TKwqWOoseyTRdSz8jd7L
         u80A==
X-Gm-Message-State: AAQBX9d7XqjhkxMJ3Lxpfdu3YGejZNgfVvARl4gLS0/hfsaEmXM5WJLq
        7BGRgFGB+gOAQt5N8zHYwosqiQ==
X-Google-Smtp-Source: AKy350Z5wfhTkRydKKc5Ikh4OLcEW6DwobyPTf5WBp8sjWB/EwsebviKxYM7sCDYl+M9vs/GyS0S0w==
X-Received: by 2002:a05:6a20:4659:b0:db:9726:8e46 with SMTP id eb25-20020a056a20465900b000db97268e46mr2674124pzb.54.1680632601831;
        Tue, 04 Apr 2023 11:23:21 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:23:21 -0700 (PDT)
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
Subject: [PATCH V4 22/23] platform/surface: Disable for RISC-V
Date:   Tue,  4 Apr 2023 23:50:36 +0530
Message-Id: <20230404182037.863533-23-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

So, disable this driver for RISC-V even when ACPI is enabled for now.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
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

