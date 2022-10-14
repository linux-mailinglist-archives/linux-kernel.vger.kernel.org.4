Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B265FEDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJNL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJNL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791E644E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665748780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uu1ydqkQUNoqd4AjsuOOEhP4tSswrWwn//sbux1y4Xk=;
        b=bcJpkuY1MR9BA70fVhMuTUI85tzP85v8rLKT/caeuJJTgTo/lF8lF7HIB3dQunL7G6Czq4
        GLNs5hyofusThTeZSuB8/pGxZ7YVaW9BoN+bauzUe+5rnCJ4RwgU1s9oYcDHcnbOaP2YQZ
        gbrXx8DKPqdlJChAgnQ+UPiHRHq7yT4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-_9CgREcVOkmkYuTZifMKiA-1; Fri, 14 Oct 2022 07:59:38 -0400
X-MC-Unique: _9CgREcVOkmkYuTZifMKiA-1
Received: by mail-wr1-f69.google.com with SMTP id s5-20020adf9785000000b0022e1af0e7e8so1902378wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uu1ydqkQUNoqd4AjsuOOEhP4tSswrWwn//sbux1y4Xk=;
        b=4WpEuzYdMlHMxpI/7bo4KA4YBBeew2rS1XkDj9ISbeWvXG+7Z6w8NYtyjIoFM0Fh+r
         SLSthg5syE3Q2G1mKNsPxIqG9ntNTR68Ztk7E2oTE3towwl/RGPAUocLD00n7WmwoTnM
         Kd7+ROk7SGeWliDo/c6t+UjaVfejJer98UhHyW4xEuAO8TJjLwZetudPl4v452FJEDP3
         /Kdh6ZOT4h3uO2Ev/qPdLBx0IXKuXgR9W+7ybrBXVbNi9fMZsjTjPLpCrNSm6W4Bcsh4
         W0IREBXe8iaKw33c/sEoH4SxV6A1l52TWPYzWzRP+OwESJWIYOaokjKyhGyXbM1ji/oF
         OweQ==
X-Gm-Message-State: ACrzQf3l3uB53FYOZpyvDjPe6TB9omb9OJ4ACcCmnGiKQz1kZo7fUJQL
        RjuhYMW8cRZSgBBLReE8083kk8faT1jlKePw++oQ4pUQdSHDlfzMjpMTnbx6djuEmOg0K86GZ+e
        +GQDnxKBNPfMHXM3mwO0/52P60q6jg1/bEhiwXJIn
X-Received: by 2002:a05:600c:4ed4:b0:3c6:e26d:7f5a with SMTP id g20-20020a05600c4ed400b003c6e26d7f5amr3341350wmq.166.1665748777639;
        Fri, 14 Oct 2022 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VkcidPD00XeVGxo5EzU5OXFuhrDWzkM7DNfR1RdP3sRMB84zjVhzTUKaBFpDIM1DX4DqrnNs9nm9FHqWn4BU=
X-Received: by 2002:a05:600c:4ed4:b0:3c6:e26d:7f5a with SMTP id
 g20-20020a05600c4ed400b003c6e26d7f5amr3341338wmq.166.1665748777466; Fri, 14
 Oct 2022 04:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221011145413.8025-1-aahringo@redhat.com> <931c87d8-5856-e393-7108-66275ee4099a@suse.cz>
In-Reply-To: <931c87d8-5856-e393-7108-66275ee4099a@suse.cz>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 14 Oct 2022 07:59:26 -0400
Message-ID: <CAK-6q+ho0+mDP08yXvg7vupC-+GdUUY4zUHdfwU_7Q=B2VbQ-Q@mail.gmail.com>
Subject: Re: [PATCHv2] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 14, 2022 at 3:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/11/22 16:54, Alexander Aring wrote:
> > This patch will add a comment for the __GFP_ZERO flag case for
> > kmem_cache_alloc(). As the current comment mentioned that the flags only
> > matters if the cache has no available objects it's different for the
> > __GFP_ZERO flag which will ensure that the returned object is always
> > zeroed in any case.
> >
> > I have the feeling I run into this question already two times if the
> > user need to zero the object or not, but the user does not need to zero
> > the object afterwards. However another use of __GFP_ZERO and only zero
> > the object if the cache has no available objects would also make no
> > sense.
>
> Hmm, but even with the update, the comment is still rather misleading, no?
> - can the caller know if the cache has available objects and thus the flags
> are irrelevant, in order to pass flags that are potentially wrong (if there
> were no objects)? Not really.

No, the caller cannot know it and that's why __GFP_ZERO makes no sense
if they matter only if the cache has no available objects.

> - even if cache has available objects, we'll always end up in
> slab_pre_alloc_hook doing might_alloc(flags) which will trigger warnings
> (given CONFIG_DEBUG_ATOMIC_SLEEP etc.) if the flags are inappropriate for
> given context. So they are still "relevant"
>

yes, so they are _always_ relevant in the current implementation. Also
as you said the user doesn't know when they become relevant or not..

> So maybe just delete the whole comment? slub.c doesn't have it, and if any
> such comment should exist for kmem_cache_alloc() and contain anything useful
> and not misleading, it should be probably in include/linux/slab.h anyway?
>

ctags brought me there, but this isn't a real argument why it should
not be in the header file...

I am not sure about deleting the whole comment as people have an vague
idea about how kmem_cache works and still need to know for __GFP_ZERO
that it will always zero the memory, but thinking again somebody will
make the conclusion it does not make sense as the user doesn't know
when objects are reused or allocated. Having that in mind and reading
the current comment was making me do more investigations into the
internal behaviour to figure out how it works regarding __GFP_ZERO.

- Alex

