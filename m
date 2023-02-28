Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30B6A6256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjB1WUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1WUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:20:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3023DB0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:20:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y11so7890498plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677622847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfzEktNQLe+xyAZo0LFWsAuZvI/VB5AMndRLwn4eRMc=;
        b=EWVe+dJ8ENyvNC7uRoqDenjcKYSaTbK9iVz8RE14KL/Rzez2w7EMj7UX3CWi/UVWwB
         yusc80z+JhiWaGFp9gRjvyITcVsAQh1Zy+zfzR5WTYXk+KV+sm0Q48y13Dxhescyho1F
         Rh9eDF/vg/DsiF8psSaYO0Ic90m4NIEHl6AA6//jXmD64CU4kaePmN0BbTbhOfexiCh2
         ZhjqC9CkCHmfA6hX2cRBIrCZdrDykX/YL1fhRym5cOgt0CAq9/yYe8NZyoE3PMHJ1iVS
         BvbbZl+HibRUsc/XxDj5qNO3jccws8mswznGDp5bHTym+gdAr3VcznIomE1rlpxKca9p
         XAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677622847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfzEktNQLe+xyAZo0LFWsAuZvI/VB5AMndRLwn4eRMc=;
        b=hAAffnbozaBoLSaKHI8ly9D+ocI2qgQ4hPivDs5qf1ldXHIxbcUWJaKJPW7ep5xWjS
         ghzNou9dm/lqEs3dD/fYNsg/oo0I8BjGOOGSPLJtZU9K1Csx15z+c6GpyR5a9EXfSVKb
         8yUwE/yJkAmVSA89lqXAwPNqlHiwG+TO4E56zpvvebR9aVQTHqcHdWfQe2DrDPvqx+RW
         EJFMSZjj5mg5eP8j0SOkfrH5nYOb08HuH58sUFhxRROwN6NBPQRm+KY5DEa9wdzbQ1+p
         MmEVq2IHATQ1aOGAQy5gdaaLFi6cKNxe5Moi+TqvReUgddVCIXaeGMJVpbkiFkWlW6+4
         J8lA==
X-Gm-Message-State: AO0yUKVfcT0sxIyCILmPM5A7rIJ9tWZvhDkFHn8WZV1l23GZtMYG5nXw
        zBJnJ9wgUsekezIx17vVH1E=
X-Google-Smtp-Source: AK7set/yOTaJIlc69YDjq8aDh81Z3wrGg9YnqUaT0VB50VAdsZGukvegpdH+97anxKXa7D5tgC/6Cg==
X-Received: by 2002:a17:903:190:b0:19d:323:e68 with SMTP id z16-20020a170903019000b0019d03230e68mr5344178plg.1.1677622846702;
        Tue, 28 Feb 2023 14:20:46 -0800 (PST)
Received: from google.com ([2620:15c:211:201:639:82f5:b510:3494])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b0019a6e8ceb49sm6982975plb.259.2023.02.28.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:20:46 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Feb 2023 14:20:44 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <Y/5+PEfuEl3b/sDR@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
 <Y/f75fkcQg6m3cbG@google.com>
 <Y/rYQdUDNHDCJJTO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rYQdUDNHDCJJTO@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 12:55:45PM +0900, Sergey Senozhatsky wrote:
> On (23/02/23 15:51), Minchan Kim wrote:
> > On Thu, Feb 23, 2023 at 12:04:50PM +0900, Sergey Senozhatsky wrote:
> > > Extend zsmalloc zs_pool_stats with a new member that
> > > holds the number of objects pool compaction moved
> > > between pool pages.
> > 
> > I totally understand this new stat would be very useful for your
> > development but not sure it's really useful for workload tune or
> > monitoring.
> > 
> > Unless we have strong usecase, I'd like to avoid new stat.
> 
> The way I see is that it *can* give some interesting additional data to
> periodical compaction (the one is not triggeed by the shrinker): if the
> number of moves objects is relatively high but the number of comapcted
> (feeed) pages is relatively low then the system has fragmentation in
> small size classes (that tend to have many objects per zspage but not
> too many pages per zspage) and in this case the interval between
> periodical compactions probably can be increased. What do you think?

In the case, how could we get only data triggered by periodical munual
compaction?
