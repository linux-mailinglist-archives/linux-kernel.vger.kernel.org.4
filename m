Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D86970C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjBNWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjBNWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBF2CC7A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676414149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YheRg9Vw4P/y4jjZohytFNgbAeq2StqYfeQb5/kAN8o=;
        b=dX1KwI2KG6ZuI+KeZe02m2x+6YOyMhrRIRwEFLLBh/m7FXiEdM/KvV7CoFsMyD/bUYUO/Z
        cmi2Ik1aR8ao7h5Nb0AF2PeCkFxVdmkM+fStobAYpc4MqgeLBi5+5+aMpOwBvQeu/tAdcH
        JE2Y02o7/O83ZJRj3mEBzK2FmoYINcM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-_Go8Hx0vPgqwuLHD2HVQUg-1; Tue, 14 Feb 2023 17:35:48 -0500
X-MC-Unique: _Go8Hx0vPgqwuLHD2HVQUg-1
Received: by mail-qv1-f71.google.com with SMTP id gu10-20020a056214260a00b0056c2005684aso5107310qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676414147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YheRg9Vw4P/y4jjZohytFNgbAeq2StqYfeQb5/kAN8o=;
        b=Rt+nyEmBhNZEZgnQxqLsMY7olnfM3gjw9/vxWzHCj2fBBWSWXJ4t1COsYyxeLrsYp0
         Twnp8GGWlTWzTFSc+SWRoocVQbkFZIMMkUNVdHplX0WM/yl+f2TRP1Dg4lhosYQ/50qI
         cWKVxyvWhvvj8/GgTDQ02yS1RgzH7AcybaD5rMsel3Mz2msmyPp8NO0alOa9CC+cTBfB
         lz8m6yaPs4fr+bIETV0t8GTe2S27RkD7u/mg9z3Vf4/0X67xIeJ16uMVgXr98BVjuMeN
         M2v9fTgWXTNgRdpGqTaAlmZu7EKiQAQFbjlk+0QdlyMYwm0WuXCAmTTL0iyKuk9TWRSJ
         CjaQ==
X-Gm-Message-State: AO0yUKWVtmyDwpW/VW6NXRyfvgkl9H0DKBipnVE3wmwBUGESSP0drhWk
        g73/9/wZ4tMaoMm7qJXPSNryB5xKOTwce2Lo7m6DUvUrwtk/haMnHBkJMDBNcFzHAr+bfkD/CCX
        JntBHCh1EUfatTkuBpixu/GbC
X-Received: by 2002:a05:622a:1a11:b0:3b8:4951:57bb with SMTP id f17-20020a05622a1a1100b003b8495157bbmr7602119qtb.5.1676414147655;
        Tue, 14 Feb 2023 14:35:47 -0800 (PST)
X-Google-Smtp-Source: AK7set9ZAa+oY9vbMlSxvaFJ8usz7qINFYUhnR8zRXwUH/Xz+UYY5ixxvOvEGXCPq8mv0aKJwXoApg==
X-Received: by 2002:a05:622a:1a11:b0:3b8:4951:57bb with SMTP id f17-20020a05622a1a1100b003b8495157bbmr7602069qtb.5.1676414147296;
        Tue, 14 Feb 2023 14:35:47 -0800 (PST)
Received: from x1n ([70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e16-20020a05620a015000b0073b399700adsm5597387qkn.3.2023.02.14.14.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:35:46 -0800 (PST)
Date:   Tue, 14 Feb 2023 17:35:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+wMvVjDpW0nlaPu@x1n>
References: <20230214075710.2401855-1-stevensd@google.com>
 <20230214075710.2401855-2-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230214075710.2401855-2-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

On Tue, Feb 14, 2023 at 04:57:10PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Make sure that collapse_file respects any userfaultfds registered with
> MODE_MISSING. If userspace has any such userfaultfds registered, then
> for any page which it knows to be missing, it may expect a
> UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
> collapsing a shmem range would result in replacing an empty page with a
> THP, so that it doesn't break userfaultfd.
> 
> Synchronization when checking for userfaultfds in collapse_file is
> tricky because the mmap locks can't be used to prevent races with the
> registration of new userfaultfds. Instead, we provide synchronization by
> ensuring that userspace cannot observe the fact that pages are missing
> before we check for userfaultfds. Although this allows registration of a
> userfaultfd to race with collapse_file, it ensures that userspace cannot
> observe any pages transition from missing to present after such a race.
> This makes such a race indistinguishable to the collapse occurring
> immediately before the userfaultfd registration.
> 
> The first step to provide this synchronization is to stop filling gaps
> during the loop iterating over the target range, since the page cache
> lock can be dropped during that loop. The second step is to fill the
> gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> time, to avoid races with accesses to the page cache that only take the
> RCU read lock.
> 
> This fix is targeted at khugepaged, but the change also applies to
> MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> return EBUSY if there are any missing pages (instead of succeeding on
> shmem and returning EINVAL on anonymous memory). There is also now a
> window during MADV_COLLAPSE where a fault on a missing page will cause
> the syscall to fail with EAGAIN.
> 
> The fact that intermediate page cache state can no longer be observed
> before the rollback of a failed collapse is also technically a
> userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> is exceedingly unlikely that anything relies on being able to observe
> that transient state.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 8 deletions(-)

Could you attach a changelog in your next post (probably with a cover
letter when patches more than one)?

Your patch 1 reminded me that, I think both lseek and mincore will not
report DATA but HOLE on the thp holes during collapse, no matter we fill
hpage in (as long as hpage being !uptodate) or not (as what you do with
this one).

However I don't understand how this new patch can avoid the same race issue
I mentioned in the last version at all.

-- 
Peter Xu

