Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA136D918A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjDFI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjDFI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:29:20 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 01:29:18 PDT
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [IPv6:2001:41d0:203:375::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685E130
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:29:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680769233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UFsqLHECiaaZpUWd/R1g+L87eavPw4icy8tzwp+ivws=;
        b=Qn0MScj3Ee2BYVFqPVQ+cea8TMWj0zA5FdtSZ9gpPTlV5MwLSd93kH70ti9md/zUXKNDns
        3DZx+Y26sQJscgVZPN0NygmL/3LueEXL1LYTgG9t5OWRo/LywTC7UDRM9O+Vx8FCzvc17u
        CFCziuqW4+tPLRyYVHFH7QuAX5dBwLg=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Xu Yu <xuyu@linux.alibaba.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/huge_memory.c: warn with pr_warn_ratelimited instead of VM_WARN_ON_ONCE_FOLIO
Date:   Thu,  6 Apr 2023 17:20:04 +0900
Message-Id: <20230406082004.2185420-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

split_huge_page_to_list() WARNs when called for huge zero pages, which
sounds to me too harsh because it does not imply a kernel bug, but just
notifies the event to admins.  On the other hand, this is considered
as critical by syzkaller and makes its testing less efficient, which
seems to me harmful.

So replace the VM_WARN_ON_ONCE_FOLIO with pr_warn_ratelimited.

Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
Reported-by: syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/000000000000a6f34a05e6efcd01@google.com/
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: stable@vger.kernel.org
---
 mm/huge_memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81a5689806af..06bcdd6f5060 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2649,9 +2649,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
 	is_hzp = is_huge_zero_page(&folio->page);
-	VM_WARN_ON_ONCE_FOLIO(is_hzp, folio);
-	if (is_hzp)
+	if (is_hzp) {
+		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
 		return -EBUSY;
+	}
 
 	if (folio_test_writeback(folio))
 		return -EBUSY;
-- 
2.25.1

