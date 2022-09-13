Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B285B6546
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIMByo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIMByl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:54:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72EDDE86
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:54:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so5099790pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pE3z9bD3wrpH25CppWpqm9Q7/WCYzJnth3D82Qxm1v4=;
        b=TwgGk/wDWHjdQyudMHLQ8VmAf25Ydi+vzLWO1bjhdunrnMX38iDLAnzo+e7LJwKYnD
         Ey9AIWwURLkLihWy9U0IRzWGw8Y0VCcgARIRb1PRWUF2LxFe5mSMMC3rFf7ucI6+VcUQ
         Hmtz0KdSopcwaIDVezJv4L6TqGINJzTnhoCUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pE3z9bD3wrpH25CppWpqm9Q7/WCYzJnth3D82Qxm1v4=;
        b=EzUAX/hKqZofHdxiYXaqn8mdXjsExp/gfN646++GoVsb2KxrbQyHl0hTQZ9kBd+H0M
         VWI6Pf9ni9gAry5fqgfoiA4SoJxebV8yVFY5LInDxTU9wZcNqCfrwpbEwF1goyTCTVOK
         AZp3l8ShUo5jxbwuxnja5vloYf2SJj4WlPF3C+mgBL12dhdO3Is34ifqVfKOM7cr2PEH
         P/EBufvvC2Uq1gPneczv+9zL5vqzlBxEq8zs4bn2egGUovM8zsubgUtP7xm92xqDbQon
         SrKDX2PCQNf/hB6CItTf7TgPz5Oi2PL+cxY3vDEdUpRvwXduWeJUehT/nIQr/ye1NBgX
         tI+A==
X-Gm-Message-State: ACgBeo3OkbodqeILhAz+jVI4U2dOQ/QNjp3V9neBx3tOiw7g4jqbLFxS
        gi5WqzH22D2mAdp5B6g30yyEJj4qJwOh7w==
X-Google-Smtp-Source: AA6agR5f8dn7gcyjPhzSjCQEUKUlhpH4GmTaxdK7mM1Nm/sJBrcwdD5XM6C18yend0AUTw2lxN0DUw==
X-Received: by 2002:a63:4a1e:0:b0:438:fa59:c0f3 with SMTP id x30-20020a634a1e000000b00438fa59c0f3mr7043568pga.107.1663034080220;
        Mon, 12 Sep 2022 18:54:40 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:481a:bead:f512:e554])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902710200b00172f4835f60sm6718522pll.189.2022.09.12.18.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 18:54:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 10:54:34 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCHv2] zram: do not waste zram_table_entry flags bits
Message-ID: <Yx/i2nQ/XVG334ag@google.com>
References: <20220912152744.527438-1-senozhatsky@chromium.org>
 <CADyq12z8ijE__cgxdMssoE6Ooz4zdazsZ-TeipLTNqqis2vSzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12z8ijE__cgxdMssoE6Ooz4zdazsZ-TeipLTNqqis2vSzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/12 11:39), Brian Geffon wrote:
> > zram_table_entry::flags stores object size in the lower bits and
> > zram pageflags in the upper bits. However, for some reason, we
> > use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> > which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> > 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> > instead.
> >
> > Also add a BUILD_BUG_ON() to alert us should we run out of bits
> > in zram_table_entry::flags.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/block/zram/zram_drv.c |  2 ++
> >  drivers/block/zram/zram_drv.h | 15 +++++++--------
> >  2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index f3948abce2f7..07913bcdb5c2 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2449,6 +2449,8 @@ static int __init zram_init(void)
> >  {
> >         int ret;
> >
> > +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
> 
> Should this be >= BITS_PER_LONG?

__NR_ZRAM_PAGEFLAGS == BITS_PER_LONG == 64 (e.g. on 64 bit host)
means that the last valid zram pageflag (and __NR_ZRAM_PAGEFLAGS
is not a valid pageflag) is __NR_ZRAM_PAGEFLAGS - 1, which is 63
and which is a valid BIT() offset for u64.

So __NR_ZRAM_PAGEFLAGS == BITS_PER_LONG should be a valid case.
