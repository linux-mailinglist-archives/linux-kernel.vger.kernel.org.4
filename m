Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9C69E9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBUWTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBUWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF1E076
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677017908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMP74qjrWS/RnxRgCif5/ytCoK1M+dLaO1HQufl21IU=;
        b=X1OHcp5wFVF7/U0lSQmLTZrchVh0+psNGxtTwSQxNIv8tjfnYLzEzNtMB37WkJtXx0HJ9Q
        Uf9j4E0UWkX63hpR5fFG4usaKX9D9/mpWhpZj+v85fXbItDenLr7KwvcrGs8ShLqCYUmqk
        oECcVZkqFi230DZ7gviJRs8ym3j/5FE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-qt8Ho-d_MwS6odLYImY8Zw-1; Tue, 21 Feb 2023 17:18:25 -0500
X-MC-Unique: qt8Ho-d_MwS6odLYImY8Zw-1
Received: by mail-qv1-f70.google.com with SMTP id y3-20020a0cec03000000b0056ee5b123bbso2782648qvo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMP74qjrWS/RnxRgCif5/ytCoK1M+dLaO1HQufl21IU=;
        b=XON+TpPj3Wxun7iW6xJ2bm3g1MRdkwrpMH1Jq1KKswlELXE7LcLgNG4QDClYbqwYUh
         BYSRubEbCRQBtxp/KWTEEql0wwTGGH2YKdJWZtKI+KWKOMmwUXzKXVelCbJamL80t95I
         cH7eG7LIO0mGttX3Q/iKk3/jFaNpPiCcJgSWsKgEpsgh9umK5Qm0pa9QLyUwfD73RLuP
         1vIXJYYibzoE5W8kvTjESMt1VhkERS9/JgvktUlJ/qfhQJe3ktAzJXIXXSWa/X2Qq9PA
         O5hUG68WqOvHG79S1Z3hGDvzFUXE8pChb/rdv/r81SWgKNwjWyh6EyIPiUFWKeTg8wk9
         bPCQ==
X-Gm-Message-State: AO0yUKWMxWVuLaRsgGdrnD9AtbtD2dWXK/8RP9BRwma2NtQ6889emBIc
        aKH65MBd1iw729dK4aUiNaWNWlBtBJ1rOqs2xtwYmN2jS14arUcLAfrffwElbSb2g9UJpm4TsU2
        PI0YirbsYxo6PRPoyLjq2BbB3
X-Received: by 2002:a05:622a:19a8:b0:3b8:6d44:ca7e with SMTP id u40-20020a05622a19a800b003b86d44ca7emr12833855qtc.4.1677017904624;
        Tue, 21 Feb 2023 14:18:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+wmjGEyaT6rSowNRC8r+xsf3YRukGF6Utxm0Nxjz2Mf+0NQiX0ieQ6jI/aZsENjm4cnmXEJA==
X-Received: by 2002:a05:622a:19a8:b0:3b8:6d44:ca7e with SMTP id u40-20020a05622a19a800b003b86d44ca7emr12833819qtc.4.1677017904370;
        Tue, 21 Feb 2023 14:18:24 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d65-20020a37b444000000b0073b3316bbd0sm2697192qkf.29.2023.02.21.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:18:23 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:18:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <Y/VDLvLpiHkRgVjs@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
 <20230217085439.2826375-4-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217085439.2826375-4-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:54:39PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Make sure that collapse_file doesn't interfere with checking the
> uptodate flag in the page cache by only inserting hpage into the page
> cache after it has been updated and marked uptodate. This is achieved by
> simply not replacing present pages with hpage when iterating over them
> target range. The present pages are already locked, so replacing the
> with the locked hpage before the collapse is finalized is unnecessary.
> 
> This fixes a race where folio_seek_hole_data would mistake hpage for
> an fallocated but unwritten page. This race is visible to userspace via
> data temporarily disappearing from SEEK_DATA/SEEK_HOLE.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: David Stevens <stevensd@chromium.org>

Per my knowledge, this one looks all correct too.

Acked-by: Peter Xu <peterx@redhat.com>

So at least to me the whole set looks mostly good except patch 1 needs some
confirmation.

Thanks,

-- 
Peter Xu

