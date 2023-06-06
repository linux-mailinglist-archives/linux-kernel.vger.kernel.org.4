Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B39724233
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjFFMcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjFFMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:32:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6610C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:32:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so52758935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686054766; x=1688646766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VkYPmR4uwo3dQGo/xrqreqAL15LP1pmyYPpri/bVQI=;
        b=A/uKqwtEcKgcSPKr31oKfGQWzCDK+I5uwySB1amNGpoL/G+Ux4zhDv4E04xf3WVRFq
         S3iIfxO9PFeO56O3e5MIYfHsA2DkNv/h2mpJ8q7CverBninN0QglliYDjavjhaLO5oRg
         ZNIGSfjRLaJTQgVlSntipLaPFHWACUdYlBqRztLu4IemmeohNlFkUwVUXgVC1nb2AA4k
         iF9QKa6vzSO1S+ywsL4MbD83dwt1gV9WdnaILv3UHceuQbzhnrBhfIxqS2+pL5bEcoxZ
         EkoymbRON3DS498HuawQ6nGqW5lNlVpo7gKBu1bvy3YyTFGkRjDcMmmPf/gQ6P0B13tu
         Gy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054766; x=1688646766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VkYPmR4uwo3dQGo/xrqreqAL15LP1pmyYPpri/bVQI=;
        b=Yiz/gNcw/P2s1BzWR1bpFJTglWOQl++x9XSqzuX/SRdG6yR2kTrXn7/Tk1TQYldWGI
         gzEaMrxFnSgi6lIZVr70aTjVooQsZQYs1ZUahCCADj4Ls4OjqjZClnOw9ZWnJL9jzn8O
         zvv33Pi5K991EBt1vXF+aW6pTbYZjbPDh0I30N8QJLwDSbXqxIK7NvECIcZBYqD+4LfJ
         AAm4R4Z+o7sr1DwNLqoc8ze3jt1+O4w6uL4I9rtbyyNkm/rPAJImpMbE9l2qRsGwjRCM
         10eAOsNF826Mc3QUVSCLq1u3U87V+UyE5mHKYW6NGHNjXQI0v/lXF8rcpmmsu5qIPPf4
         WpeQ==
X-Gm-Message-State: AC+VfDyL3U6GIrKvGjOpa1ioGYrqSkfcvQm07fimtd6Eo+RpBNC0PDtf
        AB+Y3VWXtMCxoBWpYSi70KPpcQ==
X-Google-Smtp-Source: ACHHUZ7QqLlFe/7LiprVf2Cv/Aho0tMb/8DFVwnFC5vQGWT2ZIdvz9X7gsH2OjgJ5MSVW8x5dpZadA==
X-Received: by 2002:a1c:4c15:0:b0:3f6:688:f658 with SMTP id z21-20020a1c4c15000000b003f60688f658mr1733922wmf.20.1686054766516;
        Tue, 06 Jun 2023 05:32:46 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003f7e6d7f71esm4761868wmc.36.2023.06.06.05.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:32:46 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 0/5] riscv: Introduce KASLR
Date:   Tue,  6 Jun 2023 14:32:37 +0200
Message-Id: <20230606123242.20804-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following KASLR implementation allows to randomize the kernel mapping:

- virtually: we expect the bootloader to provide a seed in the device-tree
- physically: only implemented in the EFI stub, it relies on the firmware to
  provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
  hence the patch 3 factorizes KASLR related functions for riscv to take
  advantage.

The new virtual kernel location is limited by the early page table that only
has one PUD and with the PMD alignment constraint, the kernel can only take
< 512 positions.

base-commit-tag: v6.4-rc2

Changes in v3:
  * Rebase on top of 6.4-rc2
  * Make RANDOMIZE_BASE depend on 64bit
  * Fix efi_icache_sync and efi_get_kimg_min_align which were undefined
    in x86 (and certainly other archs)
  * Add patch 4 to fix warning on rv32

Changes in v2:
  * Rebase on top of 6.3-rc1
  * Add a riscv cache sync after memcpying the kernel
  * Add kaslr_offset implementation for KCOV
  * Add forward declaration to quiet LLVM

Alexandre Ghiti (5):
  riscv: Introduce virtual kernel mapping KASLR
  riscv: Dump out kernel offset information on panic
  arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
  libstub: Fix compilation warning for rv32
  riscv: libstub: Implement KASLR by using generic functions

 arch/arm64/include/asm/efi.h                  |   4 +
 arch/riscv/Kconfig                            |  19 +++
 arch/riscv/include/asm/efi.h                  |   4 +
 arch/riscv/include/asm/page.h                 |   3 +
 arch/riscv/kernel/image-vars.h                |   1 +
 arch/riscv/kernel/pi/Makefile                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c          |  13 ++
 arch/riscv/kernel/pi/fdt_early.c              |  30 ++++
 arch/riscv/kernel/setup.c                     |  25 +++
 arch/riscv/mm/init.c                          |  36 ++++-
 drivers/firmware/efi/libstub/arm64-stub.c     | 112 +------------
 drivers/firmware/efi/libstub/arm64.c          |   5 +
 .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  18 +++
 drivers/firmware/efi/libstub/riscv-stub.c     |  28 ++--
 drivers/firmware/efi/libstub/riscv.c          |   5 +
 16 files changed, 332 insertions(+), 124 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c

-- 
2.39.2

