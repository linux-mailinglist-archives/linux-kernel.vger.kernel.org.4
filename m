Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C773E9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjFZSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjFZSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:41:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB96CC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:41:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8063aa2e1so7087865ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687804912; x=1690396912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc8gTI3W4RW6dHKji0wpJv9Z8xook1q3V9GncqmxBNs=;
        b=iOnzyINlILniQP2HRPivDFLMjVUVk2QQghS1NdKbwT8rRo+aVuMr+sfhItnycltrNm
         +n6dJOvm68rZFp2EiiEnVADw/GZuH7oKvqN5Sq39xJfzgSMC4/5mT/TAx3BStqepAQXQ
         Sg4Dn+fhfxgYQwc18AdfeP92dYRiA++NH4Fi85nAY0RVNSlIGXaoGVPilka2ylzoQiOL
         QFv51RKurWg4uRW70Xv1lzgmSMw2Ip/+GK4UUgD+U9SZlbfDzwzEPmEvWFZ81IT+N/0w
         PNWNpwtVOFrYPj4+2nZkY4bDzIDrdYhdHQSuBH1u4hj92twmPTY8PNZWxTnXDJ34Xi9t
         MkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804912; x=1690396912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc8gTI3W4RW6dHKji0wpJv9Z8xook1q3V9GncqmxBNs=;
        b=kJFUEg+BjMY6yFmmm6V4EfohtX8tyf9aaxuu+xbj2mDGh40wQGzVYF88y4b1n0KHiT
         gy8nysyWywnPC8Cw4mKhk+2+JyMv0snKtnm4KEQ6DUUj/Lxq19k63CmvURXP3Q4otvOF
         CXG4dWT663cbjAoejSYhoiBTcknlm7fVPkZSztnsKngkfVt74VROiBy4FMADqB2Enwet
         WzmDf3nRW5le1MFX5kpRi+oZEEDajvG7I4O6jsZ1hWUlaGH4Q0cu/tD9v8Lxw61i2Cqg
         I0Tm+DHQJsULA7ve5zDirvcBX2lB/H+PSNCGFEgyigFSddrVi5nKpm2yhGvCe54Zqyf6
         p+bw==
X-Gm-Message-State: AC+VfDzTWyD4yPLPWBf/iM0Y6b7wSTIbJVjZzaJ3/BQBZO0iIeO6jArb
        gEvmJYZKRdLSBCeiHyp+/GbWvw==
X-Google-Smtp-Source: ACHHUZ6kF7UCHGB/S7z47aVb3jHXMmBM7Gkc9O6kvyrBL6waC3X7eaZQjrosczNmx+jqkRnxb00mxg==
X-Received: by 2002:a17:902:be09:b0:1b3:d6c8:7008 with SMTP id r9-20020a170902be0900b001b3d6c87008mr3314468pls.57.1687804912000;
        Mon, 26 Jun 2023 11:41:52 -0700 (PDT)
Received: from ghost.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709029b8600b001b682336f66sm4499842plp.55.2023.06.26.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:41:51 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     charlie@rivosinc.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:EXEC & BINFMT API),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 0/2] Restrict address space for sv39,sv48,sv57
Date:   Mon, 26 Jun 2023 11:36:02 -0700
Message-Id: <20230626183611.40479-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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

Make sv39 the default address space for mmap as some applications
currently depend on this assumption. The RISC-V specification enforces
that bits outside of the virtual address range are not used, so
restricting the size of the default address space as such should be
temporary. A hint address passed to mmap will cause the largest address
space that fits entirely into the hint to be used. If the hint is less
than or equal to 1<<38, a 39-bit address will be used. After an address
space is completely full, the next smallest address space will be used.

Documentation is also added to the RISC-V virtual memory section to explain
these changes.

Charlie Jenkins (2):
  RISC-V: mm: Restrict address space for sv39,sv48,sv57
  RISC-V: mm: Update documentation and include test

 Documentation/riscv/vm-layout.rst             | 20 ++++++++
 arch/riscv/include/asm/elf.h                  |  2 +-
 arch/riscv/include/asm/pgtable.h              | 21 ++++++--
 arch/riscv/include/asm/processor.h            | 41 +++++++++++++---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
 .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
 7 files changed, 144 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c


base-commit: eef509789cecdce895020682192d32e8bac790e8
-- 
2.34.1

