Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79F6342B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiKVRnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiKVRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:43:03 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3E65E5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:42:59 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x21so10810606qkj.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iA1K0/PLRcTpu9Um4AiiDo04fVuw2D9+eEQ49osbP6o=;
        b=vc8r77vyiXRvXUe3+AMRnVLgLCIsC4OsOCDWe3rCJW2IVov4V4YZPGLmd48QdrXls1
         +lNRSeViZJLZClfY7dfx6ak8ATT5c8nlzBkZJNsBryGK2xvTCa2gqYjA3BbAcdvhm3R5
         iAuDWUKnYS5KpJeBvSFZ1nKl8dYRGDCophtaB9dbUX3o89mSzuXJPCDrAwdc53E8jBtl
         8IvsomWz2tBsh6QLtkrhz9eXat/HJSGMkuwuPIkW4yNYrlclY79TqbsXEh2TKU5Fc3wV
         wQ9g5on0TVTynx4RuL588OgF7ESmBstmn8LlE13TK0iRXM7ApqZ7958SLvbivW2B1ifO
         gJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA1K0/PLRcTpu9Um4AiiDo04fVuw2D9+eEQ49osbP6o=;
        b=B96sMbwEuLH+mltFfR7lN7GMDdtklkAsuUZ3+iCYTL6SwK19/zZrvk+yGy7VHO1fP6
         wZgoa4yMgh7czkfFAguKZs8iR+v0qTjMIVCUambZ2aI1EC1WvFqEoE3vIG+bO/9+F+AW
         YnJLvsAaXAYTZfENyQd+6pu6w3mug7aM7iNzoDnzGzyrszy5UuzDbl1a0wSbNkzxuyos
         1Y3fIyyCKFrvzcxiiLLc06lnS2gmTcUqA9Xs96u2JKbEEblvf13RGs56d1E/SA+2w1LU
         +IWsS2UvoxmgZHksvAhTqwgyps/0Gc9aWT2S7Z+bBdIra6uYqlslZHpyAdkzkT6nMlia
         +LpA==
X-Gm-Message-State: ANoB5pl0pSZaFwZrNkrudhZmw7vcxIa/n6N4VP0CWjICP082qRjWsUZH
        ENeCeUc0HSLTLX8XMQn1tJYWhw==
X-Google-Smtp-Source: AA0mqf4963YDFZa7gZBl28D+fFDc0NIsi2mlp4Nkg2Zwd7mQGPC9mZ/14k+YxaRjg7YMrx8hwMCsDg==
X-Received: by 2002:a37:a53:0:b0:6e2:285e:92ea with SMTP id 80-20020a370a53000000b006e2285e92eamr7904620qkk.213.1669138978997;
        Tue, 22 Nov 2022 09:42:58 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id q25-20020a05620a2a5900b006ee7923c187sm10660795qkp.42.2022.11.22.09.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:42:58 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:42:57 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y30KIbewtg+b5JTq@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3wreqR1IRWFtSUz@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:52:58AM +0900, Sergey Senozhatsky wrote:
> On (22/11/18 16:15), Nhat Pham wrote:
> [..]
> > @@ -1249,6 +1267,15 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
> >  	obj_to_location(obj, &page, &obj_idx);
> >  	zspage = get_zspage(page);
> > 
> > +#ifdef CONFIG_ZPOOL
> > +	/* Move the zspage to front of pool's LRU */
> > +	if (mm == ZS_MM_WO) {
> > +		if (!list_empty(&zspage->lru))
> > +			list_del(&zspage->lru);
> > +		list_add(&zspage->lru, &pool->lru);
> > +	}
> > +#endif
> 
> Do we consider pages that were mapped for MM_RO/MM_RW as cold?
> I wonder why, we use them, so technically they are not exactly
> "least recently used".

This is a swap LRU. Per definition there are no ongoing accesses to
the memory while the page is swapped out that would make it "hot". A
new entry is hot, then ages to the tail until it gets either written
back or swaps back in. Because of that, the zswap backends have
traditionally had the lru-add in the allocation function (zs_malloc,
zbud_alloc, z3fold_alloc).

Minchan insisted we move it here for zsmalloc, since 'update lru on
data access' is more generic. Unfortunately, one of the data accesses
is when we write the swap entry to disk - during reclaim when the page
is isolated from the LRU! Obviously we MUST NOT put it back on the LRU
mid-reclaim.

So now we have very generic LRU code, and exactly one usecase that
needs exceptions from the generic behavior.

The code is raising questions, not surprisingly. We can add a lengthy
comment to it - a variant of the above text?

My vote would still be to just move it back to zs_malloc, where it
makes sense, is easier to explain, and matches the other backends.
