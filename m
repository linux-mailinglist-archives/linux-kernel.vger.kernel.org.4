Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3C695A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBNHJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjBNHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB771E1C9;
        Mon, 13 Feb 2023 23:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D17761462;
        Tue, 14 Feb 2023 07:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5083EC433D2;
        Tue, 14 Feb 2023 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358442;
        bh=2hxyWMtg3qxmQjhBEluIl/tRKP8X+GwBr5MgjENjNlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuohZJZaQgSpW4PNmGOGgvGy5cTg/0OUzSzqmcDohcYVEnfiFYGENb4NGucvlv0Gx
         anWdKfZuIgLNgf+y4nCfCNeS1o3bdNwyrq4xaNuuuJ05y1uwPyDxZKJrJJQEBZ2Gu9
         JtV1n64jmwGGQxJR/IMbZBlxrFl15/Up5U8Zli0cw05zAglUisySLslJZovTubsbPf
         cK9/hfHIUJowq+jMsn/kL34u804BcBYyKT/hAtlTopsvrJJ+t5iQtHShyWS1PsPjKH
         2uDWvN9/CoD/8fn4NPNGZ8GBjHmbCOWVu5OuEQXJvNul7BccgM6smZdc+l51S9/vmp
         9L+2qpthjzEmg==
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
Subject: [PATCH v2 18/24] x86/cpu: Mark play_dead() __noreturn
Date:   Mon, 13 Feb 2023 23:05:52 -0800
Message-Id: <f3a069e6869c51ccfdda656b76882363bc9fcfa4.1676358308.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
References: <cover.1676358308.git.jpoimboe@kernel.org>
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
index e57cd31bfec4..4433d13edd44 100644
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
2.39.1

