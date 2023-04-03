Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559D6D430F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDCLLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjDCLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:11:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26CB35A9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680520232; x=1712056232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6n3D4JZD6jPRhROHlLAaHVSb3yrYur06jnlZ91gKLc=;
  b=YB+wS6qPVTikLkQg7M14hCFeTApAQ2tyH0UAbduFWdSYcMkRfARNkunD
   3kj1VUM/c+RCJL5irsALtzB/he/241FfkvQtOW2pHmSh13cPD6X6+JKj+
   raaICOooXOOuzXXOpuOR6nJvAfKWv+K1nmCRqTTscjLuw0aJanarVFVyZ
   ADFkYz7Dv0hvbCdh5WGlGtQVBAOofeLMNf6ClWxK37hTeNvJ4miii3KNF
   a2eh4BDccyibHy0Ohr4EN1ylOWvraJgYV/FEHF82cFnQeUShMw0qApRrc
   q+v6AJsbL0Q1Kda3nT0aVTkboleEID9vK4wNl67GDY/df+pnQplwfqSdl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="341895521"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="341895521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="663165543"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="663165543"
Received: from amomin-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.227])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F205610DFD3; Mon,  3 Apr 2023 14:10:23 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA bit from outside
Date:   Mon,  3 Apr 2023 14:10:20 +0300
Message-Id: <20230403111020.3136-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_prctl(ARCH_FORCE_TAGGED_SVA) overrides the default and allows LAM
and SVA to co-exist in the process. It is expected by called by the
process when it knows what it is doing.

arch_prctl() operates on the current process, but the same code is
reachable from ptrace where it can be called on arbitrary task.

Make it strict and only allow to set MM_CONTEXT_FORCE_TAGGED_SVA for the
current process.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/kernel/process_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c7dfd727c9ec..cefac2d3a9f6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -885,6 +885,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
 	case ARCH_FORCE_TAGGED_SVA:
+		if (current != task)
+			return -EINVAL;
 		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
 		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
-- 
2.39.2

