Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC026D0FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjC3UKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3UKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CF172A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13604620BE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DB6C433EF;
        Thu, 30 Mar 2023 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680207014;
        bh=65urcWDJM1aNO6xZxCWkwK2KeKrFuD7Q79vl5/+iSAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qjk+6lnbBXu33eRAEN5TzklCabFGfi+TkC/IEih7eBLKrE9s9kUY7cAnstztsGRxG
         H1qhQ9hK0FnoQZUFUUHBY4ZeZ1vl+mzRZrb/pvyYbR4qYgnuWjJTJuOjzLY0fVkCP4
         9OcykttciEicNRpp4A2ZV3dddXLPnBLaTMiMjbrE=
Date:   Thu, 30 Mar 2023 13:10:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hao Ge <gehao@kylinos.cn>
Cc:     alex.williamson@redhat.com, jgg@ziepe.ca, akrowiak@linux.ibm.com,
        arnd@arndb.de, mark.rutland@arm.com, ye.xingchen@zte.com.cn,
        ojeda@kernel.org, alex.gaynor@gmail.com, me@kloenk.de,
        gregkh@linuxfoundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gehao618@163.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RESEND PATCH] kmemleak-test: Optimize kmemleak_test.c build
 flow
Message-Id: <20230330131013.2685eeee5f7db76b850512ed@linux-foundation.org>
In-Reply-To: <20230330060904.292975-1-gehao@kylinos.cn>
References: <20230330060904.292975-1-gehao@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 14:09:04 +0800 Hao Ge <gehao@kylinos.cn> wrote:

> Now kmemleak-test.c is moved to samples directory,
> if CONFIG_DEBUG_KMEMLEAK_TEST=m,but CONFIG_SAMPLES
> is not set,it will be meaningless.
> 
> So we will remove CONFIG_DEBUG_KMEMLEAK_TEST and
> add CONFIG_SAMPLE_KMEMLEAK which in samples directory
> to control kmemleak-test.c build or not

Thanks.

I changed the patch title, reworked the changelog and added the Fixes:
information.  Please check all this carefully.



From: Hao Ge <gehao@kylinos.cn>
Subject: kmemleak-test: fix kmemleak_test.c build logic
Date: Thu, 30 Mar 2023 14:09:04 +0800

kmemleak-test.c was moved to the samples directory in 1abbef4f51724
("mm,kmemleak-test.c: move kmemleak-test.c to samples dir").

If CONFIG_DEBUG_KMEMLEAK_TEST=m and CONFIG_SAMPLES is unset,
kmemleak-test.c will be unnecessarily compiled.

So move the entry for CONFIG_DEBUG_KMEMLEAK_TEST from mm/Kconfig and add a
new CONFIG_SAMPLE_KMEMLEAK in samples/ to control whether kmemleak-test.c
is built or not.

Link: https://lkml.kernel.org/r/20230330060904.292975-1-gehao@kylinos.cn
Fixes: 1abbef4f51724 ("mm,kmemleak-test.c: move kmemleak-test.c to samples dir")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Behrens <me@kloenk.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Ye Xingchen <ye.xingchen@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/Kconfig.debug          |    8 --------
 samples/Kconfig           |    7 +++++++
 samples/Makefile          |    2 +-
 samples/kmemleak/Makefile |    2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

--- a/mm/Kconfig.debug~kmemleak-test-optimize-kmemleak_testc-build-flow
+++ a/mm/Kconfig.debug
@@ -249,14 +249,6 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
 	  fully initialised, this memory pool acts as an emergency one
 	  if slab allocations fail.
 
-config DEBUG_KMEMLEAK_TEST
-	tristate "Simple test for the kernel memory leak detector"
-	depends on DEBUG_KMEMLEAK && m
-	help
-	  This option enables a module that explicitly leaks memory.
-
-	  If unsure, say N.
-
 config DEBUG_KMEMLEAK_DEFAULT_OFF
 	bool "Default kmemleak to off"
 	depends on DEBUG_KMEMLEAK
--- a/samples/Kconfig~kmemleak-test-optimize-kmemleak_testc-build-flow
+++ a/samples/Kconfig
@@ -273,6 +273,13 @@ config SAMPLE_CORESIGHT_SYSCFG
 	  This demonstrates how a user may create their own CoreSight
 	  configurations and easily load them into the system at runtime.
 
+config SAMPLE_KMEMLEAK
+        tristate "Simple test for the kernel memory leak detector"
+        depends on DEBUG_KMEMLEAK && m
+        help
+          Build a sample program which have explicitly leaks memory to test
+          kmemleak
+
 source "samples/rust/Kconfig"
 
 endif # SAMPLES
--- a/samples/kmemleak/Makefile~kmemleak-test-optimize-kmemleak_testc-build-flow
+++ a/samples/kmemleak/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
+obj-$(CONFIG_SAMPLE_KMEMLEAK) += kmemleak-test.o
--- a/samples/Makefile~kmemleak-test-optimize-kmemleak_testc-build-flow
+++ a/samples/Makefile
@@ -33,7 +33,7 @@ subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
-obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
_

