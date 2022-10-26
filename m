Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6260DA88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJZFWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJZFW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:22:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD93AE858
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 22:22:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b11so6895833pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6nf8tg6bfdy8ZRRZrGWc8N60AgATSDdfOrh6ffniPwQ=;
        b=TyV9GL0jd2Mv6ivukXVpz1xSMyfoSpjC6FJM/Ef8WbFqhhzx8QwBPV+9BWtVMmAYGQ
         Jrp/boQLjGn8EWt9xhCSvYIY77aUhb9Pfj9E5Cl65U7a4f3QQy2SfhBrGpcIe8jfZeAz
         PVIMu4Ie3QZHLGztJRa94BBtw+R/mNtN2NzkG4a/OuZZ1BbjYW04UL2fvDlZWCAZGY7w
         A94aD/CRyrhy/OBhJf8yRuZdNq+1TjRn4EH2itjVfgKayKg3wKAZCmeqoWwou5CSKU2J
         Dum56GZzsCQUjlkI6rjTUFbxF8uE8YtVfAj236f6RBybvmOD647sD1254G1l2nadpxIi
         Qa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nf8tg6bfdy8ZRRZrGWc8N60AgATSDdfOrh6ffniPwQ=;
        b=D6IQvQZUna1mk59HaJtthKtW8nJg3QwAqW0WfLjhbGN46LHBXBgecVLNqVyaY1CwVL
         OTq4Hxmf4SxJH7XfomrAxF5i5yQl7Z7Z/p0QaMEXFmUjcoEqYmBngn+OQtEb7tOs6IVH
         8yp0uCNMX8LySEqtugTarLlqg9dD+ATmNy+UA4j5km+GNGZwgxSdmqdqIl4pmvelSVvJ
         YWaza0zAyCDQes/OI0s1Dl9jiMW6pJki2Dz7wQjSFVVGUmGpsfaM2ns61OeaKsJyiS9n
         HZnaI1ss5HmQL0erUu1Nhu4mZhw7OfyL6fXsfCcMv0rQbGtqXsSIcIVaHoKmVZqCoc6z
         29fQ==
X-Gm-Message-State: ACrzQf1VcPMhwLRIaT9FXMGj5giraLJTwEw4lOWFBV2roXYJxo//WzKP
        2Z7XgQzW8sFg1TQQu6J7wLk=
X-Google-Smtp-Source: AMsMyM5velXK9ExPRI0uRTPhyVhMw70ESTcz9auVVTqB2thmc0XR5091ci6jAeJf3aF1ukevYhWUjA==
X-Received: by 2002:a17:902:c948:b0:186:7baa:10ef with SMTP id i8-20020a170902c94800b001867baa10efmr25082844pla.73.1666761746218;
        Tue, 25 Oct 2022 22:22:26 -0700 (PDT)
Received: from biggie.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b001869f2120a6sm2066817plg.108.2022.10.25.22.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 22:22:25 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, shy828301@gmail.com, zokeefe@google.com,
        david@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/khugepaged: add tracepoint to collapse_file()
Date:   Wed, 26 Oct 2022 10:52:18 +0530
Message-Id: <20221026052218.148234-1-gautammenghani201@gmail.com>
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

 include/trace/events/huge_memory.h | 38 ++++++++++++++++++++++++++++++
 mm/khugepaged.c                    |  7 +++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 935af4947917..472238d0e3a3 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -203,5 +203,43 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 		__print_symbolic(__entry->result, SCAN_STATUS))
 );
 
+TRACE_EVENT(mm_khugepaged_collapse_file,
+	TP_PROTO(struct mm_struct *mm, struct page *hpage, pgoff_t index,
+			bool is_shmem, unsigned long addr, struct file *file,
+			int nr, int result),
+	TP_ARGS(mm, hpage, index, is_shmem, addr, file, nr, result),
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, hpfn)
+		__field(pgoff_t, index)
+		__field(bool, is_shmem)
+		__field(unsigned long, addr)
+		__string(filename, file->f_path.dentry->d_iname)
+		__field(int, nr)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->hpfn = hpage ? page_to_pfn(hpage) : -1;
+		__entry->index = index;
+		__entry->is_shmem = is_shmem;
+		__entry->addr = addr;
+		__assign_str(filename, file->f_path.dentry->d_iname);
+		__entry->nr = nr;
+		__entry->result = result;
+	),
+
+	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, is_shmem=%d, addr=%ld, filename=%s, nr=%d, result=%s",
+		__entry->mm,
+		__entry->hpfn,
+		__entry->index,
+		__entry->is_shmem,
+		__entry->addr,
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

