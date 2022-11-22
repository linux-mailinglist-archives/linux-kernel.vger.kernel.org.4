Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7E633376
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKVCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKVCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:43:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FB6A693
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:43:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so12302214plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5nZio34a7iO8a+Fk6WwE3Rm4GJSqkWAtcImuxPFRVI=;
        b=T7kae4evFTD4VQsvLzIk4/oUaJ/dj+a6RCKO2C2LZNjWdvLR7CbKHt5pG/SwrfY/rt
         Jqm1mkH/zFV+EWLDhfQcxtYbhXY2Onme/FyKmDFVj6g2AgFpcNwGPFX0Vyhxvhba3cqQ
         PsYa7aIcnfTvwBvj4Qeot+BHNPh/M6AMGIj6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5nZio34a7iO8a+Fk6WwE3Rm4GJSqkWAtcImuxPFRVI=;
        b=SHYeL5pmJR5Q+Pcuc1jS3av6bDy678Ya7M3ntv+LuhMXvUN0cbaU7tnUNekz0CYM0A
         kzkbhqudCETnJjKfvC3fjLbOe62jx8RKSka0SC4pAdbb/3vlXJulJL3HQvRCMIe7sMdB
         Qtpr6GsqCwR2mdKAUnKEa0cj5LiuTDti53zne/kv3iqoLorhu4+pAOIZZjyCXJ4eDEFV
         M27gsMAR7rdPt/IgeYJVqwYVt9Wo48JwV3GAtFoN52+rzgeZQ+zxMAHOzrVleTEmvZUH
         5wQ4w85yZDmM4X6Rb9Tf7CkooIQtq748XSaMyIAKcx+7G6bCSmNOUY6QOtaLdyNeEiBb
         VtFQ==
X-Gm-Message-State: ANoB5pkdvnwO6+pQNcfH28F7dJEAlgBFoxm78X9BItVngsA2/q9fdcfI
        7x0LJudSsncn3ghJ2c1nWXMiJA==
X-Google-Smtp-Source: AA0mqf7asHdpOm0LjzuKd/lWwQdaHLMxAw5CQhjDkTT7/3lG4NHEQ9uROlM11vvl7godqRgRzsWqLw==
X-Received: by 2002:a17:902:7042:b0:186:7fce:5ec9 with SMTP id h2-20020a170902704200b001867fce5ec9mr5765496plt.48.1669085017594;
        Mon, 21 Nov 2022 18:43:37 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709029a0400b001782398648dsm10532350plp.8.2022.11.21.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:43:36 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:43:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-ID: <Y3w3VKm6CBzucSWg@google.com>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
 <20221121175619.f38259bac177de86bd9eb558@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121175619.f38259bac177de86bd9eb558@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/21 17:56), Andrew Morton wrote:
> > zswap_frontswap_load() should be called from preemptible
> > context (we even call mutex_lock() there) and it does not
> > look like we need to do GFP_ATOMIC allocaion for temp
> > buffer there. Use GFP_KERNEL instead.
> > 
> > ...
> >
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1314,7 +1314,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
> >  	}
> >  
> >  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > -		tmp = kmalloc(entry->length, GFP_ATOMIC);
> > +		tmp = kmalloc(entry->length, GFP_KERNEL);
> >  		if (!tmp) {
> >  			ret = -ENOMEM;
> >  			goto freeentry;
> 
> It seems strange to do

It does indeed.

> 	if (! can sleep)
> 		do something which can sleep

Some allocators enter the non-preemptible context in ->map callback and
exit that context in ->unmap. zswap uses async compression and needs to
wait for crypto to finish decompression of the mapped object, which it
cannot do when allocator disables preemption in ->map. So for allocators
that do this zswap allocates a temp buffer, then maps the object, copies
it to that temp buffer and unmaps the objects. So now it can wait for
async crypto because we are in preemptible context and we use the temp
copy of the object.

> or am I misreading the intent of zpool_driver.sleep_mapped?  If so,
> perhaps some explanatory code comments will help.

I can add one. I assume at mm/zpool.c zpool_can_sleep_mapped() would be
the right place.
