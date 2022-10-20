Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30160592D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiJTH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiJTH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:58:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3BB17FD7D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:58:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so19558469pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btCTic98t1YLcf0biOQlX60g2ym+aQBextAw5Z0lMQI=;
        b=WP2LfURmJyrrwGBfyjAvVGryktBs5nbOUpVEiVkl2z+GjizmUMXi4YulnzbowoEDH1
         k8jNv7jdbwrjzZJYAYlToDltr3Lfji9Ex3HqaOdrDB+VUJenstDasSBNo7aBmqXMNIwV
         qW2FMI6UIFgnug3vxkbt7Wvkj3JmqL8q+CA+5CfryIMuHdGcW9oEMluFmGkFRh5Ccni3
         1TIJzWetNlbFW2UudoPqZ7zRwA63gCfiW66ZN4VXlFS9o6MBH+wZOKzURU5BGpbvTvO2
         k+vDXHuNEDg/RRcAKs2u58de499p71nqQp4r3XsZuLE+o6FSTIspXkKWxu1jCQCTdZuI
         B5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btCTic98t1YLcf0biOQlX60g2ym+aQBextAw5Z0lMQI=;
        b=ld8dWCbXRd/rf3hXYvUKH4UTgadksNTpLMqnSoBJDhYB+GeE/qcuodROrMENDhlmGe
         eH1bJFYCZ68fKw5YlLqFPDsaPP5fBHaYKCwlYXjVf1nIzGyAff624JkTZpJMHOi5F8xr
         ypA2B0LX4Ty4XmaPJjIqjM/DTxbXsPk3gaRmWNEizgiYBz6m/vbN8cUo0wyzqWsJfxVQ
         WG8x9/39Xy63QPCqj/NOLcHKTr5R4GFX37reEo4OFpk997iQ1XBQxU1MmjDdtk5Z+wCW
         6PBNCFdyGawldyqVOxlO0wxYi8FAiwX+4uvYmK6hurkB9X0d/hX2FnH1okJDI7yIQ8hJ
         6LyQ==
X-Gm-Message-State: ACrzQf3D3n7REdJTXO7QHuJm36FtTYInsd8UPyg24j+oBIAc8UTDnd9O
        a5EdTuRsVoOGmxnDt8JZSvsBWQ==
X-Google-Smtp-Source: AMsMyM5fHSIer/wcJYaOMK/yvrfB4UfLK02PnkKnVWsKkPds2h9u0G1U/jwaGe0a1wKkF18A/ybG4w==
X-Received: by 2002:a63:cf48:0:b0:439:7d1c:fedc with SMTP id b8-20020a63cf48000000b004397d1cfedcmr10905620pgj.281.1666252735493;
        Thu, 20 Oct 2022 00:58:55 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.23])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b0052dfe83e19csm13206438pfr.16.2022.10.20.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:58:54 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 0/4] Add PMEM support for RISC-V
Date:   Thu, 20 Oct 2022 13:28:42 +0530
Message-Id: <20221020075846.305576-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux NVDIMM PEM drivers require arch support to map and access the
persistent memory device. This series adds RISC-V PMEM support using
recently added Svpbmt and Zicbom support.

First two patches are fixes and remaining two patches add the required
PMEM support for Linux RISC-V.

These patches can also be found in riscv_pmem_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Simplify PATCH2 by implementing RISC-V specific arch_memremap_wb()

Changes since v3:
 - Pickup correct version of Drew's patch as PATCH1

Changes since v2:
 - Rebased on Linux-6.1-rc1
 - Replaced PATCH1 with the patch proposed by Drew

Changes since v1:
 - Fix error reported by test bot
   https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/

Andrew Jones (1):
  RISC-V: Fix compilation without RISCV_ISA_ZICBOM

Anup Patel (3):
  RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/configs/defconfig        |  1 +
 arch/riscv/include/asm/cacheflush.h |  8 ------
 arch/riscv/include/asm/io.h         |  5 ++++
 arch/riscv/mm/Makefile              |  1 +
 arch/riscv/mm/cacheflush.c          | 38 ++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 41 -----------------------------
 arch/riscv/mm/pmem.c                | 21 +++++++++++++++
 8 files changed, 67 insertions(+), 49 deletions(-)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

