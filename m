Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF6604701
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJSN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiJSN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:26:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBE1DEC10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:12:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so16782513pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWjBfacUm2GoxWBQ/vmD99Tjjb4/op+CT9vp/T4pxWI=;
        b=eIBMtWthlAeYDvmoJsyh0OIJsFoA/+tcZn16Z1W42D7671Bz3D98zZi+I48MNGYIO2
         sfIU8cb8fbF3zDc7KhsQNfO4LsmP58uygqFUsC6j4lC5pA192KzRUTeSmPARUhtVwF4Q
         /Mm/cSJ5T384ozqK9Qef+ooZOKzLQR0nKFGlFv25hmkbCkyowuP2IjD2AiMNnn3Q6Ft/
         OK4vNMLwKT9o/5QsjEaJ/yn6aL3aQS6DnLbo3+A+Yp18fkUf/4pvD67SmnP8mwR/IUGG
         OsM/VnbtmtOLL+oiU45LFjoAdXh8scIoYryq+6XQ1dqjlFb9A/AdN+kCngeiUIqiqhco
         HKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWjBfacUm2GoxWBQ/vmD99Tjjb4/op+CT9vp/T4pxWI=;
        b=3f4+T95Je/Y29os536GYkPy4eR0iYq7MTXo5NLX/BhFhGQz0hGTP67vq9brXS3JihM
         SSNn8TRMsYSdWduebYsvbSXfZZe7j7lEKjqZJVObrYUsFSnlViATfFgO3IObC/mM0KDv
         G+F7vs+IS/AriXoxpusB3FSjqAbx/rHmu0Y/jM3bUIu2mwfMMKusB1VvJBdJuPQ/Pz5W
         AqPsYJ3VdHLcZhhMft5ZrgXXh3oA+Mb/830XLd9rRo/4nOchRmneo+dY0fFsfcqGWF6t
         +XK5BykLoOR96DIw9avPaGg+C7/A5A56/jsg4sycNqP07qeMEJok90xBwF3euOcJmmTq
         MSfQ==
X-Gm-Message-State: ACrzQf3gVyiEdkIpsXVm9HrrAI/LCSeIDC5cprclGxgxDsH0MZGUrEJy
        0qlCjxGLARMwjrCdJeJ3AM9gRw==
X-Google-Smtp-Source: AMsMyM6yOBDpeWz5bKxvbDSGQeEIk4lLHBWXPdRB1MHshgvJm/FiLJyi8uMbRoqc1Gm5c01k23U39A==
X-Received: by 2002:a17:90b:3a86:b0:20d:616f:4bb6 with SMTP id om6-20020a17090b3a8600b0020d616f4bb6mr45991309pjb.238.1666185097752;
        Wed, 19 Oct 2022 06:11:37 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm10934478plc.283.2022.10.19.06.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:11:37 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 0/4] Add PMEM support for RISC-V
Date:   Wed, 19 Oct 2022 18:41:24 +0530
Message-Id: <20221019131128.237026-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

These patches can also be found in riscv_pmem_v4 branch at:
https://github.com/avpatel/linux.git

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
  RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/configs/defconfig        |  1 +
 arch/riscv/include/asm/cacheflush.h |  8 ------
 arch/riscv/include/asm/io.h         | 10 +++++++
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/mm/Makefile              |  1 +
 arch/riscv/mm/cacheflush.c          | 38 ++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 41 -----------------------------
 arch/riscv/mm/pmem.c                | 21 +++++++++++++++
 9 files changed, 74 insertions(+), 49 deletions(-)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

