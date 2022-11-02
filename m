Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF95616F83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED31BC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667423844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHTGds9MfIzizVOKWUvyRmvhOQ74hdBvvx9ULgkSqlk=;
        b=T1mW3j/4KLr7PAhgdJtJwfL66W40iRzRV8513IEPhV9YluULenakpuv8PCQjq/1WiDN/h7
        2hG1T/Ftn/jU/gOP9UE3NzuO07+wHWz1dXVBcxMF8DEllagWCDT/HBAOs5l7LjdbzjrM45
        H+RERRWtUGLj23G1VjDXUKI/i1F7FuM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-uooQa6j3NiOJg7kkjvXjDg-1; Wed, 02 Nov 2022 17:17:23 -0400
X-MC-Unique: uooQa6j3NiOJg7kkjvXjDg-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020a05620a430600b006e47fa02576so16639599qko.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHTGds9MfIzizVOKWUvyRmvhOQ74hdBvvx9ULgkSqlk=;
        b=Dos3imQFHp8mJ2njuuipR+X3QqxGZtnR9L6mrdAnMVVYR/6N8CEGLQpFyQrB1eS+qU
         NXIx4MZjkrN8rHuCQbipq4Y28xx+HQhYOlmiizsl0PxQL8Bo05EwejP0hlKaBz4HtaF3
         FBdJ0l5W48h/m9lzHBd0q64nhyDbkfqHNdSfw26UbKdArbKSc0Wu3B6g75g3LiCbEqq9
         XjmRxkA3EDt8gc1oUyhjGnioibJ03/15gwyAWQ1/36xhZ/xJv7X8PgTwKh1oseRaBNDW
         mC4LtJBDKDs7Frhe6sRacyuTvG4/Ue4BvwTbXPrIZU5Kymzo/E+uJ1IEQLokdMipkKyH
         i45w==
X-Gm-Message-State: ACrzQf2OsGLcqneob9ZaEKOLMmUXeNDGWC2rlTkhYhEVJqvvNuxTy6DB
        441C0ec83JV67KXuzS4NJOEB9Lf3JhmmOBbXe9wkSukjPnYh/PW1rhUUf9PDGzV6FoNFEsShjGF
        VX3Ky/i/vONgJZYTMAcYcZsmC
X-Received: by 2002:a05:620a:17a4:b0:6ee:bf6f:2e3a with SMTP id ay36-20020a05620a17a400b006eebf6f2e3amr19497760qkb.690.1667423843385;
        Wed, 02 Nov 2022 14:17:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7DXTVoVuZ6bnlwcHndCdDko8cEy6gHXoM/8e0hFqLoiKB6Vl89LbBpxAIz4NOIjKzTfbX+uQ==
X-Received: by 2002:a05:620a:17a4:b0:6ee:bf6f:2e3a with SMTP id ay36-20020a05620a17a400b006eebf6f2e3amr19497742qkb.690.1667423843163;
        Wed, 02 Nov 2022 14:17:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bp6-20020a05620a458600b006cf9084f7d0sm9177478qkb.4.2022.11.02.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:17:22 -0700 (PDT)
Date:   Wed, 2 Nov 2022 17:17:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 04/10] mm/hugetlb: Make userfaultfd_huge_must_wait()
 RCU-safe
Message-ID: <Y2LeYALtTmeM423H@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-5-peterx@redhat.com>
 <CADrL8HWpvAozbfqGyr0=4M6bu-ecQ7mQXb3xzvMTjpCPH3OVcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HWpvAozbfqGyr0=4M6bu-ecQ7mQXb3xzvMTjpCPH3OVcg@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:06:16AM -0700, James Houghton wrote:
> On Sun, Oct 30, 2022 at 2:29 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > RCU makes sure the pte_t* won't go away from under us.  Please refer to the
> > comment above huge_pte_offset() for more information.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 07c81ab3fd4d..4e813e68e4f8 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -243,6 +243,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> >
> >         mmap_assert_locked(mm);
> >
> > +       /* For huge_pte_offset() */
> > +       rcu_read_lock();
> 
> userfaultfd_huge_must_wait is called after we set the task's state to
> blocking. Is it always safe to call rcu_read_lock (and
> rcu_read_unlock) in this case? (With my basic understanding of RCU,
> this seems like it should be safe, but I'm not sure.)

I'm not aware of an issue here, but please shoot if you have any further
concerns or clues, because I'm definitely not a rcu person so I can
overlook things.

What I remember is my smoke test should be with LOCKDEP, it didn't trigger
anything so far I think.

-- 
Peter Xu

