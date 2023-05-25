Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB8710584
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbjEYFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjEYFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:54:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628F1B3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:53:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso2050861b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684993999; x=1687585999;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7P2pViE0Pdm1oz/lthOVONUXxJhbAwJFigoZZnYI7I=;
        b=dkzqX7I+LHjgODgV0ywVKF5SLiBAzr+fGfCFf4pam8H9IH8uK2DHL9sYz1mJQS+T0j
         QGPRv+8atks+Kg3RkZzzt2nYCvFvKiycZ+lBKTZKBJc5LTFDvnHfJw/l+5PVDXEUzzE/
         BxFMkUbVzc1Vi9KvP5BU2ypMquo3bkBJHMh6tNCJyVQAIzez4AeuyUq/xKQMkTPpLyv5
         c6R27f2W1KANiiXX1d547hMrtCug7n26Pu25Wa0MtlQTwNC0Y7gfvKNlc7+iqX4uRNHM
         dNzlmlAuakASNyGw/L4BvGTGwzfDL8qBKcvQeMux0JDr6i1AbbgGi/18DhmFzz9SDLtp
         Kt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684993999; x=1687585999;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7P2pViE0Pdm1oz/lthOVONUXxJhbAwJFigoZZnYI7I=;
        b=bRiFizdfZ3d3CTq5mT4zmfMCx7UD1OJuhbC1AC7msNNSZlMbARnT3xMxbvyH0mECrD
         vVRvw/rbaA/3mqsc01zN8rpAHJk3/GcT3FkghVTYC0tJlzJ9sp+2MYcWtzNuQ/lWNhZf
         4rarYY2ByPokrG3f8RsxyH7IB+OFAsAzSc+d5sD4Spu4XPuwx/GFinJNvZLzoh9quL12
         mDMCtJMQVBB7dIgMszby+CnsT3+BYuqynUmkicmnS0j+rs7O9kpLtPKMBCQCDBgouQyj
         UNWeyRJsnqA/EG7Sv3O8dsxWSx7oX0xF7KkRS8d5EIAVG1kQ/uFrxOqugjkrMKLWlNFV
         9AVg==
X-Gm-Message-State: AC+VfDzblgq2fJFyQyBzYzqeZihqwuLMEU4KnMOOjv/lnqjhBdWnWdOb
        NGLwPyN769Jmqq5xS3K/6/g=
X-Google-Smtp-Source: ACHHUZ4/7hCeo6+NoomrhmCHRq3yUsBAuo2crzdqr8m6FlZpndwMWY0HzBfzd6xDatii84yEQvl5mw==
X-Received: by 2002:a05:6a00:13a8:b0:64b:205:dbf3 with SMTP id t40-20020a056a0013a800b0064b0205dbf3mr7081362pfg.34.1684993999543;
        Wed, 24 May 2023 22:53:19 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78001000000b006437c0edf9csm415895pfi.16.2023.05.24.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 22:53:18 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: don't calculate new start when expanding read length
Date:   Thu, 25 May 2023 13:51:47 +0800
Message-Id: <20230525055147.13220-1-zbestahu@gmail.com>
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

We only expand the trailing edge and not the leading edge.  So no need
to obtain new start again.  Let's use the existing ->headoffset instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 874fee35af32..bab8dcb8e848 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
-	erofs_off_t cur, end;
+	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
 	if (backmost) {
 		if (rac)
-			end = f->headoffset + readahead_length(rac) - 1;
+			end = headoffset + readahead_length(rac) - 1;
 		else
-			end = f->headoffset + PAGE_SIZE - 1;
+			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
-		/* expend ra for the trailing edge if readahead */
+		/* expand ra for the trailing edge if readahead */
 		if (rac) {
-			loff_t newstart = readahead_pos(rac);
-
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
-			readahead_expand(rac, newstart, cur - newstart);
+			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
 		}
 		end = round_up(end, PAGE_SIZE);
-- 
2.17.1

