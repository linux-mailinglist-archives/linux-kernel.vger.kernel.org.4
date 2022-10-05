Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575605F5322
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJELHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJELHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:07:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0266116;
        Wed,  5 Oct 2022 04:07:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so14995860pgb.4;
        Wed, 05 Oct 2022 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T6cNJN1BhNPosz4VSa6UZSLK0x7rvKXHqaLGbTtwrio=;
        b=Xd6r4cBUTSnEVZYxm+xmIkHByx7mcvEIip0+xONd3YDwWnW+O/ghjxKjYrW9JIFAIW
         wAlAPFGTMXDZtEhPUmMuWB2H+71JOfvoMCu0kEplxlSLPMD1lpfTfcScz3UqyGRJvQIa
         /yoWMbBrIBWXOIl6WZRgfeiqyztiJebIIySbe6QB3ppFGkt5QJdtdlRkvH0Hh8ppKRuW
         IqUXS79J0TuvmFJanubnGIWfKzjjPjkzA6dAKZdCe4T6AzBtEQjwskMqVTQlHTCnW7Jr
         94MWUQeI1wJf6W/D8tBC/hwx4vb/NxsQ10rN+jw21Dk/zCM4cAl3cLzB6gEHofKw15f2
         U9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T6cNJN1BhNPosz4VSa6UZSLK0x7rvKXHqaLGbTtwrio=;
        b=k3A2Zye9DOf9ALJBxjPQ5M+3S5ORtxsvhOr8uWF4kQYMmBIiu9uJaCDW6quXb6j6Z/
         3Et8TVvrnACrBq/txyN6Bm3fJrZKBYQNgcT2pcjKbEPhnHIQwu4FemookkMOkcCFVrlB
         yatDgC/PaBxzQ6olyjyzfMCI8XmgK1SfsaMZ0vWlW3iQYbp1gH9Uhrg9ldnFVb0AY5e0
         v9NOQWuN7X2TzyoBXwsMjdCVDOzrHn93sMpGnjst0x8UfiYmsSfnvl37aJdbdow5iyvQ
         w+g9hL0dtVr3Z6q9mo88T4ADo+kOD7t25o/VQSDS59W1DOb8HdoxObjzl+o4xfYVIiPB
         yuGA==
X-Gm-Message-State: ACrzQf04C/+2lXLJRSUyXi3OBHbN4NbfiITMD/aajimoy12UNWwhg0N5
        jJqq//jhJMS1jpEs80P2g6I3JkBPbuifVA==
X-Google-Smtp-Source: AMsMyM4xABv0qGQveu5WBb1LJTFbve6/miMk7xY0HKOkzkNJHgum0LT8wCUu5302g9jha9XGUbAfOA==
X-Received: by 2002:a63:c06:0:b0:439:9b18:8574 with SMTP id b6-20020a630c06000000b004399b188574mr27029784pgl.608.1664968049671;
        Wed, 05 Oct 2022 04:07:29 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v5-20020a626105000000b00561852ff01bsm4872099pfb.61.2022.10.05.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:07:28 -0700 (PDT)
Date:   Wed, 5 Oct 2022 20:07:23 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <Yz1lawQXGHZBvuqe@hyeyoo>
References: <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <YzxCmR3dGJz45NVD@hyeyoo>
 <YzxF5Bs/tgLDOB0T@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxF5Bs/tgLDOB0T@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:40:36PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 04, 2022 at 11:26:33PM +0900, Hyeonggon Yoo wrote:
> > > It's the acquisition of
> > > the refcount which stabilises the slab flag, not holding the lock.
> > 
> > But can you please elaborate how this prevents race between
> > allocation & initialization of a slab and isolate_movable_page()?
> > 
> > Or maybe we can handle it with frozen folio as Vlastimil suggested? ;-) 
> 
> Yes, we discussed that a little yesterday.  I'm hoping to have a
> refreshed patchset for frozen folios out today.  Some of this patch
> is still needed, even if we go that route.

Good to hear that.
With that, everyting looks sane to me.
 
> > > @@ -91,8 +99,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
> > >  	 * lets be sure we have the page lock
> > >  	 * before proceeding with the movable page isolation steps.
> > >  	 */
> > > -	if (unlikely(!trylock_page(page)))
> > > -		goto out_putpage;
> > > +	if (unlikely(!folio_trylock(folio)))
> > > +		goto out_put;
> > 
> > I don't know much about callers that this is trying to avoid race aginst...
> > 
> > But for this to make sense, I think *every users* that doing their stuff with
> > sub-page of a compound page should acquire folio lock and not page lock
> > of sub-page, right?
> 
> There is no page lock per se.  If you try to acquire the lock on a tail
> page, it acquires the lock on its head page.  It's been that way for a
> very long time.  A lot of people are confused by this, which was part of
> the motivation for making it explicit with folios.

You are right! Reading the code, too bad
I even assumed that there was sub-page lock.

-- 
Thanks,
Hyeonggon
