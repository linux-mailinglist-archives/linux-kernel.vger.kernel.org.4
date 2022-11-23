Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB5634E81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiKWDu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWDuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:50:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D35C6888
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:50:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so15536385plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgI153kJkkt5PmpyORDszV5rqTG/6f9C6u8V1Iy/cuM=;
        b=a/ujDkNKxsotcLMKHCgcaGcaPXRcjEPlWxyuFltIs/bs65prAVwO6g/P6xYrdZgf8t
         14CpJHEdtLWiJr1mxrUI8kVFYEVNcj/gvoyzYDPGXmXOOZXQ0gM8Au93mPqorjKbfP3I
         5Or0379Nq4RltYk/Diy7Zeh2+GkdD8oPHeOLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgI153kJkkt5PmpyORDszV5rqTG/6f9C6u8V1Iy/cuM=;
        b=ZQuFODj04GCG/wImpUYyLFc1nCNN4xPlENAphX4s5z9olEgX9lRLmkXY0/bmcW2/9y
         iXIqhA/urL+Fpl+2X2XBXEMrLnf7l7pkAQSOiK9DzzBdW+z+vRF4Q9+ciAnCiz1hdH8M
         mlOXIfxeLFgjL7Vi5QvmExMNS4ADfdAisLwM3qhHf3DR+4450F1aa+xCAka738QBS8cL
         scW6jMcOyF/j9/sqjmkik0ZlOVwxKIn5rcYPCWR/NswjVLhxTXNagC6H0FWvdlwCDRFP
         LkKWciUGz1yn0Kqu5bAb3DG3mTTSTm0tepNOm9FAxtuhyErphvyPJQmU/qpLY4akfsul
         Qvhw==
X-Gm-Message-State: ANoB5pnsOx0Vs8beUufBPLekql1DbkD4sBR714A/1aYMXc7D+JgFkl0s
        6mgLcuvMdKwtXWrQuyfQq7Bp1A==
X-Google-Smtp-Source: AA0mqf76YsveXXGdWDr/BwQhfOXhvB5dGKgAhOu9zf8EZagpXIasJ4xZKlIK4A/CP8/d/KiW7hiwbQ==
X-Received: by 2002:a17:903:278b:b0:188:4bac:cc97 with SMTP id jw11-20020a170903278b00b001884baccc97mr7007653plb.159.1669175454003;
        Tue, 22 Nov 2022 19:50:54 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:b570:e8d2:6522:6054])
        by smtp.gmail.com with ESMTPSA id a28-20020aa795bc000000b0056beae3dee2sm11811989pfk.145.2022.11.22.19.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 19:50:53 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:50:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y32Yl/Emcw/2a51t@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com>
 <Y30KIbewtg+b5JTq@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y30KIbewtg+b5JTq@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 12:42), Johannes Weiner wrote:
> On Tue, Nov 22, 2022 at 10:52:58AM +0900, Sergey Senozhatsky wrote:
> > On (22/11/18 16:15), Nhat Pham wrote:
> > [..]
> > > @@ -1249,6 +1267,15 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
> > >  	obj_to_location(obj, &page, &obj_idx);
> > >  	zspage = get_zspage(page);
> > > 
> > > +#ifdef CONFIG_ZPOOL
> > > +	/* Move the zspage to front of pool's LRU */
> > > +	if (mm == ZS_MM_WO) {
> > > +		if (!list_empty(&zspage->lru))
> > > +			list_del(&zspage->lru);
> > > +		list_add(&zspage->lru, &pool->lru);
> > > +	}
> > > +#endif
> > 
> > Do we consider pages that were mapped for MM_RO/MM_RW as cold?
> > I wonder why, we use them, so technically they are not exactly
> > "least recently used".
> 
> This is a swap LRU. Per definition there are no ongoing accesses to
> the memory while the page is swapped out that would make it "hot".

Hmm. Not arguing, just trying to understand some things.

There are no accesses to swapped out pages yes, but zspage holds multiple
objects, which are compressed swapped out pages in this particular case.
For example, zspage in class size 176 (bytes) can hold 93 objects per-zspage,
that is 93 compressed swapped out pages. Consider ZS_FULL zspages which
is at the tail of the LRU list. Suppose that we page-faulted 20 times and
read 20 objects from that zspage, IOW zspage has been in use 20 times very
recently, while writeback still considers it to be "not-used" and will
evict it.

So if this works for you then I'm fine. But we probably, like you suggested,
can document a couple of things here - namely why WRITE access to zspage
counts as "zspage is in use" but READ access to the same zspage does not
count as "zspage is in use".
