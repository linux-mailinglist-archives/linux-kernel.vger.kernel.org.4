Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008B66CD469
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjC2IVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjC2IUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:20:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EA49E8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:19:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so10561510wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680077974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olPuTVJAN4zMwmNPZ6aRAjo+h/QsedtQg1W0MV2/+c8=;
        b=4JF5/qgietg3bxay6q88J4jadm9tbedcL+YIaGNhIwz8YKRb/CvRBeTV4umGJEWq4j
         lXYSPgZaJpo0tVXg2yFIKIZfSBn1nM+pCoXZPZIMCUL+3Vqh2TBVIjldnDAZDW3t5ynZ
         byIi9/RdxcMI/zapfESfzB//6qXOFd5kz3AQVnEV4B/tnsIyT4PMWS6C8ZfO+DPnDUui
         iofLfYVUyOD6d1i7Qb55RnN7dyVtJ98voUtzW7bCEeXTcWKZIIW0WNKpyI2QB2EWWLP+
         szxMqjitxdroPUIoUHspNweyAqmz+fapWzEqM730+mWiaST7+FwTwN7rnhBy3KgqM4a0
         6TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olPuTVJAN4zMwmNPZ6aRAjo+h/QsedtQg1W0MV2/+c8=;
        b=xR2LpkY1uWgjalpknKdzNlaUGrVa0Q2XchARTGySe6tVuPTm0VnEgEOqDbQnx7Ie6g
         vl+2n8Zh86cl9wb9XNWK+JOvX02Wd/o1Ig307XYnwkv8Q1mAGbOkgxwtmrKQrTYqEbfx
         ZH9XsMecfU8M0vL0b5AhRbP+7rQf7+SDTZ3pyAmPfY9iMc6JsJ0YOG7rNdpAKoLeQk1N
         Y5h7/CgMzRZF+chQDco97HgXVyndn9rHzn/6EP1hmIzFhIIlDPhqiz+N+jcFsOU9oTcy
         z3qv8N29He1w/QKwDvK90DDKYOXUX4rmiLcCR72dlyWqDFvgQT3XVMvX3uphjKAtUfPJ
         cVSQ==
X-Gm-Message-State: AAQBX9chcI2M8Wh2oFtZMQRh5bKsS3oE6z/TUGVTc0syHLoQWRB4/3HX
        HZdIXpCGpT93NruxDI2B3NClBw==
X-Google-Smtp-Source: AKy350ba7NoMqjW8oJNYLSYupiBj+VkhqtyFEezaN8ebT0ysK+vZGrpWsjx1UPheUr50M05ZyMjXag==
X-Received: by 2002:a1c:4b04:0:b0:3ed:c84c:7efe with SMTP id y4-20020a1c4b04000000b003edc84c7efemr1068097wma.7.1680077974759;
        Wed, 29 Mar 2023 01:19:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003ef36ef3833sm1416512wmb.8.2023.03.29.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:19:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes v2 0/3] Fixes for dtb mapping
Date:   Wed, 29 Mar 2023 10:19:29 +0200
Message-Id: <20230329081932.79831-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to map the dtb differently between early_pg_dir and
swapper_pg_dir which caused issues when we referenced addresses from
the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapping
to the fixmap region in patch 1, which allows to simplify dtb handling in
patch 2.

base-commit-tag: v6.3-rc3

Changes in v2:
  * No functional changes!
  * Add RB/TB from Conor in patch 1
  * Split patch 2 into 2 separate patches, as suggested by Conor
  * Fix the changelog, add Fixes tag, as suggested by Conor

Alexandre Ghiti (3):
  riscv: Move early dtb mapping into the fixmap region
  riscv: Do not set initial_boot_params to the linear address of the dtb
  riscv: No need to relocate the dtb as it lies in the fixmap region

 Documentation/riscv/vm-layout.rst |  6 +--
 arch/riscv/include/asm/fixmap.h   |  8 +++
 arch/riscv/include/asm/pgtable.h  |  8 ++-
 arch/riscv/kernel/setup.c         |  6 +--
 arch/riscv/mm/init.c              | 82 ++++++++++++++-----------------
 5 files changed, 54 insertions(+), 56 deletions(-)

-- 
2.37.2

