Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C973D807
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFZGvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjFZGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:51:29 -0400
X-Greylist: delayed 41273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 23:51:24 PDT
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC97DE7B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1687762277; bh=Pgn7S7GW3U6u3f3Hy8tc/2FAPWJkWS46rNADXIMWKy4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=PRpAQuq9eHEuXF0MJhvvlHEm7wlDa1lGzzqt5J8Q+MaLVMRLZeFFkRIjrJglUR2lI
         llD8LnPmQSEsdNFiQm/hk5FNXr9z+fMcksD+w9U8jldbTs+Gm4IDJ1yqK3gMQ58Mg3
         yjY/gYln4YRMoT85o2c/Vum7nYKQJGoJtEuUkz1k=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Mon, 26 Jun 2023 08:51:16 +0200 (CEST)
X-EA-Auth: Eu/Q3BBGOZASBNR3dpmx6ET/wlVioDsvV4FoUhX+WcVKwrfl6adetu3e6VtSUbBvxZC7qTm86HVr6Td9HE/uWXqx2GV65Gol
Date:   Mon, 26 Jun 2023 12:21:09 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v2] gfs2: Replace deprecated kmap_atomic() by
 kmap_local_page()
Message-ID: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

Therefore, replace kmap_atomic() with kmap_local_page() in
gfs2_internal_read() and stuffed_readpage().

kmap_atomic() disables page-faults and preemption (the latter only for
!PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
gfs2_internal_read() and stuffed_readpage() does not depend on the
above-mentioned side effects.

Therefore, a mere replacement of the old API with the new one is all that
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: The Patch is build tested only. I will be happy to run recommended testing
with some guidance if required.

Changes in v2:
   - Update patch description to correct the replacement function name from
     kmap_local_folio to kmap_local _page 


 fs/gfs2/aops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3b41542d6697..7bd92054d353 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 	if (error)
 		return error;
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
 	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	flush_dcache_page(page);
 	brelse(dibh);
 	SetPageUptodate(page);
@@ -498,12 +498,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 				continue;
 			return PTR_ERR(page);
 		}
-		p = kmap_atomic(page);
+		p = kmap_local_page(page);
 		amt = size - copied;
 		if (offset + size > PAGE_SIZE)
 			amt = PAGE_SIZE - offset;
 		memcpy(buf + copied, p + offset, amt);
-		kunmap_atomic(p);
+		kunmap_local(p);
 		put_page(page);
 		copied += amt;
 		index++;
-- 
2.34.1



