Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5373FE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjF0OjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF0Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:38:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BAA358E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so21338915e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687876699; x=1690468699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+C41V7RG5y8tus8a2bS6fXzYKHyPug4YX52zYixdqXc=;
        b=yv/rlGV56Rx4w5dUzZqxeq5KGVYUscxz3mVtXcfwBEl7sAAaz8EkIR7pRo1RvSkaUj
         rUr0ZuP+7Nh/NPTdSZ0HtaVaSof+gUZU0qs1twkErLIfkAHeARPAcA4wjS7etd34sCJH
         ie/CvDHYDIa3TeGKLM98hyoQIYaMThelko2Lc4Xs7Ec9/63AhE6wZ8Nk0wL2k9lqHP8K
         c8SXBfjrGGJvliutBkOYMWpRit6MLCBRj5WL+CNqXOAUz95Ompcg8RQXz0QZf14yg7Q2
         rBl81WLIA8PZKkMtvgpvXrachnOEjL3gVM6ty+EqBv7wWyHICm7skQDU/9x/FlP42KFC
         WBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876699; x=1690468699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+C41V7RG5y8tus8a2bS6fXzYKHyPug4YX52zYixdqXc=;
        b=NvG6aoRGRiQl2U+YAENpZm7GISdTQbh2YKoOpXHxmFiQ6CykuKXjFW3WCQCtZ+Tru6
         PNnqcVs7hPhn/KbfZENAftcVS7anbnTFAu1964udkc2DKzbuYV8hecDtCUAN8XVk68+Z
         DN8sMJGqeDIE4y4n4TvMlcD9XKmlXs1sUXjDDor9Djy5JMfTIdKOD9GhWSVm0b30mNr3
         mu4gz6NGueHD0COs4huQP+xvyJBwHdvp++pvSI3lhS73WMg6dKQcQII5t9/sCkOBrA/Z
         ru4gfANsR14Zc/fOuRwlEGfDqAF9B6xma/0eOT4Y5+k3pUs0+pfC4iYQ3ZwLjb/MWK3b
         hr/w==
X-Gm-Message-State: AC+VfDxzWCGGkjQVCNGOqerv86vDPots4mzVhO6yl4faWvSZtzJKejMu
        Ffpef5HtI8dFdKY7VOn2qu7vWA==
X-Google-Smtp-Source: ACHHUZ4+vt4NZ58/U/X3S1zrCFaI/7IJINbviXWuuOta5mxEG3BMIF9gWctFWwGmtg0aVJjJ4Q1Anw==
X-Received: by 2002:a7b:c050:0:b0:3f8:f45f:5c34 with SMTP id u16-20020a7bc050000000b003f8f45f5c34mr10342762wmc.40.1687876698944;
        Tue, 27 Jun 2023 07:38:18 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f8fac0ad4bsm10894793wml.17.2023.06.27.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:38:18 -0700 (PDT)
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
Subject: [PATCH 0/3] RISC-V: archrandom support
Date:   Tue, 27 Jun 2023 16:37:41 +0200
Message-ID: <20230627143747.1599218-1-sameo@rivosinc.com>
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

Hongren (Zenithal) Zheng (1):
  RISC-V: add Bitmanip/Scalar Crypto parsing from DT

Samuel Ortiz (2):
  RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
  RISC-V: Implement archrandom when Zkr is available

 Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++
 arch/riscv/include/asm/archrandom.h   | 66 +++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h          |  9 ++++
 arch/riscv/include/asm/hwcap.h        | 11 +++++
 arch/riscv/include/uapi/asm/hwprobe.h | 11 +++++
 arch/riscv/kernel/cpu.c               | 11 +++++
 arch/riscv/kernel/cpufeature.c        | 30 ++++++++++++
 arch/riscv/kernel/sys_riscv.c         | 36 +++++++++------
 8 files changed, 193 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/archrandom.h


base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
-- 
2.41.0

