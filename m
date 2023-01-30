Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFB6818B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbjA3SWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjA3SWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:22:01 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064945885
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:21:18 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id h19so11683927vsv.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5TU1Iff8wOSYIuihsNLjPZPQxnxZG9F/TEcr2cj9sU=;
        b=ti93R0Fc+NvDLWspUHxQEogucx+0FOTiB/H+4cAOJk5vRHgTA7R5pB9E87KnZH5zmt
         2Zx24EluskG4k/8wp8c8SVN9Q1AyigP7DPeCw2v2FkUg10GrzBX1QhNGIKEy/wD9hzVI
         8RzOiiRJln9o6Ad4J3BirxJ8qn6YQTuGU9zDmnx+ehyzoZvp/hkavk8GWZCrf/7CVhAY
         c5EGWAY+gVUDThSD99rRS/BmtLeZW3RSneYxS3JagdrdtQsV7YTwAtgJuAfFpv8IvIoU
         aSrNSQRShvPrmE83AVu7AJfOUmyQd4dYaxWglelJwX6G/Tm+UW8R/wVB1PTmtrr/KGq4
         fYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5TU1Iff8wOSYIuihsNLjPZPQxnxZG9F/TEcr2cj9sU=;
        b=C3BReQXMsMuf3S0lHoMvwG3rz10Neng2M/AGP/ZrkIIVYwq5c1qZ4tAiakaLmkprSA
         J5+ornrlNXpxXynYSTjlAwuksc7T/83vMD2Sr+MjmV6wzIIUIgI9GX6H9kR3BMwSM9XJ
         9kdrt7c+ZN3OcZFBkdFfcjNv5PgU5L3yDyWYhUbks2e1EqMkCr7zfIjws3ZVvERzoTfO
         CcL7l/ZYkr+2ZtihMdmpAAHIVDNz+fMo8fR7ohpbDBw+kzqkV+AFLU0pT091gj6rvcCv
         Po/OzS4Oe3/bEJwrQZOIUrKEPCo/ZuF9XUg5lDFYw5wkCc5+hxqOArxGIbmi0h9GQvn8
         NkbQ==
X-Gm-Message-State: AO0yUKX3xoVeExylNu/L2Q+F0bI+n/OXSMYviY+JnV+mcM4eym8E6i5I
        a0bHgK8f08icpRdzgJNv3LSSUZh8XuwgIzGSrPqM4Q==
X-Google-Smtp-Source: AK7set/kXv07zOZU7pYxD8+0imoIgDvYa7wyC6q6DaDs/59rlPuju1HxyaH4+qurTW60HvGhSi/gpCmFSKrTyxp42VM=
X-Received: by 2002:a67:c31e:0:b0:3ed:1e92:a87f with SMTP id
 r30-20020a67c31e000000b003ed1e92a87fmr1878200vsj.1.1675102876842; Mon, 30 Jan
 2023 10:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org> <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
 <Y9f0tkiXUoQexGsS@casper.infradead.org>
In-Reply-To: <Y9f0tkiXUoQexGsS@casper.infradead.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 30 Jan 2023 19:20:40 +0100
Message-ID: <CAG_fn=XaOnr5n2UoT5xzYXYPvgGXwJD_1+u-BFDo=Mv17V=-NA@mail.gmail.com>
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I haven't really followed KMSAN development but I would have expected
> > that it would, like other debugging tools, add its metadata to page_ext
> > rather than page directly.
>
> Yes, that would have been preferable.  Also, I don't understand why we
> need an entire page to store whether each "bit" of a page is initialised.
> There are no CPUs which have bit-granularity stores; either you initialise
> an entire byte or not.  So that metadata can shrink from 4096 bytes
> to 512.

It's not about bit-granularity stores, it's about bits being
uninitialized or not.

Consider the following struct:

  struct foo {
    char a:4;
    char b:4;
  } f;

- if the user initializes f.a and then tries to use f.b, this is still
undefined behavior that KMSAN is able to catch thanks to bit-to-bit
shadow, but would not have been able to detect if we only stored one
bit per byte.
Another example is bit flags or bit masks, where you can set a single
bit in an int32, but that wouldn't necessarily mean the rest of that
variable is initialized.

It's worth mentioning that even if we choose to shrink the shadows
from 4096 to 512 bytes, there'd still be four-byte origin IDs, which
are allocated for every four bytes of program memory.
So a whole page of origins will still be required in addition to those
512 bytes of shadow.

(Origins are handy when debugging KMSAN reports, because a single
uninit value can be copied or modified multiple times before it is
used in a branch or passed to the userspace.
Shrinking origins further would render them useless for e.g. 32-bit
local variables, which is a quite common use case).
