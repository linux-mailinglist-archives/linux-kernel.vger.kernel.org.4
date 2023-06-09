Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23372A101
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFIRNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFIRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:12:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0B1734
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686330767; x=1717866767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQeK8cRefKQp/n56iwZnAne7cbfUjkNfhV5SR+TckvM=;
  b=NP5G2np32NyJUPb0/uDiSyJpFNnIAXoRj1YY11qfuLM6qIzhtLBSrrnP
   MNqGrP7KmQQZtFhawbYmIGK3WrV+iJ21RyyD37UWrG2Yi2I5o+XMLa4la
   U3WZKiOxAf3n5+aunOha81HYKo+V1EZn9UUR/yxCuZG9LIZfrkj7s8enG
   KZxFaLB1iJut/CufCCHFJk3ZXQmlYELYOEpRZ6nocdy0EaynZVvq5uKy9
   GkrE9qNi2pdlXYb+x5W7eudwvwL6WZrKOwHcASPmsszVIy1DIUztuuYWA
   DD94gCQomQ8o/0p7mXxFEFIIYB+PnzEQxLtMIHnWRKgWVeM6/L2TBKfP/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357647346"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357647346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="660824653"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="660824653"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 10:12:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 2/2] x86/sev: Drop unneeded include
Date:   Fri,  9 Jun 2023 20:12:14 +0300
Message-Id: <20230609171214.31846-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
References: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 20f07a044a76 ("x86/sev: Move common memory encryption code to
mem_encrypt.c") forgot to remove the include of virtio_config.h from
mem_encrypt_amd.c when it moved the related code to mem_encrypt.c (from
where this include subsequently got removed by a later commit).

Remove it now. No functional changes.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/mm/mem_encrypt_amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b1edeb8642b8..30dc5f1978ab 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
-#include <linux/virtio_config.h>
 #include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
-- 
2.39.2

