Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA27743A27
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjF3LAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF3LAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:00:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD853C21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:00:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7e66ff65fso13392825ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688122786; x=1690714786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFrE+nd0LeR05nJ5NVrdpn/ufPx0wKCGgMdooQskSO8=;
        b=M62+hmz8SSePadjJXz71Q8pq7HqyWXfJKK/UQMiabow3oyGMUgm9ZYsRS94utLkGwI
         4Wsx8nROvO2Ib0/xd8v+4KdX2+7yeDpFd5PBrM/dyfF0cPN0HDkK8yPsCFqjHhPnDZXL
         quDB65UYh0TTv3lJ4aNeRNfp+vCd5lD3o/yRO4Ik/sboKP7QdKchzdOJx4l89gjXSUVU
         Zha2W5a4WkGTTDf2oN8cpQYk168Nwfu7penKwi8uFSmIj/UPW8riJ3sGbXwYr2R9WVvR
         EqRiKLhEiPN2d7/DHGt+EG669RXUmp/OKDjXXErwGitM5CIaMYqHPHHdRKUQPAYCDMu9
         ZVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122786; x=1690714786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFrE+nd0LeR05nJ5NVrdpn/ufPx0wKCGgMdooQskSO8=;
        b=SeXBPSu8iReIMTRH3Aql5f+r66BIHJgBFFIhrejEDdJnZWRGu/UuDhpNT/2LflisFt
         F/t2BhRlVAEAen7q7ib1VTI1DbFULo16G0UIDx2Cz4KFZZZQhNyujPPvOGvpEhxFUEjC
         p5cgbchre5jW7nvKStDpk0Fto7njkO5j0cOjIc03Rp/fZT50yzJ916b/4Vorpf8A0eBE
         pY76DvYzEn8nuwp0vPTqn4M3POym4XZlPe2ZZypY3HO79YZKIxZj/gAGlf380Tvz/Hu8
         +LZUm8b+sF5JVvVHocg8Ox4evU2NhN/BqQBnIMtRoDCxdAC6tZw5ykcgDt4I1xMC6P0S
         +z3w==
X-Gm-Message-State: ABy/qLYenYPCvQP4UOlhwqjh8VyTJGjINPckl8M3160RlyMz/oPYvS+m
        4Ype1R75xORz1cg70cK7YkQ=
X-Google-Smtp-Source: APBJJlEorxDlYCCE4k4tSFhPD6RKUovabJRUTk9iGyqV1FTWpz/+wHvtljhQWARdjwkL2hP5M9x61g==
X-Received: by 2002:a17:90a:4b:b0:262:df8e:fcb6 with SMTP id 11-20020a17090a004b00b00262df8efcb6mr1998839pjb.43.1688122786288;
        Fri, 30 Jun 2023 03:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c10:118:1a0:d87f:f44e:7fe7])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0025bf1ea918asm10435172pjj.55.2023.06.30.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:59:45 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        ajones@ventanamicro.com, sunilvl@ventanamicro.com,
        heiko.stuebner@vrull.eu, apatel@ventanamicro.com,
        suagrfillet@gmail.com, evan@rivosinc.com, greentime.hu@sifive.com,
        leyfoon.tan@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] riscv: Add BUG_ON() for no cpu nodes in devicetree
Date:   Fri, 30 Jun 2023 18:59:38 +0800
Message-Id: <20230630105938.1377262-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When only the ACPI tables are passed to kernel, the tiny devictree created
by EFI Stub doesn't provide cpu nodes.

While if append the "acpi=off" to kernel cmdline to disable ACPI for kernel
the BUG_ON() in of_parse_and_init_cpus() indicates there's no boot cpu
found in the devicetree, not there're no cpu nodes in the devicetree.

Add BUG_ON() in the first place of of_parse_and_init_cpus() to make it clear.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
Changes since V1:
https://lore.kernel.org/linux-riscv/20230629105839.1160895-1-suagrfillet@gmail.com/
- revise the commit-msg and move the BUG_ON into of_parse_and_init_cpus() as Conor suggests

---
 arch/riscv/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 6ca2b5309aab..04d33afbdf55 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -147,6 +147,8 @@ static void __init of_parse_and_init_cpus(void)
 	int cpuid = 1;
 	int rc;
 
+	BUG_ON(!of_get_next_cpu_node(NULL));
+
 	cpu_set_ops(0);
 
 	for_each_of_cpu_node(dn) {
-- 
2.20.1

