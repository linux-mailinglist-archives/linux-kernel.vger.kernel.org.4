Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246C6CD144
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjC2Exi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2Exg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:53:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E02D46
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:53:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso10646114wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680065613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo0pBz6wf3kyiWYQ9fjYRy+Wu64GhON7Bmz6ajIouOI=;
        b=dT3vR+5BCE0d2cD8qefotDYbxWqPr15i/uHQCi1YF886RpaVStPW6F27dSe9spSiBr
         nSo/S/VtEpndi0j2dD/H1lMx8HaUY3qjH1EQ0q68rn++tg5lbeV9YItR3H0UmqtidEr4
         GKRKJRhc5o+iNCRWeEZHO5kblPX5hYBdEfCMio2bAlbhW/sSelRb5v3N5WHsZkyfM5Gj
         becrsvXvlUJx1Mi33oacQC/hIR35TWFoCcR6S6AhtBxCZ8C9wt3Pf9FlTe+EOUXVxDTu
         KpQUXUSJ49y/XaC9UKkb06EVDpFkbGgNuj1x5g1oHnS0J3RO9jlYM2uhXRKwop3WEa/o
         XeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680065613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo0pBz6wf3kyiWYQ9fjYRy+Wu64GhON7Bmz6ajIouOI=;
        b=HBFjJMAdcLvprPpHpOcZg/3vwwYaX2tqyTsbAYP9eWh/8Zae1zRHNURGx4bjIQPnVu
         ny8whNy029LGjPsYcGfWG99A7vc94RyrNzG16gpxMk1ox+c3arp5fxkEug8GxaffrfuU
         epDzP0fy1misjzzYljbBXFbdy/UGAJidAtAtS51xrnJqgQHVeqAZqJnOlTVBgHAp7Z8A
         P6XEK2FeuNfdGRUPMObLO6FU5zLSbNN/WXgufiytz7466iEKMHGzAXb5PUNHoj5ogK8K
         IIbJiFpKQMestJ8T9FJKWe6UqDY6Fpg8gh7y96TzdlJZhdhHVy1pjUDBQzKmUImmZq4M
         8MYQ==
X-Gm-Message-State: AO0yUKXI/UksTV8TFYrkGSTsNDCV7tp96KOvlZ5ieN/uvGfxQUI3hh5N
        Gq9E+UaC3OyCWpUkp63iRaXhZQ==
X-Google-Smtp-Source: AK7set9J+TBd/c5WkVGXfbeJnMQvLgoUo8YsvVH4bgNXSXp/VtTgvyfk23V2+90Kw1vfaq4rCqyaVA==
X-Received: by 2002:a7b:c850:0:b0:3ed:29db:cb80 with SMTP id c16-20020a7bc850000000b003ed29dbcb80mr13580773wml.18.1680065613023;
        Tue, 28 Mar 2023 21:53:33 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o6-20020a1c7506000000b003ee63fe5203sm757591wmc.36.2023.03.28.21.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 21:53:32 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v9 0/6] Introduce 64b relocatable kernel
Date:   Wed, 29 Mar 2023 06:53:23 +0200
Message-Id: <20230329045329.64565-1-alexghiti@rivosinc.com>
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

After multiple attempts, this patchset is now based on the fact that the
64b kernel mapping was moved outside the linear mapping.

The first patch allows to build relocatable kernels but is not selected
by default. That patch is a requirement for KASLR.
The second and third patches take advantage of an already existing powerpc
script that checks relocations at compile-time, and uses it for riscv.

This patchset is rebased on top of:

riscv: Use PUD/P4D/PGD pages for the linear mapping
(https://patchwork.kernel.org/project/linux-riscv/list/?series=733603)
base-commit-tag: v6.3-rc1

Changes in v9:
  * Fix gcc/llvm compilation errors by adding patch 1, thanks to Bjorn
  * Move a patch to move rela.dyn outside of init (patch 2): it is a
    separate patch to clearly explain why
  * To effectively move rela.dyn to init, we need to add patch 6: separate patch since we may be
    able at some point to revert (along with patch 2).
  * Add a lot of orphan sections to the linker script

Changes in v8:
  * Fix UEFI boot by moving rela.dyn section into the data so that PE/COFF
    loader actually copies the relocations too
  * Fix check that used PGDIR instead of PUD which was not correct
    for sv48 and sv57
  * Fix PE/COFF header data size definition as it led to size of 0

Changes in v7:
  * Rebase on top of v5.15
  * Fix LDFLAGS_vmlinux which was overriden when CONFIG_DYNAMIC_FTRACE was
    set
  * Make relocate_kernel static
  * Add Ack from Michael

Changes in v6:
  * Remove the kernel move to vmalloc zone
  * Rebased on top of for-next
  * Remove relocatable property from 32b kernel as the kernel is mapped in
    the linear mapping and would then need to be copied physically too
  * CONFIG_RELOCATABLE depends on !XIP_KERNEL
  * Remove Reviewed-by from first patch as it changed a bit

Changes in v5:
  * Add "static __init" to create_kernel_page_table function as reported by
    Kbuild test robot
  * Add reviewed-by from Zong
  * Rebase onto v5.7

Changes in v4:
  * Fix BPF region that overlapped with kernel's as suggested by Zong
  * Fix end of module region that could be larger than 2GB as suggested by Zong
  * Fix the size of the vm area reserved for the kernel as we could lose
    PMD_SIZE if the size was already aligned on PMD_SIZE
  * Split compile time relocations check patch into 2 patches as suggested by Anup
  * Applied Reviewed-by from Zong and Anup

Changes in v3:
  * Move kernel mapping to vmalloc

Changes in v2:
  * Make RELOCATABLE depend on MMU as suggested by Anup
  * Rename kernel_load_addr into kernel_virt_addr as suggested by Anup
  * Use __pa_symbol instead of __pa, as suggested by Zong
  * Rebased on top of v5.6-rc3
  * Tested with sv48 patchset
  * Add Reviewed/Tested-by from Zong and Anup

Alexandre Ghiti (6):
  riscv: Prepare EFI header for relocatable kernels
  riscv: Move .rela.dyn outside of init to avoid empty relocations
  riscv: Introduce CONFIG_RELOCATABLE
  powerpc: Move script to check relocations at compile time in scripts/
  riscv: Check relocations at compile time
  riscv: Use --emit-relocs in order to move .rela.dyn in init

 arch/powerpc/tools/relocs_check.sh  | 18 ++--------
 arch/riscv/Kconfig                  | 14 ++++++++
 arch/riscv/Makefile                 |  7 ++--
 arch/riscv/Makefile.postlink        | 49 ++++++++++++++++++++++++++
 arch/riscv/boot/Makefile            |  7 ++++
 arch/riscv/include/asm/set_memory.h |  3 ++
 arch/riscv/kernel/efi-header.S      | 19 ++++++++--
 arch/riscv/kernel/vmlinux.lds.S     | 26 ++++++++++----
 arch/riscv/mm/Makefile              |  4 +++
 arch/riscv/mm/init.c                | 54 ++++++++++++++++++++++++++++-
 arch/riscv/tools/relocs_check.sh    | 26 ++++++++++++++
 scripts/relocs_check.sh             | 20 +++++++++++
 12 files changed, 218 insertions(+), 29 deletions(-)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh

-- 
2.37.2

