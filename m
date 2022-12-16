Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC864E73A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLPGOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLPGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:14:49 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9DC15823
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:14:47 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8B7E11E80D72;
        Fri, 16 Dec 2022 14:09:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qNLiGqz1SLfn; Fri, 16 Dec 2022 14:09:56 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B51DC1E80D58;
        Fri, 16 Dec 2022 14:09:56 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] orangefs: remove unnecessary (void*) conversions
Date:   Fri, 16 Dec 2022 14:14:39 +0800
Message-Id: <20221216061439.3750-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void * type pointer does not need to be cast.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/orangefs/orangefs-debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..6e69e47ee739 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -721,7 +721,7 @@ gossip_debug(GOSSIP_UTILS_DEBUG, "%s: string:%s:\n", __func__, debug_string);
 
 static void do_k_string(void *k_mask, int index)
 {
-	__u64 *mask = (__u64 *) k_mask;
+	__u64 *mask = k_mask;
 
 	if (keyword_is_amalgam((char *) s_kmod_keyword_mask_map[index].keyword))
 		goto out;
@@ -747,7 +747,7 @@ static void do_k_string(void *k_mask, int index)
 
 static void do_c_string(void *c_mask, int index)
 {
-	struct client_debug_mask *mask = (struct client_debug_mask *) c_mask;
+	struct client_debug_mask *mask = c_mask;
 
 	if (keyword_is_amalgam(cdm_array[index].keyword))
 		goto out;
@@ -794,7 +794,7 @@ static int check_amalgam_keyword(void *mask, int type)
 	int rc = 0;
 
 	if (type) {
-		c_mask = (struct client_debug_mask *) mask;
+		c_mask = mask;
 
 		if ((c_mask->mask1 == cdm_array[client_all_index].mask1) &&
 		    (c_mask->mask2 == cdm_array[client_all_index].mask2)) {
@@ -811,7 +811,7 @@ static int check_amalgam_keyword(void *mask, int type)
 		}
 
 	} else {
-		k_mask = (__u64 *) mask;
+		k_mask = mask;
 
 		if (*k_mask >= s_kmod_keyword_mask_map[k_all_index].mask_val) {
 			strcpy(kernel_debug_string, ORANGEFS_ALL);
@@ -842,10 +842,10 @@ static void debug_string_to_mask(char *debug_string, void *mask, int type)
 	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: start\n", __func__);
 
 	if (type) {
-		c_mask = (struct client_debug_mask *)mask;
+		c_mask = mask;
 		element_count = cdm_element_count;
 	} else {
-		k_mask = (__u64 *)mask;
+		k_mask = mask;
 		*k_mask = 0;
 		element_count = num_kmod_keyword_mask_map;
 	}
-- 
2.18.2

