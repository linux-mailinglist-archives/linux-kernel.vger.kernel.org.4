Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8295FD59F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJMHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJMHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:41:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8A11E454
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2E9A225C6;
        Thu, 13 Oct 2022 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665646859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HdOPO99xuMfZ/oP6c+KobUVqYqDXR7WD4w84BArgUFo=;
        b=gKjdz+K4izZEevlx/jrNz8axz6mlKJG1xAdpa+XbXHudPafqhh/IxXUdDRd/dho9r2nisW
        dP07VCzdQFRjrnivPGPAEeLdh47YJVts1wlQcp/zGWRCIG0ar4YDyvd2XDgWDaSaf0CF4r
        2jH996/amtKBm+wXzgCu3oEIyVz8ZkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665646859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HdOPO99xuMfZ/oP6c+KobUVqYqDXR7WD4w84BArgUFo=;
        b=eNgQ9WTq4mzq2l0Z2iRktECS2mErWqIj3SdepyvFFo3ZTTO+3GMgQLZSeAag1YlHOdX62R
        XIpSo2GrQHAUJ8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 873C7139F3;
        Thu, 13 Oct 2022 07:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fv5mHgvBR2PCTQAAMHmgww
        (envelope-from <mliska@suse.cz>); Thu, 13 Oct 2022 07:40:59 +0000
Message-ID: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
Date:   Thu, 13 Oct 2022 09:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] gcov: support GCC 12.1 and newer compilers
To:     linux-kernel@vger.kernel.org
Cc:     oberpar@linux.ibm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with GCC 12.1, there are 2 significant changes to the .gcda
file format that needs to be supported:

a) [gcov: Use system IO buffering] (23eb66d1d46a34cb28c4acbdf8a1deb80a7c5a05) changed
   that all sizes in the format are in bytes and not in words (4B)
b) [gcov: make profile merging smarter] (72e0c742bd01f8e7e6dcca64042b9ad7e75979de)
   add a new checksum to the file header.

Tested with GCC 7.5, 10.4, 12.2 and the current master.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 kernel/gcov/gcc_4_7.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 460c12b7dfea..7971e989e425 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -30,6 +30,13 @@
 
 #define GCOV_TAG_FUNCTION_LENGTH	3
 
+/* Since GCC 12.1 sizes are in BYTES and not in WORDS (4B). */
+#if (__GNUC__ >= 12)
+#define GCOV_UNIT_SIZE				4
+#else
+#define GCOV_UNIT_SIZE				1
+#endif
+
 static struct gcov_info *gcov_info_head;
 
 /**
@@ -383,12 +390,18 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 	pos += store_gcov_u32(buffer, pos, info->version);
 	pos += store_gcov_u32(buffer, pos, info->stamp);
 
+#if (__GNUC__ >= 12)
+	/* Use zero as checksum of the compilation unit. */
+	pos += store_gcov_u32(buffer, pos, 0);
+#endif
+
 	for (fi_idx = 0; fi_idx < info->n_functions; fi_idx++) {
 		fi_ptr = info->functions[fi_idx];
 
 		/* Function record. */
 		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
-		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION_LENGTH);
+		pos += store_gcov_u32(buffer, pos,
+			GCOV_TAG_FUNCTION_LENGTH * GCOV_UNIT_SIZE);
 		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
 		pos += store_gcov_u32(buffer, pos, fi_ptr->lineno_checksum);
 		pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
@@ -402,7 +415,8 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
 			/* Counter record. */
 			pos += store_gcov_u32(buffer, pos,
 					      GCOV_TAG_FOR_COUNTER(ct_idx));
-			pos += store_gcov_u32(buffer, pos, ci_ptr->num * 2);
+			pos += store_gcov_u32(buffer, pos,
+				ci_ptr->num * 2 * GCOV_UNIT_SIZE);
 
 			for (cv_idx = 0; cv_idx < ci_ptr->num; cv_idx++) {
 				pos += store_gcov_u64(buffer, pos,
-- 
2.37.3

