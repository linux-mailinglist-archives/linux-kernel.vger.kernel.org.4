Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F56663CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjAKTdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjAKTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:33:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23216498;
        Wed, 11 Jan 2023 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673465585; x=1705001585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0cOJw84V6/UKZ6A9b4jwVD33YpuY7WN9o7pXNfDH4kA=;
  b=g4jrhCCrTFyqHGZ1lB6RWLacwiOMPgxrBM9E82FXFf0cFB77dHq/x7zW
   CNlTw/vi7LCz422hii6IGu5QW6JVgtzwiIWnzqYinthi6rm500ZMo8cIu
   MvtCTqmle1apV8AbRCm/gWuZXaCpLDSqq7MsShfYFtdIS9b6MppR0x1Op
   Qgezj6dMi+0hffhnFhw2cHKX9FQZd+PWqwpS/oh9fWp6ZnxZG0/CwIGW1
   BxXg3EIjfkTVBv/vVRtCaK6NMnyJTGE3nHrMz2Iy5ofhiM8b9et8dxWlB
   UWRWUrBJptKHvDtx4i9qPnzi50NgSOgYO/TSHQmj0uoX++h6wtthrzuGu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385828038"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="385828038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 11:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746281835"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="746281835"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2023 11:33:04 -0800
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/vsyscall: Fix documentation to reflect the default mode
Date:   Wed, 11 Jan 2023 19:32:11 +0000
Message-Id: <20230111193211.1987047-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default vsyscall mode has been updated from emulate to xonly for a
while. Update the kernel-parameters doc to reflect that.

Fixes: 625b7b7f79c6 ("x86/vsyscall: Change the default vsyscall mode to xonly")
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Do documentation fixes typically get backported to stable? I haven't included
a stable cc assuming they do not.

 Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..87f0b645922c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6756,11 +6756,11 @@
 			functions are at fixed addresses, they make nice
 			targets for exploits that can control RIP.
 
-			emulate     [default] Vsyscalls turn into traps and are
-			            emulated reasonably safely.  The vsyscall
-				    page is readable.
+			emulate     Vsyscalls turn into traps and are emulated
+			            reasonably safely.  The vsyscall page is
+				    readable.
 
-			xonly       Vsyscalls turn into traps and are
+			xonly       [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.  The vsyscall
 				    page is not readable.
 
-- 
2.34.1

