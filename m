Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869BD61745E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCCoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCCoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:44:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4312AE2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:44:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y4so660051plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj1OXM86++Ax5WK9NQpXE8onmLsfEj10gyUi+TO3JfE=;
        b=ROLVFzyL5oaa51yfOrh3XK/kCTxN0hPymFWPR3PKxJnXkCAX0o6mTw6kJ3TcfIvztf
         G+Z9C5gJr3mVzv8rtbVtGHhvr4Px83/zMQ8VKbOhbEo1+x4vWdAG2CvE1ytt1MJtR/Io
         UoLUAPfhJMtiwLBIwi0KIOH6ZXSixbLexAT9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj1OXM86++Ax5WK9NQpXE8onmLsfEj10gyUi+TO3JfE=;
        b=vhbuWU4AS3HoUCKqZYN3HdZGCdMaEMykAyQ49KHqAVfVHugahJO1EzdCG7GvbJiq/l
         BWggFV04VlryNlvMpKorihfBRycu/95OfuPzh6PE1tYlT01cnmDgdyqgCQ/Ll/0Fo8Ck
         ubAi+35ZElvN5tj7ID1o0qpiiz6LT54/mAz3WoXrm65UPsXEHalPwvw217PjrI3qC+jO
         NW3fEg3xRx8tnJkP3tYHf/rqqyZtoat7Sxo2LVpDGMq2f4kwki3S4CsgPhgaY8LE6K4A
         yqlAhQcYQ+HxPzVX38gW/o6OUPqmpqag/DyjtIH4zbDp/d/gxe9VdSbWVsexNdMDJP24
         FPww==
X-Gm-Message-State: ACrzQf2Cz1g1fCu/ymPPROo509RWp9p2BI1JczvCbHleHakZdtJzJ7Ls
        QsasFaG/i1qIKLm5f9Gpq42mGA==
X-Google-Smtp-Source: AMsMyM7HkYl3D9Gi70kLV6hQTPnEikEh/jsu9Z67wnN9zuwHwNyPp7zjL2gw3L8jRdkl8Nx3hPmDDQ==
X-Received: by 2002:a17:902:7294:b0:187:146c:316f with SMTP id d20-20020a170902729400b00187146c316fmr22170504pll.149.1667443442354;
        Wed, 02 Nov 2022 19:44:02 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id i7-20020aa796e7000000b0056b2e70c2f5sm9103526pfq.25.2022.11.02.19.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:44:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:43:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 3/9] zram: Factor out WB and non-WB zram read functions
Message-ID: <Y2Mq7t+eMpXv2hD/@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-4-senozhatsky@chromium.org>
 <Y2LQ+Wv/3xQmrfmL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LQ+Wv/3xQmrfmL@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/02 13:20), Minchan Kim wrote:
> On Tue, Oct 18, 2022 at 01:55:27PM +0900, Sergey Senozhatsky wrote:
> > We will use non-WB variant in ZRAM page recompression path.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/block/zram/zram_drv.c | 73 ++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index a8ef3c0c3dae..94c62d7ea818 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1314,8 +1314,30 @@ static void zram_free_page(struct zram *zram, size_t index)
> >  		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
> >  }
> >  
> > -static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> > -				struct bio *bio, bool partial_io)
> > +/*
> > + * Reads a page from the writeback devices. Corresponding ZRAM slot
> > + * should be unlocked.
> > + */
> > +static int zram_read_from_writeback(struct zram *zram, struct page *page,
> 
> How about zram_read_from_bdev?

As far as I can see, we already have that one, so that name is already taken.

We have read_from_bdev, read_from_bdev_sync, read_from_bdev_async, and
probably some more.
