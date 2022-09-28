Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42405EE3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiI1R5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiI1R4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:56:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B96FB33A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:56:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so12853496pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=saNHm7XA+j5ek8JG01ePSb0qFtAx/myMwKal0d1qkOE=;
        b=JR5z3zsj5qfxQDXXG7sZ8I+XslICivFkqVyGuijM9p3S9yvf2mcbAaPYzYnQmxhjZP
         ziM7OlP8SmngBFVW/95vq8oUuliyIEfXeDHJNBiDhd7LUScYJc5gpexf+ZSP83zLOsAT
         JX8mkj+zM96jcU3DFosFFdjntLlKGL+DA/2ShNrtbJ82cyuktNPqiaylcL2UMC16xWau
         /hykJydX1MJx3aE4OQmPH3bnFJmNjIHejOahfDPwHyWLa7cAcvsD3lJnkq8gn9qk0X9B
         Iqi2hawD2G5CBsyh7piPuzgL3OBQEUbLkG4mnfmWItL/EgtOvDc5AgqV9GxLoqAVcTF6
         aXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=saNHm7XA+j5ek8JG01ePSb0qFtAx/myMwKal0d1qkOE=;
        b=nEKr/kLOKsDUfbYuH7naeqnwnvqMKkfxk3KLTd+cGD3PE+M4lyb1YtWduo8l25L0ng
         g+BTyq0cCMwhv79GEUsYKjd3v/4lz+Ekxreo6hE3AuE9p1hcn56hBW0/vNHFoc2q9EXM
         qs6X7bVFKvOj1Siz7n77N6BSneoYUTMcwIuF3dl6qMzULgns9i/mBHQuZdY9tp2olRyl
         tMTa66HCVVOW4+eeIVlgbj9RjUKBXgJhJ1fv/no0tFr44wH4ab9IPZnire8QsLzEvIV1
         pYEa7YlQek2xKvNalWhO7ZyHRWgp3qQUOVzVYW/ujhUij94Yqn8deLRfBxNgYT4Rlpla
         oRZA==
X-Gm-Message-State: ACrzQf2uBgWj1XIkJdsTQo6DKnsQI/wbLckK1yLQpSHTvHbWNJLFdjBX
        bUQ3gZV3WGYzLbHfec/3eTut07iawER6jxA5lDk=
X-Google-Smtp-Source: AMsMyM6vzk7vMFkioI9bgdejXIIQN+OaGxtFssZJ+Yh7sJ8cRox0ioktunoVeE7JVE64PFCnqwPrrQ==
X-Received: by 2002:a05:6a00:158f:b0:546:b777:af17 with SMTP id u15-20020a056a00158f00b00546b777af17mr35552988pfk.51.1664387810335;
        Wed, 28 Sep 2022 10:56:50 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0016bb24f5d19sm4134281plg.209.2022.09.28.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:56:49 -0700 (PDT)
Date:   Thu, 29 Sep 2022 02:56:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzSK3LJst80JkP4q@hyeyoo>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:20:10PM +0200, Vlastimil Babka wrote:
> On 9/28/22 15:48, Joel Fernandes wrote:
> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> > > On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> > > > It's a bug in linux-next, but taking me too long to identify which
> > > > commit is "to blame", so let me throw it over to you without more
> > > > delay: I think __PageMovable() now needs to check !PageSlab().
> 
> When I tried that, the result wasn't really nice:
> 
> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> 
> And what if there's another conflicting page "type" later. Or the debugging
> variant of rcu_head in struct page itself. The __PageMovable() is just too
> fragile.
> 
> > > > I had made a small experimental change somewhere, rebuilt and rebooted,
> > > > was not surprised to crash once swapping and compaction came in,
> > > > but was surprised to find the crash in isolate_movable_page(),
> > > > called by compaction's isolate_migratepages_block().
> > > > 
> > > > page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
> > > > which expects struct movable_operations at page->mapping minus low bits.
> > > > But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
> > > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.
> > > > 
> > > > Over to you! Thanks,
> > > > Hugh
> > > 
> > > Wow, didn't expect this.
> > > Thank you for report!
> > > 
> > > That should be due to commit 65505d1f2338e7
> > > ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
> > > as now rcu_head can use some bits that shares with mapping.
> > > 
> > > Hmm IMO we have two choices...
> > > 
> > > 1. simply drop the commit as it's only for debugging (RCU folks may not like [1])
> > 
> > Yeah definitely don't like this option as patches are out that depend on
> > this (not yet merged though). :-)
> 
> But we'll have to do that for now and postpone to 6.2 I'm afraid as merge
> window for 6.1 is too close to have confidence in any solution that we came
> up this moment.

Agreed.

> 
> > > 2. make __PageMovable() to use true page flag, with approach [2])
> > 
> > What are the drawbacks of making it a true flag?
> 
> Even if we free PageSlab, I'm sure there will be better uses of a free page
> flag than __PageMovable.
> 
> 3. With frozen page allocation
> https://lore.kernel.org/all/20220809171854.3725722-1-willy@infradead.org/
> 
> slab pages will have refcount 0 and compaction will skip them for that
> reason. But it had other unresolved issues with page isolation code IIRC.
>

4. Always align function rcu_free_slab() with 'aligned' attribute
[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-aligned-function-attribute
[2] __aligned in include/linux/compiler_attributes.h
> > thanks,
> > 
> >   - Joel
> > 
> > 
> > 
> > 
> > > [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> > > [2] https://lore.kernel.org/linux-mm/20220919125708.276864-1-42.hyeyoo@gmail.com/
> > > 
> > > Thanks!
> > > 
> > > -- 
> > > Thanks,
> > > Hyeonggon
> 

-- 
Thanks,
Hyeonggon
