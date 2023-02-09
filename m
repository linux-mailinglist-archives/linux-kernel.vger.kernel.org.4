Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8268FD59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBICvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjBICuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:50:44 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7110F8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:48:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbE3e2D_1675910906;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbE3e2D_1675910906)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 10:48:26 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] erofs: update print symbols for various flags in trace
Date:   Thu,  9 Feb 2023 10:48:24 +0800
Message-Id: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As new flags introduced, the corresponding print symbols for trace are
not added accordingly.  Add these missing print symbols for these flags.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2
---
 include/trace/events/erofs.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index e095d36db939..f0e43e40a4a1 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -19,12 +19,18 @@ struct erofs_map_blocks;
 		{ 1,		"DIR" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",	\
-	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
+	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
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

