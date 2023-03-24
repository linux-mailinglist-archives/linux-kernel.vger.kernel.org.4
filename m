Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E16C8718
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjCXUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCXUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:52:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A71F5FD;
        Fri, 24 Mar 2023 13:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1394B825E6;
        Fri, 24 Mar 2023 20:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A9EC4339B;
        Fri, 24 Mar 2023 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691170;
        bh=tOxw83oZFLY5cLM0Umf91sclKQV9Ud5SQytulJUtscU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TH7o1ZuA9ZZ70h+ls2Pj+OberIHACnPGoD9DibZQ0YSx/fWOnmnXdNaXI9iJjJc0V
         hc4rpe9zAYnGKrN4H4iSbprs7tgVnzy4YCXlIvpxvubJdVwZ8wZJn9dOeI83pjAbix
         CzfN1gC6O18QBCKsMS5mYcw/bmd7XU9Et7cOL9KXTx0C6hit/SSfdDr8Vmm5BkSpbB
         cuy50ftXkLyQHC+C3s/WJoNuQziZZwzatBxsyQefT+S+6mgtzhx7y6tLcYGQ6KtwfL
         NphMxLnzIv0my4Q/X8cL3MyXN8wtcuHp2ZFuNE+dIwcMTrynoSvobpakAYjWQfVOXA
         7/zTe/0+1REdw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C1B21540432; Fri, 24 Mar 2023 13:52:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v3 1/4] arch/x86: Remove "select SRCU"
Date:   Fri, 24 Mar 2023 13:52:46 -0700
Message-Id: <20230324205249.3700408-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
References: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 arch/x86/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..947e24714c28 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -283,7 +283,6 @@ config X86
 	select RTC_LIB
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
-	select SRCU
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
@@ -1938,7 +1937,6 @@ config X86_SGX
 	depends on X86_64 && CPU_SUP_INTEL && X86_X2APIC
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
-	select SRCU
 	select MMU_NOTIFIER
 	select NUMA_KEEP_MEMINFO if NUMA
 	select XARRAY_MULTI
-- 
2.40.0.rc2

