Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A006CD189
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC2F3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC2F3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:29:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7230FF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:29:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so14383179wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680067771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0nKREiU5apoP9AERkcSfoCMtcJ2QiDWhd7LmZsVvuQ=;
        b=b4oOAK2vzMWROSK9CPdsTAH7ZN/tAeYeBXukc0zQcNww3+rA3dyiqsmIVHemW0qdqU
         htlzmbuOyfGr47cqTYtjKgU/lrLCuCmryoyrryfOw1NndFn3ah41a23JgdrOz7/ZpbMn
         wZB6MIqbnTRX7TiHeFSUmFCBCGOF27cCnEGFMAMFNMxScIQmtYYLo33QKxJZywdRy6al
         /OdvqKoumD++Rv0OXKYfeYmVd6TdAd6C0nsRizMZl220EoVWin0FC93RTb8xzkWwJaSX
         bb3qtbnxZqJFG0W4wU/7bQl77eFG93/mOHevexnD+37DgCHFoD/enVEPwI58BfrRrGAI
         4ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680067771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0nKREiU5apoP9AERkcSfoCMtcJ2QiDWhd7LmZsVvuQ=;
        b=lErPztzHi0jeFewsVggLHulEtVs5qlZ27vq8r+9M5+kPfk+LXkIAsi9UT6TwXSjfUN
         xn7cL80I3tcvDFwQY4u/nOrI4gpaC0ENJqCFTguW6wOZonKjXyilXtO4SaOqarDX3Jxt
         T6wKD8bEaIIwKXhrdX45yVlOKQQiL/JHJ7p4C3aK4SFsuqEymA+NbSgar4c42HigMkfg
         prUvAKFBMl28gE07c9iA1uT6HMVbIDS5bkiBagNukK4qYGVzExZNtBFONvBGMebpx7/9
         S9eAcrSUKWNpWwiKUMWutZgdzPyPR9FiSDKwcoicfBM92KWV0IWpARRMWAxKPOnraP+Z
         LKDw==
X-Gm-Message-State: AAQBX9fQGIXvOcoI5AiIyQ2XARcgi9YltiCH6jsvWUfBzCNCaHvKt2qi
        rCdGGRzkrUdAOztYD3zksHX0UQ==
X-Google-Smtp-Source: AKy350bEq5NqVvP0FW42rtbPv8tMVOKg3WWaFwubyVFWEP6t3QqmPu/EBQ1qtrwUuEQVOE9V/NpKlg==
X-Received: by 2002:adf:fc8e:0:b0:2d9:16f9:aee3 with SMTP id g14-20020adffc8e000000b002d916f9aee3mr15858960wrr.14.1680067771579;
        Tue, 28 Mar 2023 22:29:31 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002be5bdbe40csm29201205wrs.27.2023.03.28.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:29:31 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/4] riscv: Introduce KASLR
Date:   Wed, 29 Mar 2023 07:29:22 +0200
Message-Id: <20230329052926.69632-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Note that the patch "riscv: Use PUD/P4D/PGD pages for the linear
mapping" is necessary to retrieve the memory below the physical kernel
address, so that the EFI stub does not have to try to relocate the kernel
as close as possible to the start of dram.

This patchset is rebased on top of:

riscv: Allow to downgrade paging mode from the command line
(https://patchwork.kernel.org/project/linux-riscv/list/?series=734849)
base-commit-tag: v6.3-rc1

Changes in v2:
  * Rebase on top of 6.3-rc1
  * Add a riscv cache sync after memcpying the kernel
  * Add kaslr_offset implementation for KCOV
  * Add forward declaration to quiet LLVM

Alexandre Ghiti (4):
  riscv: Introduce virtual kernel mapping KASLR
  riscv: Dump out kernel offset information on panic
  arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
  riscv: libstub: Implement KASLR by using generic functions

 arch/riscv/Kconfig                            |  18 +++
 arch/riscv/include/asm/page.h                 |   3 +
 arch/riscv/kernel/image-vars.h                |   1 +
 arch/riscv/kernel/pi/Makefile                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c          |  13 ++
 arch/riscv/kernel/pi/fdt_early.c              |  30 ++++
 arch/riscv/kernel/setup.c                     |  25 +++
 arch/riscv/mm/init.c                          |  36 ++++-
 drivers/firmware/efi/libstub/arm64-stub.c     | 111 +------------
 drivers/firmware/efi/libstub/arm64.c          |   5 +
 .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  10 ++
 drivers/firmware/efi/libstub/riscv-stub.c     |  28 ++--
 drivers/firmware/efi/libstub/riscv.c          |   5 +
 14 files changed, 315 insertions(+), 123 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c

-- 
2.37.2

