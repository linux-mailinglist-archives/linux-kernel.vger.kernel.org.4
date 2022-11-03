Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862B617C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKCMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiKCMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2E7651;
        Thu,  3 Nov 2022 05:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A48FBB8277B;
        Thu,  3 Nov 2022 12:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD7C433D7;
        Thu,  3 Nov 2022 12:17:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lrD9JVVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667477871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCNlgmyItqyuRavx+qm0fBnSnb18rMft+VAzhi/oxew=;
        b=lrD9JVVUL9UrnfqHLp1I7x/5J2b+aAtYmL7jczhvVtrKpqiU/HWdbsi1zxmZclPFnh1x7y
        Jytf4GEX4gtC70S1GOuZ2xn5Y/Z1Zh4JNmhjzpciYdZFIiYvdznQ6Pq5aAFV56zWUfzB2p
        o24siwI87dCNeeEHsBXM/dF+shfXXYk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4fa6e674 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 12:17:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3] random: do not include <asm/archrandom.h> from random.h
Date:   Thu,  3 Nov 2022 13:17:40 +0100
Message-Id: <20221103121740.6684-1-Jason@zx2c4.com>
In-Reply-To: <20221029010857.161574-1-Jason@zx2c4.com>
References: <20221029010857.161574-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The <asm/archrandom.h> header is a random.c private detail, not
something to be called by other code. As such, don't make it
automatically available by way of random.h.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/s390/kernel/setup.c           | 1 +
 drivers/char/hw_random/s390-trng.c | 1 +
 drivers/char/random.c              | 1 +
 include/linux/random.h             | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 6d041993a45d..9b10e57040c6 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -59,6 +59,7 @@
 #include <asm/xmon.h>
 #include <asm/cputhreads.h>
 #include <mm/mmu_decl.h>
+#include <asm/archrandom.h>
 #include <asm/fadump.h>
 #include <asm/udbg.h>
 #include <asm/hugetlb.h>
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ab19ddb09d65..b53a45735a5d 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -52,6 +52,7 @@
 #include <linux/hugetlb.h>
 #include <linux/kmemleak.h>
 
+#include <asm/archrandom.h>
 #include <asm/boot_data.h>
 #include <asm/ipl.h>
 #include <asm/facility.h>
diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
index 795853dfc46b..3a388e1c3631 100644
--- a/drivers/char/hw_random/s390-trng.c
+++ b/drivers/char/hw_random/s390-trng.c
@@ -23,6 +23,7 @@
 #include <linux/sched/signal.h>
 #include <asm/debug.h>
 #include <asm/cpacf.h>
+#include <asm/archrandom.h>
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("IBM Corporation");
diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf6144c1de7d..b696f5dd3241 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -55,6 +55,7 @@
 #include <linux/siphash.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
diff --git a/include/linux/random.h b/include/linux/random.h
index 2bdd3add3400..47e7cf126e8f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -151,8 +151,6 @@ declare_get_random_var_wait(long, unsigned long)
  */
 #include <linux/prandom.h>
 
-#include <asm/archrandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.38.1

