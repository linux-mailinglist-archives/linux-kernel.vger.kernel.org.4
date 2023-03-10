Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7A6B3B33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCJJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCJJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:45:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9813D7B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:45:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l1so4434535wry.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678441544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UftmAx9eMUlUVZ1zG+blrWbVPdUhF6IePoR+esHHRyE=;
        b=mw/JcuakIGznshhAisrjTRMD8Po1tDitbLm42cReJ+D5WwLSfKHow3B63jzrH5HNzg
         im0RBmwfWgltbaAWUJfikpey3379n7iZgcZV1xayELAh3GVtZKo9jw2i4oYXXL0/h3FX
         vnKMl9pnCxls1xtoHkwRsxR73kAA1NnZ0Uvi9JFZokS5Oul8vNx2CdfxWCg25vVTzULy
         /bL073+f9A0eCN03cbNr92x9ZQW1JVyhrVWHsaHy3G8YR4nIjwpNNqi8F/5MyxOjpXv8
         IaWEpDsI+7aC3l8hLqSbbjhgSsESc6VIiplKe/ZqliiM6bRlTKclTHaj6U36MU59E2zp
         tHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UftmAx9eMUlUVZ1zG+blrWbVPdUhF6IePoR+esHHRyE=;
        b=IYkwYXl9oBtEClTBOUIh2SqHN9u518WcudJdRXJ/Le8jZbbQOp2zB6i+yeU8geTatf
         YSCLbkU1ZYAgVaSyD+47fZazvEsBpG30G/oMsfnXKRXYuAMBxi70h8eVOKLKjeYcI84R
         DNgq5wk5cTlkVfrP2r84KJksPWZs8EKmF6HP/2AOnWH2WAMQAf9DN6HEkQz2lWz4UTZf
         YZvL2DQ6gEQKTeDyBY6Zpx6AZm3gdscpjagtHUdreptnSAPeqAmhFVoeBTZQPj+FTs0Z
         qs8uAJciAQnJZ9BL/PJZrwW2IzR7n5UZiRk0RFpEDPvuvvwUbBPu1ItgQ2DwHMbZgVpu
         fm1Q==
X-Gm-Message-State: AO0yUKW2ilnadt4iyve3LgHCsLN92aa0AOKraRGAv0R9TXm4Z/biLG7Q
        vCyRXv4e0u04NSZ4+hQhDXtJdw==
X-Google-Smtp-Source: AK7set+348Cnhg9OopXRYq6mmFzZ+O41Mzkm9zWAs2amuAeiaWL8WS531F/GY1Nq+XByYlhgrJNy4g==
X-Received: by 2002:adf:fbcc:0:b0:2c7:bb13:e23f with SMTP id d12-20020adffbcc000000b002c7bb13e23fmr16291966wrs.24.1678441544476;
        Fri, 10 Mar 2023 01:45:44 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r7-20020a0560001b8700b002c7163660a9sm1646775wru.105.2023.03.10.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:45:44 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v7 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Fri, 10 Mar 2023 10:45:35 +0100
Message-Id: <20230310094539.764357-1-alexghiti@rivosinc.com>
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

This patchset intends to improve tlb utilization by using hugepages for
the linear mapping.

As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
take care of isolating the kernel text and rodata so that they are not
mapped with a PUD mapping which would then assign wrong permissions to
the whole region: it is achieved by introducing a new memblock API.

Another patch makes use of this new API in arm64 which used some sort of
hack to solve this issue: it was built/boot tested successfully.

base-commit-tag: v6.3-rc1

v7:
- Fix Anup bug report by introducing memblock_isolate_memory which
  allows us to split the memblock mappings and then avoid to map the
  the PUD which contains the kernel as read only
- Add a patch to arm64 to use this newly introduced API

v6:
- quiet LLVM warning by casting phys_ram_base into an unsigned long

v5:
- Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
  Conor
- Add RB from Andrew

v4:
- Rebase on top of v6.2-rc3, as noted by Conor
- Add Acked-by Rob

v3:
- Change the comment about initrd_start VA conversion so that it fits
  ARM64 and RISCV64 (and others in the future if needed), as suggested
  by Rob

v2:
- Add a comment on why RISCV64 does not need to set initrd_start/end that
  early in the boot process, as asked by Rob

Alexandre Ghiti (4):
  riscv: Get rid of riscv_pfn_base variable
  mm: Introduce memblock_isolate_memory
  arm64: Make use of memblock_isolate_memory for the linear mapping
  riscv: Use PUD/P4D/PGD pages for the linear mapping

 arch/arm64/mm/mmu.c           |  4 ++--
 arch/riscv/include/asm/page.h | 19 +++++++++++++++--
 arch/riscv/mm/init.c          | 39 ++++++++++++++++++++++++++---------
 arch/riscv/mm/physaddr.c      | 16 ++++++++++++++
 drivers/of/fdt.c              | 11 +++++-----
 include/linux/memblock.h      |  1 +
 mm/memblock.c                 | 22 +++++++++++++++++++-
 7 files changed, 92 insertions(+), 20 deletions(-)

-- 
2.37.2

