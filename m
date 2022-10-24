Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428460B388
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiJXRI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiJXRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:08:31 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A811C29
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:43:29 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id mx8so6728843qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3y2AMrHeVKvlfYZQ2uRso4bzDxf1Jp6u6RB+7N/ROg=;
        b=Z6H0V/KnDIDr+iK4ALSarBPwH632T1G5oGp3SDUHnpEebz/CWdkx0Gvj0KeApZZV3q
         AgHV6H8pEWsE40nitz3o1frKYCUTvj3RTqVdJJYVfnXm/5bJ4dogQGkY2S8qVGs7AvCL
         qETHwAUVgPYzH3IMvvT3dBa2P7A8kqZnXhaw2fThf1utMAagGpq1usWh+XnSsoK3v63A
         sU+udcfxpHzXfiVcDgNooXDgKANYya1kkT1T6FE036JoEBW8L9/sgA7YdGl9T0nn5Vlk
         PIOl9MXz4YAzQ9aEDVgZaUnzalov/jk+EuZNnrFKPKccPwJONed+fmhtzZHVr7Sjjq9D
         8ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3y2AMrHeVKvlfYZQ2uRso4bzDxf1Jp6u6RB+7N/ROg=;
        b=uDeAABSY2QPtRWgiPwFfYm/8DCgxCsJxRmK/ydqWnMzifdmVGmHHmsB8Sua/wZUKgE
         c+6InRjMFvRhR6KB8EfDmyWTnkiifSvQXmtHuhQdocltvDTSyT7A/Q10lPxkodVGr4Pj
         cwhPuOMRmCQgJUJsWaTiGrNeBXc8Ebnw3xBtsmuXyigDXcJPr9SkDZzE8gLJb5aGJWb9
         WCqGrnq69DL81d1uUemrNa2y5BVCR+UEUWGSSyiDEdbQxx61XXBfkLL6Sc5pnhz9qFcy
         9+77eEResschkN6IS7k69PVknzk7UauB2tokE72RVDodfcH6GRFLTWV/2TCe3bplOlaN
         +5oA==
X-Gm-Message-State: ACrzQf2vW49QXnWasGnFFB1QdiudejstKB62YEJDLeInVT5vKIHMvBbB
        y50QgxLYPOkKNT64lzDm4Ap4Xn6TAMZJuQ==
X-Google-Smtp-Source: AMsMyM6N/9jO7DpbdtNliGJjhCPCNxfkUwy6g54IEy3I0K1xF7p1W5slfSfQGbwcdb3YEz80xd5Fpw==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id q13-20020a17090311cd00b00170cde818b7mr34053534plh.165.1666624171540;
        Mon, 24 Oct 2022 08:09:31 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id w65-20020a628244000000b0056b802b8845sm4300138pfd.43.2022.10.24.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:09:30 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, zokeefe@google.com, shy828301@gmail.com,
        vbabka@suse.cz, david@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/khugepaged: add tracepoint to collapse_file()
Date:   Mon, 24 Oct 2022 20:39:22 +0530
Message-Id: <20221024150922.129814-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mm/khugepaged.c, a TODO in the function collapse_file() asks
to add tracepoints. Add the tracepoint named "mm_khugepaged_scan_file".

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 include/trace/events/huge_memory.h | 32 ++++++++++++++++++++++++++++++
 mm/khugepaged.c                    |  4 +++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 935af4947917..b2f3157d2ff6 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -203,5 +203,37 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 		__print_symbolic(__entry->result, SCAN_STATUS))
 );
 
+TRACE_EVENT(mm_khugepaged_collapse_file,
+	TP_PROTO(struct mm_struct *mm, struct page *hpage,
+			unsigned long addr, const char *filename, int nr,
+			int result),
+	TP_ARGS(mm, hpage, addr, filename, nr, result),
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, hpfn)
+		__field(unsigned long, addr)
+		__string(filename, filename)
+		__field(int, nr)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->hpfn = hpage ? page_to_pfn(hpage) : -1;
+		__entry->addr = addr;
+		__assign_str(filename, filename);
+		__entry->nr = nr;
+		__entry->result = result;
+	),
+
+	TP_printk("mm=%p, hpage_pfn=0x%lx, addr=%ld, filename=%s, nr=%d, result=%s",
+		__entry->mm,
+		__entry->hpfn,
+		__entry->addr,
+		__get_str(filename),
+		__entry->nr,
+		__print_symbolic(__entry->result, SCAN_STATUS))
+);
+
 #endif /* __HUGE_MEMORY_H */
 #include <trace/define_trace.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..14db90e2f2ec 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2059,7 +2059,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		mem_cgroup_uncharge(page_folio(hpage));
 		put_page(hpage);
 	}
-	/* TODO: tracepoints */
+
+	trace_mm_khugepaged_collapse_file(mm, hpage, addr, file->f_path.dentry->d_iname,
+				      nr, result);
 	return result;
 }
 
-- 
2.34.1

