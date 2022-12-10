Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B72648F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLJOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:19:01 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C4C1928F;
        Sat, 10 Dec 2022 06:18:55 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2BAEIad7015397;
        Sat, 10 Dec 2022 23:18:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2BAEIad7015397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670681917;
        bh=Ia6V8MS9ZgSY5Cr1WvVb7WzPyY80v7nZsIJI2MaDc3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSbVJZCoh8ho14pq6OSuN9JTLWL0CW17vhcePjMTwHd3P6iK2OBm04j7JEE/W4G1S
         QyoYzHG57p83l7n3C/TsXxJzMDjrzNKsK9IO3g0j1qGKE+86vuSviL44uJygBlmnvl
         ZdUldQIGCkCNYyToZoE3NvJlljI/EOXwOzCZBrMOnKVJmXnqxfRwjx62PRW9GcF0GL
         /RkZY7TVD+pL8oo5akDHRYUSLxiO7W6EMpX/hksUgy5Ajc2Q9RCGlreA9V4gOsvwa+
         llzjLXzTOxHARCRC1ahS+C2vPLSWVbxo5lhfiycU1RHd9kdDx+4wzr7C50ZhW4dWfO
         MnO6VgDZNRSJw==
X-Nifty-SrcIP: [209.85.167.176]
Received: by mail-oi1-f176.google.com with SMTP id e205so7127023oif.11;
        Sat, 10 Dec 2022 06:18:37 -0800 (PST)
X-Gm-Message-State: ANoB5plGvlUCTsuay11rShoOokqp534yHNT/E1jYExdZ3c2pYGrAhlaO
        rTPM+//xsXjCXC5JeYrmJ9dLgZqOseJUOLJBZsw=
X-Google-Smtp-Source: AA0mqf5Fx7wDL8HDtlGCqQfOi0v6DjvgjH/xpRuHrLIVIur+yJvQRvBGMy5L26A/Vx2q5jKAA6wg5bWWSS0TGsKd+B4=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr37452171oib.194.1670681449026; Sat, 10
 Dec 2022 06:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20221126225624.751661-1-masahiroy@kernel.org> <20221126225624.751661-3-masahiroy@kernel.org>
 <20221207154044.2181347-1-alexandr.lobakin@intel.com> <20221207162208.2200189-1-alexandr.lobakin@intel.com>
In-Reply-To: <20221207162208.2200189-1-alexandr.lobakin@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Dec 2022 23:10:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbGaXDRzeByOcJhMX4y-ShA6Qtpcqhr4gNZ5t8vX-PPw@mail.gmail.com>
Message-ID: <CAK7LNAQbGaXDRzeByOcJhMX4y-ShA6Qtpcqhr4gNZ5t8vX-PPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] kbuild: add read-file macro
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 1:25 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Wed, 7 Dec 2022 16:40:44 +0100
>
> > From: Masahiro Yamada <masahiroy@kernel.org>
> > Date: Sun, 27 Nov 2022 07:56:22 +0900
> >
> > > Since GNU Make 4.2, $(file ...) supports the read operater '<', which
> > > is useful to read a file without forking any process. No warning is
> > > shown even if the input file is missing.
>
> [...]
>
> > Great stuff. Used it in my upcoming series to simplify things, works
> > as expected.
> >
> > sed-syms = $(subst $(space),\|,$(foreach file,$(sym-files-y),$(call read-file,$(file))))
> >
> > The only thing that came to my mind while I was implementing the
> > oneliner above: maybe add ability to read multiple files? For now,
> > I used a foreach, could it be somehow incorporated into read-file
> > already?
>
> Oh, nevermind. This one also works:
>
> sed-syms = $(subst $(space),\|,$(call read-file,$(sym-files-y)))
>
> So I believe read-file works for an arbitrary number of files.



Really?


In my understanding, $(call read-file, foo bar) reads a single file "foo bar".
(a space in the file name).






>
> >
> > Besides that:
> >
> > Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>
> [...]
>
> > > --
> > > 2.34.1
> >
> > Thanks,
> > Olek
>
> Thanks!
> Olek



-- 
Best Regards
Masahiro Yamada
