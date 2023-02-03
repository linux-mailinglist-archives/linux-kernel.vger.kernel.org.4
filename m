Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7368A5C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjBCWJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjBCWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:08:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D939AF0DE;
        Fri,  3 Feb 2023 14:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F4222CE31C3;
        Fri,  3 Feb 2023 22:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF46C4339C;
        Fri,  3 Feb 2023 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461975;
        bh=bXJvKHvsodpO0BPlco2s0aMLVPJi3gp9AhXx9K2v2Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2rixxjxWrJRRyUMI/UIOonFKDfpZNhS5xd+/8CuXK0prPGkQnnv9Kfg10DIKZOUJ
         TnQ9bBPlqmYQDrXpQSFxMhJGIKsE/V+npKts3TEZNdT8iuM0s9Iq/8P0rYPzPyZwJ4
         Jh6lhsIXNcEbx1B5mweJ3CQge57WG2SQxBM/6jESjWiE44sc6FKSEPhym1/PqmwKMO
         nhRytRWxyWzWSDDhS1ZWNY+LxbnIUqHAkuGjhF7/fQVzkTW/gQPTqo4uppxXJbVsVu
         u2gxECq3yVWPrt2pTsvgswuFgQhH6K6nVThvA924uuSIhWhkbCYXj3lDMkpQXXw5sZ
         tcWARjjzt2M+A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: [PATCH 18/22] x86/cpu: Mark play_dead() __noreturn
Date:   Fri,  3 Feb 2023 14:05:27 -0800
Message-Id: <6e322880a30ed582847702f400fa99f55be821d3.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/process.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 8f628e08b25a..e6d1d2810e38 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -93,7 +93,7 @@ static inline void __cpu_die(unsigned int cpu)
 	smp_ops.cpu_die(cpu);
 }
 
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	smp_ops.play_dead();
 	BUG();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b650cde3f64d..f1ec36caf1d8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -715,7 +715,7 @@ static bool x86_idle_set(void)
 }
 
 #ifndef CONFIG_SMP
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	BUG();
 }
-- 
2.39.0

