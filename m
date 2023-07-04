Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324D2746C81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGDI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:58:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8EE127
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688461104; x=1719997104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Wgbu7wK7rFcmaZB1337sSETmf/kxZ+SZA/q+zURtiA=;
  b=ThDc/TAZ1bolFr5QkM4rsrOv01+ah6RahK5C1y627Q904XI0RQh8qxaI
   n3cqxnXcMSzwb8BeKNN4Z37KiI+XvLIaD2aDCrPwgeeyjMJ6bJ3/AzXsl
   oFPfxvTI2JxBhlAhJxPzAMd4hmHf4c5Y+E+PLFJKgogEIO1P5bQSDIA4e
   +HeHxmHhu25jxUbBftS9WUXJRw2BArcD01D45bmrI6Yoft7DnePEz6UOB
   k/IR1jcDF3viG3C4gB2qJ64NuGOApwLhs1f/VP9dnZhuz7ntOCQ7wski6
   ZIKh5tOkWxhRgSh+RfZ4a+8LpPDWswj1h0P7/ZtMr0gFvK+YlBzlBHCjp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352902743"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="352902743"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 01:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="784156657"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="784156657"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2023 01:58:21 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     dvyukov@google.com, nogikh@google.com, linux-kernel@vger.kernel.org
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        syzkaller@googlegroups.com, keescook@google.com,
        Mehta Sohil <sohil.mehta@intel.com>,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Subject: [PATCH v1 1/1] x86/kernel: Increase kcov coverage under arch/x86/kernel folder
Date:   Tue,  4 Jul 2023 17:00:41 +0800
Message-Id: <582ab7050597df7a996c11df048f168995b30747.1688460800.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1688460800.git.pengfei.xu@intel.com>
References: <cover.1688460800.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kcov instrument is disabled for object files under arch/x86/kernel
folder.
For object files under arch/x86/kernel, actually just disabling the kcov
instrument of files:"head32.o or head64.o and sev.o" could achieve
successful booting and provide kcov coverage for object files that do not
disable kcov instrument.
The additional kcov coverage collected from arch/x86/kernel folder helps
kernel fuzzing efforts to find bugs.

Link to related improvement discussion is below:
https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
Related ticket is as follow:
https://bugzilla.kernel.org/show_bug.cgi?id=198443

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 arch/x86/kernel/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4070a01c11b7..00df34c263cc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
 
-# If instrumentation of this dir is enabled, boot hangs during first second.
-# Probably could be more selective here, but note that files related to irqs,
-# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
-# non-deterministic coverage.
-KCOV_INSTRUMENT		:= n
+# If instrumentation of the following files is enabled, boot hangs during
+# first second.
+KCOV_INSTRUMENT_head$(BITS).o				:= n
+KCOV_INSTRUMENT_sev.o					:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.31.1

