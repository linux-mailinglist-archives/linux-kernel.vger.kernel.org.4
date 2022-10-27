Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7413560FF81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiJ0RnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiJ0RnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:43:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9528C7863
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:43:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so2274376plz.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcBV9/xdG+LS543Zweyj0rQwffcIyct4ubc4kgjI9tQ=;
        b=PDOMzyXOlzzN5Mwz/KVTajGWl6GpFhNxYI7Gust7tX4OGK//puzBeMokR89Bat18Uo
         NmtuLMhi7yMt2vjssnNdMeL7xLSiDVsQYvY8iezjSAqVuKtqouAY8FWVvFbEWr71LANf
         mtKy9I6Bd7VNUA1Wb3FJkEoG3nlX/oGbqcSnFa7JBaPW7mj1IB/vCeT/eLZttPWJsBGR
         +RMgbeZ++4oAou69N7KVkXr+PlvONcFS6RGpQAAVQr4WPJ6KOT+VfLOFfOfP2LWQ7Rpn
         jU6yR2WIoM4VhVBx5C85o3rmFI6yu+LEm3+5jecXCZzQ54y/eLuCVtwhFlWpx3gHnKew
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcBV9/xdG+LS543Zweyj0rQwffcIyct4ubc4kgjI9tQ=;
        b=QXX/0sQShhblrl0KvuFXeX5A2W0DyYemJ57L+Vw0OUUg8oikAgT/ajzYPLumJ7Ew4S
         d/qpzIoFdAy2sPoc14UTqC85y2ZpvYSl9zyXjaAq1jPZ9dY9MXWUWmXKAiZmsaTqPl21
         cXFa1ZQqo5oHjxgXNYuXU8Q0TUGbh9rWpB46NFzXzR4IYpPe8ALxhSBBYHnX9Z/fCV/j
         yhebN/rCLqdoEkZg+ZA+nd2xyZ5auqORONNjb8c3BUL61s28UqTgh2UbC6P0iNRaRnq4
         GmdGdwrOcUGLnKBr5df1PLyyNc0e5qMzvmOj1yuLtkEyVSO8INfEwiiNyasqyvFmhPTh
         LRIA==
X-Gm-Message-State: ACrzQf00nYSl85Gjutpsr2N7q8crqYQILPMbbzx24v3VZYSEjtqK7QhS
        51Qdsl1x5iOZe5cA0uf1LwWatQ==
X-Google-Smtp-Source: AMsMyM4WfP/m85wHs6m5EA8K5UsqFlXgTUt9HV2qBc1hd6rOpted8SuSra8LMaOSsY59sculIgt3yA==
X-Received: by 2002:a17:90a:65c7:b0:20f:8385:cc18 with SMTP id i7-20020a17090a65c700b0020f8385cc18mr11500757pjs.235.1666892593872;
        Thu, 27 Oct 2022 10:43:13 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g13-20020a65580d000000b00429c5270710sm1324935pgr.1.2022.10.27.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 10:43:13 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:43:09 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Refactor mm_khugepaged_scan_file
 tracepoint to remove filename from function call
Message-ID: <Y1rDLUUVxfRt6mal@google.com>
References: <20221026044524.54793-1-gautammenghani201@gmail.com>
 <CAHbLzkq_6tGYfmd-f8Gg-YSLoLXtdFmpxVCUof90B=YA4X7SAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq_6tGYfmd-f8Gg-YSLoLXtdFmpxVCUof90B=YA4X7SAA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26 11:10, Yang Shi wrote:
> On Tue, Oct 25, 2022 at 9:45 PM Gautam Menghani
> <gautammenghani201@gmail.com> wrote:
> >
> > Refactor the mm_khugepaged_scan_file tracepoint to move filename
> > dereference to the tracepoint definition, for maintaing consistency with
> > other tracepoints[1].
> >
> > [1]:lore.kernel.org/lkml/20221024111621.3ba17e2c@gandalf.local.home/
> >
> > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> 

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

> > ---
> >  include/trace/events/huge_memory.h | 8 ++++----
> >  mm/khugepaged.c                    | 3 +--
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index 935af4947917..760455dfa860 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -171,15 +171,15 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> >
> >  TRACE_EVENT(mm_khugepaged_scan_file,
> >
> > -       TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
> > +       TP_PROTO(struct mm_struct *mm, struct page *page, struct file *file,
> >                  int present, int swap, int result),
> >
> > -       TP_ARGS(mm, page, filename, present, swap, result),
> > +       TP_ARGS(mm, page, file, present, swap, result),
> >
> >         TP_STRUCT__entry(
> >                 __field(struct mm_struct *, mm)
> >                 __field(unsigned long, pfn)
> > -               __string(filename, filename)
> > +               __string(filename, file->f_path.dentry->d_iname)
> >                 __field(int, present)
> >                 __field(int, swap)
> >                 __field(int, result)
> > @@ -188,7 +188,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> >         TP_fast_assign(
> >                 __entry->mm = mm;
> >                 __entry->pfn = page ? page_to_pfn(page) : -1;
> > -               __assign_str(filename, filename);
> > +               __assign_str(filename, file->f_path.dentry->d_iname);
> >                 __entry->present = present;
> >                 __entry->swap = swap;
> >                 __entry->result = result;
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4734315f7940..9808a899f9f7 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2157,8 +2157,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> >                 }
> >         }
> >
> > -       trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
> > -                                     present, swap, result);
> > +       trace_mm_khugepaged_scan_file(mm, page, file, present, swap, result);
> >         return result;
> >  }
> >  #else
> > --
> > 2.34.1
> >
