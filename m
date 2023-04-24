Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165C6D26E2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCaRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCaRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:45:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFB2221C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:45:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q206so13882594pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680284757; x=1682876757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoHEj/XaVMrYODDwsIv3pUiYWBKTCAt/9DW5FF1yPGU=;
        b=lH/bQ9n9gJdd02yFVctKPMa86VHkqXM8Ocliwa6VG+FvFHiYgR5AAZt11nq31SwgZP
         O7EgeY84Ar56xdrVYLkB7bIs6ZpHGXA4CQB7i+ZkeNbDoKJioB3FXKIY35z1hKrpT/r0
         Ch7QkjOtaqVc8mvf2LgY6cCPM05vXWSPjOGyRfPSdbvbMlI5ZOdbSw3kMwhUmaeJUUQU
         4zT7bEn29fjEU7/C7BsieueLxeezVbV/BwgJaW2HdbKD2O+a5EuB92fbQXT2M3oVlyoD
         x3v9tEhCjru8IQlPGWVhUfnKwwGdmNm+5e9338klW4+cN6L3WPAuAIjpkksZcCAeWVAA
         B2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284757; x=1682876757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoHEj/XaVMrYODDwsIv3pUiYWBKTCAt/9DW5FF1yPGU=;
        b=jS/9GR/nQBY0G0etE7McAXyxmgg4ge3n83uJNN30u9SZT/g0Lp3IikEhnZzzNxIACh
         /udft+wKNBngTipCwcWYmhUDkrvHsWf1GG0VZ7gN79R05Es1+66hCrOyCctIXAGVhvqa
         2lQ55DmH0K2ij4uCIP68Swvuv/16xSAyU/G4/SuVpTmzSmWMrnv6zQeWv+Udbwl0gj0x
         6hmqaX7vM8Sf3g5vOqoChhKwd9epAPaj/7v74pMu4e7UmAntrHbwJP5OOxH9h6gxR1WX
         otvmv4aSz7c9tZR3byfyl121WA3VMiMTFvsyvMVhX7sCo2II9YV05lNntuD8o5KJV/4m
         oZ3Q==
X-Gm-Message-State: AAQBX9eF0CbVsW55Spm0Uge2yZou2G4NKyJeTxAPEbNDERXh2Fsp6vU7
        HUUvZRzZ+DClCRRaFIiFlOeVcQ==
X-Google-Smtp-Source: AKy350YhbyoJvszMMJ4xz2sGJ4p6nihEv5ylZR69ZEbPfkWDlUNtsyg1Ouc5zPXjIr9MMcNF7WElow==
X-Received: by 2002:a62:524b:0:b0:62d:e95d:51a0 with SMTP id g72-20020a62524b000000b0062de95d51a0mr2439275pfb.13.1680284756986;
        Fri, 31 Mar 2023 10:45:56 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b005ae02dc5b94sm2043143pfe.219.2023.03.31.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:45:56 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 0/1] RISC-V KVM ONE_REG interface for SBI
Date:   Fri, 31 Mar 2023 23:15:41 +0530
Message-Id: <20230331174542.2067560-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first does few cleanups/fixes (PATCH1 to PATCH5) and adds
ONE-REG interface for customizing the SBI interface visible to the
Guest/VM.

The testing of this series has been done with KVMTOOL changes in
riscv_sbi_imp_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_sbi_imp_v4 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Added missing switch case for KVM_REG_RISCV_SBI_EXT in
   kvm_riscv_vcpu_get_reg().
 - Return a bit mask of disabled extensions for
   GET(KVM_REG_RISCV_SBI_MULTI_DIS).

Changes since v2:
 - Improve ONE_REG interface to allow enabling/disabling multiple SBI
   extensions in one ioctl().

Changes since v1:
 - Dropped patches 1 to 8 since these are already merged.
 - Rebased on Linux-6.3-rc4

Anup Patel (1):
  RISC-V: KVM: Add ONE_REG interface to enable/disable SBI extensions

 arch/riscv/include/asm/kvm_vcpu_sbi.h |   8 +-
 arch/riscv/include/uapi/asm/kvm.h     |  32 ++++
 arch/riscv/kvm/vcpu.c                 |   4 +
 arch/riscv/kvm/vcpu_sbi.c             | 247 ++++++++++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_base.c        |   2 +-
 5 files changed, 274 insertions(+), 19 deletions(-)

-- 
2.34.1

