Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A55F83EE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJHHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJHHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:06:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C589193F3
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:06:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so6655671pfz.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+7cGrSCaB8toCY9LzJTV6eREW3WTAoZDgmk6SweSp0=;
        b=NI+szN5GnNITjU+LpGlHOTnVh2BNC7vF7YjihBuKzgQvD13g7J70KAt8n01JOrPCGE
         pfjhUSYusC/G0Rj7vJSaSLmiou6u2wtpZFAj1ygAIjlpggrW7H/0ADcIQM+2DCw11/Tl
         eM5igZHSw+2qV2dqucWmz5HaEv1wTvni+/GCpHOgRN6oxpsoNJqMmEQOfR65/8AFnqPM
         77uv6tGOZYwqebSlCFSjeOWOlK449c1myqh4id/BZLKFXjA3Kd64Cf69h70BkmHFoPL6
         F4mERXoSD7EgxjZAVhhAkfR9ipQXWDPZiRaWAN0WpfzMb7XTy+xLNCIR4Xhf6WuBnyfz
         Jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+7cGrSCaB8toCY9LzJTV6eREW3WTAoZDgmk6SweSp0=;
        b=7NnknaB/Rqf29NLeY5dtIKfKE8TsxLTMKaFYS0ozYEv1ZHlUZbE200Bw7YzyHiGeCt
         BJv+a1M3CDMrPHhYl4uytDOOTNdOM6OdVfHSzDvGb/H+CwZTCNJ4dUplKuhqFnsNsAmj
         Q7Yh1WvhGoaxFW//EL6fGppccysyUnXzou37PaseKui8eiYTejM52LZrfovY6TQ0g75y
         SPn78u+Ll4BAAzUbJgVNHeuv7iYYbf1qx1GQRPaE+HY6zwoFeHRzn/OTHWw01p1d1IBc
         mFZYfm1WblqZ8LDVw5xZAuF7HXDmGa76FNELrxc4duXrQdY739+8X9SM+pnF8CofaWgt
         JKTA==
X-Gm-Message-State: ACrzQf3jOe76jlT+BVYdZmslRSWjUMMQoTwbPXg7JKLqg1FPyAvIQfBh
        LXNHRmww7wapM4UcG0o4a48=
X-Google-Smtp-Source: AMsMyM5y3td7v+CEksjuK/XyY+otk4kTI3C1PTEjt8Qr6W7VoZaJT/xWMQBDRZnZZMRIN+xcHpeLqw==
X-Received: by 2002:a63:4283:0:b0:457:dced:8ba3 with SMTP id p125-20020a634283000000b00457dced8ba3mr7736754pga.220.1665212810118;
        Sat, 08 Oct 2022 00:06:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id pc14-20020a17090b3b8e00b0020a28156e11sm4281098pjb.26.2022.10.08.00.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:06:49 -0700 (PDT)
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
Subject: [PATCH 4/5] ksm: count zero pages for each process
Date:   Sat,  8 Oct 2022 07:06:42 +0000
Message-Id: <20221008070642.308693-1-xu.xin16@zte.com.cn>
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
 mm/ksm.c                 | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

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
index 9b7c28abfc89..a889b1925f51 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -547,6 +547,7 @@ static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 	if (rmap_item->address & ZERO_PAGE_FLAG) {
 		if (!unshare_zero_pages(rmap_item))
 			ksm_zero_pages_sharing--;
+			rmap_item->mm->ksm_zero_pages_sharing--;
 	}
 	ksm_rmap_items--;
 	rmap_item->mm->ksm_rmap_items--;
@@ -2082,6 +2083,7 @@ static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
 		if (!err) {
 			rmap_item->address |= ZERO_PAGE_FLAG;
 			ksm_zero_pages_sharing++;
+			rmap_item->mm->ksm_zero_pages_sharing++;
 		}
 	}
 
@@ -2185,6 +2187,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 */
 			rmap_item->address &= PAGE_MASK;
 			ksm_zero_pages_sharing--;
+			rmap_item->mm->ksm_zero_pages_sharing--;
 		}
 	}
 
-- 
2.25.1

