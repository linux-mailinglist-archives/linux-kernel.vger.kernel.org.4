Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA17501DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGLIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGLIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:41:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164CDA2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:41:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so109811621fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689151298; x=1691743298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUbAuUSvAlU7VMm5cmtoV0SpHebNxqAw1L0b3txSkeA=;
        b=q0AyVktPOJVBLAjWdHnUNM/pjTZmAsjJDDXL/tZPG2yS5iNCBt6aLEdnLrBoMnhnmz
         WAc9c5eoOLd+gctm6PEInMsjY8PhtcDqwL3B1Dl5BDeMqL43Mw6VMUL5w7DnIn1mgmvD
         yTQXB960YJxyFpnAYKsZN5cRdQPTji0LOy0TxUckPKJx/NpimVI7A8NiRL4DqA0gqmBo
         Fb3sCT+6425IsW6GrkzsdGqNAPJFWqmNHYHWBN9RuJa/4AyJaBkFyXY3MqqFWOFoVN5U
         HEqEFAE3wVMj1/uyQjkuxdT0TvC/lz5ONbcTueaNuzPJf52K2+ICCJ3+Fo5hE4yqZI2J
         UkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151298; x=1691743298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUbAuUSvAlU7VMm5cmtoV0SpHebNxqAw1L0b3txSkeA=;
        b=Bw6OeoLIIUxVmmertGH707zlm+5khKGpsaQEjvPnhN2qM+lnmrQoILSNyLzf5ogwG2
         QH/JbZj3xzdbwRW2JAJypaE1PrzU4ixHvEYw6X/oi5TvujJLcMJQmd2Yw5mCrLohWHWD
         BDSm2c1jsn2q4YFRXU9/PNoiOfB9GPRgDHQx07yyMHQpYGGFI93WDuhmP+dnpr9aVoWT
         qKOFHMraGVvvKUvWcYwBxgQs2cfifjvFkqfdfijdYVa8DEQ8EZqpBoQ1KnnEZDjQhGSG
         TAGuUI50J2zcj7ZGONj9xAPmrPvIFJNSNNrTalgU4lf0orIZnGryk5IZsozgIT1xUN+C
         F7Hw==
X-Gm-Message-State: ABy/qLY7XZJDDqoi85BoohJz1eqadmL8gkY644XDliWqIdR86YTVOF5m
        sEL1rbM3XCa5hwPxYeJ0lDRDgA==
X-Google-Smtp-Source: APBJJlGKY0rPUEVIW0S4wt6ebCIbE/MCdi8SP1zuwJFBdbAWwb185JZBJ5tkEleUiq2f5q8wWYV9uA==
X-Received: by 2002:a05:651c:120c:b0:2b7:ada:cb25 with SMTP id i12-20020a05651c120c00b002b70adacb25mr13810462lja.31.1689151298155;
        Wed, 12 Jul 2023 01:41:38 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b003143ac73fd0sm4496122wrm.1.2023.07.12.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:41:37 -0700 (PDT)
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org,
        sorear@fastmail.com
Subject: [PATCH v4 0/4] RISC-V: archrandom support
Date:   Wed, 12 Jul 2023 10:41:16 +0200
Message-ID: <20230712084134.1648008-1-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the archrandom API to the RISC-V
architecture.

The ratified crypto scalar extensions provide entropy bits via the seed
CSR, as exposed by the Zkr extension.

The first patch of this patchset allows for detecting support of the Zbc
and all scalar crypto extensions. The second patch documents the
corresponding dt-bindings.

The third patch exposes the Zbc and scalar crypto extensions through
the hwprobe syscall.

The last patch relies on the first ones to check for the Zkr support,
and implements get_random_seed_longs by looping through a seed CSR
read-write to return one long worth of entropy.

---
v4:

- Documented the USEED and SSEED requirements when Zkr is enabled

v3:

- Increased the CSR SEED retry loop max iterations to 100
- Documented the added extensions in the related dt-bindings file

v2:

- Fixed the ISA map setting for zkbx
- Alphanumerically sorted the ISA map setting
- Added my SOB on Hongren's patch
- Fixed patch #1 commit message
- Removed printk prefix from the archrandom implementation
- Fixed needed_seeds computation (and make it const)
- Replaced riscv_isa_extension_available() with
  riscv_has_extension_likely()
- Made the get_random_seed_longs implementation more readable

---

Hongren (Zenithal) Zheng (1):
  RISC-V: Add Bitmanip/Scalar Crypto parsing from DT

Samuel Ortiz (3):
  dt-bindings: riscv: Document the 1.0 scalar cryptography extensions
  RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
  RISC-V: Implement archrandom when Zkr is available

 .../devicetree/bindings/riscv/extensions.yaml | 87 +++++++++++++++++++
 Documentation/riscv/hwprobe.rst               | 35 ++++++++
 arch/riscv/include/asm/archrandom.h           | 70 +++++++++++++++
 arch/riscv/include/asm/csr.h                  |  9 ++
 arch/riscv/include/asm/hwcap.h                | 11 +++
 arch/riscv/include/uapi/asm/hwprobe.h         | 11 +++
 arch/riscv/kernel/cpu.c                       | 11 +++
 arch/riscv/kernel/cpufeature.c                | 30 +++++++
 arch/riscv/kernel/sys_riscv.c                 | 36 +++++---
 9 files changed, 286 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/archrandom.h


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

