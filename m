Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E75E6CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiIVUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiIVUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:08:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC7E4D80;
        Thu, 22 Sep 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877312; x=1695413312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=v8yPnByOxolH3y3Ja7dBlrus/vQe6rAVnEPjft+iu64=;
  b=NHbvyv89nnSIp472EKBVd2ltCy2rlZTexivLxV7iEm84TjVFm3Ti3pHJ
   qA820PIBYVb5gXDhpeOYuBzUCpTwdxKTw8NY+swCgxKh2a4Uw4pujePvO
   2MKilWipFJ/JReXegawbH3q1t4G44n7WZvu7S5i/AsufsQwYR7cFQdLr8
   bWX0IbcUwd+3Ou9c8hoH93jVecEO6n/GpNWZ7lQsQPDjf9NfVpBO+qGJ/
   bK65yx7v1VyVRldYq5sfU5KxO+5pHgze+dWdom+MfbJAIH6myb/DdZ0ug
   sQY/e7Bd8EzjcUeJW17zIkn+amYyr1YQ5YQysC/ZjNndxoUFKd8nXV8fG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362221577"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362221577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571117136"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 13:08:14 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 2/4] x86/arch_prctl: Add AMX feature numbers as ABI constants
Date:   Thu, 22 Sep 2022 12:58:08 -0700
Message-Id: <20220922195810.23248-3-chang.seok.bae@intel.com>
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

AMX state is dynamically enabled by the architecture-specific prctl().
Expose the state components as ABI constants. They become handy not to be
looked up from the architecture specification.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Add as a new patch (Tony Luck).
---
 arch/x86/include/uapi/asm/prctl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..f298c778f856 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_XCOMP_TILECFG		17
+#define ARCH_XCOMP_TILEDATA		18
+
 #define ARCH_MAP_VDSO_X32		0x2001
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
-- 
2.17.1

