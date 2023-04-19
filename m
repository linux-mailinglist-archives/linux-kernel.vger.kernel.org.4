Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285866E7258
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDSEhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSEht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:37:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E17689
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:37:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fe82d8bf5so171636027b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681879067; x=1684471067;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYXTmrYzjexfz2MYsEFttRvUhicjx4hCZtLdGvtQzsM=;
        b=NMv2ixsdeJ2a+1uurjusEhBS/ufWexNvFFga5/rJhOUoAgjMZdaah+/24pR9timYUR
         v7L0Z2K/ppuPRYJgoNMEHbWXR/W6MxWp7sHfbnlJZVRunnTw3NC6LV5l8awNm+dSOZu5
         +dd14JRu4n4WGnbbaCkIWxK/KyQaDekD7oU7oKHBgwsx1eJh/feC5wR44B7zM7uBTyLH
         iYHKqJF3i1a0sx+9c4THEj8h2y6ET7sgvVC/JWjCf7kJj8Iv/r1lkoMguvT/7y3G9l+Z
         cuBXhHNuL57m+yq7+1Xn3aZ7I+DqEVJTqzAaUyiCfHPOeVngJRbDNtUvwCnPQOY+O2K0
         P45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681879067; x=1684471067;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYXTmrYzjexfz2MYsEFttRvUhicjx4hCZtLdGvtQzsM=;
        b=R2Y9VdWLIPp11hugnIYIADX4kp/TMhxZG4wyWxBgl1nHopme5aUuLCDBEY+CdnntrU
         9RS898qgGogy5wiTU4jEAoc4ogUpqvuC9PLNygqt/S4zjlXLTabSzWPIGkwOcb2Vc8Fh
         Gx9vt767/TAvTE2CIWmHPqSBeicyfcwvXPQipMEfLnE+v1RXRFRnqrNGNBX3qcKo1owq
         Fn2Ke8Pa4mfDnbZgm2h4lGrPhN1zkNJ+PBnpG+Vk0Ulz9D07XD5d9/GBVcXJqSd7ozsr
         uu2W/9WSI0pBecRkK8uU3Ml9m3WWq2i8BORmAw2f1aJP7PJ3g12UGNSpsEJ9EAmNvvM2
         F4EA==
X-Gm-Message-State: AAQBX9eOaK9cHK0CszLlvmNypmKseSo9cSHzhKvmdQ+2uC2hsIPjLhsf
        Xge7TtDoF+mEibBlrqVUoN0qsw==
X-Google-Smtp-Source: AKy350aGHTz+Ltc4k7j3L7XZcD97vWaCIjBIDRGX3tdF0AU/AKX3ld5oQqd4/FYqRaJLBIYd2/JlSA==
X-Received: by 2002:a81:a044:0:b0:54e:dcf2:705b with SMTP id x65-20020a81a044000000b0054edcf2705bmr2006239ywg.47.1681879067533;
        Tue, 18 Apr 2023 21:37:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cl22-20020a05690c0c1600b0054fbadd96c4sm4241038ywb.126.2023.04.18.21.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:37:46 -0700 (PDT)
Date:   Tue, 18 Apr 2023 21:37:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate
 flag
In-Reply-To: <ZCyU26ZLSKqLj+kA@x1n>
Message-ID: <2c32b136-f17c-8362-a9ec-4490b35be1c0@google.com>
References: <20230404120117.2562166-1-stevensd@google.com> <20230404120117.2562166-5-stevensd@google.com> <ZCyU26ZLSKqLj+kA@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023, Peter Xu wrote:
> On Tue, Apr 04, 2023 at 09:01:17PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > Make sure that collapse_file doesn't interfere with checking the
> > uptodate flag in the page cache by only inserting hpage into the page
> > cache after it has been updated and marked uptodate. This is achieved by
> > simply not replacing present pages with hpage when iterating over the
> > target range.
> > 
> > The present pages are already locked, so replacing them with the locked
> > hpage before the collapse is finalized is unnecessary. However, it is
> > necessary to stop freezing the present pages after validating them,
> > since leaving long-term frozen pages in the page cache can lead to
> > deadlocks. Simply checking the reference count is sufficient to ensure
> > that there are no long-term references hanging around that would the
> > collapse would break. Similar to hpage, there is no reason that the
> > present pages actually need to be frozen in addition to being locked.
> > 
> > This fixes a race where folio_seek_hole_data would mistake hpage for
> > an fallocated but unwritten page. This race is visible to userspace via
> > data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
> > a similar race where pages could temporarily disappear from mincore.
> > 
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
...
> 
> Personally I don't see anything wrong with this change to resolve the dead
> lock.  E.g. fast gup race right before unmapping the pgtables seems fine,
> since we'll just bail out with >3 refcounts (or fast-gup bails out by
> checking pte changes).  Either way looks fine here.
> 
> So far it looks good to me, but that may not mean much per the history on
> what I can overlook.  It'll be always good to hear from Hugh and others.

I'm uneasy about it, and haven't let it sink in for long enough: but
haven't spotted anything wrong with it, nor experienced any trouble.

I would have much preferred David to stick with the current scheme, and
fix up seek_hole_data, and be less concerned with the mincore transients:
this patch makes a significant change that is difficult to be sure of.

I was dubious about the unfrozen "page_count(page) != 3" check (where
another task can grab a reference an instant later), but perhaps it
does serve a purpose, since we hold the page lock there: excludes
concurrent shmem reads which grab but drop page lock before copying
(though it's not clear that those do actually need excluding).

I had thought shmem was peculiar in relying on page lock while writing,
but turn out to be quite wrong about that: most filesystems rely on
page lock while writing, though I'm not sure whether that's true of
all (and it doesn't matter while collapse of non-shmem file is only
permitted on read-only).

We shall see.

Hugh
