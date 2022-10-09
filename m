Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5A5F88D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJICXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJICX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:23:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF33056E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:23:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h13so6628380pfr.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBN6huPdGpKqKhIAKLLkaRuR3gOgGOPhsRbsJyWYIRI=;
        b=XAM200tElyyWyP4GFtgU07tj8DP41cBE6Jr/D2kKGZQS47KOTs70HLvvrDFZ0vQYmE
         XWUAAYh0ItKz+yYjLgzElI4Isid9D9OBcUb0fVZTdTnb/r7gOBi9b1qZcIWvDN++Xb06
         4bz8nkLMLMMTW2yxu3Bd59NlsdTWOgzrigJNJB3cTfGO1gmHwxSJ+OvxyOuKiHs0EKT2
         Rx9fX6/B6me420ELRJ1oLiIpvI9P54g/+uGrPrRYdjINHIsPKMteAyWOD16wiFaRI/4W
         1FmDlBiAvtpeDGFbLJs7IuP7j9JZGMZG53OtYOdT+RUfEnlGReZ1QSA1qcN6GpmtI31r
         RFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBN6huPdGpKqKhIAKLLkaRuR3gOgGOPhsRbsJyWYIRI=;
        b=Z+necq1tW32sEabfrk9jKskCLoR20bSLaO2JK97EX75mIMK1NPwaJ6M/rGHFpkvXag
         vMl/5FAN2XWZM3cX0o2jm/qA7p2rpvFGk3F39QULpUKyb3jtf72Z/lou5F6oLTg8BUwU
         tzy9VxIOvZje9/zEWJm68dFSTl+P7vFJMn2ExpFd+quZ8kPszwZG/ii8n+GFgpXAemFC
         f8fY1YqZmi0zBMkXvqrQ4AVJmudNMMaklltyJ/BbqKV9r30J9tQdmvzNB6Z7IaOt0BJ/
         6wy3MLFM0/TTCVeq4EvPQx1SjOH7chHhXUI3emvxT0+T7qTYPQIjBHHq3sTZeBN5+iJi
         302Q==
X-Gm-Message-State: ACrzQf12WDpH4LFF7qJVai85pXJJwdLUZE+N+izjo7dGtOPXubrQuMQh
        61qkk/bSm68x1OXU1Oeh7do=
X-Google-Smtp-Source: AMsMyM6y79bKyw1UWc6p/gUgr0Ws8By8/oW6O0JhPjmAErRjz/PWawklzQiLVCrXJdD+Jqf/+FLiTQ==
X-Received: by 2002:a63:450c:0:b0:443:94a1:3703 with SMTP id s12-20020a63450c000000b0044394a13703mr10648210pga.565.1665282207477;
        Sat, 08 Oct 2022 19:23:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902cf0e00b0017cc29a5536sm3976353plg.17.2022.10.08.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:23:26 -0700 (PDT)
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
Subject: [PATCH v2 3/5] ksm: count all zero pages placed by KSM
Date:   Sun,  9 Oct 2022 02:23:21 +0000
Message-Id: <20221009022321.315374-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009021816.315205-1-xu.xin16@zte.com.cn>
References: <20221009021816.315205-1-xu.xin16@zte.com.cn>
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
index e988a17b837e..80672325f179 100644
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
@@ -541,8 +544,10 @@ static inline int unshare_zero_pages(struct ksm_rmap_item *rmap_item)
 
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
@@ -2074,8 +2079,10 @@ static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
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
@@ -2177,6 +2184,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * to reset the flag and update the corresponding count.
 			 */
 			rmap_item->address &= PAGE_MASK;
+			ksm_zero_pages_sharing--;
 		}
 	}
 
@@ -3189,6 +3197,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
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
@@ -3249,6 +3264,7 @@ static struct attribute *ksm_attrs[] = {
 	&merge_across_nodes_attr.attr,
 #endif
 	&max_page_sharing_attr.attr,
+	&zero_pages_sharing_attr.attr,
 	&stable_node_chains_attr.attr,
 	&stable_node_dups_attr.attr,
 	&stable_node_chains_prune_millisecs_attr.attr,
-- 
2.25.1

