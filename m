Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E05B6568
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIMCKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIMCKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:10:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344213DCC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:10:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e68so10389440pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HbIsJbdpklXhNPcLc0RY7lmKO4fvnKXN6Gt2hfkBd9g=;
        b=nJa62AAc/Zix2+vehfKmnxBd7GwSz1F22pdW3BwVQlS/NW7I/NMfw2TQRRwJb1l6tM
         RpkeWRGIYH8CGTeNcv7eYD7+mkxRupi6teJCFazwslbcHY8Oiom2iqkYxtoqUTZMWYxZ
         ni3sx+52rQVmVSt8tA0UDLhYbXDKwSOVaKDSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HbIsJbdpklXhNPcLc0RY7lmKO4fvnKXN6Gt2hfkBd9g=;
        b=P4QynLrhgxWvVX59XHGSGxxM5xj99SgaUHMOnoYjPOqqRa5fX9JZAcp99MeJb+zwfY
         9Bm/YrbxaNDoLAD7tcjy5DzTy1pHpd+vD+asc8VOCvfdrmXiIgjGr+LgwryJI8sYv9v7
         Llsl/7iEu6ckfvSzMhnIOnawfXi58JDCyUe1oQUjM2CPEknoe2DxhFo7sEsYqeHGGCjd
         xpQxHpreUj0Y2xULhL1aFcEnDCnB58hfqkaj+YZEacxGiTgAFO+1xhwB46k5r/k0dZ/y
         t5iVyPmgEZBklKOXqdpqk5FewV09FsoCLFFdUXg1GYGkp5vdzF9bya+yJaDt8SkTGWEi
         iKSg==
X-Gm-Message-State: ACgBeo24dyYNqnnl8A+hS0ockLpZ9G5MvCSJ9Uf+UpJF4bRZ+OSdkjMB
        JdIsixcH5H2nWWlOmwzsX9ou2g==
X-Google-Smtp-Source: AA6agR6PMK9kDio0o6BqLs/G4wBuRYfP6sm2eCpdKZ+8F/kRweE7t1gz66xBA09PfcrMDRLrtOFRUw==
X-Received: by 2002:a05:6a00:15cb:b0:52e:6100:e7a7 with SMTP id o11-20020a056a0015cb00b0052e6100e7a7mr30377748pfu.23.1663035005290;
        Mon, 12 Sep 2022 19:10:05 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:481a:bead:f512:e554])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78f36000000b0052d200c8040sm6350408pfr.211.2022.09.12.19.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 19:10:04 -0700 (PDT)
Date:   Tue, 13 Sep 2022 11:10:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCHv2] zram: do not waste zram_table_entry flags bits
Message-ID: <Yx/meM18N6Ok5FzQ@google.com>
References: <20220912152744.527438-1-senozhatsky@chromium.org>
 <CADyq12z8ijE__cgxdMssoE6Ooz4zdazsZ-TeipLTNqqis2vSzA@mail.gmail.com>
 <Yx/i2nQ/XVG334ag@google.com>
 <CADyq12xxxTWQ3Wz_jfayJA7k6u+20KAqhOSpqBxa3T0Zkr2pQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xxxTWQ3Wz_jfayJA7k6u+20KAqhOSpqBxa3T0Zkr2pQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/12 22:07), Brian Geffon wrote:
> > On (22/09/12 11:39), Brian Geffon wrote:
> > > > zram_table_entry::flags stores object size in the lower bits and
> > > > zram pageflags in the upper bits. However, for some reason, we
> > > > use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> > > > which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> > > > 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> > > > instead.
> > > >
> > > > Also add a BUILD_BUG_ON() to alert us should we run out of bits
> > > > in zram_table_entry::flags.
> > > >
> > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > ---
> > > >  drivers/block/zram/zram_drv.c |  2 ++
> > > >  drivers/block/zram/zram_drv.h | 15 +++++++--------
> > > >  2 files changed, 9 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > index f3948abce2f7..07913bcdb5c2 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -2449,6 +2449,8 @@ static int __init zram_init(void)
> > > >  {
> > > >         int ret;
> > > >
> > > > +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
> > >
> > > Should this be >= BITS_PER_LONG?
> >
> > __NR_ZRAM_PAGEFLAGS == BITS_PER_LONG == 64 (e.g. on 64 bit host)
> > means that the last valid zram pageflag (and __NR_ZRAM_PAGEFLAGS
> > is not a valid pageflag) is __NR_ZRAM_PAGEFLAGS - 1, which is 63
> > and which is a valid BIT() offset for u64.
> >
> > So __NR_ZRAM_PAGEFLAGS == BITS_PER_LONG should be a valid case.
> 
> I apologize, you are correct.

No worries! It's always good to double check.

> Reviewed-by: Brian Geffon <bgeffon@google.com>

Thanks.
