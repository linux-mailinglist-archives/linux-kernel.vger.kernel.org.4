Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0646FEF75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjEKJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbjEKJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:55:34 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C6215FD0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:55:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-05 (Coremail) with SMTP id zQCowABXXc1Iu1xkAWf0IQ--.37442S2;
        Thu, 11 May 2023 17:54:16 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] locking/rwsem: Add configuration dependency constraints consistent with source file
Date:   Thu, 11 May 2023 17:54:09 +0800
Message-Id: <20230511095409.7005-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABXXc1Iu1xkAWf0IQ--.37442S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWkWryDCF43ury5Jry5Arb_yoW8Wr4xpw
        s5G3W5JF4ktF13tr4DZa40gFyDGas3JrW3CFW7C34rZFyDA3yIvryvqrW2vF18Za9rAFWr
        XF95WF40vF1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
        0wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUY9a9UUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

"CONFIG_RWSEM_SPIN_ON_OWNER" and "CONFIG_DEBUG_RWSEMS" are used in
kernel/locking/rwsem.c while "#ifndef CONFIG_PREEMPT_RT" is met,
which means they are available only if "CONFIG_PREEMPT_RT" is turned off.

To ensure that the corresponding source code can be compiled
when "CONFIG_RWSEM_SPIN_ON_OWNER" and "CONFIG_DEBUG_RWSEMS" are turned on,
it is recommended to add a dependency constraint on "CONFIG_PREEMPT_RT"
in kconfig.

Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 kernel/Kconfig.locks | 2 +-
 lib/Kconfig.debug    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273ecd..0e3462b08543 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -230,7 +230,7 @@ config MUTEX_SPIN_ON_OWNER
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
-       depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+       depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW && !PREEMPT_RT
 
 config LOCK_SPIN_ON_OWNER
        def_bool y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f202648dead9..0b392b1bd741 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1342,7 +1342,7 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.
-- 
2.17.1

