Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8723265C812
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjACU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbjACU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:26:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856B14D2B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:26:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y8so30842186wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJd3NQqdohX/EjLJYnI3IKupf1n8/BBvgnGo9sOOFuU=;
        b=QKadA8SEB2rBW3p0Mjuz98wZqz1uT1OnIlZs/1KnyFTSSM0QXaldHo1cIxM0MQ0shL
         KIZZDQXrkzrF3EKxOjUeBTWOW0ZUuhmrttIh2zjx2Y1gMmGqlZIhrTkgLhP+uijD7HGf
         0gr/J3l0D/Gppwqi8GW6669GsS7TKz0CdKLif/v2c9++Fj7tLCWsJ2QNtmRNXrcZEdJ6
         SrOGdbH6zocjmWePebaODxB1FvZp0nKIbC9gGHK/tJbM77mu1M/Buw16mY6UMPte60+i
         IYTtO8waZd2zPN6bAqwK3El3qf2K2We2l1hhdwU9E9l0PIFBva6Mmj2fpHCFEbCiz8eq
         rGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJd3NQqdohX/EjLJYnI3IKupf1n8/BBvgnGo9sOOFuU=;
        b=S/7dTntEIOmiaKvUL4uFfFkIqgUVVHqEPHU/jI5dRP8ZAwtVruhsLGNroU16gE2H5T
         cK8mKkdNAVTJhhfHKxAHboMSd7NPs1GA7ogv8C6xcVM2Sdl5dhwD8u9Ytx040OSiV89q
         2qWUzFm7W5MyMqNrMN0ABgwwTAXQWugF9v6BKylygc2uGivY5rqQJ6vLxJKVQ9vg5MxH
         wAGIGpooCWhd5+Rk+4XlLfi7lnurSmFXLzVQEf6v99vDYlyBXFXestjaaWgACTxNYqgK
         /8XZc5VCHigPvLeqdMefOrq9RVEmV6ej5X1ZxOupCCOl8IblagmN9vlorezVx/25KMJf
         mYUw==
X-Gm-Message-State: AFqh2krtUCWv5cf4PrCOTMYaUGN9oToVoaSicHlYaYVAe8B0xQnx6FuK
        NMFj1QzAeGMglLd/NQTQMuGzoRm43VBGta166mpzfQ==
X-Google-Smtp-Source: AMrXdXvi1jl5stzvILraZWn9snll5YYZJX300dAamfZiCHex7vC72EwkN0b8PcfYx2NG2iPdOnjZGIkqWZAw8UJkdVw=
X-Received: by 2002:a5d:6148:0:b0:280:91ea:29b7 with SMTP id
 y8-20020a5d6148000000b0028091ea29b7mr886765wrt.98.1672777573057; Tue, 03 Jan
 2023 12:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20230101230042.244286-1-jthoughton@google.com> <Y7SA839SDcpf+Ll0@monkey>
In-Reply-To: <Y7SA839SDcpf+Ll0@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 3 Jan 2023 20:26:01 +0000
Message-ID: <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

> Thanks James.  I am just trying to determine if we may have any issues/bugs/
> undesired behavior based on this today.  Consider the cases mentioned above:
> mbind - I do not think this would cause any user visible issues.  mbind is
>         only dealing with newly allocated pages.  We do not unshare as the
>         result of a mbind call today.
> madvise(MADV_DONTDUMP) - It looks like this results in a flag (VM_DONTDUMP)
>         being set on the vma.  So, I do not believe sharing page tables
>         would cause any user visible issue.
>
> One somewhat strange things about two vmas after split sharing a PMD is
> that operations on one VMA can impact the other.  For example, suppose
> A VMA split via mbind happens.  Then later, mprotect is done on one of
> the VMAs in the range that is shared.  That would result in the area being
> unshared in both VMAs.  So, the 'other' vma could see minor faults after
> the mprotect.
>
> Just curious if you (or anyone) knows of a user visible issue caused by this
> today.  Trying to determine if we need a Fixes: tag.

I think I've come up with one... :) It only took many many hours of
staring at code to come up with:

1. Fault in PUD_SIZE-aligned hugetlb mapping
2. fork() (to actually share the PMDs)
3. Split VMA with MADV_DONTDUMP
4. Register the lower piece of the newly split VMA with
UFFDIO_REGISTER_MODE_WRITEPROTECT (this will call
hugetlb_unshare_all_pmds, but it will not attempt to unshare in the
unaligned bits now)
5. Now calling UFFDIO_WRITEPROTECT will drop into
hugetlb_change_protection and succeed in unsharing. That will hit the
WARN_ON_ONCE and *not write-protect anything*.

I'll see if I can confirm that this is indeed possible and send a
repro if it is.

60dfaad65a ("mm/hugetlb: allow uffd wr-protect none ptes") is the
commit that introduced the WARN_ON_ONCE; perhaps it's a good choice
for a Fixes: tag (if above is indeed true).

>
> Code changes look fine to me.

Thanks Mike!
- James
