Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30DA6B557B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCJXSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCJXSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:18:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C815C93;
        Fri, 10 Mar 2023 15:18:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p20so7206954plw.13;
        Fri, 10 Mar 2023 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678490286;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz51x4A7Eu2J8EAn+UJRgtV0WTJYDaCqLo8gQb4mjo8=;
        b=IkTv3XFEIPNwy4r9MsPML+H2ITnf/hCMh/ExSQ5fRUWO2YF0FXQbGYUBvPFIsaAp/V
         ExZwHOD9QBnhtikHQFevhWxsi2uzrNwqaec2d2sIU3WW07Wr3buOynStkbZ1yrMaO7C9
         XdW5YJT6L/BJM0LwxaLn7iQt16DGI/8UxcchwXSAtqUZkgU6CkBLIQzS6DLTfJBElshv
         zVSG1L3VeBMEZe/o3MtLXJX0W+kxJf6N5GkUAWNtyrN/gxdK6X280V66GzTi0j0V/fzk
         8t3kHXQ4eU7zlU/aIB7MnkkJlalPRBy8aTFY2kKQGoOyDfJTkkqwy9w2AT12aH26ZJee
         b9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678490286;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz51x4A7Eu2J8EAn+UJRgtV0WTJYDaCqLo8gQb4mjo8=;
        b=AWxVblmUlmuLb7NNFE6yMd4onF9ZtgS2rCMdg1bqVPZDUmLiBGJZVQuRNRTXP5FNT9
         8NOqhg5u5ow73l6oPsRpnk0rQYB8uTZ6wgpzNdPErbQC4HGjwKrkqdXvupU/TLisOqjz
         mm4sMVTXGJkGv8GC/+3Jgm8SIOHdOXUhf+Yi+qrzuwtffYCHP0rK5adYk3XF3ICqd6gG
         rej7p5MOzik0AfbZ4W+srNjFacsQ/Ige5CA09bZYtLg2myDa2ahlyYfVxWfMAHJ6ZSbz
         lWKeD7ilvCVnTI3aQQa62q+VLwvaMtXJyKOu8apDp+GrxOUEwFnQXjkCPQfD+rc3WYEB
         knGg==
X-Gm-Message-State: AO0yUKWbvW/SsJ7IjJr3WdK1WB83ya1amw8GQY4YudEIsJS9wB0fzE/H
        PjwHsQMWGRL4bRmh+C8Yr8wWoJSZDYc=
X-Google-Smtp-Source: AK7set/Iz59s/NdeXOmRSALJuBKpSAOu9yMJGeQkSDCuRCUm52bWvdDU5u6oYbAy83whlCfN/Id08w==
X-Received: by 2002:a05:6a20:3ca5:b0:cc:50de:a2be with SMTP id b37-20020a056a203ca500b000cc50dea2bemr4018231pzj.14.1678490286291;
        Fri, 10 Mar 2023 15:18:06 -0800 (PST)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id g19-20020a62e313000000b005813f365afcsm291741pfh.189.2023.03.10.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:18:05 -0800 (PST)
Date:   Sat, 11 Mar 2023 08:18:00 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm: mmap: remove newline at the end of the trace
Message-ID: <ZAu6qDsNPmk82UjV@minwoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have newline in TP_printk so remove the redundant newline
character at the end of the mmap trace.

<...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...

<...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...

<...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...

<...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...

to

<...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
<...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
<...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
<...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 include/trace/events/mmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 216de5f03621..f8d61485de16 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -35,7 +35,7 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->align_offset = info->align_offset;
 	),
 
-	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
+	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx",
 		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
 		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
 		__entry->total_vm, __entry->flags, __entry->length,
@@ -110,7 +110,7 @@ TRACE_EVENT(exit_mmap,
 		       __entry->mt		= &mm->mm_mt;
 	),
 
-	TP_printk("mt_mod %p, DESTROY\n",
+	TP_printk("mt_mod %p, DESTROY",
 		  __entry->mt
 	)
 );
-- 
2.34.1

