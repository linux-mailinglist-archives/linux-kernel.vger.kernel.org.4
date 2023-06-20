Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03BF7375C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFTUNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjFTUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D011726
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687291953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oXwoZ8RwLqLe3dWcXzZAE1NkRHUk+3J42l+YGXGeVc=;
        b=G4Jw5c1ea54QM+p1W48Yy3l8/uYHQNHCVGtibq4JMy8q+caK+7z+WDQ64HjaZOPXo9PJzc
        cSq8avFaQIS/MfgTWHt22k/CI2lYO0RNWkwLIeAQYiMeq4QXqxnY5V/0+PwnZ7xePXwQw9
        YA0/hyss32mpKlZMdrMO9kf8qgy0R6U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-FvweO73IN86mCHR5zfBvLw-1; Tue, 20 Jun 2023 16:12:29 -0400
X-MC-Unique: FvweO73IN86mCHR5zfBvLw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62dd9986b76so10142036d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291947; x=1689883947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oXwoZ8RwLqLe3dWcXzZAE1NkRHUk+3J42l+YGXGeVc=;
        b=VV5SilxfzqAJZR10e61zq1FFtufYezZxg/3yRxS50ZsWsrLYLDFEzlMAdFd0RgSmqE
         MWFZwrDe9iMwcjbFcFMREA31A5qmRnipt1Cxz5G74/kNm9OM3py42itsQ0hagmUePrLL
         /2YjOS1yynJs6zyaYnkH14eci5M7ZVF7cHGToOkz86K375M1uIC47SIGfh/cUuVAaqBW
         lgHwMonudYZ73ngHx91bxqhoThanzl1s0EGXWRxnmNNxWuAXDco1f1XGzXewRZZZK/fo
         VVJbjrn3jqwRu7dGNy+5QGqjnCB/LH8pH1HU4ncSU3EqiUNMZksrWAm2TNBmYLgWizLe
         6Fcw==
X-Gm-Message-State: AC+VfDwxRBu2jzya8nBKDPfxeXBHk/kDHboxhEKKwrLSyNV0fzR6ndrs
        GGtKXr+gvsFKnAav1XPpYN1qjdMu5rZg5hItvrS38K+mTLdpevSaQWEJylBjRJsBLggUhyn9D9T
        JeY2mGI8uBbsqS6gaIqqv0U413N0PQma5
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr16109351qvb.3.1687291947712;
        Tue, 20 Jun 2023 13:12:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5o7Di3dlhvIk+HgV8vPtkZ3osdYPg3Dh1c9EB8/W71nPxIahr7Cd8J0A2q7op/6+K5KADG0w==
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr16109335qvb.3.1687291947382;
        Tue, 20 Jun 2023 13:12:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f22-20020a0caa96000000b0062deea179aesm1618650qvb.22.2023.06.20.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:12:27 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:12:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages !=
 NULL"
Message-ID: <ZJIIKSEBM5yrkShT@x1n>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-6-peterx@redhat.com>
 <02a057a3-3d9e-4013-8762-25ceb1beec86@redhat.com>
 <ZJHSm/UbEy3JndZ4@x1n>
 <a73ed9f3-97f7-5822-f894-fce57ac02dc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a73ed9f3-97f7-5822-f894-fce57ac02dc7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:02:41PM +0200, David Hildenbrand wrote:
> Thinking about why we have the flush_anon_page/flush_dcache_page stuff here
> and not in GUP-fast ... I suspect that all GUP-fast archs don't need that
> stuff.

Yeah that's a bit confusing, and I sincerely don't know the answer.  Though
here I had the other side of the feeling - I feel like gup-fast should also
do it.. but maybe it's just get missed.

AFAIU the idea was that the data can be mis-aligned between user / kernel,
and if it's needed on slow gup I don't see why it's not needed in fast..

There're still a few archs that implemented flush_dcache_page() but
meanwhile has HAVE_FAST_GUP selected, like arm/arm64/powerpc.

It's just getting out of scope of what this series wanted to achieve.

> I was wondering if there are some possible races with the flush_anon_page()
> / flush_dcache_page() on a page that might have been unmapped in the
> meantime (as we dropped the PT lock ...).
> 
> Some flush_dcache_page() implementations do some IMHO confusing
> page_mapcount() things (like in arch/arc/mm/cache.c). But maybe the unmap
> code handles that as well ... and most likely these archs don't support THP.

Maybe true.

It seems that the page_mapcount() was mostly used to identify whether a
page is mapped in the userspace address space, if so I'd worry less because
the only race possible here, iiuc, is when the user unmaps the page
concurrently (and since we got it from gup it must have been mapped once).

Then I would assume the caller should be prepared for that, and the
flush_dcache_page() won't matter too much in this case I assume, if the
userspace dropped all the data anyway - the whole page* can already be
invalid for that VA for a completed unmap.

> 
> Anyhow, just a note that the flush_anon_page/flush_dcache_page left me
> confused.

I share the same confusion. Hopefully, what this series did here was not
changing that, at least not making it worse.

-- 
Peter Xu

