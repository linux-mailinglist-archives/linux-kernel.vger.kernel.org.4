Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB1628F73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiKOBnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKOBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:43:44 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF492BEF;
        Mon, 14 Nov 2022 17:43:43 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2AF1hLAT010861;
        Tue, 15 Nov 2022 10:43:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2AF1hLAT010861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668476601;
        bh=b1x1Kj8P+6WbUE5nJdBuqD7XVOqNhCNqOG+2cE0ljhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LigbXN0aUH/n0hMQ1OYSTIMhlMtvCqMWXBaubm5bNE846Q7sTzctQzizDswHei6mL
         oGAzk301M8F9cOxjm80RkHT4HrFrtBxLBhudXFAFv37Ki2BalGIIwsjXhjBKnTI7MO
         4RRMa227IqRz+GZE7FuBaQwGoIKEa4uFNpFqbqFhbUQ6Ycdja+e9hzVsBJr6LCLYuu
         1vfl3d4L8jEOev5JFG0pFRyIV81XWLhIMn/rz9vHsxqpiArbaRd5U0FLuOlGG8Tc+B
         X7IXodrJYa3W3PusOJcy0XSuOvCjUYt8k2JtnJaq6GolW8ldeYSWKV3y162Y59aJoB
         XwAE1LFXdXuYA==
X-Nifty-SrcIP: [209.85.167.173]
Received: by mail-oi1-f173.google.com with SMTP id m204so13388658oib.6;
        Mon, 14 Nov 2022 17:43:21 -0800 (PST)
X-Gm-Message-State: ANoB5pmzkPQHFUXtKCM+2fRylVbiY3QVga9ftiHAqEWvxggJcEbcpklV
        oE2zd12kfg4uIk7Z1sU3a3Hy8JXkolkRMrReHtU=
X-Google-Smtp-Source: AA0mqf5g7tUc1VTintEbygLYf09320/bprtmEsKJj5znTXkV/pO4PXDzV5S5VI3OuD1tKdbSF+aCHucPpnCwj7tzlAI=
X-Received: by 2002:aca:3b82:0:b0:354:28ae:23b3 with SMTP id
 i124-20020aca3b82000000b0035428ae23b3mr7074481oia.287.1668476600373; Mon, 14
 Nov 2022 17:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20221114181055.214948-1-masahiroy@kernel.org> <Y3KutB2fPCXX2Amn@fjasle.eu>
In-Reply-To: <Y3KutB2fPCXX2Amn@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 10:42:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxf9xq6eAc7__doa4ZniX6W8n0VN0NvyxnvdhsoELt_A@mail.gmail.com>
Message-ID: <CAK7LNARxf9xq6eAc7__doa4ZniX6W8n0VN0NvyxnvdhsoELt_A@mail.gmail.com>
Subject: Re: [PATCH] scripts/jobserver-exec: parse the last --jobserver-auth= option
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 6:11 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Tue, Nov 15, 2022 at 03:10:55AM +0900, Masahiro Yamada wrote:
> > In the GNU Make manual, the section "Sharing Job Slots with GNU make"
> > says:
> >
> >     Be aware that the MAKEFLAGS variable may contain multiple instances
> >     of the --jobserver-auth= option. Only the last instance is relevant.
> >
> > Take the last element of the array, not the first.
> >
> > Link: https://www.gnu.org/software/make/manual/html_node/Job-Slots.html
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/jobserver-exec | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
> > index 8762887a970c..4192855f5b8b 100755
> > --- a/scripts/jobserver-exec
> > +++ b/scripts/jobserver-exec
> > @@ -23,7 +23,9 @@ try:
> >       opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> >
> >       # Parse out R,W file descriptor numbers and set them nonblocking.
> > -     fds = opts[0].split("=", 1)[1]
> > +     # If the MAKEFLAGS variable contains multiple instances of the
> > +     # --jobserver-auth= option, the last one is relevant.
> > +     fds = opts[-1].split("=", 1)[1]
> >       reader, writer = [int(x) for x in fds.split(",", 1)]
> >       # Open a private copy of reader to avoid setting nonblocking
> >       # on an unexpecting process with the same reader fd.
> > --
> > 2.34.1
>
> I think it feels a bit odd to check for '--jobserver' (w/o '-auth'), but
> "fixing" it would require depending on make >= 4.2 (May 2016).  That's probably
> not yet old enough, isn't it?


Right. The option was --jobserver-fds= for Make <= 4.1.
I think requiring Make 4.2 is too early at this moment.






> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>



--
Best Regards
Masahiro Yamada
