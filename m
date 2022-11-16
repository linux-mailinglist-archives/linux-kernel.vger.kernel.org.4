Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7A62B033
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKPAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:44:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DDF2BB15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559445; x=1700095445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tx19St9qzi0HfKCU80s71CDjOvtppRUy1zquC1kpDYM=;
  b=QWcsbQT8PktRUKx+mk+1Ijk0qlzdQu37u8+bN+DR+4kshHfGm1rkezeM
   LioqLDKtlHQCzA/WPTr/6rH/rBj7bgIdNcIp+jOW1MjwcTpTlh/rLtKId
   PHhBUNIgAvZyytAkqicx4ACxhipp/QB1ovpzCfP61r78f3wLw8rPKeXkc
   q9p+Y+waac5rGyotxyNoGHwNEaZLNFDTU42r7H+9rMLMgoCGcz3Xt9d5+
   Rsptbxc+D0k/v38D8ks1mshGlbdrU3VE+p0GFvzDFlY4H/iMs8hr9sSAU
   anZS8ElYltWBIg7X8341l0P9W8Q3za1eURG7YhNjOagx2fgtbIz3boo6E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292800212"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292800212"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968210385"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968210385"
Received: from nrobin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.45.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:01 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 23AB810446E; Wed, 16 Nov 2022 03:43:59 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill@shutemov.name
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        jejb@linux.ibm.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        martin.petersen@oracle.com, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org
Subject: [PATCH 2/2] x86/mm: Fix sparse warnings in untagged_ptr()
Date:   Wed, 16 Nov 2022 03:43:53 +0300
Message-Id: <20221116004353.15052-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking patchset triggered a lot of sparse warnings.

The root cause is that casting pointer to '__typeof__(*(ptr)) *' will
strip all sparse tags. The type has to be defined based on the pointer
type, not based on what the pointer points to.

Fix cast in untagged_ptr() and avoid __typeof__() usage in
get/put_user().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/include/asm/uaccess.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1d2c79246681..bd92e1ee1c1a 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -43,7 +43,7 @@ DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
 #define untagged_ptr(mm, ptr)	({					\
 	u64 __ptrval = (__force u64)(ptr);				\
 	__ptrval = untagged_addr(mm, __ptrval);				\
-	(__force __typeof__(*(ptr)) *)__ptrval;				\
+	(__force __typeof__(ptr))__ptrval;				\
 })
 #else
 #define untagged_addr(mm, addr)	(addr)
@@ -158,10 +158,8 @@ extern int __get_user_bad(void);
  */
 #define get_user(x,ptr)							\
 ({									\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_get_user_call(get_user,x,__ptr_clean);			\
+	do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
@@ -263,10 +261,8 @@ extern void __put_user_nocheck_8(void);
  * Return: zero on success, or -EFAULT on error.
  */
 #define put_user(x, ptr) ({						\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_put_user_call(put_user,x,__ptr_clean);			\
+	do_put_user_call(put_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
-- 
2.38.0

