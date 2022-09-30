Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92285F0990
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiI3LJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiI3LJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:09:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F850E0052
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:45:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d64so4328325oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=rp+AUzw48kPjNoG0TObMsKe52xjTIWv93LqcpRlYlJM=;
        b=KncvJt3XyKHWuEPGMYajxDFRmbhE3pvdWWOcetyR3KDtNpCt4uS3iGTl+qUOFe5c5v
         AWJFrxzbnStIEaBDZKAnNpt40NftazR0unQZI5WQlQD7U3Nj/p628I9NfJSWOzcjj4ry
         XsUj8XSxEGPilzwUNuqfit2216tZktBXNA8uruw+Y7z+OIaFEKMEgDeSnG6ITEG64WmL
         U7hpuTnVOFn/h4eQyysugmbyDVbmsE0D5l8QcmPihpEHLO7Gn7WYXcZ1jSkd+3+779qx
         AQ2Z9rlyNGui0NxKHmI2NhgRd2n1BeMGC+MZPG4Um6HVx+jVc51dZcVIjR8YzOSSQOyu
         Y19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=rp+AUzw48kPjNoG0TObMsKe52xjTIWv93LqcpRlYlJM=;
        b=KFaBDW50SnfKTxDWTbGToQ4ZDvW94R6gDk+bk2yhX9XYyg/6+iXiH8+ELzOz90sER3
         lyfgtucnpwLImIA+Q4lHR41rcac3UG+gUFCJRl7jQGCeFHmibkpi5XGMa8zugqZpsinO
         EJ6m94voFR3iIC6A7vDVlTjLWTaZp7cqGrpJyeTTxlm0NQnV3yZH4BOecS++YsnDkcWy
         +wf/FZ6FO86HZHUYNf/aVQWPOe8lvwRPytT+TTgff40lurmNZrUt6It613zlknyaSuFT
         djmBvrwP477a3DERDjnshJ27ZcBPsCYEmN0K6Cu9vkKMdebjp6CqQwqd+zFD99ZxvLTm
         SR8A==
X-Gm-Message-State: ACrzQf021vRRKrl7rdkn5gf06uQzSZhLqC04MXXPGZkSz5EswaoEiiqS
        OluQ8qps8Z4dcq7VAW8rSM53jw==
X-Google-Smtp-Source: AMsMyM4xAVJT+qKKj0t+3/lVyFvt474wQzC+bc4sFjbEL4Cy7lPhvKLnep2tqBYkRTFhPEP5+khWaQ==
X-Received: by 2002:a05:6808:1285:b0:350:9908:6394 with SMTP id a5-20020a056808128500b0035099086394mr9307788oiw.150.1664534716913;
        Fri, 30 Sep 2022 03:45:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a9-20020a0568300b8900b00655bbb53c55sm512687otv.15.2022.09.30.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:45:16 -0700 (PDT)
Date:   Fri, 30 Sep 2022 03:45:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
In-Reply-To: <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz>
Message-ID: <16fe443a-dabe-aa46-6bc7-dad03f29e0dc@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz> <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com> <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 30 Sep 2022, Vlastimil Babka wrote:
> On 9/29/22 23:54, Hugh Dickins wrote:
> > On Thu, 29 Sep 2022, Vlastimil Babka wrote:
> >> 
> >> Thanks a lot Hugh! That's a sufficiently small fix (compared to the other
> >> options) that I'm probably give it one last try.
> > 
> > I suddenly worried that you might be waiting on me for a Signed-off-by,
> > which I couldn't give until I researched my reservations (a) and (b):
> > but I'm pleased to see from your kernel.org tree that you've gone ahead
> > and folded it in - thanks.
> 
> Yeah could have been more explicit about that, sorry. But made the whole
> thing a very last merge so I can still drop it before the pull request.

No probs, you did the right thing.

> 
> > Regarding (a): great, you've found it too, mm/slab.c's kmem_rcu_free()
> > looks like it needs the same __aligned(4) as mm/slub.c's rcu_free_slabi().
> 
> Right.
> 
> > Regarding (b): I booted the PowerMac G5 to take a look, and dredged up
> > the relevant phrase "function descriptor" from depths of my memory: I
> > was right to consider that case, but it's not a worry - the first field
> > of a function descriptor structure (on all the architectures I found it)
> > is the function address, so the function descriptor address would be
> > aligned 4 or 8 anyway.
> 
> Thanks. I admit I wasn't that thorough, just consulted somebody internally :)

Exactly what I had hoped you would do.

> 
> > Regarding "conflicting" alignment requests: yes, I agree with you,
> > it would have to be a toolchain bug if when asked to align 2 and to
> > align 4, it chose not to align 4.
> 
> Yeah. But I still would be less worried if another __aligned(X) function
> existed in the tree already. Found only data. I assume the i915 thing wasn't
> fixed like this in the tree? So if there are buggy toolchains or anything,
> it will be us to discover them.

Linus put it in himself, after it had got lost over several -rcs:
5.15's cdc1e6e225e3 ("drm/i915: fix blank screen booting crashes").

Originally I'd written "__aligned(4)" explicitly, but later found i915
relied on it elsewhere since 4.9, and had an __i915_sw_fence_call for it.

But 5.17's 44505168d743 ("drm/i915: Drop stealing of bits from
i915_sw_fence function pointer") appears to have removed all that now.

I think that gives assurance that the x86 toolchains are okay;
but I imagine i915 is unlikely to be found on other architectures,
so not quite so much assurance there.

Hugh
