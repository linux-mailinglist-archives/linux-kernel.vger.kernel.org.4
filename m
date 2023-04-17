Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82036E3FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQGmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQGmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:42:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A126AE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:42:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p8so24623308plk.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681713725; x=1684305725;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHGyWlcoQD9UeffDXzUOvm+FtnM3Ld1GsqM2RKnrFyc=;
        b=exAhRPnqf1otSCxJRXagmwhR/d7yMDEjNw/kOlbIsgCnTfYzFkuqXuzM358CnunZTJ
         nq4uL/PXp0JIV1IPC9XURHdKoikyWadpWZ/z9J+oR+wZGHy6ktIggsVYk3oN9HRza+4i
         yFpOJORSSMO8t+iyn8vgvV2MWl9KNyNZzR3tBobP/SQcZmsL/5z7khjfo39gRSnOjHYG
         u9pFWDCBedrlQyxGLDA9LX6PDOJG25CSisAXNs25vP2S7F07/pP+5X+9zABOqxowhUv8
         bXpyahKyD1mXl5CLNzxqKf/k6+32CWg5X2eiesaBOuhU+ujRoKxc5diQfv0kse6XSHnM
         mJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713725; x=1684305725;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHGyWlcoQD9UeffDXzUOvm+FtnM3Ld1GsqM2RKnrFyc=;
        b=Lym3ykvb11yQIrB1dTs7KjbvuEneBvkSQp7FH3X33uBEsZOnGdioGRY4rvbrNgE7Lw
         yJC1Y3MQg63y3WI54qgu/hZVFp6eIGYU+6XzYsriT+idIRI+ex+9/sZPjb8L7aOgQyWl
         ccmeuACFxnAizH5xYeE19s5JEPV7juKEIcIw0odMbFAqoVncw76MBvtHFC6FhEeQ7AU5
         NYm/18fLV4S0Szypc72HrjMKzBKIdSeTXQk7i9LshUdHCZx/XhvM9bVdzrRr3wHFcaUX
         MKUc4v5Z9UnXUA143mcQL0jhgvItpTlMjW3mLpOrbYXIcGqdc61Ywg92l4F9/367NPi/
         Tk8w==
X-Gm-Message-State: AAQBX9fC3oqvq9uyhhqce0PEgpagbAVLN/pUOhQ7GtuWHdH9pDqUmGbY
        vUqVQUx39UKx7qfpKKP3TSBEXIqM/O3HKg==
X-Google-Smtp-Source: AKy350Z9r/nm7Hue6j1B9JqqNUGMYGRMBJg8i+lW0xdRIiZhw8JHyqOnWZNK8ZE40Wcn9ntjjJ/q7A==
X-Received: by 2002:a05:6a20:748b:b0:ef:2d6:446c with SMTP id p11-20020a056a20748b00b000ef02d6446cmr7924499pzd.17.1681713724956;
        Sun, 16 Apr 2023 23:42:04 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l15-20020a654c4f000000b0051a3c744256sm6337824pgr.93.2023.04.16.23.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:42:04 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: [PATCH] erofs: remove unneeded icur field from struct z_erofs_decompress_frontend
Date:   Mon, 17 Apr 2023 14:41:35 +0800
Message-Id: <20230417064136.5890-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

The icur field is only used in z_erofs_try_inplace_io(). Let's just use
a local variable instead. And no need to check if the pcluster is inline
when setting icur since inline page cannot be used for inplace I/O.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f759152feffa..f8bf2b227942 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
-
-	/* a pointer used to pick up inplace I/O pages */
-	unsigned int icur;
 };
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
@@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 				   struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_pcluster *const pcl = fe->pcl;
+	/* file-backed online pages are traversed in reverse order */
+	unsigned int icur = pcl->pclusterpages;
 
-	while (fe->icur > 0) {
-		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
+	while (icur > 0) {
+		if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
 			     NULL, bvec->page)) {
-			pcl->compressed_bvecs[fe->icur] = *bvec;
+			pcl->compressed_bvecs[icur] = *bvec;
 			return true;
 		}
 	}
@@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	}
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
-	/* since file-backed online pages are traversed in reverse order */
-	fe->icur = z_erofs_pclusterpages(fe->pcl);
 	return 0;
 }
 
-- 
2.17.1

