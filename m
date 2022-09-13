Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77AD5B6564
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIMCIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:08:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7F520B9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:08:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3452214cec6so123070927b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=g0oDvjtBK2VMBJ47PBfid9tISF3aZdmjyN5GalTdGoc=;
        b=H3ix/l4xybalXZ4LUIQ2BcjD1Ln9iwfZZDx2bCgXUfGOstyQXEwriY1lPwo+yLOKoH
         sOGeKqbAenfyvPs2QuGnSYj+4e1ILYo7RMv0z20/2cwY44l754TakT+NGCgGyrBoRAAD
         fMgLSUAIXwcl1zxDMRNnIqwQqR3kXAafFi02epl0BCzhF8m6n6IASf1yaePQcTf1mALQ
         mLnyQ2sxpD231eejfwnghYHdkXSz0EtgpHOSU2zVcGrL8lN7FE2qdOAVjZh7pAvv9MeQ
         Y6Bp/xiAb5T1dt421ivskyURuN0SjyK7UEgPOyJyPc7YOppPyp7ZnxXqQtuPLZwZbfhw
         dwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=g0oDvjtBK2VMBJ47PBfid9tISF3aZdmjyN5GalTdGoc=;
        b=zWxNySwGov2Qzjk5ed48/7i1KrK+kxV0QGY6/9YmVa06UnW9aV/63QFN7THNe/s+4i
         RxLohA3kiWt3s8cx4W9I/UBx7Xd8/RGkgNsO2/yu4wjT8lt52DRGlTpbYCQLmC2AE5V5
         6Dp8pB9LfMnFdMgyPTm3HV5U1dSxgnTK9xaj1wqoxUoTn43MZdilN7L2b5TAcdY/VFVT
         6PlYAnoHN+Mz0Uv5Gld2h08SEPUgoi2gyPjJm4Tc4L8NDL6yUuPSgTlGnJx4PBwqUrX9
         GnSmLIF+Fdd/CXyZcd9NBX0OQYtxzeKIaZGECazc5oOpO8VClwOkjHadWqLoioVYQfTi
         7m2g==
X-Gm-Message-State: ACgBeo0LxsYR6sIrhkXLH+tYp/DlQczWyO1hHHGeRVrs4/SPYWeFIruZ
        VoVeI/7mw9d1ll+6dSNX29GpEllqXjrC+XUN/3fgYduyixGl+A==
X-Google-Smtp-Source: AA6agR6CmjtxBnbAId0YEdeOQdD6gV/7WuXuQJudc6F6AQAIXlEPG8AJiQz8BmcsA2KAm5BJNW/NEGaHUIv+wVu+Mrc=
X-Received: by 2002:a81:47c4:0:b0:341:2cab:a63c with SMTP id
 u187-20020a8147c4000000b003412caba63cmr25194352ywa.58.1663034883870; Mon, 12
 Sep 2022 19:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220912152744.527438-1-senozhatsky@chromium.org>
 <CADyq12z8ijE__cgxdMssoE6Ooz4zdazsZ-TeipLTNqqis2vSzA@mail.gmail.com> <Yx/i2nQ/XVG334ag@google.com>
In-Reply-To: <Yx/i2nQ/XVG334ag@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 12 Sep 2022 22:07:08 -0400
Message-ID: <CADyq12xxxTWQ3Wz_jfayJA7k6u+20KAqhOSpqBxa3T0Zkr2pQg@mail.gmail.com>
Subject: Re: [PATCHv2] zram: do not waste zram_table_entry flags bits
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 9:54 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/12 11:39), Brian Geffon wrote:
> > > zram_table_entry::flags stores object size in the lower bits and
> > > zram pageflags in the upper bits. However, for some reason, we
> > > use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> > > which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> > > 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> > > instead.
> > >
> > > Also add a BUILD_BUG_ON() to alert us should we run out of bits
> > > in zram_table_entry::flags.
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  drivers/block/zram/zram_drv.c |  2 ++
> > >  drivers/block/zram/zram_drv.h | 15 +++++++--------
> > >  2 files changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index f3948abce2f7..07913bcdb5c2 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -2449,6 +2449,8 @@ static int __init zram_init(void)
> > >  {
> > >         int ret;
> > >
> > > +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
> >
> > Should this be >= BITS_PER_LONG?
>
> __NR_ZRAM_PAGEFLAGS == BITS_PER_LONG == 64 (e.g. on 64 bit host)
> means that the last valid zram pageflag (and __NR_ZRAM_PAGEFLAGS
> is not a valid pageflag) is __NR_ZRAM_PAGEFLAGS - 1, which is 63
> and which is a valid BIT() offset for u64.
>
> So __NR_ZRAM_PAGEFLAGS == BITS_PER_LONG should be a valid case.

I apologize, you are correct.

Reviewed-by: Brian Geffon <bgeffon@google.com>
