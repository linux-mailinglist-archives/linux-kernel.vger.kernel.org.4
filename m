Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234B676271
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAUAb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjAUAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:31:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29DDFF13;
        Fri, 20 Jan 2023 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674261085; x=1705797085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=v8yPnByOxolH3y3Ja7dBlrus/vQe6rAVnEPjft+iu64=;
  b=OCaO3Qr6DVgQZRvgrGsQtBg83/tU7y6WFHokyBLjj09uF25OlukilrDb
   7UX/Fk3Yv10tgiiJgv38BnnKF9HJunhNv+vZBC/2JLvmLnkPwQ/ntvUiE
   rWFcMzVSywPgUEy6nzLH2x9R33ron45VkxlEEpqFjSyYNGtu065fACw9f
   zKw+ktV4+6VwWFlTcgJq8luJMY47SMl/TE01LyEnk6OkK8Gu8IDz+OMBW
   2j6NM01gO3BKv83I0SgwOIkwO7RyGFKXp8ATBZYGq747IxvGLhhWwu9GM
   B/7oohh20b8sIXs0NvNwxoJKLPjagBmR3qSwtfqvZWwAiacerrAQpYHk9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305404624"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305404624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="784729488"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="784729488"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 16:30:16 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@linux.intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 RESEND 2/4] x86/arch_prctl: Add AMX feature numbers as ABI constants
Date:   Fri, 20 Jan 2023 16:18:58 -0800
Message-Id: <20230121001900.14900-3-chang.seok.bae@intel.com>
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

