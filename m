Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4A64EEED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiLPQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiLPQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:21:55 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF429C9E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:21:53 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4523207wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6XB8sFEdgRyJHccqiCj1UYEgQGTrZTp9EBrE9hoiO8=;
        b=tMy2czpcjtMBFGplX2Fj7b6/e2vG/fUtkThLYkBLLkPglMspo20XEG9HwQEYmXVsLt
         eO4VB9DrpQAXgI4uETDdB5L/OKyiOCfwyhrPKjBWG9vZWeSVuhwtQJMlvHU/2IpavWrp
         X86zGFLZ9TwJ5mquI/XvqoT+hBZxioXiysJ9WYjdGkLQ0A19DgU7N8Uo9ghG0Qd5nVH2
         avk3pjckQjBuRBCwX+hZYyijMiEK5rNp4CRX+dgJr74DbLMoG9mt5xoCJerRFZgKGCj2
         DFdtGso5i2tLuoWGzkL+T0dKYB53/BOLKQbuzU66FYjo6xcL9xaZ+SzMMIyRzTiC79xj
         CTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6XB8sFEdgRyJHccqiCj1UYEgQGTrZTp9EBrE9hoiO8=;
        b=V+V1fNgY6f0pJsl49TYaRB5OUx3m0QyRkUwOQN8JKjKMQ0CR0dxLcEvRu6fHGPuJve
         lHgXryqPoscJkSTnnf5mjTgWC5kn0fSVDqv4/LShBPvliJgWJeD7tUJ7eChkkgt1BtpP
         +Oo74F1A0Trrd1WbedzmO2FjLsmGMX0TquxeWQflFGFpRHkJdIYlfaPxK7+yTYvmwS1q
         aDzmQ/R7ZZCdVW1anJrQoql93/H2rbpGvhBlZWc2wAJs4w0a/3xE1P9WAT6rIW9gErcP
         0n8rRcLY7Ug5RI2wIsvKnuuhAGmLqg7lSBtd8Qm7pssVDuE76aF2jqOTd0ua+q95Fwyv
         eZOw==
X-Gm-Message-State: ANoB5pkrhEHesa1JLzs3PLclW7D+7f4LLn0CE8TlkXiCfb+5oDWFLwTf
        rUDhy6uDDPI4pLYSMKkk9gU/sw==
X-Google-Smtp-Source: AA0mqf6XX4eU8Q/Q2iGuiyIeR9rQW9MHPz8fX+YXLEsXTUndzUIQSOASBsznrQAqHBCm+nCjyFr86A==
X-Received: by 2002:a05:600c:1e8a:b0:3d1:bd81:b1b1 with SMTP id be10-20020a05600c1e8a00b003d1bd81b1b1mr24959580wmb.18.1671207712025;
        Fri, 16 Dec 2022 08:21:52 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c221300b003a3170a7af9sm3027506wml.4.2022.12.16.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:21:51 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/6] RISC-V kasan rework
Date:   Fri, 16 Dec 2022 17:21:35 +0100
Message-Id: <20221216162141.1701255-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in patch 2, our current kasan implementation is intricate,
so I tried to simplify the implementation and mimic what arm64/x86 are
doing.

In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
instrumentation: all kasan configurations were tested on a large ubuntu
kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.

inline ubuntu config + uefi:
 sv39: OK
 sv48: OK
 sv57: OK

outline ubuntu config + uefi:
 sv39: OK
 sv48: OK
 sv57: OK

Actually 1 test always fails with KASAN_KUNIT_TEST that I have to check:
# kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan__test.c:1020
KASAN failure expected in "set_bit(nr, addr)", but none occurrred

Note that Palmer recently proposed to remove COMMAND_LINE_SIZE from the
userspace abi
https://lore.kernel.org/lkml/20221211061358.28035-1-palmer@rivosinc.com/T/
so that we can finally increase the command line to fit all kasan kernel
parameters.

All of this should hopefully fix the syzkaller riscv build that has been
failing for a few months now, any test is appreciated and if I can help
in any way, please ask.

Alexandre Ghiti (6):
  riscv: Split early and final KASAN population functions
  riscv: Rework kasan population functions
  riscv: Move DTB_EARLY_BASE_VA to the kernel address space
  riscv: Fix EFI stub usage of KASAN instrumented string functions
  riscv: Fix ptdump when KASAN is enabled
  riscv: Unconditionnally select KASAN_VMALLOC if KASAN

 arch/riscv/Kconfig                    |   1 +
 arch/riscv/kernel/image-vars.h        |   8 -
 arch/riscv/mm/init.c                  |   2 +-
 arch/riscv/mm/kasan_init.c            | 511 ++++++++++++++------------
 arch/riscv/mm/ptdump.c                |  24 +-
 drivers/firmware/efi/libstub/Makefile |   7 +-
 drivers/firmware/efi/libstub/string.c | 133 +++++++
 7 files changed, 435 insertions(+), 251 deletions(-)

-- 
2.37.2

