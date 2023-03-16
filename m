Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E36BD0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCPNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCPNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:17:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D4CC30F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:17:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3143343wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678972636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yb0JNi6cRDb5cM5WC9CEwD00CUTLKwtDAX0RcxE9c8c=;
        b=2Ev7aL6Z6zhWHuGqPE5WRugL+grtCgf1Rw+DE5yPncJqWsJZHaCBhlqpfyHHzrwI1D
         IUpoT5Oj2+AxeGLsJn0E0MGbjKM4v8gxIxDStGUIXy02nc+EgqABDoYG/hOTYXCiYSOG
         iJXRweRTFhgYGpwr8xQprpP8UgTS76aclNF9Q88Vn0eLPUVtmLtJpd6cV7LoVTHbBvrh
         1q5XhWPVPnaXpKPzJ2vWiPfcyS8XnUsHIEUE5rYpgUMCG70N6PMSUo4+vx3GXuGIPvt/
         V4QCyObIV+J3zkqwYafQgaQwhM6mcbbbhcaBTGh3Ec5hqKIhtCwzq3Y8iM8EHnAJ0VUh
         gAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb0JNi6cRDb5cM5WC9CEwD00CUTLKwtDAX0RcxE9c8c=;
        b=WbsvDofOg6mkjiKPWURz18FSdBiZtfTuZpTLa7iS+WjNr+HZJ4mpA8QDm+I69e/NUW
         2qovvAoAfJMGpAAjCoaeQ+dL67gO+FM+F1nejQR9yu8lUkB2WgtGBWZ8P/sAWoiAjm9l
         0iNeuf1SO0IqyDKEbuTdwnpqaNl3hbaz03eiA2JPH+ljirFk2rscyKKraIHXlueyn9Bo
         qfcl6LJq/8qugzaDbx2TNNMMsGrhhGqcI+eesOgbTzt5y9K9NOQsZH3yN6wfq0B8Txz+
         s4EjSPP5+E2T7fdEWiso1fwACPYG0aZTVmi1vukc5NS20vbQQJ2UVPnAXf37B287nIkF
         P3Ew==
X-Gm-Message-State: AO0yUKUmK3gb0R1DCqiMLMmu21qc/ydEWKJ3xNtUjZnWIC7xugDtGtIH
        BLWBbSB5XBp+Hm41w6M4vRa0ww==
X-Google-Smtp-Source: AK7set/fhVDeuPDPVeUXVE63TtFOQa0R+UvB04ejBiBb1VAkOz3jRjT1WOxKNz9X4Jff53YqrdofPA==
X-Received: by 2002:a7b:ca41:0:b0:3ea:f75d:4626 with SMTP id m1-20020a7bca41000000b003eaf75d4626mr21011181wml.38.1678972636633;
        Thu, 16 Mar 2023 06:17:16 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (238.174.185.81.rev.sfr.net. [81.185.174.238])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003ed4f6c6234sm1963364wmb.23.2023.03.16.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:17:16 -0700 (PDT)
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
Subject: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Thu, 16 Mar 2023 14:17:07 +0100
Message-Id: <20230316131711.1284451-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

v8:
- Fix rv32, as reported by Anup
- Do not modify memblock_isolate_range and fixes comment, as suggested by Mike
- Use the new memblock API for crash kernel too in arm64, as suggested by Andrew
- Fix arm64 double mapping (which to me did not work in v7), but ends up not
  being pretty at all, will wait for comments from arm64 reviewers, but
  this patch can easily be dropped if they do not want it.

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

 arch/arm64/mm/mmu.c           | 25 +++++++++++------
 arch/riscv/include/asm/page.h | 19 +++++++++++--
 arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-------
 arch/riscv/mm/physaddr.c      | 16 +++++++++++
 drivers/of/fdt.c              | 11 ++++----
 include/linux/memblock.h      |  1 +
 mm/memblock.c                 | 20 +++++++++++++
 7 files changed, 119 insertions(+), 26 deletions(-)

-- 
2.37.2

