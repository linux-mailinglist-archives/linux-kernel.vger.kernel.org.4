Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5F68B379
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBFAzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBFAzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483D14214
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 16:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675644879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtOrxUe6MXUilzi3ALeyX9aNN6+6Dp+de8fvauQCp/I=;
        b=Hrxqg0b0x1JE5AsWN8Ur2s7CV8VZ08FzU0ZrphavyCf+Z9Rnz5L7hfV2WxMYCnvZLuY8ix
        Wi9uR8sTHNT/SkNVie2ab/2erBLS6oMnrzL+Y1FreVgTdlkj66VhXQDobAnq/iwRCYYoPc
        YO2ak5DR+rYeArgk6c60lJQZyR4JJW0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-Z_xO1a9jMtS6EF0Knp6W6Q-1; Sun, 05 Feb 2023 19:54:38 -0500
X-MC-Unique: Z_xO1a9jMtS6EF0Knp6W6Q-1
Received: by mail-qv1-f71.google.com with SMTP id kd28-20020a056214401c00b0053cd4737a42so5178384qvb.22
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 16:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtOrxUe6MXUilzi3ALeyX9aNN6+6Dp+de8fvauQCp/I=;
        b=zuk2sBEJ1GzTjn89AkM44SNDeU3/8jQgLQmQvyqaDWSXzUX14MHEg8kJNLQ8TknqYG
         /r0Gl8XjNRhPUv52wqUDOk4/QYb1agif3RuqFYwYwNqaji3oM9qU7m3F3AwRB69wqTkY
         wA4+rOrcAcOrgQM8luLxrPWkmKYcz15GZ+cIaFkyqCfvOjEpux+ZZYVdjxqOX4j+JtZy
         bBImFG3EnTdAN+MlyO7ayJNCzaNOW2Nc5AyB61vA/Jv22L7k+l1Uq3o55CzZZDxTVWyk
         2GLMg/3QNDjGy5V1KFzhvKcXO/JygLieZhq8fK4NGSFhSbAD0TeziDvwW/bRKj6yQfEr
         9Ifg==
X-Gm-Message-State: AO0yUKUZGBZJUQo/0fy46YTvRNmAlmhaIVck1RSZaHDEIzMDZz23CQ1t
        IXmXZe0ZitDQWfMMN+iHnKzzjB4vB7DviItuY+1ZYQnO41CPQzOHw40n2R83cKxwEylV9g5erBj
        9c0h73LoRhP+GZgvaywdg0Je8
X-Received: by 2002:ac8:70c6:0:b0:3b8:6d44:ca7e with SMTP id g6-20020ac870c6000000b003b86d44ca7emr30245544qtp.4.1675644877148;
        Sun, 05 Feb 2023 16:54:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/bBn9Wk9zrv600E6sElTcu40EYMTtlJ9J9a7mc/Qqbw8vjmF+ThB3qUAXhFvwAv8oykMT1bA==
X-Received: by 2002:ac8:70c6:0:b0:3b8:6d44:ca7e with SMTP id g6-20020ac870c6000000b003b86d44ca7emr30245533qtp.4.1675644876816;
        Sun, 05 Feb 2023 16:54:36 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm6441832qkn.37.2023.02.05.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:54:36 -0800 (PST)
Date:   Sun, 5 Feb 2023 19:54:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BPy3jFcHqOnWL0@x1n>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+BFjQDBIFq5ih+t@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:10:53AM +0000, Matthew Wilcox wrote:
> On Sun, Feb 05, 2023 at 06:17:01PM -0500, Peter Xu wrote:
> > I noticed a few collision usage on VM_FAULT_* definition in the page fault
> > path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
> > definition of vm_fault_reason.
> > 
> > The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
> > the hugetlb hwpoisoning.
> > 
> > I'm not sure whether any of them can have a real impact, but that does not
> > look like to be expected.  I didn't copy stable, if anyone thinks it should
> > please shoot.  Nor did I test them in any form - I just changed the
> > allocations from top bits and added a comment for each of them.
> 
> This seems like a bad way to do it.  Why not just put these VM_FAULT_*
> definitions in linux/mm_types.h?  Then we'll see them when adding new
> VM_FAULT codes.  Sure, they won't be used by every architecture, but
> so what?

My initial version actually contains a few VM_FAULT_PRIVATE_N there, but I
noticed only the minority uses that, especially there's s390 which takes 5
entries.  I didn't had my mind straight on which's the best to go, then I
removed them and posted this simpler version, with comment on each to fix
the issues, more in a sense of raising the problem first.

I agree it isn't a problem at all, not until 32 bits all used up.  But that
seems to slightly encourage more archs from using the new private entries
which I wanted to avoid.

If to take a closer look, we may not really need that much private entries.
With s390, what I read is:

  - VM_FAULT_BADMAP could be replaced directly with VM_FAULT_SIGSEGV?
  - VM_FAULT_PFAULT could be replaced directly with VM_FAULT_BADCONTEXT?

Then if I'm not wrong we can already reduce 5->3 private entries.

I didn't directly change that because I am not 100% confident and I can't
test them myself.  It'll be great if arch people can have a look at either
s390 and arm to see whether there's chance of simplifcations first.  So the
patchset is more of raising the collision issue first, meanwhile great to
attract attention for arch people to refactor upon it.

I can also try to reduce the private entries and introduce PRIVATE entries
accordingly as you suggested, but I'll need more help on reviews and tests
than this one.

Thanks,

-- 
Peter Xu

