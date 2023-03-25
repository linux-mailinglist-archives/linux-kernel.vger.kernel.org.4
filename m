Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0CB6C9081
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCYTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:34:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5DCDED
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679772859; x=1711308859;
  h=from:to:cc:subject:date:message-id;
  bh=jdQMrjyXEjETIE5OO4zUf/1YC69vzcHfW315iYpfUEE=;
  b=A7CE/q4o2BQKSKiZLc+55PheDjERaCghhGK33+ISoh5hsx99c3hrGLrr
   Dd68zcAduJxQDq1wEeHZnlUt88HwcEvtv1gIF42RhPgF9B5QbgrCQPml5
   wlOUJBYzX2Xdy0g3dandjho/M/IbfLPsl30Ig9yCY2ryT2Lnaond0QOY2
   rX9Jb0mpNyi89bewr2lNPouekS8eaa5duqV3GZwvBxK2+/ytM6ArVGaDH
   NrAWHtnIInPy6MWd27EO+isc+7+U6r4OY54uxPfTwQEKOh52g99JULZiC
   06NS7hqrvTUQLrvKI7NoA/NcaKGAZ+x/32Dn/stuU/mefXy99DvCB+pjU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="323891537"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="323891537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 12:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="857237873"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="857237873"
Received: from rameshp1-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.109.233])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 12:34:18 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH] x86: Enforce only whole copies for ssp_set()
Date:   Sat, 25 Mar 2023 12:33:49 -0700
Message-Id: <20230325193349.31893-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regset set interface takes pos and count arguments to allow for
partial copies. No callers use a non-zero pos, but ptrace allows for the
count to be specified. It limits count to be a multiple of regset size, so
this still allows for a zero size to be passed to ssp_set().

In ssp_set(), user_regset_copyin() returns success for copying zero bytes,
which means user_ssp can later be accessed uninitialized. So add
enforcement for this case. The other regset's also enforce pos == 0, so do
that as well even though there is no caller today.

In the case of partial copies, some regsets return -EINVAL and some
return -EFAULT. -EINVAL seems more appropriate, so use that error code.

Fixes: d84e6ee122e5 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/90af27cc-6c9d-4fb9-be3b-fc4ef378766d@kili.mountain/
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Hi x86 maintainers,

While debugging this I wrote a shadow stack ptrace selftest that tries
a bunch of invalid values. I thought to save it for a future series
with selftests enhancements, unless you'd like to see it sooner.

Thanks,

Rick
---
 arch/x86/kernel/fpu/regset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index f0a8eaf7c52e..6bc1eb2a21bd 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -223,6 +223,9 @@ int ssp_set(struct task_struct *target, const struct user_regset *regset,
 	    !ssp_active(target, regset))
 		return -ENODEV;
 
+	if (pos != 0 || count != sizeof(user_ssp))
+		return -EINVAL;
+
 	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_ssp, 0, -1);
 	if (r)
 		return r;

base-commit: b642e9e5f0dc797f543b431d4ba910a3da72a074
-- 
2.17.1

