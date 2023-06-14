Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C973038A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjFNPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbjFNPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F51A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686755993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEIN0Smv09A3v1esQkaZzNJnVZHbG2zMXf43EwatZAA=;
        b=Cb9MeLNjfiuGSuuWFDIBDZ+/mVXIAXfICw8iPAAiEXiL4ArHsQEM8J6jqyhiSNtwp09vjv
        1du8mHe+cmcaw4uan8cDtPYdNd0WkMm/XP3ZFbLIH6qjwT/3u54yhoJozZsSpA2WIImboH
        iD41sGzylr7lPlkDTygTKEWtLzwxvCQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-mRllwUJgMWOeydXGoMMwCw-1; Wed, 14 Jun 2023 11:19:52 -0400
X-MC-Unique: mRllwUJgMWOeydXGoMMwCw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62de85c6862so7838186d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755991; x=1689347991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEIN0Smv09A3v1esQkaZzNJnVZHbG2zMXf43EwatZAA=;
        b=GlYPyp8A3JJ7vp3ZexMWj9E2qMmNZwht+71BV9dYgEReIyLoIvP6fnl1zr1aO5HUlp
         fYA+dP3YLpbNLOZ4x9cVO0bi+24at3UZHbW6v5M0y2eXpP1ilEv0nb3799cv/6aarm85
         8qPsFOKzx0nGU/Y7mRROEL1/cHWPyvVaxLClftjK3Dp/rrZhHZCOyykP5slQr7G/77Uc
         PmGSWwHFAH8xoBYAES+La6fneRIMQwDxTu0t8m/5D6gdfnsV6JX7n5NzjbJJiE7qaG4U
         0gdsCNA70oMAa/dmFmyf7tI9CfZR7dpmckgY59XQQMMrZkskkpbMOswUynDu17eqArEl
         vrBQ==
X-Gm-Message-State: AC+VfDyH0B+T5irUTZ3l+kMOC/MrG5ij5ar8C0Ff8MR8RGDF3Z/J93ii
        t/ggvD02w/pheBpLKhZD7os3LI93zeNbqMQbMHOMCinsg6Ai+XasPgM5M9IMXMOSaEpuBXTjDH1
        DgSUuUfK06cgT60pEUjKLjG/IvHr/BC/D
X-Received: by 2002:a05:6214:29ec:b0:62d:fc81:44fc with SMTP id jv12-20020a05621429ec00b0062dfc8144fcmr4517508qvb.6.1686755991025;
        Wed, 14 Jun 2023 08:19:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jdzOkVYLOu8PyDNBjwnGS4XsXSVi0ytxraAq+ZkAUaL/Uoq2BaHTMOZAIfuflUgf/a9iU0Q==
X-Received: by 2002:a05:6214:29ec:b0:62d:fc81:44fc with SMTP id jv12-20020a05621429ec00b0062dfc8144fcmr4517487qvb.6.1686755990729;
        Wed, 14 Jun 2023 08:19:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id y13-20020a0cec0d000000b006215d0bdf37sm4768906qvo.16.2023.06.14.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:19:50 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:19:48 -0400
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
Message-ID: <ZInalCeSNmAiG2K4@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
 <ZInVmrJdLWxOEkeD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZInVmrJdLWxOEkeD@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:58:34PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 13, 2023 at 05:53:45PM -0400, Peter Xu wrote:
> > +			if (page_increm > 1)
> > +				WARN_ON_ONCE(
> > +				    try_grab_folio(compound_head(page),
> 
> You don't need to call compound_head() here; try_grab_folio() works
> on tail pages just fine.

I did it with caution because two things I'm not sure: either
is_pci_p2pdma_page() or is_longterm_pinnable_page() inside, both calls
is_zone_device_page() on the page*.

But I just noticed try_grab_folio() is also used in gup_pte_range() where
the thp can be pte mapped, so I assume we at least need that to handle tail
page well.

Do we perhaps need the compound_head() in try_grab_folio() as a separate
patch?  Or maybe I was wrong on is_zone_device_page()?

> 
> > +						   page_increm - 1,
> > +						   foll_flags) == NULL);
> > +
> > +			for (j = 0; j < page_increm; j++) {
> > +				subpage = nth_page(page, j);
> > +				pages[i+j] = subpage;
> > +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> > +				flush_dcache_page(subpage);
> 
> You're better off calling flush_dcache_folio() right at the end.

Will do.

Thanks,

-- 
Peter Xu

