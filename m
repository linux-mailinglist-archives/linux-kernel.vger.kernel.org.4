Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C478873C3FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFWWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFWWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:20:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD12940
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:20:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b55643507dso8578765ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687558835; x=1690150835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZx6+oVqWxI1dOKVQNClxhZWPvsRArizB5EStMZMnN8=;
        b=f2c2+uJXWg2ggdJELahXkTmw8NS0Vlee1pomXdIE0kk8Lt8DJlKSY5iypXKPDDOs6K
         wrDqPIXgzwx+nbXjr83KbOiy5FLoQVFGt+OG4ZVNqITEz/nDcEx5/hwJ2vNaf42EuDAm
         K+n/0rjM6Ay9V7yM0s9JnvSM9slynHhVVZQAgiIqMW7vU3ap7cE5JOU74jEslDFRAqUM
         XaPG2ToBREBysGAUDnSjCZ90N0u8/k2GCoupIDmn1EUyPgF3Aq0Vaz+D3WNuYnbe+n1p
         TuU7AUCIfSXyAgDZPqgRQyjOgV2srBzC3pX/ZaYcMNi8bwn6/wIA7wojudNGkdcCF5YM
         d8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558835; x=1690150835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZx6+oVqWxI1dOKVQNClxhZWPvsRArizB5EStMZMnN8=;
        b=BAfkOvGmXBO0C3QhjkSzaE5opjADmrK3UuMPHyM/vshvZnMtdt0aQtJgyqSWaTJ5yN
         eZ+nPI8hWT1SUlgjedEkqjMZlzYWvKCpLbMTodvqOeHqP78Neu6BaN+CRrhmzqNDkdKl
         y5UFa2rb0Iuj0sXt69a8sDupHawokjmnEGFS6McpA3iRHk0shtj6Bzpfubezu/stQtk3
         dvmxzhVrJCqj0lEInBva+Mm6GIf6YPHxoyyd+mHPPz8LsCBAZYCZZ0jSaq7IunoAhR5B
         uOBiglbTYbXrdpST6/WvQVB4RNvERVlfdY+O+dHY/nzK+pALR3fP2D81R8xdmvTOx7TP
         FTmQ==
X-Gm-Message-State: AC+VfDwPpb55vXYl0DkM5uDghdnFTcehuPn4s1KEREViOYKPY0tfNSas
        XcEFcA04TiOkZzVGLyPYZlW25g==
X-Google-Smtp-Source: ACHHUZ4KpR/ga06S8BRcXk1g7+jvLR7eSUaEmxlWlNWtwv8HuPbty6CowrJ27XQLeqFEsWiVPb8qDQ==
X-Received: by 2002:a17:902:dac3:b0:1b6:8b70:328f with SMTP id q3-20020a170902dac300b001b68b70328fmr462343plx.6.1687558834840;
        Fri, 23 Jun 2023 15:20:34 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b001a80ad9c599sm35535plb.294.2023.06.23.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:20:34 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Simon Hosie <shosie@rivosinc.com>, Evan Green <evan@rivosinc.com>,
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
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] RISC-V: Probe for misaligned access speed
Date:   Fri, 23 Jun 2023 15:20:14 -0700
Message-Id: <20230623222016.3742145-1-evan@rivosinc.com>
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
of algorithms). On my THead C906, I found measurements to be stable
across several reboots, and looked like this:

[    0.047582] cpu0: Unaligned word copy 1728 MB/s, byte copy 402 MB/s, misaligned accesses are fast

I don't have a machine where misaligned accesses are slow, but I'd be
interested to see the results of booting this series if someone did.



Evan Green (2):
  RISC-V: Probe for unaligned access speed
  RISC-V: alternative: Remove feature_probe_func

 Documentation/riscv/hwprobe.rst      |  8 +--
 arch/riscv/errata/thead/errata.c     |  8 ---
 arch/riscv/include/asm/alternative.h |  5 --
 arch/riscv/include/asm/cpufeature.h  |  2 +
 arch/riscv/kernel/Makefile           |  1 +
 arch/riscv/kernel/alternative.c      | 19 -------
 arch/riscv/kernel/copy-noalign.S     | 71 +++++++++++++++++++++++++
 arch/riscv/kernel/copy-noalign.h     | 13 +++++
 arch/riscv/kernel/cpufeature.c       | 78 ++++++++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c          |  3 +-
 10 files changed, 171 insertions(+), 37 deletions(-)
 create mode 100644 arch/riscv/kernel/copy-noalign.S
 create mode 100644 arch/riscv/kernel/copy-noalign.h

-- 
2.34.1

