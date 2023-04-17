Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203CC6E4670
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDQL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDQL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:29:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFF7DA7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:28:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so1254987f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681730845; x=1684322845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1bjYOZ0+WFkX3zMO2+p0oL2JA0K0j319E8cjNoH3SQ=;
        b=iJ8T0QKBqr0mm2B+ByRi/km6mBfPBPFP+G0Ah/RNFPO50HvSIryJeXEpglA5ysuQMN
         3424CMWcaQkffQS4XPgTABCKtuEUsQPxy9pOwqSYwjLebtqOeBLsFWN/DQDch0uHyOYt
         gYYot8hUgSJlpImrN3+9F1dZBDgqcMv57NZeAXjFY7cyjcADnbvtcq4bCSeNSsbFhYHI
         sCO43GjLGvm4F6CVgTQNSaqtpRxqdtvlkQv6FDp2LjyQc/W9C++QpIkJScxG3hqvuvRV
         BcpjclI+vUxGFoEsITwTiA9RK81fxd7kSMaBoB7H5LugBy+UHO3ioxqomPecbiIBSwBJ
         H8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730845; x=1684322845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1bjYOZ0+WFkX3zMO2+p0oL2JA0K0j319E8cjNoH3SQ=;
        b=dQJrCcTYy2OOxssOxeijjjZZRLf405X7xXroo5nAYlYCeqoQ4zhDyKnfBc1D0nIhIS
         a1OkILzOEHLEqzdIAu7CNUoBWnsF3clW05dPwRUmaLOEKei4UDhwrJJNTC4Z6B5gPLUJ
         koFzojBxevqQABpquv8M+GW1kjSYB7Xe/GmAeTxuXebssqL+yABci7m/NEDqrjKJgczI
         E8S42MU0y0nQ8xqynGF5SEQyGG1BPGSMk5Inq/NsepQbeb/F4uu4oTBWTVepI2hIAE5h
         Cp9XgAIZckje62PjWj8Vj2B0nz8iURnGn8MmumF2iRyvI2IF6WeJbZiURq1xAJzjvn1E
         on9Q==
X-Gm-Message-State: AAQBX9dsbQT30LDsTNhj+yIdN39EbFif0TtGFwWzQjYfZKiBbmXozfFH
        mjg9nlYDyKDeORClHCEVtu4=
X-Google-Smtp-Source: AKy350ZNtknwYsgyT9D24QijtMkYk8/hy75MlISQ9kZqMOVw2VRsKIIhnRMvUrL+KiinweLLr0sqnA==
X-Received: by 2002:a5d:558f:0:b0:2f9:9f6f:e4d with SMTP id i15-20020a5d558f000000b002f99f6f0e4dmr3102635wrv.39.1681730844892;
        Mon, 17 Apr 2023 04:27:24 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id b2-20020adfe302000000b002fae2a08089sm1610694wrj.70.2023.04.17.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:27:24 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:27:22 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Message-ID: <e614a3c1-d933-40aa-9cee-a4175b5d0cec@lucifer.local>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <2feedd2bad6fd1ec4bc4639f9d9012c5ae2faf1f.1681558407.git.lstoakes@gmail.com>
 <e4087551-c5d3-e82d-3c4e-dcfa476a971e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4087551-c5d3-e82d-3c4e-dcfa476a971e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 01:13:58PM +0200, David Hildenbrand wrote:
> On 15.04.23 14:09, Lorenzo Stoakes wrote:
> > This flag causes GUP to assert that all VMAs within the input range possess
> > the same vma->vm_file. If not, the operation fails.
> >
> > This is part of a patch series which eliminates the vmas parameter from the
> > GUP API, implementing the one remaining assertion within the entire kernel
> > that requires access to the VMAs associated with a GUP range.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> [...]
>
> > ---
> >   						&start, &nr_pages, i,
> > @@ -1595,7 +1603,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
> >   	 * We want to report -EINVAL instead of -EFAULT for any permission
> >   	 * problems or incompatible mappings.
> >   	 */
> > -	if (check_vma_flags(vma, gup_flags))
> > +	if (check_vma_flags(vma, vma->vm_file, gup_flags))
> >   		return -EINVAL;
>
> FOLL_SAME_FILE is never set here, just pass NULL instead of vma->vm_file.
>
>
> As we're not allowing to drop the mmap lock, why can't io_uring simply go
> over all VMAs once, after pinning succeeded, and make sure that the files
> match (or even before pinning)?
>
> In most cases, we're dealing with a single VMA only, it's not like the
> common case is that io_uring pins accross 100s of VMAs.
>
> So I really wonder if the GUP complexity is justified by something.

This is one that needs some input from Jens I think (added to cc, for some
reason I didn't include him on this one but I did on the one updating uring
to use it).

I agree it'd be better not to introduce this flag if we can avoid it,
intent was to avoid having to add complexity to the uring code when we're
already iterating through VMAs in the GUP code, but as you say it's highly
likely most cases will consist of a single VMA anyway.

If Jens is OK with us iterating here I'm more than happy to respin without
adding the flag!

> (removing the VMAs is certainly a welcome surprise -- as it doesn't make any
> sense when used with FOLL_UNLOCKABLE).

This is a product of reading the GUP code when writing the GUP bit for the
book and wishing it were more sane :) I suspect I'll have some more patches
in this area aimed at marrying the disparate APIs where sensible to do so.

>
> --
> Thanks,
>
> David / dhildenb
>
>
