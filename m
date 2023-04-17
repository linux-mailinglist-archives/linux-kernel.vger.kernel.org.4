Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC96E49DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDQN0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDQN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:26:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9E468D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:25:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id he13so18783585wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681737956; x=1684329956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgntng0wPjZVnuP3J6V+hGBB0CrSX0X3ZWB2Cav999g=;
        b=Y35EwofwuOqYQ9xKxo9VGvzy6n8xNbIuf8XZGnMmbSuDPjLM0vGjWpTh+MYbsyNVCQ
         aakpvPQSOBeCxhpIWQcJJ0qr0s56vgY56jlYF8fdezTq+4emnXm4TBBOQ8+/nf4MVhck
         Y1kmjxn2UKtkxoQB2/lG1OJtfQBu9IjNTm2CB06o2ZuEkB4x/TvngB3H+IF/BV1w5A0X
         1iAKa/ziw2qnETW1H1zba6Tv89z05dufE9lkdXvV1zn2VIhx7pvCUNZYIQA/O/zDsTvx
         bA4EaNcQJ/1dUTtqg4f78JDcxyQ632kWmoTLvpBaiV/f61C7xKA9PK3B+PZWI+ljvGVy
         IVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737956; x=1684329956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgntng0wPjZVnuP3J6V+hGBB0CrSX0X3ZWB2Cav999g=;
        b=hoD8jSN6fibMm378M4vIsHz/9h0N1+fzYTjVzrQNlh0jt1zHJPT1JO/C2/02DSjD3g
         b7aQX5t8BMHoFemJFk22i2spjeq93uCywfa0surx480CvxeUK3beBb/wtm/rBn3bhJzb
         cg9wrPJO0krl1U6LdIaLRAGv6fJeJHSCla4RyOG4VdRpuEko/D27EJoor7K07QFMRn2F
         u26PtJsTtjzCRLKiVuSXj+RKOfOSoHHtFWMRK+EAtehlGPUsjAaubMHtHUqwDNEWnJfQ
         yyRAfDRzgh3nckK3ME4C4z2cch11f3d+aa5WQd+dRgNMmqZpojRHyMfeh5Md/bIk55kq
         xVOQ==
X-Gm-Message-State: AAQBX9ePqOmamB7uLIhToheiVniDkYACllExj+lJwOH8NYCIFkkuGVC7
        E1bVZ/e7GSQMjUQQ34s4fYA=
X-Google-Smtp-Source: AKy350Z3F49pAbniUYuKkZdPgbXvrSTr48BokDCxlPzN+jqz/sAilONWaKFwUwiYgf6YDjfkPMEGRA==
X-Received: by 2002:a7b:c8cc:0:b0:3f1:35a0:4a7b with SMTP id f12-20020a7bc8cc000000b003f135a04a7bmr8557533wml.21.1681737956555;
        Mon, 17 Apr 2023 06:25:56 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c00cd00b003edf2dc7ca3sm11900712wmm.34.2023.04.17.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:25:55 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:25:54 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Message-ID: <7f9c3ec7-ea79-4f2f-bc23-acc4c11c9620@lucifer.local>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <7ed66bd5243f7535030e0fa6a8a94b76dc5033f1.1681508038.git.lstoakes@gmail.com>
 <ZD1GGiHBOj1mRDu4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD1GGiHBOj1mRDu4@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:14:02AM -0300, Jason Gunthorpe wrote:
> On Sat, Apr 15, 2023 at 12:27:40AM +0100, Lorenzo Stoakes wrote:
> > This flag causes GUP to assert that all VMAs within the input range possess
> > the same vma->vm_file. If not, the operation fails.
> >
> > This is part of a patch series which eliminates the vmas parameter from the
> > GUP API, implementing the one remaining assertion within the entire kernel
> > that requires access to the VMAs associated with a GUP range.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  include/linux/mm_types.h |  2 ++
> >  mm/gup.c                 | 16 ++++++++++++----
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 3fc9e680f174..84d1aec9dbab 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1185,6 +1185,8 @@ enum {
> >  	FOLL_PCI_P2PDMA = 1 << 10,
> >  	/* allow interrupts from generic signals */
> >  	FOLL_INTERRUPTIBLE = 1 << 11,
> > +	/* assert that the range spans VMAs with the same vma->vm_file */
> > +	FOLL_SAME_FILE = 1 << 12,
>
> I hope we don't add this flag, but it needs to be rejected in
> internal_get_user_pages_fast()
>

intenal_get_user_pages_fast() checks against the complement of accepted
masks, therefore it will reject this as-is unless I'm missing something.

As for not adding the flag (an entirely understandable sentiment), it would
be good to get an insight into the semantics of what you feel would be more
suitable!

> Jason
