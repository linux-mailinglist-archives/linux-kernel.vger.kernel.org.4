Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C7160E702
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiJZSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiJZSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:11:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9DF83F1F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:11:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 192so9019282pfx.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7Wi8bTCvfeNU3sTUIqYkMJtWG9DEMZ1nSFdktscQLY=;
        b=i5hnjp0g6IKy9vbZyM/vQYFA7gfnU/DQtDDTINPcYQOo46VEbmSgN/Wcl1aohtlcc7
         jCZK+fQUpaZiFuiRQ0CgdxioIhEcpQH4S0PfJ9+aAv8M5SU2rP3faX/Y6rL7jCPTSCO7
         i6oTesmeL2kGUpfpKn6/ykcXfoKTUeddy7LSgpA+EOlJiNi8/QAE9roQT9DNgtDvMfk5
         9wgARWg0YjUvjWMBbCBlPW2sAW6VrTv4UuOBCOZhxdTZFXSfyTfRkwX+2haPof/r61pu
         xr9IL5RByxp/LnWkm4J79g1bBvF+yF0IPtY7CpGltf0902RQaIhufw+lli9y1hyJAr9a
         yioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7Wi8bTCvfeNU3sTUIqYkMJtWG9DEMZ1nSFdktscQLY=;
        b=Vc4XlI9G1XoplR6i0u6a5r1bZfd4cmLrwcpT8embfwd1e58x/f/orjAkfSe0arHMei
         VZKBNqrUxldUbI2f9YnQ70SprI7jiknBWpr+VUhIYpZLCO1X1CYgYM69zNrujC6iYb83
         9nyfBzNoETSuT4WOqY6Qq2xqgJQyAhQbCgB0YKuechEW2j4qtx6GqNN+SPeK/+u+E5qK
         bMG/QHggAdC6OLA9yCKSKVHw6zKnsXtwOCbxIgb2N6YGbThZZaJHJqhTBgU4aatiFTcv
         ICeJfHj+UnLEunoXPk/vt/z/SaaBbNuHla+D4UgHYSsYdTdlouAN2RKUUcD/hsjqfrnD
         pP/g==
X-Gm-Message-State: ACrzQf2auo73N2OadCDXdpGjRa8lhZShrvgZrmPlVsJUXvI0ASieIwn2
        hUpFTa0ACpkneIobqrtwAhyTkSP0fIcS2AoRaWE=
X-Google-Smtp-Source: AMsMyM76wzsg5/k2aM8/sc3UVRubuR/qvSA+/5aaMC1a9DW7CgTvtQ0uvygXw5LLq5oUthGBrGnsMk+3DEIWGCt2zBo=
X-Received: by 2002:a65:45c1:0:b0:461:5855:8d86 with SMTP id
 m1-20020a6545c1000000b0046158558d86mr38036109pgr.436.1666807871181; Wed, 26
 Oct 2022 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221026044524.54793-1-gautammenghani201@gmail.com>
In-Reply-To: <20221026044524.54793-1-gautammenghani201@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Oct 2022 11:10:58 -0700
Message-ID: <CAHbLzkq_6tGYfmd-f8Gg-YSLoLXtdFmpxVCUof90B=YA4X7SAA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Refactor mm_khugepaged_scan_file
 tracepoint to remove filename from function call
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, zokeefe@google.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 9:45 PM Gautam Menghani
<gautammenghani201@gmail.com> wrote:
>
> Refactor the mm_khugepaged_scan_file tracepoint to move filename
> dereference to the tracepoint definition, for maintaing consistency with
> other tracepoints[1].
>
> [1]:lore.kernel.org/lkml/20221024111621.3ba17e2c@gandalf.local.home/
>
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/trace/events/huge_memory.h | 8 ++++----
>  mm/khugepaged.c                    | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 935af4947917..760455dfa860 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -171,15 +171,15 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
>
>  TRACE_EVENT(mm_khugepaged_scan_file,
>
> -       TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
> +       TP_PROTO(struct mm_struct *mm, struct page *page, struct file *file,
>                  int present, int swap, int result),
>
> -       TP_ARGS(mm, page, filename, present, swap, result),
> +       TP_ARGS(mm, page, file, present, swap, result),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
>                 __field(unsigned long, pfn)
> -               __string(filename, filename)
> +               __string(filename, file->f_path.dentry->d_iname)
>                 __field(int, present)
>                 __field(int, swap)
>                 __field(int, result)
> @@ -188,7 +188,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
>         TP_fast_assign(
>                 __entry->mm = mm;
>                 __entry->pfn = page ? page_to_pfn(page) : -1;
> -               __assign_str(filename, filename);
> +               __assign_str(filename, file->f_path.dentry->d_iname);
>                 __entry->present = present;
>                 __entry->swap = swap;
>                 __entry->result = result;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4734315f7940..9808a899f9f7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2157,8 +2157,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>                 }
>         }
>
> -       trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
> -                                     present, swap, result);
> +       trace_mm_khugepaged_scan_file(mm, page, file, present, swap, result);
>         return result;
>  }
>  #else
> --
> 2.34.1
>
