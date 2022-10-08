Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFD95F83ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJHHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJHHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:06:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B901A20D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:06:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fw14so6058137pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrPOD+KhqOFJAEX56XxLC5jHOX5mIwwsCLX+qV5KxT4=;
        b=LKDDwupQjCXTZCVBlTOqwhB0ZHmLddxOJkaQI9iqpkAm4GBejemWj47pXzHJZBE5Lc
         0kZ/v/vwQymfmd/+TkJJVFJtMeMkKl/ULS2YAYwgePcUhsmNUrl9ZgpX1cbeJSnaJwU7
         Dw3yNw+wUw+i15xdQ1Pl1Ic5rS8WSgUeA01eGMhN+WNe97QRrGTnY6QLVNe2RgXLVjO9
         el8zjjlkjzMHc8ytX9dgKZnz3BWj5/r03iIFgEhnR0kKILmiYW1Y6RkZuKhvl6BHxHG9
         34p4HIHximpsSckGEyvvIOaAJ+xecU+iCKiGqP3oQc5TZqpjPxi7Fu2b74fhPq8vydcc
         65GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrPOD+KhqOFJAEX56XxLC5jHOX5mIwwsCLX+qV5KxT4=;
        b=ebL2G0hfdk3thUZRnngruJ4X8gzxmbmE8BdWjXu/f0Eh095vbQQFO6kCE+zpqccWKV
         uH7Xcp+ubO29SrRqziI3VX60gUQrlDDQVUvyaTY/acIV94ZbSoNm1iNg0Nt55gymFl7A
         ZE+LT1pu/wStRTOoagb75eykryFtZMBXJmfn4fwQY0rIXMq+pwP0zljjIhCfrd50OFKK
         RS2gB9w1Z1BgTszybLxZ9GRj9ClWf2CNo7nZpn/5WSSpOpShH63XGr2SGzfeDsDYq1XI
         jd1k5h5q1qcneFiBWiLWjE/3PqShs8lVNpTDNcugjoIAEQ4g6itAIdi04guHXu5OVEf4
         iIYQ==
X-Gm-Message-State: ACrzQf3J/oXU5Kwzquj06Nmz9wNoAerdezVAYkRYLe2IMjKsxa0fG6BY
        u2zPDDzIbeKEUcrmpagjuOA=
X-Google-Smtp-Source: AMsMyM7NGewJHu/y94jUlrNlEopVSi5jWxeOZAwuJpFctyaF2a3hIMtPMHYAHu62m2I9qFp6SMx9Mg==
X-Received: by 2002:a17:90b:2651:b0:20a:daaf:75f0 with SMTP id pa17-20020a17090b265100b0020adaaf75f0mr9004581pjb.142.1665212784299;
        Sat, 08 Oct 2022 00:06:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a678100b002004380686bsm5557157pjj.46.2022.10.08.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:06:22 -0700 (PDT)
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
Subject: [PATCH 3/5] ksm: count all zero pages placed by KSM
Date:   Sat,  8 Oct 2022 07:06:13 +0000
Message-Id: <20221008070613.308637-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221008070156.308465-1-xu.xin16@zte.com.cn>
References: <20221008070156.308465-1-xu.xin16@zte.com.cn>
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
index 75978f7eeed1..9b7c28abfc89 100644
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

