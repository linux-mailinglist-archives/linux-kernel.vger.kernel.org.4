Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC663AD64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiK1QOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiK1QOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:14:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8526E9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:35 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w37so5204798pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl4oXIilI+U2WdbMINVvxsI3t3kOFF7gSAjgWRgHySc=;
        b=e7h4lRGktftITaQLTFzJ3h3z+b6fKmtXgpcRtyQhPTmm9uRphG0oxaHiHWzgzLtviL
         eUIhtUYdUK0r+OYubjIc3jg8LG87sY/9qZkb1iajOrwzz4MsCw4n4O5WgbrrH9bE5ZqQ
         T+rtaLeWg3Hqwd3D9EvQx2fw/hZqf+zpfUIyQulIdVGjrRKXPFXHlvxx0y+yVLwdj2QR
         XRiUEP4c7u0nG0efttC7ROnQgmzXYNy5eSMIySr3SjKmlejYMgwmgGYiu8fJiVWBoQ/F
         M0B4dPCBacWkxn+baKI8GzQQdtzCiEFH6t2MteqQmQZCxdCGeCCqUJzI83Lmn7imf+i5
         11Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jl4oXIilI+U2WdbMINVvxsI3t3kOFF7gSAjgWRgHySc=;
        b=mff87+P/+hIBBCCs4Xgxzb/CWy+pe3oUncrYX4GwBsx9gQ3VujkD79M90JQpx3TZRj
         sdYT2puJs/6kgS472WVC5Wp7DZ8xsf8iw25TtbUntlo2bmlCh4ImnvL+lbqq63A5x+MP
         Fk7q9VTwE4xPDS7RCes7y7FAc4EOpDRBxvjAlkikDFKRjdweb9DkaGv5Pn/O9CB1qXu8
         qjxnaEb6e3ivYMfc/ZaSDoMtjzMEdnid9exjrR2QjpeCgyaU0Gun24c5klQ1dV3doetK
         isBOqjOnyNHFlssqeCztCS7kDccGSl9Vil35D1C1mfbf2+XKvf6wGU2To1XA4AprTO4A
         UtXA==
X-Gm-Message-State: ANoB5pnqdjB18EnWzeKXj5MWes6iE+PbTpFZRsOIoPpeRj2X6/r1SzMm
        /7XZ4ti6nqABL1yDuPRYB7n6GQ==
X-Google-Smtp-Source: AA0mqf4ALS2HgbUR5r91tr2m4UVS98vejcncYu6PiIk8G5B+Ls0u+YcI6binU/jGVUW6pDRGwzRq2Q==
X-Received: by 2002:a63:d18:0:b0:46e:b0e3:ee46 with SMTP id c24-20020a630d18000000b0046eb0e3ee46mr27574846pgl.622.1669652074732;
        Mon, 28 Nov 2022 08:14:34 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.0])
        by smtp.gmail.com with ESMTPSA id k145-20020a628497000000b0056246403534sm8210805pfd.88.2022.11.28.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:14:34 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/9] RISC-V KVM ONE_REG interface for SBI
Date:   Mon, 28 Nov 2022 21:44:15 +0530
Message-Id: <20221128161424.608889-1-apatel@ventanamicro.com>
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

This series does first does few cleanups/fixes (PATCH1 to PATCH5) and
adds ONE-REG interface for customizing the SBI interface visible to the
Guest/VM.

The testing of this series has been done with KVMTOOL changes in
riscv_sbi_imp_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_sbi_imp_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (9):
  RISC-V: KVM: Fix reg_val check in kvm_riscv_vcpu_set_reg_config()
  RISC-V: KVM: Remove redundant includes of asm/kvm_vcpu_timer.h
  RISC-V: KVM: Remove redundant includes of asm/csr.h
  RISC-V: KVM: Use switch-case in kvm_riscv_vcpu_set/get_reg()
  RISC-V: KVM: Move sbi related struct and functions to kvm_vcpu_sbi.h
  RISC-V: Export sbi_get_mvendorid() and friends
  RISC-V: KVM: Save mvendorid, marchid, and mimpid when creating VCPU
  RISC-V: KVM: Add ONE_REG interface for mvendorid, marchid, and mimpid
  RISC-V: KVM: Add ONE_REG interface to enable/disable SBI extensions

 arch/riscv/include/asm/kvm_host.h     |  16 ++-
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  14 ++-
 arch/riscv/include/uapi/asm/kvm.h     |  22 ++++
 arch/riscv/kernel/sbi.c               |   3 +
 arch/riscv/kvm/vcpu.c                 |  82 +++++++++++----
 arch/riscv/kvm/vcpu_sbi.c             | 145 +++++++++++++++++++++++---
 arch/riscv/kvm/vcpu_sbi_base.c        |  15 ++-
 arch/riscv/kvm/vcpu_sbi_hsm.c         |   1 -
 arch/riscv/kvm/vcpu_sbi_replace.c     |   1 -
 arch/riscv/kvm/vcpu_sbi_v01.c         |   1 -
 10 files changed, 244 insertions(+), 56 deletions(-)

-- 
2.34.1

