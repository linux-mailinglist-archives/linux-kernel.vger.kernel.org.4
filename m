Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE76EA45D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDUHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDUHLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:11:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502A2101
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B6961BD4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA54AC433D2;
        Fri, 21 Apr 2023 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682061113;
        bh=rMUILe+lzNtFjuK4Wo8tbKNwjXvMBXiBfW9We8f4vr8=;
        h=From:Date:Subject:To:Cc:From;
        b=UI5MuaE4/UikemG6JhQ1dvCw3HjcJDedvlypUJW+49LIfPBKusmfQe+xb+bqGx2bt
         h4KFH8SPmALftGENd9XPx7uUe+Kmwu+vn6wYpejqwQL4uzJH3B5dsLqK251VJLDpf1
         j6/IZx1mQ7aruuKhv2/dPQ9YNj9BUNuouD53rJwyF4+BvxUeZpL/t4DFGRDwcNFXHn
         UdjGJwGlCfgw614HAjzy1sciY4FSKtVhrK0A2tX5bMTeHqt/KO/JvUF55jvb6bmmFd
         sTpk4q1qNbMHN2XfktvsXsHicgpsjnNQAyBLyDhY0wL/yLGqTy0BY89f+UDIBTPFFl
         GdI2UqwjTVcyQ==
From:   Simon Horman <horms@kernel.org>
Date:   Fri, 21 Apr 2023 09:11:49 +0200
Subject: [PATCH] m68k: kexec: include reboot.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
X-B4-Tracking: v=1; b=H4sIADQ3QmQC/x2NywqDMBBFf0Vm3QGTaCj9ldJFHmMdTCcl0SKI/
 97g8lw49xxQqTBVeHQHFPpx5SwN1K2DMDt5E3JsDLrXph+0wo+9L7jQTgFZQtoiYSGf84rWqOg
 mM47aOmi+d5XQFydhbg+ypdTGb6GJ9yv4fJ3nH82Mj92AAAAA
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Baoquan He <bhe@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include reboot.h in machine_kexec.c for declaration of
machine_crash_shutdown and machine_shutdown.

gcc-12 with W=1 reports:

 arch/m68k/kernel/machine_kexec.c:26:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
    26 | void machine_shutdown(void)
       |      ^~~~~~~~~~~~~~~~
 arch/m68k/kernel/machine_kexec.c:30:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
    30 | void machine_crash_shutdown(struct pt_regs *regs)
       |      ^~~~~~~~~~~~~~~~~~~~~~

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/m68k/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/machine_kexec.c b/arch/m68k/kernel/machine_kexec.c
index 206f84983120..739875540e89 100644
--- a/arch/m68k/kernel/machine_kexec.c
+++ b/arch/m68k/kernel/machine_kexec.c
@@ -6,6 +6,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>

