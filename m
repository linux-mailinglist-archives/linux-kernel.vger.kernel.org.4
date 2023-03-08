Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535366B149A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjCHV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCHV5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472FD13EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678312573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsgsdwLQ2sHKnCaynlDgL1yX7eYq5aKUeQbZiXK8wdw=;
        b=fpLgPdL+eL4bSnu8GGqqsmHX7cc8DcvBwXCUkfrkS2J7MV2xEEP9dHCs64NzGpkuZV6OpI
        4RhokkZE6wq35r8HsrEFClCrMBK8bx6AF4zWRU7rw7VV35MbJKVfhDloQAlFZDlJo2d9y9
        cUGX3rkZ7bLNAwuSWUG1vm199H03/20=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-F-5-BBNrO0C3S4V-CTG0bw-1; Wed, 08 Mar 2023 16:56:12 -0500
X-MC-Unique: F-5-BBNrO0C3S4V-CTG0bw-1
Received: by mail-qk1-f199.google.com with SMTP id 19-20020a370c13000000b007428253bb55so30667qkm.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsgsdwLQ2sHKnCaynlDgL1yX7eYq5aKUeQbZiXK8wdw=;
        b=DOZvWDZZrnlH2aFej3+u89SbhCgicwwGW7Y80pcFgaS6XmdmazlpCk7ThohgO9awvJ
         mLI9fW4Vzd8YtuOGV1CqNlG+s/dL0PE1qAzO7nJsxVAoQMtKXwJPCiqoU6z7sY4BTN7u
         xt1zzYhbJj6hztryiWchp8+dwHVz6iu8/SfItbFP8GPs6wNeO8Yho6e0DXSIY7dUiHLV
         iK+zRF1Zc8LbwNp3caCjnJ1vVQvI6oSyK4s+zndOV3YUgyHTd3P3O4GLWYNQaPqV7fO0
         6zaH2nHYzHB0UHctYki7ZRqA8SuU8EQVP5VuXzN1PGEhQg0bvq3dDdRQ2WZBTVfcuD2I
         oMWg==
X-Gm-Message-State: AO0yUKUZdJrNFCUDRe089MEjb+5ICyMrfx4FZ2zRmM0vPbY6rMLKGAj0
        d1HUrq5vJD/0FHTnu6JENOeYZj/R1mo9QSWHmIJTo6VrmO+jXyQQ/LznNJD9+HSNlRcsPzc0VBO
        GUOXANaCysVHraP2V0W3oUrbu
X-Received: by 2002:a05:622a:10e:b0:3b9:a4d4:7f37 with SMTP id u14-20020a05622a010e00b003b9a4d47f37mr1860715qtw.3.1678312571807;
        Wed, 08 Mar 2023 13:56:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/f14mHWNw8mLgQFLAbBUa6nIqkOXtRuE+h2nLt7y+/nJ5xYiOJlQbJcpDFrAqQE7qxJvURSg==
X-Received: by 2002:a05:622a:10e:b0:3b9:a4d4:7f37 with SMTP id u14-20020a05622a010e00b003b9a4d47f37mr1860690qtw.3.1678312571536;
        Wed, 08 Mar 2023 13:56:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id fu22-20020a05622a5d9600b003be56bdd3b1sm12114385qtb.92.2023.03.08.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:56:10 -0800 (PST)
Date:   Wed, 8 Mar 2023 16:56:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: rmap: make hugetlb pages participate in
 _nr_pages_mapped
Message-ID: <ZAkEecMShUAGwZ62@x1n>
References: <20230306230004.1387007-1-jthoughton@google.com>
 <20230306230004.1387007-2-jthoughton@google.com>
 <20230307215420.GA59222@monkey>
 <CADrL8HVa3vzmrfFJD5hx_GuXVnsWhSo9hzJFb4TTzzjMhWG+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVa3vzmrfFJD5hx_GuXVnsWhSo9hzJFb4TTzzjMhWG+sQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:36:51PM -0800, James Houghton wrote:
> > >       if (likely(!compound)) {
> > > +             if (unlikely(folio_test_hugetlb(folio)))
> > > +                     VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page),
> > > +                                    page);

How about moving folio_test_hugetlb() into the BUG_ON()?

                VM_BUG_ON_PAGE(folio_test_hugetlb(folio) &&
                               HPageVmemmapOptimized(&folio->page),
                               page);

Note that BUG_ON() already contains an "unlikely".

> > >               first = atomic_inc_and_test(&page->_mapcount);
> > >               nr = first;
> > >               if (first && folio_test_large(folio)) {
> > >                       nr = atomic_inc_return_relaxed(mapped);
> > >                       nr = (nr < COMPOUND_MAPPED);
> > >               }
> > > -     } else if (folio_test_pmd_mappable(folio)) {
> > > -             /* That test is redundant: it's for safety or to optimize out */
> >
> > I 'think' removing this check is OK.  It would seem that the caller
> > knows if the folio is mappable.  If we want a similar test, we might be
> > able to use something like:
> >
> >         arch_hugetlb_valid_size(folio_size(folio))
> >
> 
> Ack. I think leaving the check(s) removed is fine.

Would it still be good to keep that as another BUG_ON()?

-- 
Peter Xu

