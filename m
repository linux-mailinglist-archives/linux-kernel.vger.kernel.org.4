Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753CC699DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBPU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBPU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59962A6C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676579191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oecOc+hiRofVEjCM7aQ0Wlwl5gfnG62Egd7W9YjTsU=;
        b=K8p9QN6d+uBgLeJT0og9GzElw71uwxwgbSzwqgZTST4CNyhQcblO/H6zS7SbRwSjcp45p4
        A8a1Q8mUNGN+f+YPH/RACcmOHzSnQsToafUbM/Gesk3AdktFu4RAr39uUM+TnTQUC0yx6w
        Mfe/7QzsGyAv994jpJ2dgfxpiE/zLhE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-LXbSz-aJMO6QWQqIUhfSEQ-1; Thu, 16 Feb 2023 15:26:30 -0500
X-MC-Unique: LXbSz-aJMO6QWQqIUhfSEQ-1
Received: by mail-qt1-f197.google.com with SMTP id l21-20020ac81495000000b003bd0d4e3a50so1384917qtj.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676579190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oecOc+hiRofVEjCM7aQ0Wlwl5gfnG62Egd7W9YjTsU=;
        b=NGJONLdMVRy6khd+/PaxIkVV44iDzGo9qjj5iHOGtTNjP9e+QhdQTIOwdJkMdsDWp2
         +BpwOtCI3fEg1UtshRsC3f8yYk1h2eZznP1DOnigi/oAtEgj2PySFlSY7ueBd6gE7XFj
         ETlYC8BaNWZJvXfy0B8PIiQ+y3TBXW+OQWgl8KsmD1wo+Qr7pZk/YCgwy+31agRQpx+K
         xF8ecohnM+pEk+kZ+fWAgQUu83xfBMR7eGmSsC8B8I219PqpT/jgt6k6/ikspQOwKfek
         fRJ6YOYW3IjJ7jrrj1oGPX1rvYC/RjGMhoJnnzRGTpbwmgvf4nlxI3LbMUW0daqUA/WF
         zhsQ==
X-Gm-Message-State: AO0yUKXCFe6tsAHiFEDq/2xCr1ZniLeGr3AjtYxRh0bkaA4OvgaXDrC7
        4a+jQrW+/5lHy53dSsfVuTJ9CifiIpttnONHJuYEXYi7hKcAesouLGT8vUn5zjMvNlLesHUPRsl
        aCvycGBqSvkqJwgaD4HDUraUt
X-Received: by 2002:a05:622a:19aa:b0:39c:da22:47b8 with SMTP id u42-20020a05622a19aa00b0039cda2247b8mr13465404qtc.1.1676579189937;
        Thu, 16 Feb 2023 12:26:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/Xjpm1YuVpFOgB7Vc7SzNUNmso7z9n0j2QOFUD0tMjJXptDDPTST7C89smgOnvOS8E8ZLz6w==
X-Received: by 2002:a05:622a:19aa:b0:39c:da22:47b8 with SMTP id u42-20020a05622a19aa00b0039cda2247b8mr13465386qtc.1.1676579189605;
        Thu, 16 Feb 2023 12:26:29 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f30-20020ac8015e000000b003bd0e7ff466sm1003888qtg.7.2023.02.16.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:26:28 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:26:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Message-ID: <Y+6Rc8RUiv7xAlKH@x1n>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <20230216091656.2045471-2-usama.anjum@collabora.com>
 <4d29a9ec-027d-06b9-8543-87d386e58c94@redhat.com>
 <c239e126-9b75-9a81-6142-a8e518e769e2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c239e126-9b75-9a81-6142-a8e518e769e2@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 02:48:51PM +0500, Muhammad Usama Anjum wrote:
> On 2/16/23 2:24 PM, David Hildenbrand wrote:
> > On 16.02.23 10:16, Muhammad Usama Anjum wrote:
> >> Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>   mm/userfaultfd.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >> index 77c5839e591c..d89ed44d2668 100644
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct
> >> vm_area_struct *dst_vma,
> >>       struct mmu_gather tlb;
> >>       long ret;
> >>   +    VM_WARN_ONCE(start < dst_vma->vm_start || start + len >
> >> dst_vma->vm_end,
> >> +             "The address range exceeds VMA boundary.\n");
> > 
> > VM_WARN_ON_ONCE is sufficient (sorry for spelling out the wrong variant
> > earlier).
> Will do in the next version. Thanks.

Shall we just squash the two patches?

-- 
Peter Xu

