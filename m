Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B468EDEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBHL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBHL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:29:19 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D93CE33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:29:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbBr6Y5_1675855755;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbBr6Y5_1675855755)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 19:29:15 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] erofs: update print symbols for various flags in trace
Date:   Wed,  8 Feb 2023 19:29:14 +0800
Message-Id: <20230208112915.6543-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As new flags introduced, the corresponding print symbols for trace are
not added accordingly.  Add these missing print symbols for these flags.

Also remove the print symbol for EROFS_GET_BLOCKS_RAW as it is going to
be removed soon.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2: remove print symbol for EROFS_GET_BLOCKS_RAW
---
 include/trace/events/erofs.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index e095d36db939..cf4a0d28b178 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -19,12 +19,17 @@ struct erofs_map_blocks;
 		{ 1,		"DIR" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",	\
-	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
+	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
+	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
+	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
 
 #define show_mflags(flags) __print_flags(flags, "",	\
-	{ EROFS_MAP_MAPPED,	"M" },			\
-	{ EROFS_MAP_META,	"I" },			\
-	{ EROFS_MAP_ENCODED,	"E" })
+	{ EROFS_MAP_MAPPED,		"M" },		\
+	{ EROFS_MAP_META,		"I" },		\
+	{ EROFS_MAP_ENCODED,		"E" },		\
+	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
+	{ EROFS_MAP_FRAGMENT,		"R" },		\
+	{ EROFS_MAP_PARTIAL_REF,	"P" })
 
 TRACE_EVENT(erofs_lookup,
 
-- 
2.19.1.6.gb485710b

