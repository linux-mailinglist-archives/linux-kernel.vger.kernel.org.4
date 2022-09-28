Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D505EDE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiI1Nsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI1Nsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:48:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3779CCE2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:48:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s18so7930389qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5+THzLJ8qEOkkmZ45Nfy4NnndEMBDTzKKsy7ol7yOEg=;
        b=AWBShZZE9oQ+lspiYowQ9ZZuGsXFGZP1QA5v+RtvySflf9wQ3F0YhBDFZwYaZhfz2t
         NKM5OawoGBBhBg/hicVBDRG/Y7P4NifQGeuUYSWvS1yy5ROO77e/8y0LFCkeQEEj5HZ0
         nj6Fe53cIx/w7+LCoJ0S3lztathnRvzzp5vgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5+THzLJ8qEOkkmZ45Nfy4NnndEMBDTzKKsy7ol7yOEg=;
        b=3hzokWQpAV75Y5u8vW2+IYRXlXTHWGDGgWqSa/dnYMDwpmpwbuNZDZtWhkINrsAxb4
         cC2/1fNM+DKlbVly2JqNeORiV722c+Av1JjgtPYHeIkTOX7jsxznT2IKw38e+/3+9yf9
         w6w+pjbB+So5EZxUaB/bMAhlf5O1oDD84pKHfOjFgNkgtrag9x/tBBmavblZgipcFL+H
         e7uyBDCF5qaJh4zhxR6Eqm3VbPqBdO4QscGRav6/5CkhpXhmn9hwzeJyProVlDm1UaNu
         e22vDJPhmlXRTapCE9M3WXiGrncHSgWzY4IB5LSfYJMDO9CJg7SB3BzdJ+7CT3p0EwZv
         teQA==
X-Gm-Message-State: ACrzQf2B5WVuDLgS/NanopneMO0y38oLtN9Uc9vmzfWyZNEaq9Tiw37T
        b3F6120GaXBrxZG1VgmjCaHH2Shu6HDB8g==
X-Google-Smtp-Source: AMsMyM5IcRvts3wqcV3T3jhxkWTgStdMcnRFfeANZgbdiJ7N6gdTvF3vonaSuxRCvq8eHBhbJt1Btw==
X-Received: by 2002:ac8:7f06:0:b0:35c:f532:3346 with SMTP id f6-20020ac87f06000000b0035cf5323346mr27235970qtk.316.1664372926811;
        Wed, 28 Sep 2022 06:48:46 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id g19-20020a37e213000000b006b949afa980sm2847751qki.56.2022.09.28.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:48:46 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:48:46 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzRQvoVsnJzsauwb@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPgTtFzpKEfwPbK@hyeyoo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> > It's a bug in linux-next, but taking me too long to identify which
> > commit is "to blame", so let me throw it over to you without more
> > delay: I think __PageMovable() now needs to check !PageSlab().
> > 
> > I had made a small experimental change somewhere, rebuilt and rebooted,
> > was not surprised to crash once swapping and compaction came in,
> > but was surprised to find the crash in isolate_movable_page(),
> > called by compaction's isolate_migratepages_block().
> > 
> > page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
> > which expects struct movable_operations at page->mapping minus low bits.
> > But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.
> > 
> > Over to you! Thanks,
> > Hugh
> 
> Wow, didn't expect this.
> Thank you for report!
> 
> That should be due to commit 65505d1f2338e7
> ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
> as now rcu_head can use some bits that shares with mapping.
> 
> Hmm IMO we have two choices...
> 
> 1. simply drop the commit as it's only for debugging (RCU folks may not like [1])

Yeah definitely don't like this option as patches are out that depend on
this (not yet merged though). :-)

> 2. make __PageMovable() to use true page flag, with approach [2])

What are the drawbacks of making it a true flag?

thanks,

 - Joel




> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> [2] https://lore.kernel.org/linux-mm/20220919125708.276864-1-42.hyeyoo@gmail.com/
> 
> Thanks!
> 
> -- 
> Thanks,
> Hyeonggon
