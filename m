Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D6618F77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKDE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:29:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186B31DA51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:29:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c15so2467599qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlEnOokG95a7hit2Jmz1aY6CvReOspMCPooMM7TFzXg=;
        b=WB19rvlcTSV5KUKnW2r9Zt8xqv8c2IH1d7ldyetlrVmKhJhg7VIY4ALPD0LE5W4Bux
         GyAB7I56sGNTKQML188wYmwjbpA7WJc9H9hOm3UgDsUiISaWblixhCTEEhWqknXNWLY/
         T0lVXjS7Ta3xDDckYVHwIf/MVYUsKFIkl9UH+DqQJusyUW4P2viNZnJvwqFKbX3pi+Q5
         rYXtY38ln1lcQs/jiLKA3TPg3FEFhZvFyipibqg62YPgFyS6x04wK4PRx2bNBCHsc9pd
         25e11/ZWiimlOwDGQHJhgocRO8rhE8hDmY2i1AYQEZGMq2qwpoaKZWwxQAmzRg8IPOgY
         nCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlEnOokG95a7hit2Jmz1aY6CvReOspMCPooMM7TFzXg=;
        b=pXTYRl3kP1iXtQZRZQ8+9SvZbwWMFxagBj6GycNHbYC79PLwABvhIoP01YOJJWj1Vb
         RZdPml5cphuIQ22gYAls1QVRbOx84bU+WTZTVeHI/VPZ5a9k10KF9rgiNrxwBl1Ebf2+
         YtFBilHZvIgb0YQvh5OlzlSieI5+wRn2B//ZatCgh7KprmGANhybMo4Qy1IgcB5xUJa+
         hRIIO4IjiFaaFt3gqPOstr4nYrj+nx+32OyrjfpzNUWgRHacDA3AN2A1bal5qdxbEXow
         9W5aQ/RJNjrLI3WKqQ/hMZ9o3CpKNbkXephoj1N6ensV6U9oxa5J5HUAB2odzWBPATAJ
         vpGw==
X-Gm-Message-State: ACrzQf0p41aTDkYm59JoeHw60zg7YS8vZ9/yavrCONB8s4E/mNNvIMVD
        IRd3ssYMqOQEgr7Rtf2eUB+BuA==
X-Google-Smtp-Source: AMsMyM7rqrXArPIOq2iMKGEGNaiOVs0iEkDFJtqhDvQrRkFoS6fHmwFYi1xYd6/CZ2v1fcQuoRDhJw==
X-Received: by 2002:a05:622a:245:b0:3a5:5312:c18e with SMTP id c5-20020a05622a024500b003a55312c18emr5445396qtx.545.1667536155142;
        Thu, 03 Nov 2022 21:29:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id br17-20020a05622a1e1100b0039467aadeb8sm1767184qtb.13.2022.11.03.21.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 21:29:14 -0700 (PDT)
Date:   Thu, 3 Nov 2022 21:29:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
In-Reply-To: <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com>
Message-ID: <3934b34-ae2f-2119-9a68-33e51e909795@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <3818cc9a-9999-d064-d778-9c94c5911e6@google.com> <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 3 Nov 2022, Sidhartha Kumar wrote:
> On 11/2/22 6:48 PM, Hugh Dickins wrote:
...
> > Undo "mm: add private field of first tail to struct page and struct
> > folio"'s recent addition of private_1 to the folio tail: instead add
> > hugetlb_subpool, hugetlb_cgroup, hugetlb_cgroup_rsvd, hugetlb_hwpoison
> > to a second tail page of the folio: THP has long been using several
> > fields of that tail, so make better use of it for hugetlb too.
> > This is not how a generic folio should be declared in future,
> > but it is an effective transitional way to make use of it.
...
> > @@ -260,13 +267,16 @@ struct page {
> >    *    to find how many references there are to this folio.
> >    * @memcg_data: Memory Control Group data.
> >    * @_flags_1: For large folios, additional page flags.
> > - * @__head: Points to the folio.  Do not use.
> > + * @_head_1: Points to the folio.  Do not use.
> 
> Changes to my original patch set look good, this seems to be a cleaner
> implementation.

Thanks a lot, Sidhartha, I'm glad to hear that it works for you too.

I expect that it will be done differently in the future: maybe generalizing
the additional fields to further "private"s as you did, letting different
subsystems accessorize them differently; or removing them completely from
struct folio, letting subsystems declare their own struct folio containers.
I don't know how that will end up, but this for now seems good and clear.

> 
> Should the usage of page_1 and page_2 also be documented here?

You must have something interesting in mind to document about them,
but I cannot guess what! They are for field alignment, not for use.
(page_2 to help when/if someone needs to add another pageful.)

Do you mean that I should copy the 
	/* private: the union with struct page is transitional */
comment from above the original "struct page page;" line I copied?
Or give all three of them a few underscores to imply not for use?

Thanks,
Hugh
