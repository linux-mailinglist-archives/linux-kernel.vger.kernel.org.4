Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEF5B409B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiIIU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIIU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:26:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE2F6B8D;
        Fri,  9 Sep 2022 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662755138; x=1694291138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZjDsoVe/m26NmdDU80Jql+Vu5NT9QFMQwUPtL9OGYPw=;
  b=E5sxz112FhR+H+MAqzCMy4LbDtZl2pzraWAAWsnVJncJZufkSIXLojxP
   m4NlWsSDK06yJD+m8d4U0DDBH56K60UKOT1hknEYWvcGLDinh/79JdsmL
   F6EfIqs1403A/yMC74fIb+2M5SvDZLCeswkRZ3Pu46Q34tYwBJz9MRvJk
   jLJO7M0HwQxhvRsYLl5vD1mxyO7IKOnONXyo1oXI74mBl2pdO3uNasU5T
   uDjt4BcKwpE3VxP4NoOXXYWZHu7fyTpDuyyzGObniHTcFQCz9mL/8Kann
   ClbROca8v0cj114Yy/A2FNViuQUiLUKUd6TmWqG5DTs+MGmHI8axMsq7m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280584699"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="280584699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="611162993"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2022 13:25:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v4 1/4] Documentation/x86: Explain the purpose for dynamic features
Date:   Fri,  9 Sep 2022 13:15:37 -0700
Message-Id: <20220909201540.17705-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909201540.17705-1-chang.seok.bae@intel.com>
References: <20220909201540.17705-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Changes from v3:
* Add as a new patch (Tony Luck).
---
 Documentation/x86/xstate.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 5cec7fb558d6..2577b28ad942 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -11,6 +11,20 @@ are enabled by XCR0 as well, but the first use of related instruction is
 trapped by the kernel because by default the required large XSTATE buffers
 are not allocated automatically.
 
+The purpose for dynamic features
+--------------------------------
+
+ - Legacy userspace libraries have hard-coded sizes for an alternate signal
+   stack. With the arch_prctl() options, the signal frame beyond AVX-512
+   and PKRU will not be written by old programs as they are prevented from
+   using dynamic features. Then, the small signal stack will be compatible
+   on systems that support dynamic features.
+
+ - Modern server systems are consolidating more applications to share the
+   CPU resource. The risk of applications interfering with each other is
+   growing. The controllability on the resource trends to be more
+   warranted. Thus, this permission mechanism will be useful for that.
+
 Using dynamically enabled XSTATE features in user space applications
 --------------------------------------------------------------------
 
-- 
2.17.1

