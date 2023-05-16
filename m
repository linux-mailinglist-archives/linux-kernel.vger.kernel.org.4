Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6AD705A97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEPWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEPWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B75FCA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684276362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MJzaFBsdors8Mev/Yq9G84UySkOY2kS3Vs3xLy2EDk=;
        b=SigYsiaycqK3Y2XbrJHdK53y4U2gfuB0vZOA18F4fWUr53ruOfbvj7WYz4h1LwVOoOh/zu
        KQwRZzVnodm++XiyZ5sqdeqsYJG6ZfPqIF6lUj5tHkqQKNMNyoQNVDHUJswAhjWKB1YHss
        2J/lxcklbunstD6jXtBI3obqnakLi+Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-nykejw5iPXi7OpOR7KBW1w-1; Tue, 16 May 2023 18:32:40 -0400
X-MC-Unique: nykejw5iPXi7OpOR7KBW1w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61a3c7657aeso175696d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276360; x=1686868360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MJzaFBsdors8Mev/Yq9G84UySkOY2kS3Vs3xLy2EDk=;
        b=WxVQjLQJe9JyxRrHil30WTek9QBpx6EN1DgkqyZ+mjKf61HH7CZFsr/6VbOl9zWMaH
         7Ald11L/geGcn/U2xBpgUxfvs8e2vMptbFLh1FF7qAe6+rt5aSH63FykjYctPNmogJtY
         N8K6lXYH6ZukWvgZlRJs+JUy7zUlbBYvl35uC+ef1sKD+b+jtmr9taMz/XOETXI63kmE
         hxxmL/Kvk3bLRMB13YPBAEzNlmhVKy+BIK0jWYgiulrNyIfNYpjyABqTXUYlICpgPjmp
         HDPiwzqx9zDCRmU+seA8+LUyrhMM2NPrKftUklWnZeNZyHpIzTk5WjamOXeXcRgH5f4C
         Bsng==
X-Gm-Message-State: AC+VfDxoq75A76E54LoQO3Kb3ZNaPhDVdONcQz06AHxjRnlxqSY3PfNk
        wMWR+xwprYvD0yyonAykKRT9zmzw9FelOExCdJN8pNrUAzSVpusHPQkMj8qX0gU7jfpAs+bxaFY
        DsTwaMjEoZetX+gtF+VCd9Dmx
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id ey5-20020a0562140b6500b0061b76ddb643mr1732510qvb.4.1684276360430;
        Tue, 16 May 2023 15:32:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6k7yQTt9V9ROhTxyHKalGuCi+1pP62Ju0r38kxo7lRU1SOLrA2ijBKl86I/lNOhQE+n97+Sw==
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id ey5-20020a0562140b6500b0061b76ddb643mr1732485qvb.4.1684276360096;
        Tue, 16 May 2023 15:32:40 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id d10-20020a0ce44a000000b005ef54657ea0sm5926054qvm.126.2023.05.16.15.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:32:39 -0700 (PDT)
Date:   Tue, 16 May 2023 18:32:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <ZGQEhuXTBdzC2CGC@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
 <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
 <ZGP4KSw/yD5ItTYu@x1n>
 <9174fd63-5d32-4b83-bf6b-27f9cb00bd9e@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9174fd63-5d32-4b83-bf6b-27f9cb00bd9e@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:15:54PM +0100, Lorenzo Stoakes wrote:
> I'll try to address this in a later series, I don't think there's much use
> in going round in circles on this. If you dislike that series, you're
> welcome to provide negative feedback there, I don't think there's much use
> in discussing further here.

I'm happy to read it, sorry if any of my wording was intruding, I didn't
mean so.

I think there's chance at least on generalizing vma flag change cases, even
though I'm not sure whether vma_merge() needs change.  Maybe it can be
another layer on top of it while keeping vma_merge() as is, but I can't tell.

> We've seen a regression on invalid input to vma_merge() (explicitly I mean
> triggering a VM_WARN_ON()) and VMA fragmentation you were not aware of
> here, that does not strike me as a great + clear interface.

Yes, the code needs time to read through, even the interface.  I don't
think I fully digested that myself.

[...]

> Ah the thanks you get for contributing a regression fix _and_ a repro - a
> nack :) will you at least give me some kind of a tag... or buy me a beer?
> ;)

I can. :)

We actually met on the conference, if I'll be able to meet you somewhere
that's what I can do.

I was probably hashing in the words, sorry about that if so, and thanks for
looking at this issue!  I appreciate both your assertion patch and the png
documentation file.

It's just that I feel irresponsible when we were talking about having vma
not merged correctly but then the discussion tried to end at there saying
it kept so so it's fine.  IMHO we should look into that problem or
something could be missing here.  Then when I was looking into that
not-merged issue I found that it's not uffd that's special.

> > Before that I'd like to know whether you agree that the new patch 1 (I'll
> > fixup the vma_prev() side effect) could be a better solution than the
> > current one, no matter whether we need a full revert or not.
> 
> In principle it looks fine actually (pending Liam's assessment), case 4/5
> should handle it, but I feel like we need a comment (perhaps only in commit
> msg) to make clear that we are ensuring that the inputs to vma_merge() are
> either clamped to VMAs or case 4/5.
> 
> Let's see what Liam thinks, then let me check it locally to give a final
> OK, if I may.

Sounds perfect here.  Thanks a lot.

-- 
Peter Xu

