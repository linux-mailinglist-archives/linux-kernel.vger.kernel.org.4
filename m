Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036BD68B160
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBETbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBETbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:31:14 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Feb 2023 11:31:12 PST
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FF3818AB0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:31:11 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 6 Feb 2023 04:01:10 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: taejoon.song@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.77)
        by 156.147.1.125 with ESMTP; 6 Feb 2023 04:01:10 +0900
X-Original-SENDERIP: 10.177.244.77
X-Original-MAILFROM: taejoon.song@lge.com
From:   Taejoon Song <taejoon.song@lge.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, yjay.kim@lge.com,
        Taejoon Song <taejoon.song@lge.com>
Subject: [PATCH] mm/zswap: try to avoid worst-case scenario on same element pages
Date:   Mon,  6 Feb 2023 04:00:36 +0900
Message-Id: <20230205190036.1730134-1-taejoon.song@lge.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The worst-case scenario on finding same element pages is that almost all
elements are same at the first glance but only last few elements are
different.

Since the same element tends to be grouped from the beginning of the
pages, if we check the first element with the last element before
looping through all elements, we might have some chances to quickly
detect non-same element pages.

1. Test is done under LG webOS TV (64-bit arch)
2. Dump the swap-out pages (~819200 pages)
3. Analyze the pages with simple test script which counts the iteration
   number and measures the speed at off-line

Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes =
512.  The speed is based on the time to consume page_same_filled()
function only.  The result, on average, is listed as below:

                                   Num of Iter    Speed(MB/s)
Looping-Forward (Orig)                 38            99265
Looping-Backward                       36           102725
Last-element-check (This Patch)        33           125072

The result shows that the average iteration count decreases by 13% and
the speed increases by 25% with this patch.  This patch does not
increase the overall time complexity, though.

I also ran simpler version which uses backward loop. Just looping
backward also makes some improvement, but less than this patch.

This patch was already applied to zram on mainline v5.6-rc1:
https://lkml.org/lkml/2019/12/3/1422

Signed-off-by: Taejoon Song <taejoon.song@lge.com>
---
 mm/zswap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6c89049cf70..2f0ebd8bc620 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1073,15 +1073,23 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
 {
-	unsigned int pos;
 	unsigned long *page;
+	unsigned long val;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 
 	page = (unsigned long *)ptr;
-	for (pos = 1; pos < PAGE_SIZE / sizeof(*page); pos++) {
-		if (page[pos] != page[0])
+	val = page[0];
+
+	if (val != page[last_pos])
+		return 0;
+
+	for (pos = 1; pos < last_pos; pos++) {
+		if (val != page[pos])
 			return 0;
 	}
-	*value = page[0];
+
+	*value = val;
+
 	return 1;
 }
 
-- 
2.34.1

