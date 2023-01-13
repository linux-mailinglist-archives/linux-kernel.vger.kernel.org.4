Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC8668826
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbjAMALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbjAMALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F950F59;
        Thu, 12 Jan 2023 16:11:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832D5621E4;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C6C433D2;
        Fri, 13 Jan 2023 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568694;
        bh=v3kfTmDwMfPA9Xint1FI2BqTjFB4FQUN1LL/8emmuPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6uNflm9Rm7u8C2JOcazN73o27Mc8b4r1r/9WwcXBq3ijw8Ojd/+4wH4FDvAwuhm5
         6cWj97Cs6XI1Q2OMhHHbUNSS4k2rJyT8vQFW0aqaMNi2X4U+pLlM7F9OgY0Dh69YYb
         YEuhoX5yS9U7h5Fya/vZm8KJdahywkioJh6vhPn494eFYytoee3CmMACuOtSDCy3+D
         JMsgrw35z8Flhq4FErQJV4uyZzry9bsYkoY9YMBclbBWku8QYnxe4OvOiLW1pJHdkU
         bbjEHtlyQUTxnw+bpwA1LRATJSQykJ7c73B6uPw0ZVTYwW1hzYubjTGH0MUuTgiZ1g
         FarGMsBFDIzFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9626D5C09F1; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 01/20] arch/x86: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:13 -0800
Message-Id: <20230113001132.3375334-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 3604074a878b8..4a9175fe7dd18 100644
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
2.31.1.189.g2e36527f23

