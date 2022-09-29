Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298745EFF72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiI2VzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI2Vy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:54:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181BF4B4B5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:54:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11e9a7135easo3419246fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=KbBn8T/FiFSpiieJxniFzc8MGe4ebTJMHKo1Isy1JoI=;
        b=L7mfDH3G1lyk5WJCFei7+S7tNh5/Iesdoj6VoErYJ9Rx05r27P19zmy5AuUEFzeSLS
         bA6KfYQtpXTpY0xp4qX7taqNzm+QwUuVPrsXl37x9Z7L3/BWYf8VHvOuRGd/FLd62nKU
         UeirjlwnaMtuy3FSV4W3+5mNxOqHZQFA7YaATs6xnLp2D7u5KSzWidZzgR5NFby9XfHg
         CfyOxITj5UZQBz66TFSCQGjcvs+zrABpMmuLZeGjWnOfh15vlu3BpHILlPnDmL/mokg4
         tDWjsYalDBw8stJY5Ks07DO9oWc1WmD7J+idkEOx+XP7uqyuIOBdjSgt8KjjQ7STIztY
         QLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=KbBn8T/FiFSpiieJxniFzc8MGe4ebTJMHKo1Isy1JoI=;
        b=OnOyg9m+0L0VnmGx331zr6B1Gw10J043BPtVcN5BmNNYyStmgQch9As9YhuWi5t+XO
         DkdivgU/l8vTMS4HPQi5nRELZzI+BQ3r3PkyyRh9O/jaeGAKAY8QkI1af+sQGeCVMkis
         yGMJTYZAObhRxXnXsO+RqaLzssy6fei1t5hLXlioJfK/jm1KfCtLeD213BB+rACRMcCb
         fAmEPbRQMJnfLnvZajb/OvyDYsUdcK9F8xeQlMteegFSCzkm8CI+ectzy/n6sE2UGr2b
         mUK+XRhVouHXd3hXMwS49ClGPt8wqRKIgvfqPExxfYzYheuJzPM39I1pepD+8FAua5ye
         GaIg==
X-Gm-Message-State: ACrzQf3F65L2nUWEjSl9vib/ArHjwOKo5bzgY8grL7uVHmo7YoQG+RNb
        GDJfV3qh6Y21It1RjOYwrmaHu26vvqqfHw==
X-Google-Smtp-Source: AMsMyM7hB/ryoJJnA/H4js1AjALKInFFXEAwFftQWLIdmXvET8zQ7jPScKLpKZbaIhjBPx6MZlCvDw==
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id ba36-20020a056870c5a400b001316edd3955mr3165338oab.96.1664488495207;
        Thu, 29 Sep 2022 14:54:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v13-20020a4aa50d000000b004760be682e9sm137347ook.15.2022.09.29.14.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:54:54 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:54:45 -0700 (PDT)
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
In-Reply-To: <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
Message-ID: <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz> <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
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

On Thu, 29 Sep 2022, Vlastimil Babka wrote:
> On 9/28/22 19:50, Hugh Dickins wrote:
> > On Wed, 28 Sep 2022, Vlastimil Babka wrote:
> >> On 9/28/22 15:48, Joel Fernandes wrote:
> >> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> >> >> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> >> >>> It's a bug in linux-next, but taking me too long to identify which
> >> >>> commit is "to blame", so let me throw it over to you without more
> >> >>> delay: I think __PageMovable() now needs to check !PageSlab().
> >> 
> >> When I tried that, the result wasn't really nice:
> >> 
> >> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> >> 
> >> And what if there's another conflicting page "type" later. Or the debugging
> >> variant of rcu_head in struct page itself. The __PageMovable() is just too
> >> fragile.
> > 
> > I don't disagree (and don't really know all the things you're thinking
> > of in there).  But if it's important to rescue this feature for 6.1, a
> > different approach may be the very simple patch below (I met a similar
> > issue with OPTIMIZE_FOR_SIZE in i915 a year ago, and just remembered).
> > 
> > But you be the judge of it: (a) I do not know whether rcu_free_slab
> > is the only risky address ever stuffed into that field; and (b) I'm
> > clueless when it comes to those architectures (powerpc etc) where the
> > the address of a function is something different from the address of
> > the function (have I conveyed my cluelessness adequately?).
> 
> Thanks a lot Hugh! That's a sufficiently small fix (compared to the other
> options) that I'm probably give it one last try.

I suddenly worried that you might be waiting on me for a Signed-off-by,
which I couldn't give until I researched my reservations (a) and (b):
but I'm pleased to see from your kernel.org tree that you've gone ahead
and folded it in - thanks.

Regarding (a): great, you've found it too, mm/slab.c's kmem_rcu_free()
looks like it needs the same __aligned(4) as mm/slub.c's rcu_free_slabi().

Regarding (b): I booted the PowerMac G5 to take a look, and dredged up
the relevant phrase "function descriptor" from depths of my memory: I
was right to consider that case, but it's not a worry - the first field
of a function descriptor structure (on all the architectures I found it)
is the function address, so the function descriptor address would be
aligned 4 or 8 anyway.

Regarding "conflicting" alignment requests: yes, I agree with you,
it would have to be a toolchain bug if when asked to align 2 and to
align 4, it chose not to align 4.

So, no worries at my end now.
Hugh
