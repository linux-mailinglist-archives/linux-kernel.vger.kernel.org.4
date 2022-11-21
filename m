Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05382632EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiKUVS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKUVST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230A67124
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669065435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1VEqd8Y4SFqXLnlYYQALR4+fdttqcWq0/uqwM6HTCA=;
        b=Mo+hi9OTVXETTvfPfuaYqSztVD3XHHdg6Ubgg5Q0oSMBt7HNh6wh0CCd1MudE9PN9OsXJT
        X5NgDVpHcfk2vJmmH19np8u3oESih1tC49IcDcjTni8JXG7OfJ/Ye8Xmll1Fkydeo1GntN
        8nhNWWMB3DPNtRmvV8icCKFpEKCz9ag=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-1FKHJ-A7M1GdVT4ojtINMA-1; Mon, 21 Nov 2022 16:17:14 -0500
X-MC-Unique: 1FKHJ-A7M1GdVT4ojtINMA-1
Received: by mail-qk1-f200.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso16915641qkp.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1VEqd8Y4SFqXLnlYYQALR4+fdttqcWq0/uqwM6HTCA=;
        b=Xm2bF2n1U9x/xg61llefq1jz2jDpVy/gjK62692h7R88p+yTlEhM7QcNgMQLRo949d
         27GgYUM/9UmXQiVudAr4bgVZqU6ljCohXVwiQQEMps3l3pY8bEam3BknbHlMwWe+zKJH
         /J4eeSJoNXmstRoMNq5s2JRoIonjWe0CtlgzoRqzrT+eOv4gjYtWpXg9Xgr1o3vTxBzC
         W8mi+H7rFsPlgCN/BYSFsvH8/c4kNvNZDSWGfQsqMs4Oq5Beaaf3mbt1qMVY4oFKntEm
         PEYhJR1aPeOFpjhrWU9dB6ADzPd6wM8BkVhxZlIJandXiyiYO7X4/eXO3w3UtdoQbx82
         2/HQ==
X-Gm-Message-State: ANoB5pnOnTeJxVXM/EnWtjdxRg7iMpX7fQgBfeykcrwdwMfOjX9eMTea
        LOj3Lt9ZXuOvZd6vdUbszIsZsY6dDUMNt2JxWdMZARcg/esWT/bA8/R6rjwcEuCXkuoZQRVc7lk
        CXR73fKNhJLVtnzjxdVNNvbCT
X-Received: by 2002:a05:620a:a03:b0:6fa:3f27:c1e5 with SMTP id i3-20020a05620a0a0300b006fa3f27c1e5mr17534571qka.447.1669065433512;
        Mon, 21 Nov 2022 13:17:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Z8fvyFzBAqWZMgsrv+dhtNnpC0JlC8ob+XIiAqveoOcQx2bjR42VDsoMPeI/zF9aAo4Bj3A==
X-Received: by 2002:a05:620a:a03:b0:6fa:3f27:c1e5 with SMTP id i3-20020a05620a0a0300b006fa3f27c1e5mr17534553qka.447.1669065433252;
        Mon, 21 Nov 2022 13:17:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i9-20020ac813c9000000b003a4c3c4d2d4sm7242891qtj.49.2022.11.21.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 13:17:12 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:17:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Y3vq18eTOE0e7I1+@x1n>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
 <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 07:57:05PM +0500, Muhammad Usama Anjum wrote:
> Hi Peter,
> 
> Thank you so much for replying.
> 
> On 11/19/22 4:14 AM, Peter Xu wrote:
> > On Sat, Nov 19, 2022 at 01:16:26AM +0500, Muhammad Usama Anjum wrote:
> >> Hi Peter and David,
> > 
> > Hi, Muhammad,
> > 
> >>
> >> On 7/25/22 7:20 PM, Peter Xu wrote:
> >>> The check wanted to make sure when soft-dirty tracking is enabled we won't
> >>> grant write bit by accident, as a page fault is needed for dirty tracking.
> >>> The intention is correct but we didn't check it right because VM_SOFTDIRTY
> >>> set actually means soft-dirty tracking disabled.  Fix it.
> >> [...]
> >>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >>> +{
> >>> +	/*
> >>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> >>> +	 * enablements, because when without soft-dirty being compiled in,
> >>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> >>> +	 * will be constantly true.
> >>> +	 */
> >>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +		return false;
> >>> +
> >>> +	/*
> >>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
> >>> +	 * vma flags not set.
> >>> +	 */
> >>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
> >>> +}
> >> I'm sorry. I'm unable to understand the inversion here.
> >>> its tracking is enabled when the vma flags not set.
> >> VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
> >> soft-dirty. When we write to clear_refs to clear soft-dirty bit,
> >> VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
> >> is enabled when the vma flags not set?
> > 
> > Because only when 4>clear_refs happens would VM_SOFTDIRTY be cleared, and
> > only until then the real tracking starts (by removing write bits on ptes).
> But even if the VM_SOFTDIRTY is set on the VMA, the individual pages are
> still marked soft-dirty. Both are independent.
> 
> It means tracking is enabled all the time in individual pages.

IMHO it depends on how we define "tracking enabled" - before clear_refs
even if no pages written they'll also be reported as dirty, then the
information is useless.

> Only the soft-dirty bit status in individual page isn't significant if
> VM_SOFTDIRTY already is set. Right?

Yes.  But I'd say it makes more sense to say "tracking enabled" if we
really started tracking (by removing the write bits in ptes, otherwise we
did nothing).  When vma created we didn't track anything.

I don't know the rational of why soft-dirty was defined like that.  I think
it's somehow related to the fact that we allow false positive dirty pages
not false negative.  IOW, it's a bug to leak a page being dirtied, but not
vice versa if we report clean page dirty.

-- 
Peter Xu

