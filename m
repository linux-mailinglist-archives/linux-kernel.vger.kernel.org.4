Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7D73712C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjFTQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393FF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687277202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+W4un4jQCwl+t3kmiC8ljRRxCS484nTzuBm5T61P9U=;
        b=fYYbfBWDX1Czze13iFBiKj4ueIO7Icg7LS2vjg/yKXYD2+nhCh8XbuoAqS8y9dzLz8BInk
        NQjSDFkcPehwIBORIh4+/AroO5lneMfjYRHc+BsegvxT8vjVtWAa8KX9tLP6RS/FMYwAZO
        sOXrsHFEoAQNI2eZ+3aOXOFXcF/7ths=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-xcAhH_X3MmegD1Wbp-X74g-1; Tue, 20 Jun 2023 12:06:25 -0400
X-MC-Unique: xcAhH_X3MmegD1Wbp-X74g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7606a134623so81010785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277178; x=1689869178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+W4un4jQCwl+t3kmiC8ljRRxCS484nTzuBm5T61P9U=;
        b=eA/KOmiKxtPN+kF9DDJLS/N/FAUGLvYs6eSqGo1eOvWaRWc9CKNrz9QrQw5kqJL7YG
         dFN7eRVTp+ww+i8w+uCbUM7QM92VfIxODrY/D6FDYJieU+4aAOwWdBdmk6tlFoTaJ5b1
         8jKdvW7zsRqtpxTvDe9V7dLlS7jeut8mJIirkeE1wVOt4y5cbxh4mpv9Xnzh6DAJsvUO
         Hevh7YGijd6ZzTYkGTzAAZEUnSsRWUGUcDxM5o44PNLnlhonx2K4AaVnYUHK808rjYvd
         Eve/HqZ1CXW8QxVb5uiCLgHW4t4bwHQ1fhEFZfoDRDk8U1ERPkV2ZNalX//ryX6C9nPq
         xCWw==
X-Gm-Message-State: AC+VfDz0pxcvTj+FvCzMza6+14vY0zqTRPT8vnJnwG5+V8A6lUnG0iKY
        b3N2QXar77t9OUmwOBUwLsLDP58Uu235W8HR/Vhoeau3epBCRVV/iujk4x0QCd+5o0Bg8uanv6D
        SAigOSKHRLkOzgd+KgCR3I9ns
X-Received: by 2002:a05:620a:171f:b0:75d:e31a:a015 with SMTP id az31-20020a05620a171f00b0075de31aa015mr14950994qkb.2.1687277178057;
        Tue, 20 Jun 2023 09:06:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Zt4E/LxpL15moKnWgZiNbP8KhawY8ICbYrAyLtymYYCduW2sW4HQ8NidvrArvLgyxDa6Zdw==
X-Received: by 2002:a05:620a:171f:b0:75d:e31a:a015 with SMTP id az31-20020a05620a171f00b0075de31aa015mr14950953qkb.2.1687277177556;
        Tue, 20 Jun 2023 09:06:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id n20-20020a05620a153400b00759300a1ef9sm1270513qkk.31.2023.06.20.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:06:17 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:06:15 -0400
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
Subject: Re: [PATCH v2 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask()
 for FOLL_PIN
Message-ID: <ZJHOdzuSEO14j7r0@x1n>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-3-peterx@redhat.com>
 <7cd1db3f-9bdf-dc0b-692c-380a2fa14286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cd1db3f-9bdf-dc0b-692c-380a2fa14286@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:28:28PM +0200, David Hildenbrand wrote:
> On 20.06.23 01:10, Peter Xu wrote:
> > follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> > target of FOLL_WRITE either.  However add the checks.
> > 
> > Namely, either the need to CoW due to missing write bit, or proper CoR on
> > !AnonExclusive pages over R/O pins to reject the follow page.  That brings
> > this function closer to follow_hugetlb_page().
> > 
> > So we don't care before, and also for now.  But we'll care if we switch
> > over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> > return -EMLINK properly, as that's the gup internal api to mean "we should
> > do CoR".  Not really needed for follow page path, though.
> > 
> > When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> > clear that it just should never fail.
> 
> Oh, and does this comment really belong into this patch or am I confused?

Ah yeh, thanks for spotting.  I used to have it in v1 but I kept the old
failure path here to partly address Lorenzo's worry; but then I forgot to
add the WARN_ON_ONCE back to guard.  I'll remember to add that in v3.

-- 
Peter Xu

