Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF07303F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjFNPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjFNPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED20C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686756922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmwzH0CjVLzqwLy7siJrCROCQ7j4iPuuS4OQ5spBH/E=;
        b=exAMnlNGa1kxKj5+T3GK/yUcyMtZp12zVaDIMuL3IQm7y6eUw8Bg/9oCzS5t+cjKkd0kkG
        21/ToNvm9AYdHh7ZkK9WEZs+jD/iEUZmcu5uKM5Ku38pcEm1foplyzP9YBIGIxKu0jno26
        Q/pRf7Khqbk+lMPFkvea6wp0cizBBLg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-53WoW33HPT-_m5obgIsd2Q-1; Wed, 14 Jun 2023 11:35:21 -0400
X-MC-Unique: 53WoW33HPT-_m5obgIsd2Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62fea7a5de9so583846d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756920; x=1689348920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmwzH0CjVLzqwLy7siJrCROCQ7j4iPuuS4OQ5spBH/E=;
        b=cyAeQPzB7ju9A4Tnj+N40NKmlrBlsBgGiOIkUq3twVNS5XqEPxmCfFXQGkjo+IDadb
         h97Lges8R31thJYWQKIjSNxjHn9ewEObn9Qa6QMyB/gJso9rLu2OxakVzhS7X2DDYeNs
         JiasJ+JHUhor7OYSkKfoG2dVNUpQRK26a0URcCBEDFrXCl3xV80ZA7ix7vjUYGe2P2fk
         jKnFP9b8/kjZufBw06DINOtjdnMmrOGSM2Zlz/vVsXD22RUsQ6BDTke9AAXX6qncM7zk
         81KqDXrmt4xIkJjMSd5fJeDs2fvx7pRgGqOmSWdRP572GFIdQlnTtx6QycbZ1iO25GHr
         VNxw==
X-Gm-Message-State: AC+VfDwxhSgafZUpZOmpYzwYxWz/axAJMXoB4C6cHoWWJz0RoOrYupC9
        DbTRTFYqoC491THPVdMxDN/GZgWig9MGht5nitCmrDOIrN3q5vTdgAw6n4fgW/p6pvCw8TvJP4A
        0D8K/l4SUcPcKDAtkEdERo6kz
X-Received: by 2002:a05:622a:1a02:b0:3f6:ab9a:3d8e with SMTP id f2-20020a05622a1a0200b003f6ab9a3d8emr20549379qtb.4.1686756920611;
        Wed, 14 Jun 2023 08:35:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TJod/VnPoMZiUa7o/El2294sJ8GL00HWcJelg2hFCktid9sv2kfOTl6JXIqQfFSSX+RvYNw==
X-Received: by 2002:a05:622a:1a02:b0:3f6:ab9a:3d8e with SMTP id f2-20020a05622a1a0200b003f6ab9a3d8emr20549357qtb.4.1686756920392;
        Wed, 14 Jun 2023 08:35:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j8-20020ac85c48000000b003f9b6d54b17sm5106366qtj.58.2023.06.14.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:35:19 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:35:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Message-ID: <ZIneNhvxGGb6zLyq@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
 <ZInVmrJdLWxOEkeD@casper.infradead.org>
 <ZInalCeSNmAiG2K4@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZInalCeSNmAiG2K4@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:19:48AM -0400, Peter Xu wrote:
> > > +			for (j = 0; j < page_increm; j++) {
> > > +				subpage = nth_page(page, j);
> > > +				pages[i+j] = subpage;
> > > +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> > > +				flush_dcache_page(subpage);
> > 
> > You're better off calling flush_dcache_folio() right at the end.
> 
> Will do.

Ah when I start to modify it I noticed it's a two-sided sword: we'll then
also do flush dcache over the whole folio even if we gup one page.

We'll start to get benefit only if some arch at least starts to impl
flush_dcache_folio() (which seems to be none, right now..), and we'll
already start to lose on amplifying the flush when gup on partial folio.

Perhaps I still keep it as-is which will still be accurate, always faster
than old code, and definitely not regress in any form?

-- 
Peter Xu

