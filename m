Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD65F96D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJJCdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJJCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:33:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72833358;
        Sun,  9 Oct 2022 19:33:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 67so9599058pfz.12;
        Sun, 09 Oct 2022 19:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqNHFO+wnYU3tQ/zlSnRMD0uRUbJO7Cs4TB5ZEpNv3w=;
        b=Up0OWIpnNumgltMC4JxjBfkp61fbritNxYuU3KT1yMQQE8xemaB4vGSN5iEpp/PaZS
         AtBJVbIY56HIeXWlowwJR44lVaDNsWi866oUJgFpXvNXpDZBXL3hp/G1/0xMbeV4E8N0
         JNBPAq/cLI6nicGre1FCEUHNgqQ00NEUXk1MELRzH7fj3fD+2m181PH2G+C1FWfGtvXZ
         yJjLbQGMTA9ZuZw+w3gYWkKLYfk/DoUmX3ctoVlNxpXNuRKYrgu5svRxjX8LcaKKDhvk
         b52DleueWhaS9fezhsJjDUJSsn8gQTaLkv3OdcC9wNd2wN5pUf2jhIDSX/QGTN6+3jZi
         RWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqNHFO+wnYU3tQ/zlSnRMD0uRUbJO7Cs4TB5ZEpNv3w=;
        b=ZF2w0fx/mFPC+fo3SaKmnHOtAVnJz3S9GfW2mliw3kmJnTupH71ujOAkQ84YErHG8b
         fHpOU8eimVdNo3md7MIGAq2WwEXNgjd1gfBtpzs/NAjauZdLTYBqjicUp9p7eirEj7os
         JxDI03X4ElG0XZYpjOY3xjS6M4p71zpKr3PSYqi7YW1K9RjdeL8CsgFWPYzZHM+gFghd
         dbZmr0zB6YbbL11ByKZNuHTjFw7MXEcQ0jXzPVTlXY5M+jkEXWaKR9bsm5YseMvLZjAZ
         SB/vlR5EuAtdoolXARL3oDr+Gpb68QJeS/aJU+3vMkMh4mj0Bei++xxNvBhJH66bkLl1
         Noaw==
X-Gm-Message-State: ACrzQf2Oyzl2NEIdMxIuqD16thcO0+9gMN9lKlIW0GFxMqY2vA1vQAmt
        AnmQPMm8CbsQ19lupAex3A1u3VVdROvVow==
X-Google-Smtp-Source: AMsMyM5JdNHma1WJKgHUKa8vOZplr/d5/dNWYX750tyf+34p/0N26QYC8Fvbs+s55/Gomlx56HP4hw==
X-Received: by 2002:a63:455e:0:b0:439:9496:ddd8 with SMTP id u30-20020a63455e000000b004399496ddd8mr14573002pgk.261.1665369214974;
        Sun, 09 Oct 2022 19:33:34 -0700 (PDT)
Received: from localhost.localdomain ([191.101.132.215])
        by smtp.gmail.com with ESMTPSA id i20-20020a63e914000000b00434272fe870sm5278816pgh.88.2022.10.09.19.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 19:33:34 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next][RFC] powerpc: fix HOTPLUG error in rcutorture
Date:   Mon, 10 Oct 2022 10:33:15 +0800
Message-Id: <20221010023315.98396-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we should avoid torture offline the cpu who do tick timer
when nohz full is running.

Tested on PPC VM of Open Source Lab of Oregon State University.
The test results show that after the fix, the success rate of
rcutorture is improved.
After:
Successes: 40 Failures: 9
Before:
Successes: 38 Failures: 11

I examined the console.log and Make.out files one by one, no new
compile error or test error is introduced by above fix.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear PPC developers

I found this bug when trying to do rcutorture tests in ppc VM of
Open Source Lab of Oregon State University:

ubuntu@ubuntu:~/linux-next/tools/testing/selftests/rcutorture/res/2022.09.30-01.06.22-torture$ find . -name "console.log.diags"|xargs grep HOTPLUG
./results-scftorture/NOPREEMPT/console.log.diags:WARNING: HOTPLUG FAILURES NOPREEMPT
./results-rcutorture/TASKS03/console.log.diags:WARNING: HOTPLUG FAILURES TASKS03
./results-rcutorture/TREE04/console.log.diags:WARNING: HOTPLUG FAILURES TREE04
./results-scftorture-kasan/NOPREEMPT/console.log.diags:WARNING: HOTPLUG FAILURES NOPREEMPT
./results-rcutorture-kasan/TASKS03/console.log.diags:WARNING: HOTPLUG FAILURES TASKS03
./results-rcutorture-kasan/TREE04/console.log.diags:WARNING: HOTPLUG FAILURES TREE04

I tried to fix this bug.

Thanks for your patience and guidance ;-)

Thanks 
Zhouyi
--
 arch/powerpc/kernel/sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index ef9a61718940..be9c0e45337e 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
+#include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/nodemask.h>
@@ -21,6 +22,7 @@
 #include <asm/firmware.h>
 #include <asm/idle.h>
 #include <asm/svm.h>
+#include "../../../kernel/time/tick-internal.h"
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -1151,7 +1153,11 @@ static int __init topology_init(void)
 		 * CPU.  For instance, the boot cpu might never be valid
 		 * for hotplugging.
 		 */
-		if (smp_ops && smp_ops->cpu_offline_self)
+		if (smp_ops && smp_ops->cpu_offline_self
+#ifdef CONFIG_NO_HZ_FULL
+		    && !(tick_nohz_full_running && tick_do_timer_cpu == cpu)
+#endif
+		    )
 			c->hotpluggable = 1;
 #endif
 
-- 
2.25.1

