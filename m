Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978067F585
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjA1H1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjA1H1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:27:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3C7D9F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:27:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lp10so6684418pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIp0ncMCm62OCfgMvP1/ZtcZEYlq9GSVvwzMRdDzsxc=;
        b=WwmJCQbfdSpysGWAhddrN6xzvrr5sfTaMCaViq0MVeVN65lEA/K0kIbWOiJ5mx00sf
         9sqz+ULl8iPa0yd67yMO+U2/mew/CeqDuS3f7o4cI2sBgRqx+OT9UxOQn/+M3B015gf9
         ZvGN2si8+FKg6JafIeg2mvKJ+8gLA/w4AD8qRBvruTPhZMTyfioTqC7XOwLb87Kqcaas
         edsL7+csyJAySV4Q8Z5WH5LtnL5jkYOvSMNGQsxJfwAcvtjdNwsuGXO7Rqa4or19sFAM
         NmQv7Zt2Z0yBUQ+ce6VtIY49NShocrenZCvCsryo8pynAFdbm7m9YMDKewvXewYPQ2uU
         ik4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIp0ncMCm62OCfgMvP1/ZtcZEYlq9GSVvwzMRdDzsxc=;
        b=yWHye72Cn3/XIr0eW0/rhTmztO/gxA4U5Df8f7dcXzWndxTdmmm9Ru8KsatBoblDoF
         ZKjepfEnOY4dfQepje27nkyPneF8sQIS9qnZm3jcmZKsWrNhkTPKbKHaVI5X2cTh0Etd
         +3DAXJGGgsUFsU/RktZ9yatMNf/gbCILXp8gqibNnZUq1pcsoiAgm5TSRva1atpR+fKF
         CqvvuQv9T1yRlNWx3G/dJ7PO3hqpSoUommCnVisEqLttbqEHmKXkvo1z6qOr7sSkr11/
         EV8fUJcJLzoDjxPYq3OKEOZlATBlYPIFHEF/4eRdXQVwUF7s+gA6Th4qiceYXpmpKa2n
         d2uA==
X-Gm-Message-State: AO0yUKUYl5cwHLfKx8zNhAzrvzuD4rYYEiE4k6A2Mse8UJnJYZlTJT7S
        bnRdu6SYFinR58E4HndMm/lWug==
X-Google-Smtp-Source: AK7set/JZk8OaVhYXMDTxZz7NE3fu1CtJ7X9nXADGQO9RjFWpzFvGeSfgyEKTn7iJvyPiZNUK7Pzxw==
X-Received: by 2002:a17:903:230b:b0:196:13cd:a49 with SMTP id d11-20020a170903230b00b0019613cd0a49mr19370623plh.27.1674890866753;
        Fri, 27 Jan 2023 23:27:46 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00194ac38bc86sm753132plb.131.2023.01.27.23.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 23:27:46 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/7] RISC-V KVM virtualize AIA CSRs
Date:   Sat, 28 Jan 2023 12:57:30 +0530
Message-Id: <20230128072737.2995881-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

The RISC-V AIA specification is now frozen as-per the RISC-V international
process. The latest frozen specifcation can be found at:
https://github.com/riscv/riscv-aia/releases/download/1.0-RC1/riscv-interrupts-1.0-RC1.pdf

This series implements first phase of AIA virtualization which targets
virtualizing AIA CSRs. This also provides a foundation for the second
phase of AIA virtualization which will target in-kernel AIA irqchip
(including both IMSIC and APLIC).

The first two patches are shared with the "Linux RISC-V AIA Support"
series which adds AIA driver support.

To test this series, use AIA drivers from the "Linux RISC-V AIA Support"
series and use KVMTOOL from the riscv_aia_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_aia_csr_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Addressed from Drew and Conor in PATCH1
 - Use alphabetical ordering for SMAIA and SSAIA enum in PATCH2
 - Use GENMASK() in PATCH3

Anup Patel (7):
  RISC-V: Add AIA related CSR defines
  RISC-V: Detect AIA CSRs from ISA string
  RISC-V: KVM: Drop the _MASK suffix from hgatp.VMID mask defines
  RISC-V: KVM: Initial skeletal support for AIA
  RISC-V: KVM: Add ONE_REG interface for AIA CSRs
  RISC-V: KVM: Virtualize per-HART AIA CSRs
  RISC-V: KVM: Implement guest external interrupt line management

 arch/riscv/include/asm/csr.h      | 107 ++++-
 arch/riscv/include/asm/hwcap.h    |   8 +
 arch/riscv/include/asm/kvm_aia.h  | 137 +++++++
 arch/riscv/include/asm/kvm_host.h |  14 +-
 arch/riscv/include/uapi/asm/kvm.h |  22 +-
 arch/riscv/kernel/cpu.c           |   2 +
 arch/riscv/kernel/cpufeature.c    |   2 +
 arch/riscv/kvm/Makefile           |   1 +
 arch/riscv/kvm/aia.c              | 624 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/main.c             |  14 +
 arch/riscv/kvm/mmu.c              |   3 +-
 arch/riscv/kvm/vcpu.c             | 185 +++++++--
 arch/riscv/kvm/vcpu_insn.c        |   4 +-
 arch/riscv/kvm/vm.c               |   4 +
 arch/riscv/kvm/vmid.c             |   4 +-
 15 files changed, 1075 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_aia.h
 create mode 100644 arch/riscv/kvm/aia.c

-- 
2.34.1

