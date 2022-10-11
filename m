Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4E5FAA95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJKCWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJKCWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:22:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643182745
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l6so2149694pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBGBO38UtGSWwXVp7Ms/n5NhA5Pd+Mi6T8z7EXrrTqE=;
        b=NQwP6y9bldduXueh4GTe05alGLYH2cXxs6iR6vqImjtYM+ijwRDNkiUFqRfINXVKnc
         lPNsjMlrdYCD/aQbcS+3J5F6ov+nKAIyIz8fHQnOMnJMVayFdHpk+dUzr0/ShM/aQ4zQ
         PIYCeXOqyA6j/JdcmzrfsfvNdk95wsVOFdb0rARM1VmPokMffWAPbzgNsgUTBRSW3iQI
         TGQJmqYdZd5YOSMSmSsSCgLgXogoXIY0JmT/e/olVLdSk5Suu0uIkOGokMlh+UnvnvLC
         WjzAbxhTg04rIwWiOQcOLB4kfxGpAL7tYhAK4fjuIiOODSi2rgBDazceiLPQFN5OD7rP
         VPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBGBO38UtGSWwXVp7Ms/n5NhA5Pd+Mi6T8z7EXrrTqE=;
        b=Ez4+yOyKiP4Z33QtLYZ/VBi04vzWhMdWnJoCTFvC/w9vnYv9jAQuZi1FyEma0d1z3T
         KOw+HRtHwapIqN5mBQjBY1NVTkXydFFIfXrMm4jXCpaSoK/I3LSHqEDXk2jzYsUSWvx+
         R9wF40do5/wBAFdiYmoWol6c7B4cw46LB0lOXlKFvX1oepKzEBOBs7ekcaw90nJ7anCP
         f61ATc+hnvG46eXumtePk/8HESBFnq0ksUOAE+FDg/D4yia3PxFVPwbX/hLMCZVxWZZc
         32WgN1xP8Jb7YNF/8DeRNBBnaNvCZg222f4ZZn632HyHz5wRwgtvjy06TBB7Xo7UYJxq
         fjCQ==
X-Gm-Message-State: ACrzQf2YWeY4a5vdM1/ixhYYhvF/Q88FUXun47JA2JMVfZCecCQkYguY
        taeXlv2k+fowrJ3CqMhWPo0RJacA0n4=
X-Google-Smtp-Source: AMsMyM4HJO1bRVw+FEpT/jpF8AW/W1KC5CylFOLFTiM7r3HksmwbDm+KaSDXGiVpS8apzQDl8EckZQ==
X-Received: by 2002:a05:6a00:2291:b0:563:9d0d:62ae with SMTP id f17-20020a056a00229100b005639d0d62aemr3557524pfe.17.1665454956397;
        Mon, 10 Oct 2022 19:22:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b0020d6fc00072sm69660pja.9.2022.10.10.19.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:22:35 -0700 (PDT)
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
Subject: [PATCH v3 3/5] ksm: count all zero pages placed by KSM
Date:   Tue, 11 Oct 2022 02:22:30 +0000
Message-Id: <20221011022230.322323-1-xu.xin16@zte.com.cn>
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

As pages_sharing and pages_shared don't include the number of zero pages
merged by KSM, we cannot know how many pages are zero pages placed by KSM
when enabling use_zero_pages, which leads to KSM not being transparent with
all actual merged pages by KSM. In the early days of use_zero_pages,
zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
it's hard to count how many times one of those zeropages was then unmerged.

But now, unsharing KSM-placed zero page accurately has been achieved, so we
can easily count both how many times a page full of zeroes was merged with
zero-page and how many times one of those pages was then unmerged. and so,
it helps to estimate memory demands when each and every shared page could
get unshared.

So we add zero_pages_sharing under /sys/kernel/mm/ksm/ to show the number
of all zero pages placed by KSM.

Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e351d7b6d15e..2970a7062db6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -275,6 +275,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/* The number of zero pages placed by KSM use_zero_pages */
+static unsigned long ksm_zero_pages_sharing;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -542,8 +545,10 @@ static inline int unshare_zero_pages(struct ksm_rmap_item *rmap_item)
 
 static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 {
-	if (rmap_item->address & ZERO_PAGE_FLAG)
-		unshare_zero_pages(rmap_item);
+	if (rmap_item->address & ZERO_PAGE_FLAG) {
+		if (!unshare_zero_pages(rmap_item))
+			ksm_zero_pages_sharing--;
+	}
 	ksm_rmap_items--;
 	rmap_item->mm->ksm_rmap_items--;
 	rmap_item->mm = NULL;   /* debug safety */
@@ -2075,8 +2080,10 @@ static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
 		 * In case of failure, the page was not really empty, so we
 		 * need to continue. Otherwise we're done.
 		 */
-		if (!err)
+		if (!err) {
 			rmap_item->address |= ZERO_PAGE_FLAG;
+			ksm_zero_pages_sharing++;
+		}
 	}
 
 	return err;
@@ -2178,6 +2185,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * to reset the flag and update the corresponding count.
 			 */
 			rmap_item->address &= PAGE_MASK;
+			ksm_zero_pages_sharing--;
 		}
 	}
 
@@ -3190,6 +3198,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(pages_volatile);
 
+static ssize_t zero_pages_sharing_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", ksm_zero_pages_sharing);
+}
+KSM_ATTR_RO(zero_pages_sharing);
+
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -3250,6 +3265,7 @@ static struct attribute *ksm_attrs[] = {
 	&merge_across_nodes_attr.attr,
 #endif
 	&max_page_sharing_attr.attr,
+	&zero_pages_sharing_attr.attr,
 	&stable_node_chains_attr.attr,
 	&stable_node_dups_attr.attr,
 	&stable_node_chains_prune_millisecs_attr.attr,
-- 
2.25.1

