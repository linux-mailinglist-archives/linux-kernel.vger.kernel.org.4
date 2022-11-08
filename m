Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2762088B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKHEyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiKHEx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:53:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC73FB9E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:52:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p8so19579741lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fra4yIWv6TZGqY5e50Ht4t7fKg9qXIteCxj5r9JD6vc=;
        b=k5nrvygDjfG84Jq8usw3TAeubZw8DjisC8BDW/Nl99poBxOVm3b4Emj6HmmfjmpRDg
         6UqJx+Zje8uwbw0492FSt+SP9nPZpSClhlI2a7jkV8gf4dZ+NQhHw/+vcVeKfiMshCy8
         l5vHZxgwLrsSFmUFQ9k9AqBdcglrJDMAIuZNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fra4yIWv6TZGqY5e50Ht4t7fKg9qXIteCxj5r9JD6vc=;
        b=Z0tYN7gBJgL8KtGq2ceMD4CsWRGtqmTnwfoVuac6N1T8OpAzouvM7I1IcV4n8obi1W
         u4/p9Y7U/QZmrycKFNrOa1ShP3vjCtLL/+6X9N9gJKmLkYVpPHYs04j2/lRSUt8OE6jF
         kogQFVtPD9LzPJIDDnUg/2LZxnq8Vq3Rt2iN4JVaQyNwZU7Q3Al0ce6xNx/+iJutCFBD
         wCXfdduB/ocgmhC0Uened3Fj8YIgCRaDFfEEiEmmDFv6Bce95/HsfMkRKk8Mms6BRyGo
         v26stZT3gqfpE8NpD0/uJJXkJWXSOEd1hQ12quW/fWI0HSTusiHoWndQ2205xkjM94s7
         y6zQ==
X-Gm-Message-State: ACrzQf2rr1UNO7dkeWF400TDZ+GjDVurF9HrNEEFxO5pUxgHzBQgYC4E
        aADWzIKdEnkqcQyUd48KJH6UdyETpLPBIwavR5g=
X-Google-Smtp-Source: AMsMyM5ByznI4hVRG9+yXCHFP+zlusD9alQb3Iplz3o811YGctXYq8RiSVN4NpN+Uk23anQM4nAVhA==
X-Received: by 2002:ac2:47fa:0:b0:4a2:361d:da19 with SMTP id b26-20020ac247fa000000b004a2361dda19mr18669534lfp.548.1667883174002;
        Mon, 07 Nov 2022 20:52:54 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p3-20020a2e7403000000b002770e6c620bsm1500123ljc.106.2022.11.07.20.52.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 20:52:53 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id d3so19395788ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:52:53 -0800 (PST)
X-Received: by 2002:a17:906:ee8e:b0:730:3646:d178 with SMTP id
 wt14-20020a170906ee8e00b007303646d178mr51989213ejb.426.1667882769115; Mon, 07
 Nov 2022 20:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20221107161740.144456-1-david@redhat.com> <20221107161740.144456-17-david@redhat.com>
In-Reply-To: <20221107161740.144456-17-david@redhat.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 8 Nov 2022 13:45:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C3Ba1WhjYJF_7tW06mgvzoz9KTakNo+Tz8h_f6dGKzHQ@mail.gmail.com>
Message-ID: <CAAFQd5C3Ba1WhjYJF_7tW06mgvzoz9KTakNo+Tz8h_f6dGKzHQ@mail.gmail.com>
Subject: Re: [PATCH RFC 16/19] mm/frame-vector: remove FOLL_FORCE usage
To:     David Hildenbrand <david@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Nov 8, 2022 at 1:19 AM David Hildenbrand <david@redhat.com> wrote:
>
> FOLL_FORCE is really only for debugger access. According to commit
> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
> writable"), the pinned pages are always writable.

Actually that patch is only a workaround to temporarily disable
support for read-only pages as they seemed to suffer from some
corruption issues in the retrieved user pages. We expect to support
read-only pages as hardware input after. That said, FOLL_FORCE doesn't
sound like the right thing even in that case, but I don't know the
background behind it being added here in the first place. +Hans
Verkuil +Marek Szyprowski do you happen to remember anything about it?

Best regards,
Tomasz

>
> FOLL_FORCE in this case seems to be a legacy leftover. Let's just remove
> it.
>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..062e98148c53 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>         start = untagged_addr(start);
>
>         ret = pin_user_pages_fast(start, nr_frames,
> -                                 FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +                                 FOLL_WRITE | FOLL_LONGTERM,
>                                   (struct page **)(vec->ptrs));
>         if (ret > 0) {
>                 vec->got_ref = true;
> --
> 2.38.1
>
