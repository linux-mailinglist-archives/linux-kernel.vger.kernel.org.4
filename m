Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F867626B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjAUAbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjAUAbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:31:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC21420F;
        Fri, 20 Jan 2023 16:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674261079; x=1705797079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YMQAWurETlSCjBbvjxddlKNJW8TpNQNrIE4e8GG/gJs=;
  b=DANXdSbgFMJ+MkCkaczkA3VB+vXSHQuaFTXk3mpJNH3Y7LSro3/o4XRY
   ejgoYrQLvzE6OV9MnGZA/uZWIGVruVc+X7DBNCdVOH1DmQbE+atwdMH1z
   7rpVxs+H+Yv5CsQ/I0sWwRBILH8DY3/0BsCLNUFaBcGXHZWb6MPKtv42Y
   i5/WZN1SGyhkSk7XkqQDvs08ZV7sFgk3QLNuuhrihlH5fSMrx2wun4WBK
   YOyt4s0Ufx7rIFM6sa6xpfaECZ/c6dRvncLi7i+Vx+4LmdsJrY3xAH+lw
   niYx1VTdZFcNBvqnTLRUivplaVztDgg3AHZQaupDTbySOWEN+kj32pqho
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305404609"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305404609"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="784729483"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="784729483"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 16:30:16 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@linux.intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 RESEND 1/4] Documentation/x86: Explain the purpose for dynamic features
Date:   Fri, 20 Jan 2023 16:18:57 -0800
Message-Id: <20230121001900.14900-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230121001900.14900-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
 <20230121001900.14900-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

