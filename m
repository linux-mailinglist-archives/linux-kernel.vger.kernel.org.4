Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2D5FAA93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJKCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:22:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2B5C379
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h10so11940716plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsbh45Fv58HEehSJMVvF1reAzOnYH1CPjnbjNiOuTbI=;
        b=lgOVYuFLApBB99lxB0wJ+xs6iHGx1lEt2NfNrp2YK62xBG7cGjYeVl9kKELJ/qMHMn
         Zyd1vrv+Pck4AGaEvT974cU36a/3WWkDBHnuCTXvw1bc04EmlKd0Em5eipe+qGAEyUaU
         LF2Fn5nE/nb7YoHhIKt0V+cWuj0RHTf4QLYA0QG0VPhZnW8IKCAS8UCah3FqahzOxcG7
         Ul5miU01nXsNlaIoyvq9ItU767ag1L+LNKPvPXixm6iPHOOSv5fl7pBcXW3nZUysG+IZ
         v5tV7aCmWU34KlM0txj6ud6e/MUyrd0QHdt4fi49yFsR/gC0GEzRYKXyVR47/GJsAc+p
         cLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsbh45Fv58HEehSJMVvF1reAzOnYH1CPjnbjNiOuTbI=;
        b=Wo2hhvo6ZjRynIgdq1ecMhhrWiuVLit/o/Jgjgwi/H5y8Yha9917qyKso5sB8iMLKK
         vZIdwpr7wbC7K2EBqVzaiUKgjZwP4KI0iI2rUYaTrshw42h9I2JOMwVwFs8Fnw40viQD
         uD6PxV9leB0nWFyJLBVvbX/iwnUvmELwfZfq8ujSlwHzLgGDRTUhR2vwfdmR9oFF2gtW
         ZiUmrPo/CEdS1xZOkKFJPAhTazwgbnFKL4uvaUJxUsv6EBwz/rgeweycIUCWPCovpIOs
         qEKUIa7ekxYPIIoAj+ggqsx8PeMgTK1Kw6adtrIb1R5wke2MI0utKkkFEzvmA6frXdQe
         9TqA==
X-Gm-Message-State: ACrzQf2a91LiIX0TBhbNqsdX3WDzveRaZ9gI61jZLPuZQ3mh/c0ZAz10
        tub8Qxj5p4iRv/j+dePMexpL0l9gJ60=
X-Google-Smtp-Source: AMsMyM7JW36aWaS0bLlTDqSb2ZhzhL4vqsQD6p3KYfBeOqc7tFwXhZjgSDiBMKko8MCBq+bCt5qKKA==
X-Received: by 2002:a17:902:f0d4:b0:17f:72bd:74f3 with SMTP id v20-20020a170902f0d400b0017f72bd74f3mr22495074pla.109.1665454923480;
        Mon, 10 Oct 2022 19:22:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090aaa9800b0020d51aefb82sm94655pjq.19.2022.10.10.19.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:22:03 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v3 1/5] ksm: abstract the function try_to_get_old_rmap_item
Date:   Tue, 11 Oct 2022 02:21:50 +0000
Message-Id: <20221011022150.322212-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011022006.322158-1-xu.xin16@zte.com.cn>
References: <20221011022006.322158-1-xu.xin16@zte.com.cn>
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

The patch improves the readability and reusability of KSM code.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03..13c60f1071d8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2187,23 +2187,36 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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
 			break;
 		*rmap_list = rmap_item->rmap_list;
+		/* Running here indicates it's vma has been UNMERGEABLE */
 		remove_rmap_item_from_tree(rmap_item);
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

