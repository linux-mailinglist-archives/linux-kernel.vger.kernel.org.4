Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C264E036
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiLOSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:08:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F13B9C8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:08:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u12so16860wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByuG98ZwLJHBzjuVb4YMRLtWuLmRZHcl+yVnvda45G0=;
        b=fQJxJx2j21x6TIPo/MlAFafl25T/N5xrD9/4zOOOsiEgdQMHhBVPl0pgXEWodm+eLH
         OnbXiUVU3PExydereiUgThfTB/eNQla8/vuW7pl0nvsApbnX5nixk3Z1+9YRdvFT95Ke
         Onvs28Fb86W24CNLEhmr0kHK0AQGmSEsHnFQdLMuGUB7x/gywUfABssUAobluwUAIaVz
         tQoP4P2QerB2YeAV5i2J7EYs2ByJvnF1mimxm6DWkiVT7e+M11xPN+982vmd8KAs0y7a
         d9O0abl4bZ0cDTNHreRtqWuo4Rg6seYesZYRO3/qNuYqIwi8rqtt1gvzv2eoP9jpnfnR
         +4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByuG98ZwLJHBzjuVb4YMRLtWuLmRZHcl+yVnvda45G0=;
        b=aqoVELS2dJN3nJ7mOgQey7cbmiVkg9eQrT88KydWPsMrbCbFKa8xy76CPQ2l31q/u7
         p2eGzZTPL6VQjtAgUwzQY+krOpeUHn8gk0/cmvaeVEWt+AC9usS2scHlvVbPcZBncUgM
         W9ZB9cQF/s8WInUHOz7c2YIOCKctdeSQ1zKKz4y7uWLsvequfQ95lyjxvAL90MqSPApG
         f7is0SNB2f6EiXlPJt7yNI2p+aTOIpcXgtS52n6m7geXgToBTA7ndTSRkMrubcTNoH7b
         kaHm1h09i7sIRSfNlN9KCaR+B/PO8c+5ciQU+/UmqR8gWdUT7LpIpkBQQ+SmTNG2W1tT
         GNSw==
X-Gm-Message-State: ANoB5pkpYivllPi4SeXV5Z3BevmHdKvx3I7rerj2DdfG2AMOK2KLpmfx
        9Ztcp84EHjMkpy8+mQ5ur6XqdHrmTX0uSt2hgiwLCA==
X-Google-Smtp-Source: AA0mqf7V0T72DWZZAp9Pphy9uCgIwIrirFh/Mq8PQcVYpyPrXGgBPjGD1agtjH36riACaZzUJE9jl4BUxsQEs7i36T4=
X-Received: by 2002:a5d:524f:0:b0:242:dee:716c with SMTP id
 k15-20020a5d524f000000b002420dee716cmr33401675wrc.664.1671127713681; Thu, 15
 Dec 2022 10:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com> <Y5fDwH6XiM808oUM@monkey>
 <CADrL8HU9sQuh_W3Qx4dvGV44VLYNbt300cpWLU--BqLo3Xxgpw@mail.gmail.com> <Y5teuidKlbKWbT/S@monkey>
In-Reply-To: <Y5teuidKlbKWbT/S@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 15 Dec 2022 13:08:21 -0500
Message-ID: <CADrL8HXaw9ci59QvZROEcWsj53QrCFRqsL1=YHrSt8Y2-JE=Kg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 15, 2022 at 12:52 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/13/22 10:49, James Houghton wrote:
> > On Mon, Dec 12, 2022 at 7:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 10/21/22 16:36, James Houghton wrote:
> > > > Currently it is possible for all shared VMAs to use HGM, but it must be
> > > > enabled first. This is because with HGM, we lose PMD sharing, and page
> > > > table walks require additional synchronization (we need to take the VMA
> > > > lock).
> > >
> > > Not sure yet, but I expect Peter's series will help with locking for
> > > hugetlb specific page table walks.
> >
> > It should make things a little bit cleaner in this series; I'll rebase
> > HGM on top of those patches this week (and hopefully get a v1 out
> > soon).
> >
> > I don't think it's possible to implement MADV_COLLAPSE with RCU alone
> > (as implemented in Peter's series anyway); we still need the VMA lock.
>
> As I continue going through the series, I realize that I am not exactly
> sure what synchronization by the vma lock is required by HGM.  As you are
> aware, it was originally designed to protect against someone doing a
> pmd_unshare and effectively removing part of the page table.  However,
> since pmd sharing is disabled for vmas with HGM enabled (I think?), then
> it might be a good idea to explicitly say somewhere the reason for using
> the lock.

It synchronizes MADV_COLLAPSE for hugetlb (hugetlb_collapse).
MADV_COLLAPSE will take it for writing and free some page table pages,
and high-granularity walks will generally take it for reading. I'll
make this clear in a comment somewhere and in commit messages.

It might be easier if hugetlb_collapse() had the exact same
synchronization as huge_pmd_unshare, where we not only take the VMA
lock for writing, we also take the i_mmap_rw_sem for writing, so
anywhere where hugetlb_walk() is safe, high-granularity walks are also
safe. I think I should just do that for the sake of simplicity.

- James

> --
> Mike Kravetz
