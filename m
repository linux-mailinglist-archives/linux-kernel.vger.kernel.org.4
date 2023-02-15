Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5F69879D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBOWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F47D42BC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676498752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qfFNZnFKtWRE4O4MevqHQ5cnOaMIQ6l++58Do45WQus=;
        b=IQ529PjtREvZHaYCHOeBV8t8OoSA7dU6oYJxwriv1lUfvpiaonWJm/xr7j5JSVV2kBgWFE
        Kz9zaFXjPF9LZgOTH9tpQT86vPWNi+fc+DA3Y/ccRNe2q2n4jQPWnpHWk7zfigWlvgZmXc
        2xZI1/ZbYUqCEl5w+Rv+1ktWBtX3Wkk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-Kwza5RIsOmGk50Q-lmH3dg-1; Wed, 15 Feb 2023 17:05:48 -0500
X-MC-Unique: Kwza5RIsOmGk50Q-lmH3dg-1
Received: by mail-il1-f197.google.com with SMTP id t6-20020a056e02010600b0031417634f4bso189449ilm.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676498748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfFNZnFKtWRE4O4MevqHQ5cnOaMIQ6l++58Do45WQus=;
        b=ZVin5kjQB4QzErU4u8pYtjDomh7t0oJ9YeNBcKKjUmtu2CzR2rz/fMU+LJ0UxHl8mZ
         VtrN/WOn1gxlaCmKM3ETpQEGpJnSWhI7iZtrIT6PZeb9azREcW5nXTUWM6xHopiWzhgd
         wwqPu89vYjIONVHEUoDWji7vpl80CnBrGZJvazD5xPN7bRdeyREkihzRRFGkRqoMOq2Y
         fYk3iRAB5jkL/CGJtQsfdwv088fDQ8797vpLmv0lkaho5Jg5/wL4eiRVJ13PnI2dwTly
         rfRbBasOWaNW6ennsqHWqrN7azQu8j56upepZ0bL4OJO/4kPHT0Nty9cHPtqJhdyWjfB
         B/cQ==
X-Gm-Message-State: AO0yUKVQboSoP+9ypDj63irm2c18URPKj+ujMTbXye9CVczku6G1kFzk
        K+UVTJ+bqdPpo/3hU0sou7sZ9TzeJI3eyfBMOnk/hgTEhQmI3CHVb2KAwwG+Ixqc+fus+sN1lFG
        qzoJ6Q0cLsOoXX+Q9J+wbhS1m
X-Received: by 2002:a05:6e02:1a64:b0:314:9f2b:f63b with SMTP id w4-20020a056e021a6400b003149f2bf63bmr3412159ilv.2.1676498747893;
        Wed, 15 Feb 2023 14:05:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8sXbg9jtkoGPrpkiuaDU6NHF/TMHj78LHiqYhEfiTkWO2wTHvOJWn3x0YdjWVWMA+Q9HsfkA==
X-Received: by 2002:a05:6e02:1a64:b0:314:9f2b:f63b with SMTP id w4-20020a056e021a6400b003149f2bf63bmr3412145ilv.2.1676498747651;
        Wed, 15 Feb 2023 14:05:47 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y3-20020a02bb03000000b003b331f0bbdfsm5988459jan.97.2023.02.15.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:05:46 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:05:45 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/khugepaged: set THP as uptodate earlier for shmem
Message-ID: <Y+1XOS88M+Pigqtq@x1n>
References: <20230214075710.2401855-1-stevensd@google.com>
 <Y+usdhfguWr/aD5x@casper.infradead.org>
 <CAD=HUj76eeScAKkX=uf03KnGcVvyzz_kJ4sYVx8XeFqwTVhDow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj76eeScAKkX=uf03KnGcVvyzz_kJ4sYVx8XeFqwTVhDow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:33:15AM +0900, David Stevens wrote:
> On Wed, Feb 15, 2023 at 12:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Feb 14, 2023 at 04:57:09PM +0900, David Stevens wrote:
> > >       /*
> > > -      * At this point the hpage is locked and not up-to-date.
> > > -      * It's safe to insert it into the page cache, because nobody would
> > > -      * be able to map it or use it in another way until we unlock it.
> > > +      * Mark hpage as up-to-date before inserting it into the page cache to
> > > +      * prevent it from being mistaken for an fallocated but unwritten page.
> > > +      * Inserting the unfinished hpage into the page cache is safe because
> > > +      * it is locked, so nobody can map it or use it in another way until we
> > > +      * unlock it.
> >
> > No, that's not true.  The data has to be there before we mark it
> > uptodate.  See filemap_get_pages() for example, used as part of
> > read().  We don't lock the page unless we need to bring it uptodate
> > ourselves.
> 
> I've been focusing on the shmem case for collapse_file and forgot to
> think about the !is_shmem case. As far as I could tell, shmem doesn't
> use filemap_get_pages() and everything else in filemap.c/shmem.c that
> checks folio_test_uptodate also locks the folio. But yeah, this would
> break the !is_shmem case and is kind of sketchy anyway. I'll put
> together a better patch.

AFAIU we lock the page iff !uptodate and we want to wait it to be uptodate,
or as Matthew said when we want to modify !uptodate->uptodate.

Take the same example of folio_seek_hole_data() that you mentioned:

	if (xa_is_value(folio) || folio_test_uptodate(folio))
		return seek_data ? start : end;

-- 
Peter Xu

