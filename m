Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424747235D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjFFDk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjFFDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:40:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420631BF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686022843; x=1717558843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFLHxFEm3u0GWuWSqbjdKs9lBf/QVQCUmYEP1/nyvz8=;
  b=RhZxegZjVvYuBejUROa+i0OlNqcGxd0XbFR0afRx6pKDpAbFPa7RQgkB
   WVhI6SjZqboOX6BgQHJQU9MrFdccNYF7TM42qhKzcYqwxYhtdi0wWUCuq
   F0cpDqBeJf5clGbBLxngePzWKhExdWDXKMtHmTwHpyaHnpr0pVeh+jgMQ
   S6px9niNCLjKJC5/pMjKrKyQDe2Zn1tHOueMP78hYTjEA7PzKCtCyKVh7
   nF8iPBv8I23dN8hZ+fZuhrQgW9Z4I78wJj8TAo1qCMS2TFNdkHI3D9bGX
   f9MA9Hpyb//Ui1t8yjU5rGk8P9iiYba9kVupV8+e02cEWlFmcFOBJ+2gO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341192090"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="341192090"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853237591"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="853237591"
Received: from nataliai-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.159.2])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:40:23 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in <asm/tdx.h>
Date:   Tue,  6 Jun 2023 15:40:00 +1200
Message-Id: <20230606034000.380270-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in <asm/tdx.h> tdx_kvm_hypercall() simply returns -ENODEV
when TDX guest isn't enabled in the Kconfig w/o having <linux/errno.h>
header explicitly included.  Although the current code doesn't have
build error, in general it is a good practice to explicitly include the
header to make sure any future patch which uses <asm/tdx.h> won't get
build error due to error code not being defined.

Fixes: cfb8ec7a31f2 ("x86/tdx: Wire up KVM hypercalls")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/tdx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 28d889c9aa16..0f303c9abee8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,7 @@
 
 #include <linux/init.h>
 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 

base-commit: 122333d6bd229af279cdb35d1b874b71b3b9ccfb
-- 
2.40.1

