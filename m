Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3E74120A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF1NPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjF1NPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2451705
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313f61890fbso2911958f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687958098; x=1690550098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6nhK8W+AfdQ4hZQdqGj29/wgqqdks0TQ+I2eHBrD5Ys=;
        b=ccY9m5lQYm1SOaalBgT1roSGj2L57EgIf+rtlbiGmeRcv0haI0bPgiHVC2hybOLWn/
         5vK/XAP0KxECaP4qo7EreOzd2IGz06dBFXie/twv/IaRSJEHIIo1zZ3KH85XeAHUUMs0
         rNtH+DCrDjkDhz9jAQaf5I0yH3YBHEyy2bl2iiTsuNax1C5wPifA6yvNO85CU06yal6b
         k9IeyBv4ipnuVnA8MoeDeSLVruznQuabOkPkDdl0KHc14EueKy0ouTk1MViFV+xxOOUq
         7G2ACm6aaV4QQp06o4BQos2iW4DkgAlAWnY2ONgmuxKJpJCTp7z+KA1kbBM+qhdRbqkx
         Dlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958098; x=1690550098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nhK8W+AfdQ4hZQdqGj29/wgqqdks0TQ+I2eHBrD5Ys=;
        b=KmXl3DnvVEsVosPgBDb66BE0SZK04gcUxmoOdTLQKZw4rJGNbT3M9T1NQa18s/iLwc
         Zlt+Gu5ZEEIFHDumiifLeGAWCIpX/6ucGEfogeV8zNeZ9XYxA7uqOxwQHSTviETin6zw
         cqeaHcAgXpjQUvnRcdb1wTcS1gLvs8EIBH21uQjphsZW3ynGl/GpjgFEbNvXhzcjEb1r
         ZzTeB+WgXiJ1ElY40/dQWpYfGxGrbPRYGysIdZ0VgUwQLFP5LjW6Zo1W7AWB0LzMdVZ6
         fEVFH9BzMk4j0qcAp+ktSMvhZul/i3++qakOC7zZDpBNmFDXiykbU5Xq8968vhzb/RMQ
         lqzA==
X-Gm-Message-State: ABy/qLYA6IcU+KL/3CB/1Va+GYv/lnwxlskUwHX+xUpnfCHTL/FTPlSm
        W+klClcZ9ioQiwB9wA5kUTlmeA==
X-Google-Smtp-Source: APBJJlGSjIr/SRBaTE80Ha1daaVNUQNbNbKCO8txWQKZ5n3EoACEySH84sVfpSPM/eC4C8JR3wboFw==
X-Received: by 2002:a5d:490a:0:b0:314:ff1:e714 with SMTP id x10-20020a5d490a000000b003140ff1e714mr941498wrq.5.1687958098406;
        Wed, 28 Jun 2023 06:14:58 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b003110dc7f408sm13456946wrf.41.2023.06.28.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:14:57 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>
Subject: [PATCH v2 0/3] RISC-V: archrandom support
Date:   Wed, 28 Jun 2023 15:14:32 +0200
Message-ID: <20230628131442.3022772-1-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
and all scalar crypto extensions.

The second patch exposes the Zbc and scalar crypto extensions through
the hwprobe syscall.

The last patch relies on the first ones to check for the Zkr support,
and implements get_random_seed_longs by looping through a seed CSR
read-write to return one long worth of entropy.

---

v2:

- Fixed the ISA map setting for zkbx
- Alphanumerically sort the ISA map setting
- Added my SOB on Hongren's patch
- Fixed patch #1 commit message
- Remove printk prefix from the archrandom implementation
- Fix needed_seeds computation (and make it const)
- Replace riscv_isa_extension_available() with
  riscv_has_extension_likely()
- Make the get_random_seed_longs implementation more readable

---

Hongren (Zenithal) Zheng (1):
  RISC-V: add Bitmanip/Scalar Crypto parsing from DT

Samuel Ortiz (2):
  RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
  RISC-V: Implement archrandom when Zkr is available

 Documentation/riscv/hwprobe.rst       | 33 +++++++++++++
 arch/riscv/include/asm/archrandom.h   | 70 +++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h          |  9 ++++
 arch/riscv/include/asm/hwcap.h        | 11 +++++
 arch/riscv/include/uapi/asm/hwprobe.h | 11 +++++
 arch/riscv/kernel/cpu.c               | 11 +++++
 arch/riscv/kernel/cpufeature.c        | 30 ++++++++++++
 arch/riscv/kernel/sys_riscv.c         | 36 ++++++++------
 8 files changed, 197 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/archrandom.h


base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
-- 
2.41.0

