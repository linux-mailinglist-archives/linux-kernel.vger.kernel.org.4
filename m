Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85E658958
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 05:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiL2EMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 23:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL2EMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 23:12:49 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B863D2;
        Wed, 28 Dec 2022 20:12:46 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2BT4CGLH018286;
        Thu, 29 Dec 2022 13:12:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2BT4CGLH018286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672287137;
        bh=qxiKtMuteKtSBzs+qooCHtOukrG1B0yPj6uAYBjgXSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kWjJb9J1y37Gn2uGZE5q2DW9Sd+NBav3lKqGLAQNOMupiX0dV61TrKn0Y8MFk1UDM
         xu9nH8KHaMsXNlbfqshHE8uIVIxqutKTyTu31necSMBBj4cs4RNV6hXwtaiv3DCD/0
         EO7xd74R6pwxIhOMiFWDDvKPCAmOyAlDD4SdoYb086clYy90uCD0HCAhjVswFxHzfb
         /2aZHXocBzXxpRYME+rnJhKsYTtFesVeZJLIuyLtDbSq6Fd6Uds+4+nBH2GfQ9BafD
         f3jYYmHyiA2GOjG950I/Jk5O12sEyv0DUtaiELhq7MkeUvEyaQiMNlvwbXMmcC006K
         nTuVaq4S0u0nQ==
X-Nifty-SrcIP: [209.85.210.41]
Received: by mail-ot1-f41.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso10920722otn.2;
        Wed, 28 Dec 2022 20:12:17 -0800 (PST)
X-Gm-Message-State: AFqh2kpvNtFim2K7XENfNJsmUsK7M/W1+CnL7n/yVTkk9OO9JVaxLaUh
        z2raTHzA1TMaige/NNXCgzGD3MtZlfQmzwLekZY=
X-Google-Smtp-Source: AMrXdXsmjSEkzHVjHqFjmTJJTxkjOuNz2vBEH1IpG1Q+o00MsoPfTsCUTinJsA5NB1lgt3ZM9DK96qjKbpnHzEErLd0=
X-Received: by 2002:a9d:128c:0:b0:66c:794e:f8c6 with SMTP id
 g12-20020a9d128c000000b0066c794ef8c6mr1752922otg.343.1672287136276; Wed, 28
 Dec 2022 20:12:16 -0800 (PST)
MIME-Version: 1.0
References: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
 <Y6mkdYQYmjUz7bqV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y6mkdYQYmjUz7bqV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 13:11:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGehTh0M0yzqvqA435jtKzRUJpyhJurU92JGcMeRRdew@mail.gmail.com>
Message-ID: <CAK7LNASGehTh0M0yzqvqA435jtKzRUJpyhJurU92JGcMeRRdew@mail.gmail.com>
Subject: Re: [PATCH next v2] kbuild: add ability to make source rpm buildable
 using koji
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jonathan Toppins <jtoppins@redhat.com>,
        linux-kbuild@vger.kernel.org, dzickus@redhat.com,
        ihuguet@redhat.com, ivecera@redhat.com, jtornosm@redhat.com,
        kheib@redhat.com, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 10:41 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Nov 21, 2022 at 09:48:45AM -0500, Jonathan Toppins wrote:
>
> Hi Jonathan, Ivan et al,
>
> This patch causes a regression on 6.2-rc1 when rpm-pkg target
> is specified on non-rpm system (i.e s390 running Ubuntu). The
> offending chunk is:
>
> > @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
> >       URL: https://www.kernel.org
> >  $S   Source: kernel-$__KERNELRELEASE.tar.gz
> >       Provides: $PROVIDES
> > +$S   BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> > +$S   BuildRequires: gcc make openssl openssl-devel perl python3 rsync
> > +
> >       # $UTS_MACHINE as a fallback of _arch in case
> >       # /usr/lib/rpm/platform/*/macros was not included.
> >       %define _arch %{?_arch:$UTS_MACHINE}



$ make RPMOPTS=--nodeps rpm-pkg

works for me.


FWIW:
https://lore.kernel.org/lkml/20221228191014.659746-1-masahiroy@kernel.org/




-- 
Best Regards
Masahiro Yamada
