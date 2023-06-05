Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A167228E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjFEOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFEOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:35:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C483
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:35:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2565a9107d2so4145047a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685975722; x=1688567722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnPfgIDWBs0YYXdVzHgFIrX5B+53ekGUHMTcfude0cE=;
        b=ffVyNgoosVSs91945n4gFuDiXVzNuQEEPwb9IjnJp4MyeKLTIRZw7Xnsyu0vqoDSPI
         1h0gdfP5D+HMUZjI6u8k40LINt0IXgn/xtnNyvPHrjKSNgKwg16mt/5bxbzXJHDfH4pF
         y1oV1LRu4cc2aOmKc0Xhtw7aXNMHdxNozGFcDads+8HgDeuwEuH28fnOKGAPOShykVoc
         Gesn8FP+iWgXBfrBRYpazhtvc46TbMy1suMh1bE+xq28UM+8iwYJ59NirSXpLYmKW1el
         zrlRuF3C/qgZEaTpEQO9kubKn6IJ/mOnezYYN9qn0zucGdn/qgrVSRHUlAwh4BCoEIYQ
         6c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975722; x=1688567722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnPfgIDWBs0YYXdVzHgFIrX5B+53ekGUHMTcfude0cE=;
        b=gyvNbxDljEsVXnfeD1oP+zQqPnQiHFuads2N9H0tMmX6g4NprV4qcV8H51h6lF/0mS
         DQCpgY1fTR4oILl3s7SZlsFo/mCqbVDpycn1DD0/YLxBttWT/IOEa2KKxNO80472UVts
         D420OIQ4Yx5sDMUNVJH25RK5LsMmUf5Y6w7cy0jl12JXrzqaqzII3hgvLNlPDBjvcLhq
         xgPY75SA88U3wLy84YiL31f7IKNNeLzMr6CPaqRYF1/52E9KSyv/pKtmwscQfzYbUyFV
         J1UzgqRy5TXhaZTkYdYB3sf1hXqFNMbQiXYc8jxUjcSEWJBpMU5R9GR9tojJYW/T7sqv
         HVRA==
X-Gm-Message-State: AC+VfDzCyAvCwY+6DCyeCxMGfNR/DCmHO2c1BITdS2WFEU2WZ5GNvOlw
        3u/jIo7fDYCGcEc0xW68BDRutA==
X-Google-Smtp-Source: ACHHUZ7T/nG/LREifYc0zczolikuIQMgBFpvxe9aToBG/9+TDnjWaZRcSokFABIaKOafGLDmMIPE4g==
X-Received: by 2002:a17:90a:319:b0:259:7ed4:d6cd with SMTP id 25-20020a17090a031900b002597ed4d6cdmr844923pje.5.1685975722231;
        Mon, 05 Jun 2023 07:35:22 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a1fce00b00250334d97dasm8297069pjz.31.2023.06.05.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:35:21 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 -next 1/2] RISC-V: ACPI : Fix for usage of pointers in different address space
Date:   Mon,  5 Jun 2023 20:05:11 +0530
Message-Id: <20230605143512.707533-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605143512.707533-1-sunilvl@ventanamicro.com>
References: <20230605143512.707533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch specific __acpi_map_table can be wrapper around either
early_memremap or early_ioremap. But early_memremap
routine works with normal pointers whereas __acpi_map_table expects
pointers in iomem address space. This causes kernel test bot to fail
while using the sparse tool. Fix the issue by using early_ioremap and
similar fix done for __acpi_unmap_table.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@intel.com/
---
 arch/riscv/kernel/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index df5a45a2eb93..5ee03ebab80e 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -204,7 +204,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!size)
 		return NULL;
 
-	return early_memremap(phys, size);
+	return early_ioremap(phys, size);
 }
 
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
@@ -212,7 +212,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	if (!map || !size)
 		return;
 
-	early_memunmap(map, size);
+	early_iounmap(map, size);
 }
 
 void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
-- 
2.34.1

