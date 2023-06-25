Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D376573D152
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFYOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFYOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:10:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E9E43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:10:51 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687702214tvcj0zr9
Received: from localhost.localdomain ( [112.2.230.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 25 Jun 2023 22:10:11 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: lm7sZZPcOdayF/iPi2BR4TEQZ9thVeHoHrWDwBsJL4ncQ7c+lAS11zf54xTy3
        Fo3M0/o47zsFTuHKr0OZtWzSNREVR8bTElBgt+LPq2dRqUYvWaBDaY7slSNJw+xNRpQWEA+
        Rjv+tFEu+l41GgNbJ595Tpfo1ghEl1eY2WMgh2qBvy0mSydhFy6oAbkbAVm1bZzrsEpYThM
        wNZ8EOsZjsJoW9egl0Ac058twNt2/hFuBOikHE40Oz6wyQzk44N8LcxXwoDcmzlKWZUWryH
        FH200fkpS3gW0ZRaqqxfSyg8II+IuY93paiLI5RgaoFXH0rFo3Iaj/JntyYdOJtBftM01yq
        CGxtWz18la1yzqzwCO2TF510Ar3DePwU1NY0qSz
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3093032413490913072
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, songshuaishuai@tinylab.org,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V1 2/3] Revert "riscv: Check the virtual alignment before choosing a map size"
Date:   Sun, 25 Jun 2023 22:09:30 +0800
Message-Id: <20230625140931.1266216-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 49a0a3731596fc004db6eec3fc674d92a09ef383.

With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
linear mapping") reverted, best_map_size() only uses PMD_SIZE or PAGE_SIZE
for linear mapping and the phys_ram_base that va_pa_offset is based on
points the kernel load address which is 2M-aligned for rv64.

So no need to check the virtual alignment before choosing a map size.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/mm/init.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..38c4b4d6b64f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -660,19 +660,18 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
-				      phys_addr_t size)
+static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
+	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
 		return PGDIR_SIZE;
 
-	if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
-	if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
-	if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -1178,7 +1177,7 @@ static void __init create_linear_mapping_range(phys_addr_t start,
 	for (pa = start; pa < end; pa += map_size) {
 		va = (uintptr_t)__va(pa);
 		map_size = fixed_map_size ? fixed_map_size :
-					    best_map_size(pa, va, end - pa);
+					    best_map_size(pa, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
 				   pgprot_from_va(va));
-- 
2.20.1

