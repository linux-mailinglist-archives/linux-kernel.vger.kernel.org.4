Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7921A604CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJSQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiJSQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:05:51 -0400
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 495CBC2CA1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:04:40 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lBYBoox5FSmRKlBYCoDstr; Wed, 19 Oct 2022 18:04:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666195453; bh=GOiiI3+8vXjlQ7VXBWeCNN1srDCedk1v4RecNZAv7pg=;
        h=From:To:Subject:Date:MIME-Version;
        b=jTRQ/WLvghaA9QEMvIRdKd+hiS4Qa6RO6qs8uiyvxaGqYZxRtJkUZex89uzrTdBK5
         hMIMwjMtj6C0TMIgeOFvx0oB8nE5OgaiOfqW/8vmtMiOIue9sf5E6aczbWtkiYPLfP
         gfG7CmUVm/3pJqwsGxjeQMr3Wla7HXTPqRAMV1E7WbKGIZVzDhtqj0tEK4NrbuSljr
         F5+rHChwbe6lfsDoZCFwawO3Wbcj2ExS7b5QY2iQAvZXw5KBM6Se0Rl2bGfzRmNTk1
         5lrpiSgdAk0ITe6oDBZhdb3qNqj8JG9CPaRYX7U5MYHrbGFuJSPKTa4rRYN1D2QgLm
         U6YGyGJACGTIA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Song Liu <song@kernel.org>,
        =?UTF-8?q?Dirk=20M=C3=BCller?= <dmueller@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] lib/raid6: drop RAID6_USE_EMPTY_ZERO_PAGE
Date:   Wed, 19 Oct 2022 18:04:07 +0200
Message-Id: <20221019160407.7550-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y0/Yt4uJWg4knNoc@infradead.org>
References: <Y0/Yt4uJWg4knNoc@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAG43ZSehpx2rzMtQ4WywAEY4w2w7pXjnboijBNvBg2L2b5faGjDfm7J/rWud9TgVdySsulvWquaGuvW9ztb2o5BitM3DsE/uaGn+77CpdMIhUgLmgbm
 wG878r2326b18l0Ht3VRVev/Tod4w+s3XZhcx8Sb6ChaoD5KVTaKzTO635Jz2xFiGXDMwdTAyB3zcYrDs5OZ9nVMYmfA5R8abLEE0NUMvzzKWLvy3luA/gLu
 1NqtznKBoeA0lDf50Vd/8Fx6aZdOs+g9EzwTMW6HFUr92PwAuMrSryqt8aiguWvufsVo9+nfxyqJsE6KxLcfT244CWi3ewNHIPfNF14iLTjbb5JiRZ09PRtX
 NXiInngJqqehS9OizZGFF1nXpSy8xSvD6GqTfU9JzsDdZPttRGxYjiBsHz6cMR5S8iFYEtp4+bhneaz0I2s0zZ4J4Wkaow==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RAID6_USE_EMPTY_ZERO_PAGE is unused and hardcoded to 0, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 include/linux/raid/pq.h | 8 --------
 lib/raid6/algos.c       | 2 --
 2 files changed, 10 deletions(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index d6e5a1feb947..f29aaaf2eb21 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -10,17 +10,9 @@
 
 #ifdef __KERNEL__
 
-/* Set to 1 to use kernel-wide empty_zero_page */
-#define RAID6_USE_EMPTY_ZERO_PAGE 0
 #include <linux/blkdev.h>
 
-/* We need a pre-zeroed page... if we don't want to use the kernel-provided
-   one define it here */
-#if RAID6_USE_EMPTY_ZERO_PAGE
-# define raid6_empty_zero_page empty_zero_page
-#else
 extern const char raid6_empty_zero_page[PAGE_SIZE];
-#endif
 
 #else /* ! __KERNEL__ */
 /* Used for testing in user space */
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 39b74221f4a7..a22a05c9af8a 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -18,12 +18,10 @@
 #else
 #include <linux/module.h>
 #include <linux/gfp.h>
-#if !RAID6_USE_EMPTY_ZERO_PAGE
 /* In .bss so it's zeroed */
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
 EXPORT_SYMBOL(raid6_empty_zero_page);
 #endif
-#endif
 
 struct raid6_calls raid6_call;
 EXPORT_SYMBOL_GPL(raid6_call);
-- 
2.34.1

