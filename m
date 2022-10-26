Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5260DA67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJZEpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJZEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:45:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB87C19A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:45:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 4so7046414pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPEBUQ2z1U7/dgSFSNAUfBzMgt42T5/xBPU+XLvKjdk=;
        b=TmkyHcYaeg+xputRQCAesOCxrLkTrfMoeoEjkOxSE04SDZO5SV/QZFbalVeNW75ShL
         oIZYtdWLD/HIgAHP4DZfdE0GKrRbH6KCqLh8IT+WrKQEsLDLw+Cb3plCs8YA/3IZx3l8
         YZnjLi7y87blubFTpSGhR9wd8w13SgDGeYwYXlUarJEa7DHWHj7tgdmE7JVWrV5X3vCr
         ZaveBbbZ2S9q47Lwrys9vAg0y7/NdbPeYSb2qZpZBWK2gvrZfh0Fv2BPxGZvnfi6LpUE
         IgRsimToKbSz/tR5IqXeoHriqufZ6XFcEpVZ5WthUiY5DETCC6REH+18YPF/4v3LphcL
         0A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPEBUQ2z1U7/dgSFSNAUfBzMgt42T5/xBPU+XLvKjdk=;
        b=p+6RcErFbuwJovsANlysggaSN2YFEVLWPpmDuL7ioLSRuAH8E0a6F0Bd9zHRHpp0XC
         zm+7gNCdRMId8PcKfgqPUm1tO3HQpVwbHJK+HPi/ZpcnwgA3gCHk9tOoNPx6Fk3JXkIo
         XgWehIxAm3LyMs0YhmlUU91CiAgxGGX9TyfFtb89UA1o27XXjjJLJK0YEZ1Y6QxuiNyj
         5HaI4bxrVblsMHpslhGOOrP4765TP7h/LtkvLDNZHM3EbHZHhmPVStCZ/yZJqxQ4mA/Y
         QGlO/35kwEXy6db03hJoE8V43di8L8pcKF537DOXtSdwzgP5f/n8s1qBJvwfy6mPci5R
         I5aQ==
X-Gm-Message-State: ACrzQf3x0hf7M6Rt0H8PapIn9tDq7j5gmw6tEevmQ/RNyMiVA3SHY7g3
        5Mq5Fbhv4Iu8wGsOjKaFriA=
X-Google-Smtp-Source: AMsMyM6E8prJ0/hpgjm9+1NHeQpQ2EDXgO5KO/czl59OZhe0/yhvhAbOj6lT2YloJ+GvrEsl+jMszQ==
X-Received: by 2002:a17:903:1109:b0:179:d220:1f55 with SMTP id n9-20020a170903110900b00179d2201f55mr41381097plh.42.1666759531164;
        Tue, 25 Oct 2022 21:45:31 -0700 (PDT)
Received: from biggie.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b00562a237179esm2181073pfq.131.2022.10.25.21.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 21:45:30 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, shy828301@gmail.com, zokeefe@google.com,
        david@redhat.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/khugepaged: Refactor mm_khugepaged_scan_file tracepoint to remove filename from function call
Date:   Wed, 26 Oct 2022 10:15:24 +0530
Message-Id: <20221026044524.54793-1-gautammenghani201@gmail.com>
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

Refactor the mm_khugepaged_scan_file tracepoint to move filename
dereference to the tracepoint definition, for maintaing consistency with
other tracepoints[1].

[1]:lore.kernel.org/lkml/20221024111621.3ba17e2c@gandalf.local.home/

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 include/trace/events/huge_memory.h | 8 ++++----
 mm/khugepaged.c                    | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 935af4947917..760455dfa860 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -171,15 +171,15 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 
 TRACE_EVENT(mm_khugepaged_scan_file,
 
-	TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
+	TP_PROTO(struct mm_struct *mm, struct page *page, struct file *file,
 		 int present, int swap, int result),
 
-	TP_ARGS(mm, page, filename, present, swap, result),
+	TP_ARGS(mm, page, file, present, swap, result),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__field(unsigned long, pfn)
-		__string(filename, filename)
+		__string(filename, file->f_path.dentry->d_iname)
 		__field(int, present)
 		__field(int, swap)
 		__field(int, result)
@@ -188,7 +188,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 	TP_fast_assign(
 		__entry->mm = mm;
 		__entry->pfn = page ? page_to_pfn(page) : -1;
-		__assign_str(filename, filename);
+		__assign_str(filename, file->f_path.dentry->d_iname);
 		__entry->present = present;
 		__entry->swap = swap;
 		__entry->result = result;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..9808a899f9f7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2157,8 +2157,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
-				      present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, page, file, present, swap, result);
 	return result;
 }
 #else
-- 
2.34.1

