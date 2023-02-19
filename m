Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F269C359
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBSXPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBSXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:15:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7451A67F;
        Sun, 19 Feb 2023 15:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uS4cWikPVXiTQ453M9jkXQ6H6A9rByEcXI4R3QotgUM=; b=QeT6zOvuqCSQ9vd0vABhZmNBNQ
        P62HvftNURvPjrvnGJougtaXa1qE8lzm0XQSDDbwemDL7UAmJqdA09Spy+naSH7EaQrZxaFvY7Slg
        r0A/QUk5r3YeVzZLNZPnVbUMExO87G5gbQhoq9pdmepqIxZmbMtczik4DBkhhR2rZt5hL9MwpH/zU
        tcqWuWQWP1nhppdMlPSKffQyaqCRQItQI6Lg6kNxhSEvDQDd6ahCNFldvIcF0EAEvnoMcU+3xKVmE
        +ZrHJutdmm7Lzz8VoUE6jjI473PglhQ+xH5jsdOFSGRIPkVFL1kBvuXoeuneAH4BkOVLefOOx85b0
        Wi0G4dZg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTsty-002Tem-Rp; Sun, 19 Feb 2023 23:15:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH v2] MIPS: vpe-mt: drop physical_memsize
Date:   Sun, 19 Feb 2023 15:15:25 -0800
Message-Id: <20230219231525.21542-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When neither LANTIQ nor MIPS_MALTA is set, 'physical_memsize' is not
declared. This causes the build to fail with:

mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'

LANTIQ is not using 'physical_memsize' and MIPS_MALTA's use of it is
self-contained in mti-malta/malta-dtshim.c.
Use of physical_memsize in vpe-mt.c appears to be unused, so eliminate
this loader mode completely and require VPE programs to be compiled with
DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined.

Fixes: 9050d50e2244 ("MIPS: lantiq: Set physical_memsize")
Fixes: 1a2a6d7e8816 ("MIPS: APRP: Split VPE loader into separate files.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202302030625.2g3E98sY-lkp@intel.com/
Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: John Crispin <john@phrozen.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc: Qais Yousef <Qais.Yousef@imgtec.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
---
v2 changes: instead of providing a default physical_memsize of 0, which
    is not correct for MIPS_MALTA, just eliminate its use in vpe-mt.c.

 arch/mips/include/asm/vpe.h |    1 -
 arch/mips/kernel/vpe-mt.c   |    7 +++----
 arch/mips/lantiq/prom.c     |    6 ------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff -- a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -23,12 +23,6 @@ DEFINE_SPINLOCK(ebu_lock);
 EXPORT_SYMBOL_GPL(ebu_lock);
 
 /*
- * This is needed by the VPE loader code, just set it to 0 and assume
- * that the firmware hardcodes this value to something useful.
- */
-unsigned long physical_memsize = 0L;
-
-/*
  * this struct is filled by the soc specific detection code and holds
  * information about the specific soc type, revision and name
  */
diff -- a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -102,7 +102,6 @@ struct vpe_control {
 	struct list_head tc_list;       /* Thread contexts */
 };
 
-extern unsigned long physical_memsize;
 extern struct vpe_control vpecontrol;
 extern const struct file_operations vpe_fops;
 
diff -- a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -92,12 +92,11 @@ int vpe_run(struct vpe *v)
 	write_tc_c0_tchalt(read_tc_c0_tchalt() & ~TCHALT_H);
 
 	/*
-	 * The sde-kit passes 'memsize' to __start in $a3, so set something
-	 * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
-	 * DFLT_HEAP_SIZE when you compile your program
+	 * We don't pass the memsize here, so VPE programs need to be
+	 * compiled with DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined.
 	 */
+	mttgpr(7, 0);
 	mttgpr(6, v->ntcs);
-	mttgpr(7, physical_memsize);
 
 	/* set up VPE1 */
 	/*
