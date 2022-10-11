Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA75FAA96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJKCW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:22:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9534857D8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14647717pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i90jsiDje3OippwaWc7d+5Gj/jeYy2WnHfwavKx1Zc=;
        b=MbQSbPtXvqYlFl1N+H0dMvFlCM2YQF26s9pH/nam6VIgQ2wFgvKeUspQIecinHRbUs
         Hj9fALXGL82tlCQZCVhYowBU8NZsqc7tDHR7jptur05LWdJ9IRwsjK4tPmvC9LlYRxNr
         K87nnfFq8DMfBcx9NkiACVW1/uAcUwQ6zoOmr5pPYeNkV9XHunRzCPT+Tktu/drkcLt6
         XD6UV/aXHyM686jv87C2eBwtIvvZHSepGPXufc4227d2Em3NzYVP+7cJX59xpguD/Hpn
         ZgUtsxjWQ8qqRzFCHaF6RYD3lqNp64V+Kg38o3fnJ1bYiKBjdfaagRf8YzMw9q09zHVm
         6pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i90jsiDje3OippwaWc7d+5Gj/jeYy2WnHfwavKx1Zc=;
        b=xt8B0tsvyeL5HqdT68Rv0r6cGljeRsnvJUdaokE53/111LGRccmuv7MmGXnZTuoXOo
         fcYYzd2Azqr/0Jr0HLdfQawC8D5O1qwwLAXE3CMUVakGnG8K1g/a/tRh5dApGVoOFyCg
         tFL68WvZLNCbqIA/MKjJff0PaWRBbYhtWAKRJg3kMd9Wi4SnfRi2/yDngBahxl1vvjVg
         kg0NqVsHYvLFd4v0IuwOsFf4pEi8w+RoBrptRhM0s9GQhL/cGR4dGY/z6Qoyfh1az5hk
         f3RN2a0EWGNmCKTxu76FoWsJNws4QNF3eE8v+eAP+GNJNJbvxLa7MvOJ0fkizcpeup3n
         rjYw==
X-Gm-Message-State: ACrzQf1i1AoNLsa8Kk+lalsNtZdGBth+4mYPXWwza0rKa8R34QWGYPxA
        fMPqNun+DwZ67QOoQffXsr8=
X-Google-Smtp-Source: AMsMyM4z5grjzv3Vvk1EW21MJh3qJtZLK69EMl0iS6JtR43bWHIz9+nVBnfZX/qCphFVvPIBr6OMSw==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr4632808plx.157.1665454972670;
        Mon, 10 Oct 2022 19:22:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e2-20020aa798c2000000b005631a40a00bsm4423241pfm.139.2022.10.10.19.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:22:52 -0700 (PDT)
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
Subject: [PATCH v3 4/5] ksm: count zero pages for each process
Date:   Tue, 11 Oct 2022 02:22:46 +0000
Message-Id: <20221011022246.322377-1-xu.xin16@zte.com.cn>
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

As the number of ksm zero pages is not included in ksm_merging_pages per
process when enabling use_zero_pages, it's unclear of how many actual
pages are merged by KSM. To let users accurately estimate their memory
demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
pages per process.

since unsharing zero pages placed by KSM accurately is achieved, then
tracking empty pages merging and unmerging is not a difficult thing any
longer.

Since we already have /proc/<pid>/ksm_stat, just add the information of
zero_pages_sharing in it.

Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c           | 1 +
 include/linux/mm_types.h | 7 ++++++-
 mm/ksm.c                 | 6 +++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..ac9ebe972be0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3207,6 +3207,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 	mm = get_task_mm(task);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
+		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
 		mmput(mm);
 	}
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..78a4ee264645 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -691,7 +691,7 @@ struct mm_struct {
 #ifdef CONFIG_KSM
 		/*
 		 * Represent how many pages of this process are involved in KSM
-		 * merging.
+		 * merging (not including ksm_zero_pages_sharing).
 		 */
 		unsigned long ksm_merging_pages;
 		/*
@@ -699,6 +699,11 @@ struct mm_struct {
 		 * including merged and not merged.
 		 */
 		unsigned long ksm_rmap_items;
+		/*
+		 * Represent how many empty pages are merged with kernel zero
+		 * pages when enabling KSM use_zero_pages.
+		 */
+		unsigned long ksm_zero_pages_sharing;
 #endif
 #ifdef CONFIG_LRU_GEN
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index 2970a7062db6..c049a95afc26 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -546,8 +546,10 @@ static inline int unshare_zero_pages(struct ksm_rmap_item *rmap_item)
 static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & ZERO_PAGE_FLAG) {
-		if (!unshare_zero_pages(rmap_item))
+		if (!unshare_zero_pages(rmap_item)) {
 			ksm_zero_pages_sharing--;
+			rmap_item->mm->ksm_zero_pages_sharing--;
+		}
 	}
 	ksm_rmap_items--;
 	rmap_item->mm->ksm_rmap_items--;
@@ -2083,6 +2085,7 @@ static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
 		if (!err) {
 			rmap_item->address |= ZERO_PAGE_FLAG;
 			ksm_zero_pages_sharing++;
+			rmap_item->mm->ksm_zero_pages_sharing++;
 		}
 	}
 
@@ -2186,6 +2189,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 */
 			rmap_item->address &= PAGE_MASK;
 			ksm_zero_pages_sharing--;
+			rmap_item->mm->ksm_zero_pages_sharing--;
 		}
 	}
 
-- 
2.25.1

