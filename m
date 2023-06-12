Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACA72D37B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjFLVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFLVru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:47:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B4A18C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686606469; x=1718142469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gq402IvNFU41ZRqoTCeVovZI74EHnRe8byGoMWL+5DQ=;
  b=nFcEufoXLzwvvAf0bE6aF2sKa9b5eKryd5NB4+LgLwvo3XgRkZh17oaw
   x1XE3RQlX+CY2ABWUc3wYytTdGPPV3a2sEl/FTM9nJhUYChmpjfeZVHFb
   zh9c/Z2pEnNzegcO1v/LBEW3Q2986xCWnshG/l+pAIR4DjU3n3Iw4e6u2
   0H0OE4usIHsrHDmz32tACQIw+XCkh/kLwmfr+kciw2fdsznxYX0eAD1a0
   M0T8X+tky4ya8wvR2rzGdLXrfBFv2eK9wh3hEdDjoBVAx6eC0aPKu2ksc
   /vdmAcKorYg49vyxexRYp08Kd0OAFWGtwbaA9773H2/oOuNd0twgSYtbV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386559453"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="386559453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714538602"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="714538602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2023 14:47:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 390A5357; Tue, 13 Jun 2023 00:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Snitzer <snitzer@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dm integrity: Use %*ph for printing hexdump of a small buffer
Date:   Tue, 13 Jun 2023 00:47:51 +0300
Message-Id: <20230612214751.9662-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has a helper to print a hexdump of a small
buffer via pointer extension. Use that instead of open coded
variant.

In long term it helps to kill pr_cont() or at least narrow down
its use.

Note, the format is slightly changed, i.e. the colon is not printed
before the buffer dump and the trailing space is always printed.
These are not a problem since it's a debug message. Also the IV dump
is limited by 64 bytes which seems fine.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/md/dm-integrity.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 63ec502fcb12..e5b9a6bab3dd 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -342,24 +342,8 @@ static struct kmem_cache *journal_io_cache;
 #define JOURNAL_IO_MEMPOOL	32
 
 #ifdef DEBUG_PRINT
-#define DEBUG_print(x, ...)	printk(KERN_DEBUG x, ##__VA_ARGS__)
-static void __DEBUG_bytes(__u8 *bytes, size_t len, const char *msg, ...)
-{
-	va_list args;
-
-	va_start(args, msg);
-	vprintk(msg, args);
-	va_end(args);
-	if (len)
-		pr_cont(":");
-	while (len) {
-		pr_cont(" %02x", *bytes);
-		bytes++;
-		len--;
-	}
-	pr_cont("\n");
-}
-#define DEBUG_bytes(bytes, len, msg, ...)	__DEBUG_bytes(bytes, len, KERN_DEBUG msg, ##__VA_ARGS__)
+#define DEBUG_print(x, ...)			printk(KERN_DEBUG x, ##__VA_ARGS__)
+#define DEBUG_bytes(bytes, len, msg, ...)	printk(KERN_DEBUG msg " %*ph\n", ##__VA_ARGS__, len, bytes)
 #else
 #define DEBUG_print(x, ...)			do { } while (0)
 #define DEBUG_bytes(bytes, len, msg, ...)	do { } while (0)
@@ -3781,8 +3765,9 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 		goto bad;
 	}
 	if (ic->journal_crypt_alg.alg_string) {
-		unsigned int ivsize, blocksize;
 		struct journal_completion comp;
+		unsigned int blocksize;
+		int ivsize;
 
 		comp.ic = ic;
 		ic->journal_crypt = crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
-- 
2.40.0.1.gaa8946217a0b

