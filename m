Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D2616FED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKBVgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKBVgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:36:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D505FC4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:36:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so17592913pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKw2P6UvmMu2vjX4KDQmeFO6vjvnVhZMd6SDmZt4f5w=;
        b=Amp8eBSEFOnxWYUEJw3lwnBr0H4J+V+Ktl/ifZ1j5+9FlVKbB3hL6yk9K75iqRXObm
         9A0WIZvUfWbuMFwPMkvlPC8g07/50NZ2hgOGSFr1A8IZ2dguk9N/SXwynHUiJ0Na5Jbl
         /HWcVguPRYGffIYdtzKx7Re6oeq5EdTpCfJoyOYuv/DlYF6JdxaHbvc3tm30Y6dHwSz2
         UIqtUuhrXYqHkuRHGx3tCgIRTWlwpU92ilFIks0HeaH5ki5Pf7k8bPeumyU26BUn7V01
         HyntI7TzuCLDmUo1sE1ew5cgOCV3s452DdQxy4R1rnnKUMXFMv0U7fAdq4Pk4yvGdhq9
         Am8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKw2P6UvmMu2vjX4KDQmeFO6vjvnVhZMd6SDmZt4f5w=;
        b=fSXW01W2ed/2Nc1+FVzAoI7ZxclyVE4B3c3Vywaxz93/SqWQTLjG9DTGbN0Dw1zf8x
         NfDEoX0brDqqxDxuKJp1HMMNK5veip43JjZUON2+j1+qLCag5PlGk4e1ibUXaFLWtB5I
         JBD8EJWLDSVEaO5Fl7qkqhwR+jjCUQzuZGNnPkaDELpM6r9Ul+IIUe0vxy5NLgNei9Ru
         4UlrVsStiFYymdNcFsEG7F1Zi4lXL79a/Q7DLecz6FZzZFo7cZdutVitVWKu9750JQAf
         yP7jy3mSANXLYFisu7gzmWv2X6W1oRYpv13XLBBCx8/G6f2Y0nmqVjawMn0XhVSzPPbQ
         YcMw==
X-Gm-Message-State: ACrzQf3OB0bQ9KQIduylacyS1aA1VieG6Hl06nZBXPP5ZQZkFuyB971X
        J8pNMFuNALrtY7psETba/y0=
X-Google-Smtp-Source: AMsMyM5pHxM+bf37MEAFg0SHbURDsbZb8oxpyU6WG6neLvc25BiT98XK6PQK5WtsJYbsOX5PHwrzow==
X-Received: by 2002:a05:6a00:14cf:b0:56d:88a8:32cf with SMTP id w15-20020a056a0014cf00b0056d88a832cfmr16113935pfu.27.1667424998306;
        Wed, 02 Nov 2022 14:36:38 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902b59100b00186b549cdc2sm8742837pls.157.2022.11.02.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:36:37 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 14:36:35 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2Li412OGB6g8ARA@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Hj+H4VzlN/fcmR@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:28:56PM +0900, Sergey Senozhatsky wrote:
> On (22/10/26 13:06), Nhat Pham wrote:
> >  struct size_class {
> > -	spinlock_t lock;
> >  	struct list_head fullness_list[NR_ZS_FULLNESS];
> >  	/*
> >  	 * Size of objects stored in this class. Must be multiple
> > @@ -247,8 +245,7 @@ struct zs_pool {
> >  #ifdef CONFIG_COMPACTION
> >  	struct work_struct free_work;
> >  #endif
> > -	/* protect page/zspage migration */
> > -	rwlock_t migrate_lock;
> > +	spinlock_t lock;
> >  };
> 
> I'm not in love with this, to be honest. One big pool lock instead
> of 255 per-class locks doesn't look attractive, as one big pool lock
> is going to be hammered quite a lot when zram is used, e.g. as a regular
> block device with a file system and is under heavy parallel writes/reads.
> 
I agree with Sergey.

I am also worry about that LRU stuff should be part of allocator
instead of higher level.
