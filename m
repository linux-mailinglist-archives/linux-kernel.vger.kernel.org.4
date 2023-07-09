Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03B374C69C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGIRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGIRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F36C7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D175860BE9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E73C433C8;
        Sun,  9 Jul 2023 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688923326;
        bh=vZxIGTzVbwcqJEpX1J2uB8CrfifoX/MNcXdkuR8ow00=;
        h=From:To:Cc:Subject:Date:From;
        b=JkH3fUUUPHirWS/4X6it5XAu38JodUVCorxx1HowQl5sD9liWtwcdWQ3ojCkBkL0r
         LV4Pr4GE4JFf54njCfxSvdetzRRn3njV3UHphD0f9XESXFG3UclpqtgLgCRu4RtON+
         fG0Dt1Ab95uAvJb8NgpZiYQBcASkSuwAD9LQDbd9iyjBSNkZfIb1g+6ZS4HBPLWC6P
         FIS0OVVFiSm3VmGi5Bh/EPSoIMIERbxpVYOSgLKfxVQerCNZWKaG9ujHu80EwcHXuX
         8j4srxtX7O+GHye7yqMcwN2Obt9jXj4DKhCRXn9D+zz43ZDTLWmDs0ReEPji9B6sOw
         w6k7o4iGl0wgw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: mm: fix truncates issue on RV32
Date:   Mon, 10 Jul 2023 01:10:36 +0800
Message-Id: <20230709171036.1906-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkp reports below sparse warning when building for RV32:
arch/riscv/mm/init.c:1204:48: sparse: warning: cast truncates bits from
constant value (100000000 becomes 0)

IMO, the reason we didn't see this truncates bug in real world is "0"
means MEMBLOCK_ALLOC_ACCESSIBLE in memblock and there's no RV32 HW
with more than 4GB memory.

Fix it anyway to make sparse happy.

Fixes: decf89f86ecd ("riscv: try to allocate crashkern region from 32bit addressible memory")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306080034.SLiCiOMn-lkp@intel.com/
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 70fb31960b63..9ce504737d18 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1346,7 +1346,7 @@ static void __init reserve_crashkernel(void)
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
 					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       min(search_end, (unsigned long)(SZ_4G - 1)));
 	if (crash_base == 0) {
 		/* Try again without restricting region to 32bit addressible memory */
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-- 
2.40.1

