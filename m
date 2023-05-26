Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F2712776
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbjEZN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjEZN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:26:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8995
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685107561;
  x=1716643561;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vQ6s9WHOVRERw63K8NCydHFioykHH4Lnjaq5pXtH6Qw=;
  b=BYQME4zL2VDlIAMPa3qQaGjq+liFxdWz55rihtik6M/neJ77i32R4rkT
   riL/Uu93cQq9EiWy9zDqcjgGaszkayZ2eu29HA11suW/pZIFbEOnied67
   KP39r9f1c/rd8BrxuyCMOUcX0fjvbvld195Vy+Ao79Clgx4J5YBlhyhu1
   lqEZkDsr1v0lPQKZR9xIXYjGnmrRtkSuwBmuFoJmaSk5LDjJWRRToPYa3
   wK8LAMSJhgc9diZ3Prlcm8Zws4tgBFMMQbhGV1r9TVFLT4FnSanT4XsJV
   +Yl5RTxmHo3qvc8NWaduUTfVq0JErP3epHXP69Sdh0ajWDdP+b3w9jxkG
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 26 May 2023 15:25:45 +0200
Subject: [PATCH mm-nonmm-unstable 1/2] squashfs: fix page update race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230526-squashfs-cache-fixup-v1-1-d54a7fa23e7b@axis.com>
References: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com>
In-Reply-To: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hch@lst.de>, <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        "Vincent Whitchurch" <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only put the page into the cache after we've read it, so the
PageUptodate() check should not be necessary.  In fact, it's actively
harmful since the check could fail (since we used find_get_page() and
not find_lock_page()) and we could end up submitting a page for I/O
after it has been read and while it's actively being used, which could
lead to corruption depending on what the block driver does with it.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 6285f5afb6c6..f2412e5fc84b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -92,7 +92,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	bio_for_each_segment_all(bv, fullbio, iter_all) {
 		struct page *page = bv->bv_page;
 
-		if (page->mapping == cache_mapping && PageUptodate(page)) {
+		if (page->mapping == cache_mapping) {
 			idx++;
 			continue;
 		}

-- 
2.34.1

