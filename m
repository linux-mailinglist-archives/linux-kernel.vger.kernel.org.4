Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8344C5E6CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiIVUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiIVUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:08:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49FE6A39;
        Thu, 22 Sep 2022 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877310; x=1695413310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YMQAWurETlSCjBbvjxddlKNJW8TpNQNrIE4e8GG/gJs=;
  b=ixR2OUx6+uGs5FmzLkBT5+BWXTGFO4EkwbIWO05ZFP9mXD0ArIoh1j68
   ynYtdAH0lWcz7DpTPzkH8FyAZsnt4Ek9KJX9oYZ+Tcy/UO3drZCRsFRsN
   Zl6IofT4vH96onKwtopi8TmcEB3RVfkWwu8h6xcQeEqKQW19HgD4e6J8y
   6EyzMS1Ah7G3wXUuHwfnhMGMddjrntxixCS2loCVWvgPNVl88QubG2vLV
   /Cg647H4fYb/IdLJP93rZN876CRraVPqKbop8YgcCpjIkCVTKLMV5uOMk
   tMmWbYhlYvUz5JpWcXuEBZjWp9gPzW+Us1+Hj+UrktCIsC2+OjZZR+Tnk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362221576"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362221576"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571117133"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 13:08:13 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 1/4] Documentation/x86: Explain the purpose for dynamic features
Date:   Thu, 22 Sep 2022 12:58:07 -0700
Message-Id: <20220922195810.23248-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922195810.23248-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This summary will help to guide the proper use of the enabling model.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes from v4:
* Re-write about the sigaltstack sizing (Dave Hansen).
* Drop the second point as the case is not clear yet.

Changes from v3:
* Add as a new patch (Tony Luck).
---
 Documentation/x86/xstate.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 5cec7fb558d6..e954e79af4ce 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -11,6 +11,22 @@ are enabled by XCR0 as well, but the first use of related instruction is
 trapped by the kernel because by default the required large XSTATE buffers
 are not allocated automatically.
 
+The purpose for dynamic features
+--------------------------------
+
+Legacy userspace libraries often have hard-coded, static sizes for
+alternate signal stacks, often using MINSIGSTKSZ which is typically 2KB.
+That stack must be able to store at *least* the signal frame that the
+kernel sets up before jumping into the signal handler. That signal frame
+must include an XSAVE buffer defined by the CPU.
+
+However, that means that the size of signal stacks is dynamic, not static,
+because different CPUs have differently-sized XSAVE buffers. A compiled-in
+size of 2KB with existing applications is too small for new CPU features
+like AMX. Instead of universally requiring larger stack, with the dynamic
+enabling, the kernel can enforce userspace applications to have
+properly-sized altstacks.
+
 Using dynamically enabled XSTATE features in user space applications
 --------------------------------------------------------------------
 
-- 
2.17.1

