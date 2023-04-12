Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBC6DFAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDLP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjDLP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6FA3C2A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681315126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4zKfTXi6p8VAPaY4tnWKKvJceMD4XzFMn5JXWhUpmQ=;
        b=HaEG1IBTWp21kV+t2xwqthmnbQbUVfi5IKJQip7UoCd5QtGPS/vXm82uTNVhEd+KauMyRg
        UhWKOpV2cdZKtnbbARxEM409Dv4g7pQIH2Rxo6J0XWbu3gz1cuQ9j8fMerDnX5JBtmlAAH
        P6z8zOwFThDBvw0Ba7/mOkA2B0u/bcI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-xvsXl7vhO_yHpZsszuHlkg-1; Wed, 12 Apr 2023 11:58:45 -0400
X-MC-Unique: xvsXl7vhO_yHpZsszuHlkg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74a90355636so61488585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315125; x=1683907125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4zKfTXi6p8VAPaY4tnWKKvJceMD4XzFMn5JXWhUpmQ=;
        b=uCcOswGbgQRtgPLdIMvbq52yPaiaUC8jWV4vJxKzoOl6dEwVpN1FuCWstP3TIdOQ4Q
         +54F0Xt2wfe2OQse/nOy89AZUcRUE9uP9HmVoMHpTZPL+KWnJSVUDbxYe0TW8YPLeQD5
         8KCu+6tf6j03QBkRgX8h5oNx2+zTVCH4S4XzE06hLUmOs3BBizpLYohUd/kDnN7pwvfe
         fn6dnhUBjACXiIYIH3A/ciBAd5J2J1JwZ11AyC1WLjI8HulEbGSM+dXPOJuS2ukxqqz3
         YA2NCHANRGSYmf3F0Fdqx37t77PHWYuPqVCvWnYK04PMPzH5nO2h1ihCJWKVvq4aaPIL
         0Ctg==
X-Gm-Message-State: AAQBX9e4OHCSu9lDkj+kTtcm/qmYUeo2fUGKkc4Imbhq/xBw9P2ZyCSl
        IPTXDY8yWBcGgqXe6hb9SprxROb6eoUwJv8HecvHIlMg5+yNfXgfpX0L/xHhKC0ots4QR7wDKyw
        RRkp1Ij7JMzbnc+OBXgdJKzMh
X-Received: by 2002:a05:622a:1a90:b0:3e6:3af1:de7a with SMTP id s16-20020a05622a1a9000b003e63af1de7amr28893760qtc.4.1681315124827;
        Wed, 12 Apr 2023 08:58:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aC9JtH8C52CSaKt8tbfGx5XbjUuOwuhENqSOA9S+Pe/ZnQYS6bdliJRl6xDFMl4aRC1Q/oGg==
X-Received: by 2002:a05:622a:1a90:b0:3e6:3af1:de7a with SMTP id s16-20020a05622a1a9000b003e63af1de7amr28893735qtc.4.1681315124555;
        Wed, 12 Apr 2023 08:58:44 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id y69-20020a376448000000b0074ace1dbd83sm1338qkb.39.2023.04.12.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:58:43 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:58:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: RFC for new feature to move pages from one vma to another
 without split
Message-ID: <ZDbVMk0trT5UaqaA@x1n>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n>
 <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:47:52AM +0200, David Hildenbrand wrote:
> > Personally it was always a mistery to me on how vm_pgoff works with
> > anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHIFT.
> > 
> > Just now I tried to apply below oneliner change:
> > 
> > @@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >                          /*
> >                           * Set pgoff according to addr for anon_vma.
> >                           */
> > -                       pgoff = addr >> PAGE_SHIFT;
> > +                       pgoff = 0;
> >                          break;
> >                  default:
> >                          return -EINVAL;
> > 
> > The kernel even boots without a major problem so far..
> 
> I think it's for RMAP purposes.
> 
> Take a look at linear_page_index() and how it's, for example, used in
> ksm_might_need_to_copy() alongside page->index.

From what I read, the vma's vm_pgoff is set before setup any page->index
within the vma, while the latter will be calculated out of the vma pgoff
with linear_page_index() (in __page_set_anon_rmap()).

	folio->index = linear_page_index(vma, address);

I think I missed something, but it seems to me any comparisions between
page->index and linear_page_index() will just keep working for anonymous
even if we change vma pgoff to 0 when vma is mapped.

Do you perhaps mean this is needed for ksm only?  I really am not familiar
enough with ksm, especially when it's swapped out.  I do see that
ksm_might_need_to_copy() wants to avoid reusing a page if anon_vma is setup
not for current vma, but I don't know when it'll happen.

	if (PageKsm(page)) {
		if (page_stable_node(page) &&
		    !(ksm_run & KSM_RUN_UNMERGE))
			return page;	/* no need to copy it */
	} else if (!anon_vma) {
		return page;		/* no need to copy it */
	} else if (page->index == linear_page_index(vma, address) &&
			anon_vma->root == vma->anon_vma->root) {
		return page;		/* still no need to copy it */
	}

I think when all these paths don't trigger (aka, we need to copy) it means
there's anon_vma assigned to the page but not the right one (even though I
don't know how that could happen..).  Meanwhile I don't see either on how
vma pg_off affects this (and I assume a real KSM page ignores page->index
completely).

Thanks,

-- 
Peter Xu

