Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5065566742E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjALOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjALODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:03:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEA52C45
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:03:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so20327653pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYAMfoPma/2nQAfBEMxDluOdt4GLLWOFoMahVP43u/U=;
        b=Mf/tlkmlfMBejawj3GBrzWk2JkrS5z/ymRrcMYXZYmNw+hoZMokkdmj1uePxiCQQ7T
         +pobWmWlxNHwvSUoRUoY3W6l3NQp2Uk1qIguf+oxGsk+OFIl4JcvmLE7W/nsyEezxITQ
         mL1Ewx1jQ4UrF+OvIRPnzUqTeoOyrZZ67vJuJCyA6Roj5fc4FGR+1bfUJKodVK6AWTtS
         YPgCGXwxLqtzi09IJIRC+pHbUkM7SIyDe5sXnDfagMc5IATQy9silgLk4f7/xJVyfKxl
         VJw2Im3boyYWeS2Qj6GHHxpfBvPXpZa1tFMcvsQUyv86tVJGlWxIW5K4nvf0XfT8MaeE
         CCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYAMfoPma/2nQAfBEMxDluOdt4GLLWOFoMahVP43u/U=;
        b=uwR4ZYJ9vbsoUvaygFCvY/hG7hEFAjK4eqj9PqkxCWU5VwTSQ3cJpWgZZikQSiATGi
         0KE/i/VmJP5K8lBCEFdE+x8ii/NtOsGDSIJ9jwklLmXu86yXZrbHhm29P+D3eA2+p3gu
         dmLfEGp2Okmh6rhpDrMpjybhxbYNZIbFJH6FHXBdJB+pZJ3+XTl19xtXjP+Bt2SzJJxw
         byPzGf58NXNkA/pT48ZsLnzIbgAE9qTbACgmXV4OU257L/OOLneEmBj8AM9PLnCOX9Kl
         JtweXFxUypDeHYqVrj0gdTsT94CxIBYIQL184an/MgB3wou3fhOKUMbhB7/6BrySEBR3
         fpRA==
X-Gm-Message-State: AFqh2kqpaAePvT+ENJHpOJdEffNL/GdUnhj5ZrcUhPJk4BrJAbrzRco9
        mcPKhf1SCN0C4qqiewbHWlhBow==
X-Google-Smtp-Source: AMrXdXslITcQTVnMcKFsd09fLItgDivV8yXOl4rnwDD026pL3dkblJOdaOcQoIfmj0GfXrGwcPfYHw==
X-Received: by 2002:a17:902:a3c1:b0:193:2a8c:28cb with SMTP id q1-20020a170902a3c100b001932a8c28cbmr14480469plb.21.1673532199587;
        Thu, 12 Jan 2023 06:03:19 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001925016e34bsm12351455plg.79.2023.01.12.06.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:03:18 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/7] RISC-V KVM virtualize AIA CSRs
Date:   Thu, 12 Jan 2023 19:32:57 +0530
Message-Id: <20230112140304.1830648-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
https://github.com/avpatel/kvmtoo.git

These patches can also be found in the riscv_kvm_aia_csr_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (7):
  RISC-V: Add AIA related CSR defines
  RISC-V: Detect AIA CSRs from ISA string
  RISC-V: KVM: Drop the _MASK suffix from hgatp.VMID mask defines
  RISC-V: KVM: Initial skeletal support for AIA
  RISC-V: KVM: Add ONE_REG interface for AIA CSRs
  RISC-V: KVM: Virtualize per-HART AIA CSRs
  RISC-V: KVM: Implement guest external interrupt line management

 arch/riscv/include/asm/csr.h      | 101 ++++-
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
 15 files changed, 1072 insertions(+), 53 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_aia.h
 create mode 100644 arch/riscv/kvm/aia.c

-- 
2.34.1

