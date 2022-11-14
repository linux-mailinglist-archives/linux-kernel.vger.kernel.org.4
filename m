Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3A627C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiKNL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiKNL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:28:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E922F;
        Mon, 14 Nov 2022 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668425303; x=1699961303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gR6BZJ2tZuQtMsb7/ERq8PsqpuT7Uc3t1sGvFFJF/U0=;
  b=IU24lA4i6wHniVfKS1NCOlv0T6fw25/avpuwt+CYLSfS6czNFQFTyeIL
   aQqM1l8dhVGCgZ/LMC9JrHVirIsjs2ZLMSpHT9fGyxGxWqDAX/36wup2X
   UXP4rLylsR4fpVhh4mDjaEYAJezLPmcDHx8TeN+6OdKFB775AAuQBBZe1
   FlgoKAEgciQmU6+lBYcAE7trLi/PxH+vJpP6VKpC3i6cY6kqWtNe8NOH/
   6eS+Jt7LudF60cJqj/cOv1abJuQNYU0S7edSCDc2ufM2KpLYkle82MeK5
   FpLU1oZGhyI1n1OgfwqZe+8KDJQulgcW7Xw0S8U3oPSxFwHfoph14v/Cp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="292344098"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292344098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="589332578"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="589332578"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2022 03:28:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2587D32E; Mon, 14 Nov 2022 13:28:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/4] list: Introduce list_count() to count existing nodes
Date:   Mon, 14 Nov 2022 13:28:39 +0200
Message-Id: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Some of the existing users, and definitely will be new ones, want to
count existing nodes in the list. Provide a generic API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/list.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 61762054b4be..098eccf8c1b6 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -655,6 +655,19 @@ static inline void list_splice_tail_init(struct list_head *list,
 	     !list_is_head(pos, (head)); \
 	     pos = n, n = pos->prev)
 
+/**
+ * list_count - count nodes in the list
+ * @head:	the head for your list.
+ */
+#define list_count(head)		\
+({					\
+	struct list_head *__tmp;	\
+	size_t __i = 0;			\
+	list_for_each(__tmp, head)	\
+		__i++;			\
+	__i;				\
+})
+
 /**
  * list_entry_is_head - test if the entry points to the head of the list
  * @pos:	the type * to cursor
-- 
2.35.1

