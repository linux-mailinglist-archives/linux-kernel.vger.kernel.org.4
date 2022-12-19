Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7E650E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiLSPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiLSPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:49 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B5D72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1671462400;
  x=1702998400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lF6zLSL3xN5QtbuDWpwls5qZgJO7KvkxQjJFjBbuqe8=;
  b=fSS3YZbzJjuTXaN7yt3ilvPJhY97NP6KMU9DTSjuywe0hk9gJy550dl3
   OJr34fVEP4RZkVkw8+xITzst3jSNdTGr9VZzGXT/IpHvDZnBOLinBXOWC
   kfP3I8c+bCOSAL4p3RcrIpGNLbgtAJ7zkt1AhIIuGw2VSgNwiagLBWoPI
   YydFw74jgs2kYBYErCMImgSEVBulEySokXwt6lwMy2WTe9OT6E7bIeBus
   1Bneg1O6YI9yJb5ZBiDVt42VDnvmhiLVB3o1BeLiWxDPBR5hUTvKkBb4A
   RLe0rS0LTe9erFh17Vs7jrIyJqoVRdObiPpAEWcrdL5FBBWsOhy16nFMv
   g==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <linux-kernel@vger.kernel.org>, <oberpar@linux.ibm.com>
CC:     <rickard314.andersson@gmail.com>, <mliska@suse.cz>,
        Rickard x Andersson <rickaran@axis.com>
Subject: [PATCH] gcov: Add support for checksum field
Date:   Mon, 19 Dec 2022 16:06:21 +0100
Message-ID: <20221219150621.3310033-1-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

In GCC version 12.1 a checksum field was added.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 kernel/gcov/gcc_4_7.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index c699feda21ac..04880d8fba25 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -85,6 +85,7 @@ struct gcov_fn_info {
  * @version: gcov version magic indicating the gcc version used for compilation
  * @next: list head for a singly-linked list
  * @stamp: uniquifying time stamp
+ * @checksum: unique object checksum
  * @filename: name of the associated gcov data file
  * @merge: merge functions (null for unused counter type)
  * @n_functions: number of instrumented functions
@@ -97,6 +98,10 @@ struct gcov_info {
 	unsigned int version;
 	struct gcov_info *next;
 	unsigned int stamp;
+ /* Since GCC 12.1 a checksum field is added. */
+#if (__GNUC__ >= 12)
+	unsigned int checksum;
+#endif
 	const char *filename;
 	void (*merge[GCOV_COUNTERS])(gcov_type *, unsigned int);
 	unsigned int n_functions;
-- 
2.30.2

