Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145C699C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBPSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:42:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54569766;
        Thu, 16 Feb 2023 10:42:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5C962067;
        Thu, 16 Feb 2023 18:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2134C433D2;
        Thu, 16 Feb 2023 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676572972;
        bh=TlkXm7VNtzsJ7EfaEbNCQ0jrF6Prk2gRLM56xZV0kHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKpTH6Xma+bwkChOl4NLqIndv0Q0HNEGdo6fSGe2zx9UY2BJokLjGScUyDUFIyjs9
         wHG7zTGmWy1W1NXsvoAG52q2DP0SVTJfLhB/sg40zsXEkiXxqQfCmiK5HkoaXoi50K
         RajXDINrwduwnFFcetLEurxPZRsCdQSD9lXzw5lPbEjrfxkkYiP49ODJA32x+gCeCZ
         Qz7xF5LCN8Pkp+5JWe3iXQAVfIJDqbiEKe6CoSERnlnc9RX8jR98iPo7qWnXozME9c
         lzv2gmFirTvDhgkYO8L7uGcZgBqTJWPnxzROBXQ924iZHTN2zPNmp9qGv97dKbm8K7
         3PR4cj03EaGxg==
Date:   Thu, 16 Feb 2023 10:42:49 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
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
Subject: [PATCH v2.1 09/24] mips/cpu: Expose play_dead()'s prototype
 definition
Message-ID: <20230216184249.ogaqsaykottpxtcb@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
 <080a5ccb-7fa0-1a75-538f-a09dc146fc4e@linaro.org>
 <20230214181101.3a2tscbmwdnwbqpu@treble>
 <c56dc4b9-035d-7773-ecb2-0e1ac6af7abc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c56dc4b9-035d-7773-ecb2-0e1ac6af7abc@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <asm/smp.h> to make sure play_dead() matches its prototype going
forward.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/cavium-octeon/smp.c | 1 +
 arch/mips/kernel/smp-bmips.c  | 1 +
 arch/mips/kernel/smp-cps.c    | 1 +
 arch/mips/loongson64/smp.c    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 89954f5f87fb..4212584e6efa 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -20,6 +20,7 @@
 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/smp.h>
 
 #include <asm/octeon/octeon.h>
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index f5d7bfa3472a..df9158e8329d 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -38,6 +38,7 @@
 #include <asm/traps.h>
 #include <asm/barrier.h>
 #include <asm/cpu-features.h>
+#include <asm/smp.h>
 
 static int __maybe_unused max_cpus = 1;
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bcd6a944b839..6d69a9ba8167 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -20,6 +20,7 @@
 #include <asm/mipsregs.h>
 #include <asm/pm-cps.h>
 #include <asm/r4kcache.h>
+#include <asm/smp.h>
 #include <asm/smp-cps.h>
 #include <asm/time.h>
 #include <asm/uasm.h>
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 660e1de4412a..4e24b317e7cb 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/kexec.h>
 #include <asm/processor.h>
+#include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
-- 
2.39.1

