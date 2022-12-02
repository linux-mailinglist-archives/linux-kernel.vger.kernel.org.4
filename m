Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27F640F18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiLBUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiLBUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:18:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD142F53
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:18:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t17so5931963pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlxbiiFsWdDqrJ8JxFSTusC0S+OriMX0V/gFk42PKp8=;
        b=X3QLxOn1qjig7LtO7aliP1TmeLmdtTMgynji6s9IuVKW9O4UwyaoeYzkUFps3JNTpQ
         WhaAiNNldV8Bol0CUGvrfQOjlieun9JSabXCLhIbGsCraSnxidzEC25ME1L/JPj/EfKM
         wrj50X+yoxnLOkahZMyKB6nL/T4QRlwhs6tAsoE+k9j21M8YymZt/4smwOMUqyE8hLcS
         g+MNiutitd5h0jOsxjf7JqXjCwmVLreY3G9Gi7wn/MTLAASABuqC51I2KOWzXeRmkGTh
         mmYRpyA7+4hEFqX6FgbYJvy27zhGty4OTOTQfD9OGWjyPSx457hhpOCVHibn7Oek0nrU
         tmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlxbiiFsWdDqrJ8JxFSTusC0S+OriMX0V/gFk42PKp8=;
        b=g1vp5JQDYozKUsvP8BSl+ji7mOzh3wn23AW0Bj9GbPsXrfEZ2qhBNnIPD6rw7WG33L
         gtI3M0429N5KM8Hpzeu0R3IBe8O+xF5KnaMd+HXDajAHGh1O4QNa6Qr1qjELwuURBpxQ
         ipL7gCrlBkKBxpRvdrcUbUDkndmmII3JjJHMxP+AD6d286XEq+Iz5dS1ulNEnvrnlV2H
         Nqrz8uBd2jRlBrNSKU9moVPQqB1f+buk8VnQvHtbxXXIICUBq3ux4YkqCZQhfL3LvHj7
         lVabj+G9KbMntW0Qe05Rclio82rxLIzj4F+ayfko+vn6py8Lpde0BSS0vlphRoZQcXas
         6tTw==
X-Gm-Message-State: ANoB5plnKPR2Du9fDW2FQ6hK7PK8ZrEnc952X51TP2XxKHiqby3F0NqD
        tmMTG2MfhlZM5bmE2hgyKwI=
X-Google-Smtp-Source: AA0mqf5lwtORbemSWYSfZgRXy5unWou9iB45CvfkeSCHerlZ8w272EPvEdUKxNauf3GIlLDOGvWrSw==
X-Received: by 2002:a17:902:8503:b0:188:e49e:2668 with SMTP id bj3-20020a170902850300b00188e49e2668mr57636232plb.125.1670012299344;
        Fri, 02 Dec 2022 12:18:19 -0800 (PST)
Received: from biggie.. ([103.230.148.191])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001714e7608fdsm5939662plx.256.2022.12.02.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:18:18 -0800 (PST)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, shy828301@gmail.com, zokeefe@google.com,
        vbabka@suse.cz, david@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/khugepaged: add tracepoint to collapse_file()
Date:   Sat,  3 Dec 2022 01:48:07 +0530
Message-Id: <20221202201807.182829-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, is_shmem is not being captured. Capturing is_shmem is useful 
as it can indicate if tmpfs is being used as a backing store instead of 
persistent storage. Add the tracepoint in collapse_file() named 
"mm_khugepaged_collapse_file" for capturing is_shmem.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
changes in v2:
1. Move filename dereference out of calling path (Steven Rostedt).
2. Capture is_shmem and index (Zach O'Keefe)

changes in v3:
1. Initialize the variables to resolve clang warning.
2. Add more info in changelog.

changes in v4:
1. Swap is_shmem and addr to save space (Steven Rostedt)

 include/trace/events/huge_memory.h | 38 ++++++++++++++++++++++++++++++
 mm/khugepaged.c                    |  7 +++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 935af4947917..f06a255d7ec8 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -203,5 +203,43 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 		__print_symbolic(__entry->result, SCAN_STATUS))
 );
 
+TRACE_EVENT(mm_khugepaged_collapse_file,
+	TP_PROTO(struct mm_struct *mm, struct page *hpage, pgoff_t index,
+			bool is_shmem, unsigned long addr, struct file *file,
+			int nr, int result),
+	TP_ARGS(mm, hpage, index, addr, is_shmem, file, nr, result),
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, hpfn)
+		__field(pgoff_t, index)
+		__field(unsigned long, addr)
+		__field(bool, is_shmem)
+		__string(filename, file->f_path.dentry->d_iname)
+		__field(int, nr)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->hpfn = hpage ? page_to_pfn(hpage) : -1;
+		__entry->index = index;
+		__entry->addr = addr;
+		__entry->is_shmem = is_shmem;
+		__assign_str(filename, file->f_path.dentry->d_iname);
+		__entry->nr = nr;
+		__entry->result = result;
+	),
+
+	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, addr=%ld, is_shmem=%d, filename=%s, nr=%d, result=%s",
+		__entry->mm,
+		__entry->hpfn,
+		__entry->index,
+		__entry->addr,
+		__entry->is_shmem,
+		__get_str(filename),
+		__entry->nr,
+		__print_symbolic(__entry->result, SCAN_STATUS))
+);
+
 #endif /* __HUGE_MEMORY_H */
 #include <trace/define_trace.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..921407e2006d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1702,12 +1702,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *hpage;
-	pgoff_t index, end = start + HPAGE_PMD_NR;
+	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
-	int nr;
+	int nr = 0;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -2059,7 +2059,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		mem_cgroup_uncharge(page_folio(hpage));
 		put_page(hpage);
 	}
-	/* TODO: tracepoints */
+
+	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
 	return result;
 }
 
-- 
2.34.1

