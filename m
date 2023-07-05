Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A674897A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjGEQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjGEQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:48:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEF10EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:48:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262e839647eso5159378a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688575721; x=1691167721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hP9DbBA1q7ePE4MjE20bv2ZQsjinvRoBDENG1RHrkc=;
        b=dN16GTJyFnx0CAdebrX0ihc9B+hOMoFybI8IewfRhaLSmnhpMkKjk+9jMWpnYCH2nO
         abZ8bieLyGIv/gBw547X4lutvAnIFkaEJOxHjM7sLCugaoYj1sNtX0sQiPttz9zUtEF4
         CjDCCW4autZVoak/I0EriHUxIgDGxz1avBoIhCt2QwLwUPcWABSd61YiMXFhhv6qgVuH
         D+mpSlhVmLZCk0iGIjRlFGBxcqXh6KlLn9P2lBSvYVEOl8eP9pFD+/Q/qGMFU78VD25T
         KzdJYFBbOvoWl+GnGsp0LKG4zRhoiTz1MD9oiijr7Q3Fzoo8Ti3Nj3VgDwxn2lTk7iVy
         shJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688575721; x=1691167721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hP9DbBA1q7ePE4MjE20bv2ZQsjinvRoBDENG1RHrkc=;
        b=jIPmP6eBvuBVAwr6GU4cNHqRrnJfC0zaFlxJEzB/xVHHyOHLAxBVe56DHkdWxgzecO
         0zyzdxuOgyF+AZPz65BrlUpiAXz1k9rquPbvai3mi+dzVBPyaFZPdXEIGcZYSQAnfSQA
         BsUzYT66/8rkTn3vfwpj9ljsvfYjHTOI/+chbhbRp6ySpxYe4pnvaIzgjQI7Qa8xI0E1
         /gy1rWwibzT1Et+ZtBI/S9GemjOu9XQ8LMvOzFbbfPNXNt39cFcVLi44iQDD17NtPV2U
         AtIjp+KWYYsxBWLXmQpLDxNwCKygP0KzgMyxpfyyqsa+XVpB6Hdwy1n0EQiP/S055wFD
         6cxw==
X-Gm-Message-State: ABy/qLYNu8QcNJTsK1OuAEgIc8FYxUGIJzMY9+OM6ioo67mvyHLXDqHR
        SNNEO1mLD5VQ8fxetYnvZ1x3Sw==
X-Google-Smtp-Source: APBJJlG4f3hzZqWilYuZ0BZOZWFUVy3ilbVJW12BSxOtJhU9JDflowuFeO6SvAVOY85YSbOMHbJLJw==
X-Received: by 2002:a17:90b:156:b0:262:ea30:2cc3 with SMTP id em22-20020a17090b015600b00262ea302cc3mr16732080pjb.2.1688575720894;
        Wed, 05 Jul 2023 09:48:40 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090ace1500b00263f85b6a35sm1311431pju.29.2023.07.05.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:48:40 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Simon Hosie <shosie@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] RISC-V: Probe for misaligned access speed
Date:   Wed,  5 Jul 2023 09:48:31 -0700
Message-Id: <20230705164833.995516-1-evan@rivosinc.com>
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


The current setting for the hwprobe bit indicating misaligned access
speed is controlled by a vendor-specific feature probe function. This is
essentially a per-SoC table we have to maintain on behalf of each vendor
going forward. Let's convert that instead to something we detect at
runtime.

We have two assembly routines at the heart of our probe: one that
does a bunch of word-sized accesses (without aligning its input buffer),
and the other that does byte accesses. If we can move a larger number of
bytes using misaligned word accesses than we can with the same amount of
time doing byte accesses, then we can declare misaligned accesses as
"fast".

The tradeoff of reducing this maintenance burden is boot time. We spend
4-6 jiffies per core doing this measurement (0-2 on jiffie edge
alignment, and 4 on measurement). The timing loop was based on
raid6_choose_gen(), which uses (16+1)*N jiffies (where N is the number
of algorithms). By taking only the fastest iteration out of all
attempts for use in the comparison, variance between runs is very low.
On my THead C906, it looks like this:

[    0.047563] cpu0: Ratio of byte access time to unaligned word access is 4.34, unaligned accesses are fast

Several others have chimed in with results on slow machines with the
older algorithm, which took all runs into account, including noise like
interrupts. Even with this variation, results indicate that in all cases
(fast, slow, and emulated) the measured numbers are nowhere near each
other (always multiple factors away).


Changes in v2:
 - Explain more in the commit message (Conor)
 - Use a new algorithm that looks for the fastest run (David)
 - Clarify documentatin further (David and Conor)
 - Unify around a single word, "unaligned" (Conor)
 - Align asm operands, and other misc whitespace changes (Conor)

Evan Green (2):
  RISC-V: Probe for unaligned access speed
  RISC-V: alternative: Remove feature_probe_func

 Documentation/riscv/hwprobe.rst      |  11 ++-
 arch/riscv/errata/thead/errata.c     |   8 ---
 arch/riscv/include/asm/alternative.h |   5 --
 arch/riscv/include/asm/cpufeature.h  |   2 +
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/alternative.c      |  19 -----
 arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++
 arch/riscv/kernel/copy-unaligned.h   |  13 ++++
 arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c          |   3 +-
 10 files changed, 198 insertions(+), 39 deletions(-)
 create mode 100644 arch/riscv/kernel/copy-unaligned.S
 create mode 100644 arch/riscv/kernel/copy-unaligned.h

-- 
2.34.1

