Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6C64E139
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLOSqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLOSqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A062A42E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671129918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekrkd7E3uwhnNPjjtuTEk8Mcw5LuenuIHKpumevKNX4=;
        b=SS72Uoo+3NhieNM4subV77cR1RoBhZ3uUKWN1AoddRAZZq/u0fN+/SatQMaGSWCMt+jwoU
        E3zw/OQcUDSKNVURxYIMAPquvGqViP15ECs4FHzgSUTSXXbiFtUmls9Ai80q4KoPfjXz4x
        xFl4EaHyo0xQzfZk5ncxMT0+u77rDjo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-LKb0T-QqMUaRTRRNlvF-_Q-1; Thu, 15 Dec 2022 13:45:13 -0500
X-MC-Unique: LKb0T-QqMUaRTRRNlvF-_Q-1
Received: by mail-qk1-f198.google.com with SMTP id az39-20020a05620a172700b006ff85c3b19eso6534791qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekrkd7E3uwhnNPjjtuTEk8Mcw5LuenuIHKpumevKNX4=;
        b=KwG3oFuHgv3jxWPFwXkc9uc0HcEDM871Kv6ChHe6wSw2MjgmLHHoXsZc+jNFXawiyH
         btRUmz4hmO1VaCtRnSMml15uptERM6Ei0jitofdX3O+ozsfdNre64bANAsdMQRphWrM0
         O4DILIIF32NvsX6wdanMxlz2t/Xj7lFGxwVlqZDGpPfUFBYIIWRXpbhGfeEoHdgL8rvH
         h1iS5ASldCNJhoYXTu9aIcI4Xf/cwQc9r+B381k8uZ7sUNh8A+KzmIGpJUzJKtNotpDJ
         BAKYNMqs3MMuovhJFaiGQGskvabW+b9GWylhXYvfld6qrU7gFzQHI991wL3HSAGDCqu4
         k7sw==
X-Gm-Message-State: ANoB5pldRfK9Ir1OQA78Dc7Ez4etYN0K7ekS8y6V05UGrlwy8kH71sVj
        YgwxUBxDQ2u4sq+7ZEcqgd3yX9lvBe95lHz6JaR9NQKP3/izCTomHnhwR+G2/fauj84hfhynhut
        jJPN4SE7aVqfUSie+Y0bONz80
X-Received: by 2002:a05:622a:4c86:b0:3a8:1bae:4cc with SMTP id ez6-20020a05622a4c8600b003a81bae04ccmr22930663qtb.55.1671129910994;
        Thu, 15 Dec 2022 10:45:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7x47l3Nqf8oUFbQsk5FX9inoyxhm+sUbPmIZaDSTq3hu9qdS0Okjla8BraTkuEZO0TJw3/Lg==
X-Received: by 2002:a05:622a:4c86:b0:3a8:1bae:4cc with SMTP id ez6-20020a05622a4c8600b003a81bae04ccmr22930630qtb.55.1671129910726;
        Thu, 15 Dec 2022 10:45:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a075600b006bb82221013sm12295147qki.0.2022.12.15.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 10:45:10 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:45:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
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
Subject: Re: [RFC PATCH v2 24/47] hugetlb: update page_vma_mapped to do
 high-granularity walks
Message-ID: <Y5trNDdi0btNDqpu@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-25-jthoughton@google.com>
 <CADrL8HU=39e8ZJkmnXNKrMM=f-v1T+SF1yykC9KzwAi6T+MA4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HU=39e8ZJkmnXNKrMM=f-v1T+SF1yykC9KzwAi6T+MA4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On Thu, Dec 15, 2022 at 12:49:18PM -0500, James Houghton wrote:
> > @@ -166,19 +167,57 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)

[...]

> I realize that I can't do this -- we're already holding the
> i_mmap_rwsem, and we have to take the VMA lock first. It seems like
> we're always holding it for writing in this case, so if I make
> hugetlb_collapse taking the i_mmap_rwsem for reading, this will be
> safe.
> 
> Peter, you looked at this recently [1] -- do you know if we're always
> holding i_mmap_rwsem *for writing* here?
> 
> [1] https://lore.kernel.org/linux-mm/20221209170100.973970-10-peterx@redhat.com/

I think so, an analysis is in previous v2 in one of my reply to John:

https://lore.kernel.org/all/Y5JjTPTxCWSklCan@x1n/

No hurt to double check, though.

-- 
Peter Xu

