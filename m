Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6460B671
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiJXS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiJXS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D71C77E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b5so9243242pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSP1eEqSv1XvPA9FALZsPLkCJwsdVfpHOieGi3imvbc=;
        b=WlmZ1wq6/6gt+R7MsXQ/k+6txkY+6LANNH270vSZs7cAXNKciUb1Aa3no7PuWJj0XN
         KDAH0220mAN4TzZYG6gbxrjGpaltlhLmpQn23Z0efGAQaxEk4kjPL5cNBo0OPQ3UNLPw
         k9r0EtHZ6BFmHl/MmP9eyxrJZ9L/y7oFV+2915zTW1x7lC6c6s428aBiSWmxW7U359RG
         PHv49s51u1NWfdUkr2lhNMnS4HuZmUz/2R70DVUUTNzcgyiPt5QVPasG9KPEHGPWGx90
         BLBcXLyRz8VK2faSvjsnYJ8sJKNaZb+C1MhvCH5pE7PgaGBbT4C5KGMdKQylV3fMmZ+L
         MtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSP1eEqSv1XvPA9FALZsPLkCJwsdVfpHOieGi3imvbc=;
        b=dlGKWTtQCMDPeq7oC1wGLn3O5ge3pXE9/MLza9u5P13S3jLMkcrImJkrRwPLl8g53j
         Lvy61Gi9yLXCxsTrE/FxXDjAQv8S2Y8QviK8RgSoQhDeSJPqi7HWWv6y72C00aTcej6B
         dhcMb5vfQr+20IIZdR5A3DuPiNpBJjTxf9CGq/6KBjYhbBS1YtsKQkMToBaG0UR7MAVc
         Rn1OY+5CBkYd/jZ7YfxyGClY2JnL5+zJLd72aROpX1VhiJZk4FA6b8WhfPtfrLYTsyM3
         2FDV0yEJphsHWwug5zut2Enbn+baG3Hi9KfPrG2OR6GvlO5jpZedhpUHonwR/tLCMHnr
         5kJQ==
X-Gm-Message-State: ACrzQf0EPv9ZRcjYSXbPlzd35DPCB/xlFqddnRPJDwUV+0RX8hORUtoS
        VaNvpt28TD6z8sZIXdQm6Qs=
X-Google-Smtp-Source: AMsMyM4IUkNMSFbXGOyhjUiHSa6EOD4mZwmCeM+q3qGeinEpducdTZh6kL5gOl1BEtnO5JFDk01u0g==
X-Received: by 2002:a05:6a00:2191:b0:56a:fd17:6723 with SMTP id h17-20020a056a00219100b0056afd176723mr17619569pfi.4.1666632966867;
        Mon, 24 Oct 2022 10:36:06 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id b26-20020aa78eda000000b0056283e2bdbdsm74955pfr.138.2022.10.24.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:36:06 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, zokeefe@google.com, shy828301@gmail.com,
        vbabka@suse.cz, david@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/khugepaged: add tracepoint to collapse_file()
Date:   Mon, 24 Oct 2022 23:05:58 +0530
Message-Id: <20221024173559.332324-1-gautammenghani201@gmail.com>
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

In the file mm/khugepaged.c, a TODO in the function collapse_file() asks
to add tracepoints. Add the tracepoint named "mm_khugepaged_collapse_file".

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
changes in v2:
1. Move filename dereference out of calling path (Steven Rostedt).
2. Capture is_shmem and index (Zach O'Keefe)

 include/trace/events/huge_memory.h | 38 ++++++++++++++++++++++++++++++
 mm/khugepaged.c                    |  4 +++-
 2 files changed, 41 insertions(+), 1 deletion(-)

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
index 4734315f7940..977c0ff82c46 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2059,7 +2059,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		mem_cgroup_uncharge(page_folio(hpage));
 		put_page(hpage);
 	}
-	/* TODO: tracepoints */
+
+	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem,
+		addr, file, nr, result);
 	return result;
 }
 
-- 
2.34.1

