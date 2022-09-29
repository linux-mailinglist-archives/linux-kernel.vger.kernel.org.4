Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF05EEC40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiI2DAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2DAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:00:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D295D108
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u92so96207pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mxeZyACnh97j+FymKAYz3kB3KSv2VBxKUGSN2j7Wq6Y=;
        b=EOz8icziHra0ftSQpyT3922e5VAw/fKBGYS00L0hmKII/vHtyvEOFWfza3kKS7yGCZ
         1y2rMrAXxc7JHY8Ep6TvKdAZjqbdzfOmBdv4GsllOKeuNdL8FV3j1wPlTkIOyBAxtSCN
         wFXNkpLMIFoHmLuEc8tfWJjbaSP7cl+jmx6u8HQnV/dp3LKjUjlkrCk+Z8W6JYgZ7h7v
         VtllJuaFXsFZkW5yociCu7t64H8eVUQwFPn8ut7ESSkBID/c6ifrykOOLgVoYr+QlCET
         oScmPiqx1sXOVoKjHBfJtDGihq4pl88H5gxFaX86WPHsE4TjwpIix+evnd9CvfpqvFfy
         5xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mxeZyACnh97j+FymKAYz3kB3KSv2VBxKUGSN2j7Wq6Y=;
        b=Z9maANf5M6Vy04tYv7vfUFCs7i+qyyZPO4ZzuLa1ZD1IOLuIh82XDtoL6GC1ADsYAa
         ICOkkilE5tilIXCH/GPlOYcCzZTjOnYyl7iVslKMW0jcb2oZO6+6fFo2DuH1V4MKbYA3
         POxlCue88uJh9cGmSlLTExwWQ+64/3OCEutJzO79uQqEitkLPBtafC3nrTAm7bHK5MXo
         w2xCWpVXoaGCRkE503u110ZoWquJ5iUbUPuEo44z3xN2egmMO/q1qHbKrab0PhC0Bh6j
         2khTHWlkLcHDxzGmjHZJfs3twTiHcQEnDLE5AQGanfJ7xCAhbj2RuyZZtJ0lL3Cxiy2S
         RQJg==
X-Gm-Message-State: ACrzQf0bDOlyuOTmrRepE0zXt7TJPFLWmQFtIrEhbiBOIVCHcKELj+8R
        zewP8/Qcne16GpPR0FLy/NI=
X-Google-Smtp-Source: AMsMyM6qqRWwaLSe1b37Y5HEzyG+6FA7W11RQ1KQ1jPPz/qLyl504CF4sqlfojbI0un7im7QrBrNtA==
X-Received: by 2002:a17:902:d2c4:b0:178:32c4:6648 with SMTP id n4-20020a170902d2c400b0017832c46648mr1261890plc.88.1664420406551;
        Wed, 28 Sep 2022 20:00:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0016dcbdf9492sm4610669plh.92.2022.09.28.20.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:00:06 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com,
        imbrenda@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        xu xin <xu.xin.sc@gmail.com>
Subject: [PATCH 1/3] ksm: abstract the function try_to_get_old_rmap_item
Date:   Thu, 29 Sep 2022 02:59:57 +0000
Message-Id: <20220929025957.281329-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929025206.280970-1-xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

A new function try_to_get_old_rmap_item is abstracted from
get_next_rmap_item. This function will be reused by the subsequent
patches about counting ksm_zero_pages.

At the same time, the patch improves the readability and reusability
of KSM code.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Signed-off-by: xu xin <xu.xin.sc@gmail.com>
---
 mm/ksm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03..5b68482d2b3b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2187,14 +2187,11 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 }
 
-static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
-					    struct ksm_rmap_item **rmap_list,
-					    unsigned long addr)
+static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
+					 struct ksm_rmap_item **rmap_list)
 {
-	struct ksm_rmap_item *rmap_item;
-
 	while (*rmap_list) {
-		rmap_item = *rmap_list;
+		struct ksm_rmap_item *rmap_item = *rmap_list;
 		if ((rmap_item->address & PAGE_MASK) == addr)
 			return rmap_item;
 		if (rmap_item->address > addr)
@@ -2204,6 +2201,21 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 		free_rmap_item(rmap_item);
 	}
 
+	return NULL;
+}
+
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+					    struct ksm_rmap_item **rmap_list,
+					    unsigned long addr)
+{
+	struct ksm_rmap_item *rmap_item;
+
+	/* lookup if we have a old rmap_item matching the addr*/
+	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
+	if (rmap_item)
+		return rmap_item;
+
+	/* Need to allocate a new rmap_item */
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-- 
2.25.1

