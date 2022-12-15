Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6164D4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLOBHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiLOBHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1254537C1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671066372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6SX5ZzHEybWQrQxJLxiT9zanQMGhd2Al6flIE5ogWzk=;
        b=AYdGixrkciaWbvzT+nFhWF4e/hVcNmE1JbFxzULKjovb9vIvA4rQXdyPtvsXcH01jrv5sc
        jxAtrL9CJQtaEnQdI9XlOHkVcJYWs32k10hyqwTLtWUTllPuy1E0cYiSgTwHNXFCxWosXT
        BN9KkQe1DhxpaZMvTsxNo08g6OCxQMg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-KmlfliSmNeWXC7peGlZ-AQ-1; Wed, 14 Dec 2022 20:06:11 -0500
X-MC-Unique: KmlfliSmNeWXC7peGlZ-AQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-3b0af5bcbd3so19175437b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SX5ZzHEybWQrQxJLxiT9zanQMGhd2Al6flIE5ogWzk=;
        b=drOfs/nvyMT6lijABeoup/oHqGQYWiSydhWUYNSxQi2L2aHIyeMKd30C9kU/+oA6zz
         fPh6a7E2locRhuJoABYzl4QCF3DgwRYcwRnfw0rug5MmN9sVlN7/mcEmyq7YYBNvLRQY
         T9/ADM/zsiRl/N2C9IaannEXbL6R33ICIFhZdFbhrGHwj0lJ/ilNqcToQ27JwKwS/wJZ
         yhYVguSTau0h+n0hAD45CSwWzGzfKIqN2tD02Wa4eOEl/ZW4L2qpToBRAsP5d5UWVl8N
         t998r2cAW6NOgPlU8pB/krQ4G1Z898jdGtJQ/qkEurWInWn+qXWd1lsQxYPQaHNDocN7
         Db4Q==
X-Gm-Message-State: ANoB5pl23Inz1Ygu+nobt9j7cMiKQpaI02s05NHWiZ/cRy9KGi3whxIP
        Yh2Q9/5c9h34jO6ENFCNN7JKiARX1vR0odxMz/CwtsM3NwPQ2KnxU7tT5qX7N9YZ0IAmSV3AuR5
        npyc8A9Z47xroa32vU6AGyhnc4qBoRhyi/qdQ/0wn
X-Received: by 2002:a25:4008:0:b0:728:37a1:b4ac with SMTP id n8-20020a254008000000b0072837a1b4acmr1236361yba.63.1671066370847;
        Wed, 14 Dec 2022 17:06:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4iReGa+vX68Fe0jrwCwf6H644+1hYm3UmS0ulsI8BPMFqUtrOd3jIFloeXiXXxYGe1/uo5NAtxXVx1aNp1CWo=
X-Received: by 2002:a25:4008:0:b0:728:37a1:b4ac with SMTP id
 n8-20020a254008000000b0072837a1b4acmr1236354yba.63.1671066370587; Wed, 14 Dec
 2022 17:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20221213234505.173468-1-npache@redhat.com> <Y5kPKpNp5qCnZEWy@monkey>
 <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
 <CAA1CXcDK=bpAbmkwyssja9d7eA3iEtNQ2aNaQo4DkdjV3YvOVA@mail.gmail.com>
 <Y5kgoTVteXm0QFgT@monkey> <fb2fb91c-1e54-a4ee-bf69-299e9114ae1e@oracle.com>
In-Reply-To: <fb2fb91c-1e54-a4ee-bf69-299e9114ae1e@oracle.com>
From:   Nico Pache <npache@redhat.com>
Date:   Wed, 14 Dec 2022 18:05:44 -0700
Message-ID: <CAA1CXcDmhQErLnEvoVE2_8EeY0EGTBVWSTC4UXP5F2n-JOgvfw@mail.gmail.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:38 PM Sidhartha Kumar
<sidhartha.kumar@oracle.com> wrote:
>
> On 12/13/22 5:02 PM, Mike Kravetz wrote:
> > On 12/13/22 17:27, Nico Pache wrote:
> >> According to the document linked the following approach is even faster
> >> than the one I used due to CPU parallelization:
> >
> > I do not think we are very concerned with speed here.  This routine is being
> > called in the creation of compound pages, and in the case of hugetlb the
> > tear down of gigantic pages.  In general, creation and tear down of gigantic
> > pages happens infrequently.  Usually only at system/application startup and
> > system/application shutdown.
> >
> Hi Nico,
>
> I wrote a bpftrace script to track the time spent in
> __prep_compound_gigantic_folio both with and without the branch in
> folio_set_order() and resulting histogram was the same for both
> versions. This is probably because the for loop through every base page
> has a much higher overhead than the singular call to folio_set_order().
> I am not sure what the performance difference for THP would be.

Hi Sidhartha,

Ok great! We may want to proactively implement a branchless version so
once/if THP comes around to utilizing this we won't see a regression.

Furthermore, Waiman brought up a good point off the list:
This bitmath is needlessly complex and can be achieved with
           page[1].compound_nr = (1U << order) & ~1U;

Tested:
order 0 output : 0
order 1 output : 2
order 2 output : 4
order 3 output : 8
order 4 output : 16
order 5 output : 32
order 6 output : 64
order 7 output : 128
order 8 output : 256
order 9 output : 512
order 10 output : 1024


> Below is the script.
> Thanks,
> Sidhartha Kumar

Thanks for the script!!
Cheers,
-- Nico

> k:__prep_compound_gigantic_folio
> {
>          @prep_start[pid] = nsecs;
> }
>
> kr:__prep_compound_gigantic_folio
> {
>          @prep_nsecs = hist((nsecs - @prep_start[pid]));
>          delete(@prep_start[pid]);
> }

