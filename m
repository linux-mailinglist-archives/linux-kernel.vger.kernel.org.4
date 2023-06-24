Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF273CACD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjFXMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFXMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:20:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFB2129
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso590375e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609255; x=1690201255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xcg93YWfCsaPVRmUBFr/zBQcP7IRrZtPOV8Dls38Ng=;
        b=dqg+BOsszxMGLdyTyEjFuHiwVXaciLVc6OPqDTS8RfHAF1bl38MZTWwQK2nO9jc7UB
         g1cMTjPqjTW0ueeubAnslmO5YjulLSxaLsRgCwCV0Bg47z1onVkor7SumyTcsenxXgO1
         F0P+GHxwq+7TiPvWLVUrZVNtbyeDk26wz4RTvb9VMIMvZ5fjeVGhZrtfI0vKQQplkUoy
         THVFJR5MX267e2XyyjG9zR/+8HfUulvWhiausMfRFBBRClFmZjXqcKS1mLXMMS8XQQJa
         JrlJlOE1hX0dWttLAPRJKfWYIm0Eds0eBbzQjyO0bYtAB10bl+CMLVX3VUjX21AMTxb/
         xpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609255; x=1690201255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xcg93YWfCsaPVRmUBFr/zBQcP7IRrZtPOV8Dls38Ng=;
        b=Ni3G+emAzh/LhAZ9SCFEbyzf8ooQTWCiwv46DEt1V6yrBw+Iky7gupKFrBfSuhxL5W
         Bc839O0Oo/Qh4tl2wF5yj9WGoz70WtLRghuIsZKrrJwHy+Atg6TJN9LFTbshp7scXSVY
         mbnmS36eqB99fEI7WfvZsaOA4iJ7RzUqhSGOkOnPpenHL168DwXUbYm77XAtoqbuO483
         7bDD1Gs4Ngun5JXfNCpKSj0M9n3NFBYBz+XPFuwDeHrlul60ZVCpykuDkfGwABKCWkwx
         hhrrbe6PH5Z50UAyaPhFSuVUzK36CHUEJCXf5N2B3sEjTXyeOEk08a6YQ1htU5GmIHmt
         SZmQ==
X-Gm-Message-State: AC+VfDwFf9wCPbQ+tyF738AH7cvxY86PSZkbmBOjx6h96b0bdzjGpSUu
        cw2SS/8hy+/e0r+g19aiTz+2kg==
X-Google-Smtp-Source: ACHHUZ6KLMNN73cFroD7E7poISffgTWCvzh26pvC4WZltuW4RPUobSZvIC+Xh+a/uBrfhhh6chbQyQ==
X-Received: by 2002:a05:600c:3c88:b0:3f9:bf0e:a312 with SMTP id bg8-20020a05600c3c8800b003f9bf0ea312mr10324537wmb.1.1687609254585;
        Sat, 24 Jun 2023 05:20:54 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:20:54 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] Add support to handle misaligned accesses in S-mode
Date:   Sat, 24 Jun 2023 14:20:43 +0200
Message-Id: <20230624122049.7886-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 61cadb9 ("Provide new description of misaligned load/store
behavior compatible with privileged architecture.") in the RISC-V ISA
manual, it is stated that misaligned load/store might not be supported.
However, the RISC-V kernel uABI describes that misaligned accesses are
supported. In order to support that, this series adds support for S-mode
handling of misaligned accesses, SBI call for misaligned trap delegation
as well prctl support for PR_SET_UNALIGN.

Handling misaligned access in kernel allows for a finer grain control
of the misaligned accesses behavior, and thanks to the prctl call, can
allow disabling misaligned access emulation to generate SIGBUS. User
space software can then be optimized by removing such access based on
SIGBUS generation.

This series relies on a SBI extension [1] allowing to request delegation of
the misaligned load/store traps to the S-mode software. This extension
has been submitted for review to the riscv tech-prs group.

This work was tested on spike since Qemu does transparently handles
misaligned access.

[1] https://lists.riscv.org/g/tech-prs/message/472i

Clément Léger (6):
  riscv: remove unused functions in traps_misaligned.c
  riscv: add support for misaligned handling in S-mode
  riscv: allow S-mode to handle misaligned traps
  riscv: add support for SBI misalignment trap delegation
  riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
  riscv: add floating point insn support to misaligned access emulation

 arch/riscv/include/asm/processor.h   |   9 +
 arch/riscv/include/asm/sbi.h         |  12 ++
 arch/riscv/kernel/Makefile           |   2 +-
 arch/riscv/kernel/fpu.S              | 118 ++++++++++++
 arch/riscv/kernel/process.c          |  20 ++
 arch/riscv/kernel/sbi.c              |  28 +++
 arch/riscv/kernel/traps.c            |   7 -
 arch/riscv/kernel/traps_misaligned.c | 276 ++++++++++++++++++++++-----
 8 files changed, 417 insertions(+), 55 deletions(-)

-- 
2.40.1

