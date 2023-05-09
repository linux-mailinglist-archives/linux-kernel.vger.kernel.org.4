Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC676FCDC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjEISZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEISZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:25:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC8E1738
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:25:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439df6c268so3683469b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683656710; x=1686248710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tiMJc6QGOIbW1ytG7Lyazrjjzo/0vM14MGeeRHZgEW8=;
        b=fbQc0hUM5ybA69Dr2SckUQkDr77wpzfeOfb3TXFobM3XKEHfKC2upOsCQALRk3QaW/
         gvMQXJFKx5N+z7jc2Rj8+q/2swBgmO76zQD7v7/mJ2qtGeD7rJsbj0q4K56UWEpFC7G/
         PQUSWRqBLvUNVY0POYD3d2LFhJrHrSX5OiPEOZKoTXJnSsxuXlXPHMiuXXdlKHGsEXck
         tBPDk7AnFxLw3LzcX1y2eI5Wh9w38lToEOmFsPvvi9XVm0haXPWkEzwX4iWMd/jeVE9p
         rw5jtQ901W+HinyEYtJgaxNNoWE9VBc43hE6/FkOG3VSXaNbYt49NmPNqOA1E5aHkE+7
         BSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656710; x=1686248710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiMJc6QGOIbW1ytG7Lyazrjjzo/0vM14MGeeRHZgEW8=;
        b=PsZHHNpCgq5XidNMidxUUv6ctY+RaNyTD90xhovMShu/V97I7VcRy7bu3sjQVzKplE
         xTLtcRT4UQnAdBTZoO8YyJy8kdlQsNoNHIcRHx8FRRDoC3ofUno+vTMs0jKQKJQYq4y3
         aDS1sMcQeZ95XrG46vqwsIKNImJDHRze0DNIzPix8ZAyCqzmJv8uPQUwiZKx2IiPDCKY
         HZvCEqz032C1Emmblkg53FUUn1v2C/fq+11/ya3lHifMQ7BeoX7oXttieZre02agOr0M
         pNRiSbxxOIbQauiA9ya0ZfQk9+LpZ2egZYajAl2d+GVfJRQxS5H9SEAuc3XO8rGzWnvp
         tthg==
X-Gm-Message-State: AC+VfDzyivXbZHCN43fnSBYdn+l8mJ985l7Eg7twHVJKvzqALFbMF6hr
        /27ngKTjcltO9alFZ6FiTxJhFozVpFLD9/Pw7Ns=
X-Google-Smtp-Source: ACHHUZ4ODHbQUf1wCIXJxzh4KKsoJdZOKpptonZyV5itOo5QhlMO4+MHW+x44Bh7MrqfPYzqlby1yg==
X-Received: by 2002:a05:6a20:7f85:b0:100:4a2f:4777 with SMTP id d5-20020a056a207f8500b001004a2f4777mr9605643pzj.38.1683656710253;
        Tue, 09 May 2023 11:25:10 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id q12-20020a63cc4c000000b0051eff0a70d7sm1633559pgi.94.2023.05.09.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:25:09 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] RISC-V: Export Zba, Zbb to usermode via hwprobe
Date:   Tue,  9 May 2023 11:25:00 -0700
Message-Id: <20230509182504.2997252-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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


This change detects the presence of Zba, Zbb, and Zbs extensions and exports
them per-hart to userspace via the hwprobe mechanism. Glibc can then use
these in setting up hwcaps-based library search paths.

There's a little bit of extra housekeeping here: the first change adds
Zba and Zbs to the set of extensions the kernel recognizes, and the second
change starts tracking ISA features per-hart (in addition to the ANDed
mask of features across all harts which the kernel uses to make
decisions). Now that we track the ISA information per-hart, we could
even fix up /proc/cpuinfo to accurately report extension per-hart,
though I've left that out of this series for now.

Changes in v2:
 - Add Zbs as well
 - Add blank line before if in riscv_fill_hwcap() (Conor)
 - Fixed typo s/supporte/supported/ (Conor)
 - Fixed copypasta s/IMA_ZBB/EXT_ZBB/ (Conor)
 - Added Zbs

Evan Green (3):
  RISC-V: Add Zba, Zbs extension probing
  RISC-V: Track ISA extensions per hart
  RISC-V: hwprobe: Expose Zba, Zbb, and Zbs

 Documentation/riscv/hwprobe.rst       | 10 ++++++
 arch/riscv/include/asm/cpufeature.h   | 10 ++++++
 arch/riscv/include/asm/hwcap.h        |  2 ++
 arch/riscv/include/uapi/asm/hwprobe.h |  3 ++
 arch/riscv/kernel/cpu.c               |  2 ++
 arch/riscv/kernel/cpufeature.c        | 20 +++++++----
 arch/riscv/kernel/sys_riscv.c         | 48 +++++++++++++++++++++++----
 7 files changed, 82 insertions(+), 13 deletions(-)

-- 
2.25.1

