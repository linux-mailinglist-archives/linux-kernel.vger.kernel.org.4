Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39873612C51
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ3Sox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3Sov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFC65D6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667155436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f++yjA22gDYnyDkTxD8DX0hMfV9eCOWk5hFBUUA9MAI=;
        b=gwwH6Z065COj6rPqUAg6BrM5U4YHyuAeDY0t/k8vTChvv+vmjQcPmknCU1nBkIQ0a3hn8k
        Ux3FhBgdqxu48xViExgf9ydmATAKMPxJK9yjDohPEOuwpAGM5SbIcPRYWQg8iBNVaZVwHw
        BpJFdQDqAjuZYObSAyudjoCuyIE49g8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-nsfDZ6ddMyK0dFW81DCZ0A-1; Sun, 30 Oct 2022 14:43:55 -0400
X-MC-Unique: nsfDZ6ddMyK0dFW81DCZ0A-1
Received: by mail-qv1-f71.google.com with SMTP id e9-20020ad45369000000b004bbb737fcf9so2393235qvv.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f++yjA22gDYnyDkTxD8DX0hMfV9eCOWk5hFBUUA9MAI=;
        b=pnyxXX/i1OeeMSmU0Rn88sps4hW7iwRpMHOoUSBo+khgIIIgk/gLZNJ2hsNwvbpAA4
         WEQgBxrT79LC3AOIui5TXcPQiNzOg9/wnpRxNGX7hIfL3rDkJKhS9pUuOhEZc2nO8zsU
         i8BKLEO5XJtKO1GXG0nOHuT+SChPkKd70sAvI2c1fit/3HwJIStFKJsaVovzppeAtZPF
         FhGkV4W82FBvy1mRlIUQL/+B6O2s2fHUhBILFwsAv2Svt8+exwC0BwKgOGa1w06CVU/i
         ncirJcCPQaV9IhMQSSQ7ITH9zfm+92Ylk63m/JAvb6iCe1XYeCqIhh0eFXgCAui8FgYS
         cyBg==
X-Gm-Message-State: ACrzQf2rQ+KiIdaNXRJDmsyzq2ERDerKV174Om7mSXCfWJEaaevWj8q1
        SEFi7Zy6r4Jfb0p5C+2kEw79f4efPBHXyPEmpdYzmHd3dqwYe+yQw3S+6/l1ZWZ5utd9hSPmUGK
        be3hMAevgPGVR4iKuAdOwlOvR
X-Received: by 2002:a05:620a:2052:b0:6f4:bf55:d1e1 with SMTP id d18-20020a05620a205200b006f4bf55d1e1mr6591376qka.378.1667155434647;
        Sun, 30 Oct 2022 11:43:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ZtjgSvh3MKmXQEei2IY0LxpBIZeRpVqLEkX1BGa5Gk8Udt5FgooWFawG0eYDtLckR/73qtA==
X-Received: by 2002:a05:620a:2052:b0:6f4:bf55:d1e1 with SMTP id d18-20020a05620a205200b006f4bf55d1e1mr6591364qka.378.1667155434403;
        Sun, 30 Oct 2022 11:43:54 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs11-20020ac86f0b000000b0039cc82a319asm2545425qtb.76.2022.10.30.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:43:53 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:43:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: don't delete vma_lock in hugetlb
 MADV_DONTNEED processing
Message-ID: <Y17F50ktT9fZw4do@x1n>
References: <20221023025047.470646-1-mike.kravetz@oracle.com>
 <Y1mpwKpwsiN6u6r7@x1n>
 <Y1nImUVseAOpXwPv@monkey>
 <Y1nbErXmHkyrzt8F@x1n>
 <Y1vz7VvQ5zg5KTxk@monkey>
 <Y1v/x5RRpRjU4b/W@x1n>
 <Y1xGzR/nHQTJxTCj@monkey>
 <Y1xjyLWNCK7p0XSv@x1n>
 <Y13CO8iIGfDnV24u@monkey>
 <7048D2B5-5FA5-4F72-8FDC-A02411CFD71D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7048D2B5-5FA5-4F72-8FDC-A02411CFD71D@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 05:54:44PM -0700, Nadav Amit wrote:
> On Oct 29, 2022, at 5:15 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > zap_page_range is a bit confusing.  It appears that the passed range can
> > span multiple vmas.  Otherwise, there would be no do while loop.  Yet, there
> > is only one mmu_notifier_range_init call specifying the passed vma.
> > 
> > It appears all callers pass a range entirely within a single vma.
> > 
> > The modifications above would work for a range within a single vma.  However,
> > things would be more complicated if the range can indeed span multiple vmas.
> > For multiple vmas, we would need to check the first and last vmas for
> > pmd sharing.
> > 
> > Anyone know more about this seeming confusing behavior?  Perhaps, range
> > spanning multiple vmas was left over earlier code?
> 
> I don’t have personal knowledge, but I noticed that it does not make much
> sense, at least for MADV_DONTNEED. I tried to batch the TLB flushes across
> VMAs for madvise’s. [1]

The loop comes from 7e027b14d53e ("vm: simplify unmap_vmas() calling
convention", 2012-05-06), where zap_page_range() was used to replace a call
to unmap_vmas() because the patch wanted to eliminate the zap details
pointer for unmap_vmas(), which makes sense.

I didn't check the old code, but from what I can tell (and also as Mike
pointed out) I don't think zap_page_range() in the lastest code base is
ever used on multi-vma at all.  Otherwise the mmu notifier is already
broken - see mmu_notifier_range_init() where the vma pointer is also part
of the notification.

Perhaps we should just remove the loop?

> 
> Need to get to it sometime.
> 
> [1] https://lore.kernel.org/lkml/20210926161259.238054-7-namit@vmware.com/
> 

-- 
Peter Xu

