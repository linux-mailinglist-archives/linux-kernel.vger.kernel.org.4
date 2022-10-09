Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C179F5F88DA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJICX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJICXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:23:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E923642A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:23:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h10so7695054plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoDnBFDHVA7LU5T0eht7qIcxVf5BHA7MxEN+oTzlcX0=;
        b=ofCcVhUEDdNXNttt6XZggV43bk1949OnzTBSrXtuZcJcps0cu2XwVVz6ksK9cV74m+
         Ta2GaV5wrtZWb5wpawvNbHLTiT95mPnnX/yBm3ErBO+AVXBdWFhQDeoxvUSH59k1PU3u
         IGtk3nC1csD38ozpWW24RtpPRl35romwjkmD+tZpABFsdK2ACdW/6wMqagcJxl9rWkW6
         vhCCFF2S0ucKwCd7HOE8EscU085BQf4QpHm9C+PYDiV9ITerSaIZtzJSswOnAjU8vBjy
         kYGBVBbJSu3aznrKX5wbXkUvRNWGUMmKqWKdwYD405pTUoqT7J8uMHj84NJ1JcX1M2D2
         fw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoDnBFDHVA7LU5T0eht7qIcxVf5BHA7MxEN+oTzlcX0=;
        b=Hi2y8oMEigp6VVoNqWjQtQLA5gXThmXM3udOG38ZF15sbV6YtOmBR4XGQZcdOiWuVE
         lbrvvNF03jaTjZcNE2qGZhtzH8HTx9FliPpRE2Q9HcoUSlQaE4xP+AEVwHW2jG9BdPLX
         Odd1dwIDzSf2je+RcLEfAEU9Nyc+pYu4g26sjf4bNppIfn68BauZxVKpGLWYYNI3PRKD
         dpXV+j4CDRU/Fmh9heIm7nVZ/h+K3qnhGokK+0+TSVXqvZk/iaTGysNhuSAZ29YvnVd4
         p2/e7naoSmlbHjQfo0x59z3Sy50/4itFhjJkBsFNbIl5ba9FZ3HmUG47gwfpt2FmhBl1
         0Oew==
X-Gm-Message-State: ACrzQf3HOwmNfHbUPYCZ2HurzAlw/4frtvJs6FU4lCFzEtMrkiLy1ZA9
        Hs2BM5tPMRcoH72+vOxaXA4=
X-Google-Smtp-Source: AMsMyM7SvcN37Jq7m3iuPnNHgqj3NFAaHIJhjx0KT7J46cKR6I1fV87kmBd2iajvV+IMG3jvXDdU1w==
X-Received: by 2002:a17:90a:1b43:b0:203:70c0:9f60 with SMTP id q61-20020a17090a1b4300b0020370c09f60mr23779368pjq.184.1665282224445;
        Sat, 08 Oct 2022 19:23:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u64-20020a17090a51c600b00200a85fa777sm6826951pjh.1.2022.10.08.19.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:23:43 -0700 (PDT)
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
Subject: [PATCH v2 4/5] ksm: count zero pages for each process
Date:   Sun,  9 Oct 2022 02:23:38 +0000
Message-Id: <20221009022338.315428-1-xu.xin16@zte.com.cn>
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
index 80672325f179..c1cc3cd370aa 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -545,8 +545,10 @@ static inline int unshare_zero_pages(struct ksm_rmap_item *rmap_item)
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
@@ -2082,6 +2084,7 @@ static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
 		if (!err) {
 			rmap_item->address |= ZERO_PAGE_FLAG;
 			ksm_zero_pages_sharing++;
+			rmap_item->mm->ksm_zero_pages_sharing++;
 		}
 	}
 
@@ -2185,6 +2188,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 */
 			rmap_item->address &= PAGE_MASK;
 			ksm_zero_pages_sharing--;
+			rmap_item->mm->ksm_zero_pages_sharing--;
 		}
 	}
 
-- 
2.25.1

