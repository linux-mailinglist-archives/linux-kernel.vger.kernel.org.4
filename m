Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156E706994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjEQNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjEQNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04108173F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9423363BDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF762C433EF;
        Wed, 17 May 2023 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329582;
        bh=aywvvDRPNw0N00F0h3QEaRNcGvMODB+TxD21Tej3Lsk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZvaPaFRkLsehNX2loEbOvDVae+1gWgD0Ic2WOkv7wxF1IPFtcmlrUL0im6guBRNxR
         +nkj2hepVCk7Vijdc0PYTMFjBI+/tbCyFFYyC2z7ntZ7SOh+IzX1gCsAo0UoETwQcx
         t/XuI179xCx4vHxkPY0hEAokDqksHrgjMzNL6808mhV9F2tTenRXJY8hEVs8gd8duu
         8/nSBouTPWLGEiHh01kNSsfMuFcd8gk+5ggFpmqrPp8YhxDQw5m5c2WM7jbYkDPAX+
         85t3QZEdPuLNBImnMpJqCD2JAeERkLfZmmPIqQQWjLanTAnT6T9iQuJop1StyB9F6Z
         sZe4Ql1zzScbQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] decompressor: provide missing prototypes
Date:   Wed, 17 May 2023 15:19:31 +0200
Message-Id: <20230517131936.936840-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The entry points for the decompressor don't always have a prototype
included in the .c file:

lib/decompress_inflate.c:42:17: error: no previous prototype for '__gunzip' [-Werror=missing-prototypes]
lib/decompress_unxz.c:251:17: error: no previous prototype for 'unxz' [-Werror=missing-prototypes]
lib/decompress_unzstd.c:331:17: error: no previous prototype for 'unzstd' [-Werror=missing-prototypes]

include the correct headers for unxz and unzstd, and mark the
inflate function above as unconditionally 'static' to avoid
these warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/decompress_inflate.c | 2 +-
 lib/decompress_unxz.c    | 2 ++
 lib/decompress_unzstd.c  | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 6130c42b8e59..e19199f4a684 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -39,7 +39,7 @@ static long INIT nofill(void *buffer, unsigned long len)
 }
 
 /* Included from initramfs et al code */
-STATIC int INIT __gunzip(unsigned char *buf, long len,
+static int INIT __gunzip(unsigned char *buf, long len,
 		       long (*fill)(void*, unsigned long),
 		       long (*flush)(void*, unsigned long),
 		       unsigned char *out_buf, long out_len,
diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 9f4262ee33a5..353268b9f129 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -102,6 +102,8 @@
  */
 #ifdef STATIC
 #	define XZ_PREBOOT
+#else
+#include <linux/decompress/unxz.h>
 #endif
 #ifdef __KERNEL__
 #	include <linux/decompress/mm.h>
diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index a512b99ae16a..bba2c0bb10cb 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -69,6 +69,8 @@
 # define UNZSTD_PREBOOT
 # include "xxhash.c"
 # include "zstd/decompress_sources.h"
+#else
+#include <linux/decompress/unzstd.h>
 #endif
 
 #include <linux/decompress/mm.h>
-- 
2.39.2

