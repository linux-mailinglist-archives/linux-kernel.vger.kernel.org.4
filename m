Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A360D379
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiJYSUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiJYSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:20:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38196203
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:20:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d24so11682701pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBXJqeD0ncoS4Tmu6q72AtqLzbpXKlZCc67GmCsp9hI=;
        b=Lqq8hjSXYrYY6nzqQ4d2XH2EACHaRScBHkmtiJUl6ArY2ORTtA25F9dy7cofHZQi57
         htk3UaKv2+TfIEDhRo04dfZWwlTrZEf/9pAbPVDe3yO/ub957/Zo5SSAaE4KXuTD9LS2
         igcZLgu/IIbWhQ0IwfSk61hnNQxjtRD39N4xnV5xBQuq+Cx50VGjdf1rDQK5uMEIAvuC
         ZZrRZ1uRau7t5t3oU5wAXz2y7l15/jbEQj7BLNWbTopa+JdElJMo+1RlGN0VkdTO1eqR
         i37KlGWbiuHYNtkMKcLRO4IZG/0STcFj6K0/cx+Lo3FndHVsGzTceBnvabUTRskkGE4n
         SP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBXJqeD0ncoS4Tmu6q72AtqLzbpXKlZCc67GmCsp9hI=;
        b=WSuss8DporXgrf9ZRh/geNjcFGDuEH0W5x2wFdaCnrORwHq5l12kPxAqbTtLwrXyrb
         iEyCHYROUAxchuGDjK8lGEuIzsHeH7Kmt3YAl4UJCq141vozjtsx4FT3daa4l4gIIClQ
         dWVl9OWKIKdwjLRkjZOUlUoAJu9pTo9LzXxyRmsiExq87W9pQ/eE/3lICPIlhHDqpw7B
         Gn9ZkTQTf9SmaulfsjUykGCgX677QJXB0McrhZlyn+I0M6PcmLHaHyESrDPxyYMfbj66
         n5NQLQeXMEUHG213MEMzWIUXkM34RUOTfbvLNQrbZ1LogvT/xLM1rVdcsFudg30Kwe5I
         fx8g==
X-Gm-Message-State: ACrzQf1+kjwB2epUOzNF65oBR5ZAmteKN9Deeh8JTPxPSULv31DxwBXS
        DGWS7JFV7GnoHefMApfl8oQhlw==
X-Google-Smtp-Source: AMsMyM73L8CF1RJG56qqHvklbVt9bqymY0ClzG/Apv3NhTiZ8Ghp+bB6ERP/CWYGAU/hAz30B3DWZQ==
X-Received: by 2002:a17:903:1109:b0:179:d220:1f55 with SMTP id n9-20020a170903110900b00179d2201f55mr39149553plh.42.1666722044358;
        Tue, 25 Oct 2022 11:20:44 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f2cb00b001837463f654sm1476176plc.251.2022.10.25.11.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:20:43 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:20:40 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rostedt@goodmis.org,
        mhiramat@kernel.org, shy828301@gmail.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <Y1go+BSdpGELmIZS@google.com>
References: <20221024173559.332324-1-gautammenghani201@gmail.com>
 <20221024131706.3d58bd92c332684386c7df13@linux-foundation.org>
 <Y1duhy5kbhLoMqWO@biggie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1duhy5kbhLoMqWO@biggie>
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

On Oct 25 10:35, Gautam Menghani wrote:
> On Mon, Oct 24, 2022 at 01:17:06PM -0700, Andrew Morton wrote:
> > On Mon, 24 Oct 2022 23:05:58 +0530 Gautam Menghani <gautammenghani201@gmail.com> wrote:
> > 
> > > In the file mm/khugepaged.c, a TODO in the function collapse_file() asks
> > > to add tracepoints. Add the tracepoint named "mm_khugepaged_collapse_file".
> > 
> > This isn't a very satisfying explanation for changing the kernel.  Maybe
> > the comment is stale are this tracepoint is unneeded.
> > 
> > Please explain afresh how this addition benefits kernel users?
> > 
> The function collapse_file() is called by the function hpage_collapse_scan_file(). 
> Without a tracepoint in collapse_file(), we won't know if it was called or not and as a result,
> we also won't know if it returned successfully or not. Also, as Zach mentioned earlier [1]:
> 
> there are a few scan result codes that overlap between hpage_collapse_scan_file() and those
> possibly returned in collapse_file() such that, if we only have the one tracepoint in 
> hpage_collapse_scan_file(), it could be ambiguous what callsite the error path stemmed from.
> 
> [1]:https://lore.kernel.org/lkml/CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com/
> 
> Please do let me know if a v3 is needed.
> 
> Thanks,
> Gautam

Thanks Guatam,

The ambiguous codes in particular are:

SCAN_PTE_MAPPED_HUGEPAGE
SCAN_PAGE_COMPOUND
SCAN_PAGE_COUNT

; properties of a page that are checked before/after the page is
locked/isolated.  This personally hasn't been an issue for me, as someone who's
spent considerable time in these codepaths over the last little while.  There
are certainly other codes (like SCAN_FAIL) which are ambiguous within functions
(and likewise haven't been an issue) so this reason alone isn't particularly
motivating.

However, some of the extra information (is_shmem, index), at times, would have
been useful if was already available -- but it was never enough of a pain to
force my hand to put this tracepoint in.

If the tracepoint is staying, then 2 nits:

CHECK: Alignment should match open parenthesis
#74: FILE: mm/khugepaged.c:2064:
+       trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem,
+               addr, file, nr, result);

and, apply Steven's advice to trace_mm_khugepaged_scan_file() for consistency.

Thanks,
Zach
