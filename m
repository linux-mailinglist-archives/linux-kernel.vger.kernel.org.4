Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676162ED2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiKRFXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:23:46 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893420F47
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:23:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so2532675qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmZFCbhZVx+S8fWiQUfSbQ8kLLMjYeNqXadz8uFT4Hk=;
        b=17g+Zcj4QfG+p5I0SLJ4UNDun1EQgDdsGQ2KWzOYSJCjj8nvfRnpRYalsIRmV1Jbza
         f+ra4lkwy06GzolOcfgajV/hxnSYGA8GSs463nLeyVB0nebG6m5jUsXGJ9ftVgRtR7Ah
         FqPDcZ0Okl1der8PXbwjPVSrWV1V+xseFipTEGIeVz64ruDZu6ElmhCYHhq8W8gMRyyU
         h/NHqivdPO8lG0cBCPQTFmrEEP/w7CfLBPgXVk7YIy7tch8u33WCw+YrlIxWSxDUCa5h
         ZPWuveYEDty4H/2bNE0JwlMO+YvHGHPpGeIQIu3/4oGuCpH83c2jUlcLVvP8G12Z2Z//
         JPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmZFCbhZVx+S8fWiQUfSbQ8kLLMjYeNqXadz8uFT4Hk=;
        b=KilOkOXvAWq7tFe4otlPqCeDxQrTviDU/C20ttDuC9WJX2yjP/e8rAojEwtgSDf26I
         G6DDdCnpVQawsWeghraj6P34sLKU9VVFkw/57tPFb7fkHAWIe5QszZtEG2b2igMHZ9et
         Ie4gCDuCN1LRUiJzAo6iiVpUcd+6HtfGKLHjqh7eY8Q5fkDv5rIZp1D5mcvHn2i0OadL
         pzdTtwWg5fRml29DI20O8cQEiLDMmbRXhONDVsfWPkVEYWCEvW8rQm/Ww4zDW0+CofaH
         YCFr4y2LgBhpAFvQibzGeYwIPyL5HeOsUgxVR9F23F023rzOqmu86bumS5mfZPgh26x6
         A8qQ==
X-Gm-Message-State: ANoB5plcNUVOPBgsjvUWYnqa11SGQqCDhhfqcoKctcLU0VtdwCbwLdEM
        Q8n+FZue9k+gqgF33jlCTg4dZw==
X-Google-Smtp-Source: AA0mqf6XM50x/7Fzdl9gUIpGLpZ55FMwfAe9+x2g1UYcFuRqYSdoJvP3v+dLLikTs1vfXEEJiiaepw==
X-Received: by 2002:ac8:740f:0:b0:3a5:2fce:adcb with SMTP id p15-20020ac8740f000000b003a52fceadcbmr5482378qtq.148.1668749024761;
        Thu, 17 Nov 2022 21:23:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm1746548qke.105.2022.11.17.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:23:44 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:24:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3cW92Hb8KpEuuQk@cmpxchg.org>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-6-nphamcs@gmail.com>
 <Y3a6PGDB5ievPYgQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3a6PGDB5ievPYgQ@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:48:28PM -0800, Minchan Kim wrote:
> On Thu, Nov 17, 2022 at 08:38:39AM -0800, Nhat Pham wrote:
> > @@ -449,6 +450,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
> >  	zs_free(pool, handle);
> >  }
> > 
> > +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> > +
> > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> 
>                                                        what pages?

Hm? This is the number of driver pages to clear out. The name matches
the function signature for this callback in struct zpool_driver:

	int (*shrink)(void *pool, unsigned int pages,
				unsigned int *reclaimed);

I agree with the rest of the feedback.

Thanks for taking a look, Minchan!
