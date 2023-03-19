Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD66C017B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCSMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCSMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:13:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17503149B7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:13:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so866edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679228024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyewVLoHn/OD7IovUzCtvgn7e3sbYgzUB2xMrii4Ha8=;
        b=aKbRGsPOzFHq2HPqDFkbU00Bw0idRYStbsMzsnmiX6AO0WyOoZEqbinCCWwcOpc24o
         si6LwIe9/Bp5IS2tMfogdnf+c9as9K3qSnh+NGQKElmf2rF2TWyvahmWaY1U/JZEgWvL
         N803CdQFPuIhqY1PGFYnIvqqRssV+Jv6B4Zh4JCLRGz/SCLUmK34Wltz/FudVzqOvFMt
         xzwwu/hbMPg4ijFESHdtsCtq4Bx+Z45Scxmt6F2iXXZFf6uzaYs+Qs935Rm/nGxFsyYR
         ANoOZ5GNSDPTpu+ajsSsBjkIVOvBfDE25We5Szay8+/UF5kTDipxUt/3hoeqtOKjH0Zd
         x8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyewVLoHn/OD7IovUzCtvgn7e3sbYgzUB2xMrii4Ha8=;
        b=AcS2b+Wyy1KusdPxADdqZP57hR4vzbObxfkE32e6aB4TOYXOvOrtcTa3CnRmirqYrk
         BTVsZRD83cSUa8O+IcLzvdU51jACDYxAzT4PIKpD2avRns4lHJPcaPQ5tIZXhXTq947m
         Y9RmxKqZwBMr9PUsURagE57dBu+diayQxOA2s2jzjIK5NOP/aOCztWGy2UnTm2+LuEvx
         OJp2C0cxA2Gl5ixzz0mdAi3C+ZhSx37w+40CRn4c27vQq7R0MRC45llMJLpW2M+0eDxd
         vFnJl9sLqENa77/9eCEgedxlUPFiTZjlz9gd2QK6ta3ZfAvy6YWEnCpBDQJRfbwk2wbL
         c2KA==
X-Gm-Message-State: AO0yUKVdWdM5+B4npm9kJBvNksISDqSc9Cz9ZmBIwuIMbjzT7Iy/KQu5
        IxLEnKtoZm7xlVHFweo8HUiIJyDf3pY=
X-Google-Smtp-Source: AK7set/eF4uh0SoaDwQZ6lfYjvsX41Tdegqm/WPSW3SPm6Dl9TL9MmtjwvsGdFLl9jbWQ980uQj7Hg==
X-Received: by 2002:a17:907:d491:b0:933:3aa7:57a6 with SMTP id vj17-20020a170907d49100b009333aa757a6mr4369349ejc.12.1679228024465;
        Sun, 19 Mar 2023 05:13:44 -0700 (PDT)
Received: from localhost ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709065e4100b008ca52f7fbcbsm3187759eju.1.2023.03.19.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 05:13:43 -0700 (PDT)
Date:   Sun, 19 Mar 2023 12:13:42 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0
 pages
Message-ID: <37a0a866-b7df-4cf1-9d0a-02f04c06a21d@lucifer.local>
References: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
 <ZBQjz9vzFaLjW0MM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBQjz9vzFaLjW0MM@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:24:47AM +0200, Mike Rapoport wrote:
> On Mon, Mar 13, 2023 at 12:27:14PM +0000, Lorenzo Stoakes wrote:
> > Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
> > __free_pages(..., 0) to use alloc_page(), __get_free_page() and
> > __free_page() respectively in core code.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
>
> But why limit this only to mm?

I wanted to keep things 'polite' and within mm to begin with, I may follow up
with a scout around other areas of the kernel.
