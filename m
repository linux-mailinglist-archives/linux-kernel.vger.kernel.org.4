Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47B69A5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQGjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:39:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC83A093;
        Thu, 16 Feb 2023 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CzxUXmaoKaTawDsDS62APQKN1CPdfaYIP+YvlMfEd5Y=; b=p4jz++3oZNOf6OwuXb4XnNQw9N
        EXbztLL9VyfBsGK6U2rT948ui+yy3vLUZSO44gMQtdA25nUIEBtQR+40rlnA8HZ34BroSVQcH78og
        p/UGPaVdk1IxmXxVYIoMrd1HZzZTnSQwTI8ogR+GiPGHLycp23ZC0p8JjVn7CjGsRqhrGmHOXC6fj
        EyaiuzGc9d49DOvDvYnajuC9Nsxs5FXMAVbBx7Qlc7/5NOWnPBd92QrBsAmmzJ0VPzUt1EhPxwJKC
        vWpYeWr639i6z54nfiNIDdM8GWNbhK6OnZE5OMVWFhvz6+SeaVr5DFEoeDYMIHE7zWblBfcXBCI7J
        j7at1odg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSuOZ-00Cxjx-48; Fri, 17 Feb 2023 06:38:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [RFC PATCH] MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not set
Date:   Thu, 16 Feb 2023 22:38:58 -0800
Message-Id: <20230217063858.28311-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MIPS_CPS=y, MIPS_CPS_PM is not set, HOTPLUG_CPU is not set, and
KEXEC=y, cps_shutdown_this_cpu() attempts to call cps_pm_enter_state(),
which is not built when MIPS_CPS_PM is not set.
Conditionally execute the else branch based on CONFIG_HOTPLUG_CPU
to remove the build error.
This build failure is from a randconfig file.

mips-linux-ld: arch/mips/kernel/smp-cps.o: in function `$L162':
smp-cps.c:(.text.cps_kexec_nonboot_cpu+0x31c): undefined reference to `cps_pm_enter_state'

Fixes: 1447864bee4c ("MIPS: kexec: CPS systems to halt nonboot CPUs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/kernel/smp-cps.c |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -424,9 +424,11 @@ static void cps_shutdown_this_cpu(enum c
 			wmb();
 		}
 	} else {
+#ifdef CONFIG_HOTPLUG_CPU
 		pr_debug("Gating power to core %d\n", core);
 		/* Power down the core */
 		cps_pm_enter_state(CPS_PM_POWER_GATED);
+#endif /* CONFIG_HOTPLUG_CPU */
 	}
 }
 
