Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B28742FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjF2VuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjF2VuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:50:22 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2530EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075416; bh=x7zd5uVxyeDRl54E+RTPj06ix1hRuqdAnUwSzOvgF+8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Y2Y80HzdbqBIq3756vJTl6ufeFaY0ZCXI1TkJovWlAK94g55+ZynJfooM/S2vE0zN
         92Vlg8l+PHyjD89HEQTr1ND9SWZ+EOPuE6vWrLzfdn4IAPpjOBZSbQIYie4KZcR1Yy
         qL/OG7LlBUiH5LmWx6bWQoIAXmMPIMio5T9yu7JE=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:50:16 +0200 (CEST)
X-EA-Auth: 8qhRdke3mHv05h5eyYsrMODcCW4Qllf4hyhJ119mGTYvfLGar6Bbd79n7KIGsdADT98DNArOr+XjY8Xfvucm8mUPvSIQ7zbX
Date:   Fri, 30 Jun 2023 03:20:07 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 2/6] gfs2: Replace kmap_atomic()+memcpy by
 memcpy_from_page()
Message-ID: <4d132d7aa9cc71f88e6e02c8f6fcb0fec56542aa.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688073459.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

kmap_atomic() disables page-faults and preemption (the latter only for
!PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
gfs2_internal_read() does not depend on the above-mentioned side effects.

Further, memcpy_{from,to}_page() wrappers combine the
{kmap, unmap}_local_page() blocks when they are intended exclusively to
copy contents from/to the temporary mapped page. So, replace the
kmap_atomic()/kunmap_automic() block by the memcpy_from_page() API call.
This change allows to tidy-up code and also eliminate unused variable p.

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   - Split as a separate patch for conversion in gfs2_internal_read() 
   - Use memcpy_from_page() as suggested by Fabio and  Andreas G
   - Included split version in patch set

Changes in v2:
   - Update patch description to correct the replacement function name
     from kmap_local_folio to kmap_local _page



 fs/gfs2/aops.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3eac4f2f5c27..f47fed657763 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -489,7 +489,6 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 	unsigned copied = 0;
 	unsigned amt;
 	struct page *page;
-	void *p;
 
 	do {
 		page = read_cache_page(mapping, index, gfs2_read_folio, NULL);
@@ -498,12 +497,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 				continue;
 			return PTR_ERR(page);
 		}
-		p = kmap_atomic(page);
-		amt = size - copied;
 		if (offset + size > PAGE_SIZE)
 			amt = PAGE_SIZE - offset;
-		memcpy(buf + copied, p + offset, amt);
-		kunmap_atomic(p);
+		else
+			amt = size - copied;
+
+		memcpy_from_page(buf, page, offset, amt);
 		put_page(page);
 		copied += amt;
 		index++;
-- 
2.34.1



