Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC946C95C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjCZOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCZOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC14682
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679841987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCwOxvpkJi/AFwFKPQO+eqD2wLsuChYdcKGvoGw4Tsg=;
        b=Lg5t5cvTOKmuZ2hG0tMHvhn51sbYjW7adE2UzK+wf0mjSHiBK1ul87WnTra8Ig+B4bAgTe
        +Q9xM0OjFjqqPWDRNHDP9idVHf15+lBIJuklcDmvmuzZCyXIO1TSIZJIH4UusY6RzjJEVZ
        jYX5cQycnhDqy61yaCBSx8nLzmSXh0k=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-NigeDiCGOiK6Q33tageoCw-1; Sun, 26 Mar 2023 10:46:26 -0400
X-MC-Unique: NigeDiCGOiK6Q33tageoCw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-b7294bdd4e3so51146276.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679841985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCwOxvpkJi/AFwFKPQO+eqD2wLsuChYdcKGvoGw4Tsg=;
        b=zFrCeBnMgJ6ayrZaIcZFV+3mdIENDkhZOPeHBIkiUMZmT+6fokHRibFdFb3cJoApy7
         mkea1rdCNRUiAxlClckObx6hyhJIGFJX6n+8nf7pekLilR2OEoXC2jHuKCaG6Mez/4k6
         9qSLe+KYuD2v1wVcff/G322E8OkJ3xWWrZOrpq77pBFDvDdMDn3Lxzr/MyTwgeEtjQ7h
         Y4t3fpCAYVj/4vra3kSFwHgGTnPVKUNzuBP65Xfbl3zsrKz12MinY+ZJ+O3a74NLMkgE
         fwNgEJXwHmTsnFzIDgY/nPLCL2EnruUtT8CyqHAktuR3DwGK2RrWr9yOBrqYGcKw3PNN
         22ow==
X-Gm-Message-State: AAQBX9dH5mRo5Ori8JbSkBpjFx55bl6/jzaWfglYbJZhUhdNAxQPl+xf
        SkHO8QfCzoNA+2NNXS60CmaFx6kF9f/nFpP1xM+htXmV1mdXb/UgjHMPIXefsL65UXVRMtl+Bas
        45MbU8YAkvqseK47YOdrLJS9K1pukxqHh
X-Received: by 2002:a25:aca5:0:b0:b74:4bff:53fa with SMTP id x37-20020a25aca5000000b00b744bff53famr7539679ybi.6.1679841985577;
        Sun, 26 Mar 2023 07:46:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350YwUtNBIndgSxYzqwugmAmBRIBhZIM5sj8jN4/1PlF/IgGjICiMvRd09ICIR43QOI24xOaQ8A==
X-Received: by 2002:a25:aca5:0:b0:b74:4bff:53fa with SMTP id x37-20020a25aca5000000b00b744bff53famr7539662ybi.6.1679841985233;
        Sun, 26 Mar 2023 07:46:25 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id v130-20020a252f88000000b00b7767ca7490sm1755262ybv.45.2023.03.26.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 07:46:24 -0700 (PDT)
Date:   Sun, 26 Mar 2023 10:46:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mm/hugetlb: Fix uffd wr-protection for CoW
 optimization path
Message-ID: <ZCBavqZE2cyVOzaW@x1n>
References: <20230324142620.2344140-1-peterx@redhat.com>
 <20230324222707.GA3046@monkey>
 <8a06be33-1b44-b992-f80a-8764810ebf3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a06be33-1b44-b992-f80a-8764810ebf3f@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:36:53PM +0100, David Hildenbrand wrote:
> > > @@ -5487,6 +5487,17 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> > >   	unsigned long haddr = address & huge_page_mask(h);
> > >   	struct mmu_notifier_range range;
> > > +	/*
> > > +	 * Never handle CoW for uffd-wp protected pages.  It should be only
> > > +	 * handled when the uffd-wp protection is removed.
> > > +	 *
> > > +	 * Note that only the CoW optimization path (in hugetlb_no_page())
> > > +	 * can trigger this, because hugetlb_fault() will always resolve
> > > +	 * uffd-wp bit first.
> > > +	 */
> > > +	if (!unshare && huge_pte_uffd_wp(pte))
> > > +		return 0;
> > 
> > This looks correct.  However, since the previous version looked correct I must
> > ask.  Can we have unshare set and huge_pte_uffd_wp true?  If so, then it seems
> > we would need to possibly propogate that uffd_wp to the new pte as in v2

Good point, thanks for spotting!

> 
> We can. A reproducer would share an anon hugetlb page because parent and
> child. In the parent, we would uffd-wp that page. We could trigger unsharing
> by R/O-pinning that page.

Right.  This seems to be a separate bug..  It should be triggered in
totally different context and much harder due to rare use of RO pins,
meanwhile used with userfault-wp.

If both of you agree, I can prepare a separate patch for this bug, and I'll
better prepare a reproducer/selftest with it.

-- 
Peter Xu

