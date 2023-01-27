Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451E167E8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjA0Oxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjA0Oxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904E5AA59;
        Fri, 27 Jan 2023 06:53:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ED6BB8212B;
        Fri, 27 Jan 2023 14:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D90C4339E;
        Fri, 27 Jan 2023 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674831206;
        bh=OA5oUiUIv6KiM0qLkfb3qYAR+1endVaDw4wVq2aWiHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ztr5zh0UCUIYINFtlaoVZ/i+iPtyDIfdeTsBzx1eOCce59e1LZY/RCbgpnle34KbB
         NqpsPB2B2xjEli9RC8nfZeXMfFcZDyHoYIcXV9U0GjCauFvzdKmCrsUXM8I92mwqq9
         mZN00Y4MQgk3EjsJrw2pDPzb8akz5CAUfIbCYG3V/SwMUQCv3G1/HbscnOyV2y6tTv
         NqDVW5IxZDBqJYABc5suVKxLyMTzOMb/8vzccu0eN5WDW5B8NJrlfvsl1U7iJHxIsk
         pomCweUJlNdGf+R6PmY2VS53OQccQmYN85YOWelVQPDC+860qSlfhRLknE3GZOIilu
         l+BYXtuGmmBIg==
Received: by mail-oi1-f173.google.com with SMTP id s124so4410221oif.1;
        Fri, 27 Jan 2023 06:53:26 -0800 (PST)
X-Gm-Message-State: AO0yUKUI8Q92gvrEOS9W6CGS0NxEEOx4iPKUB98nwfcTni2BPb7EmZiE
        pl+23e9nrwl3CYr6jQJjqVlnpXJl6IkPHm2ZZgY=
X-Google-Smtp-Source: AK7set9DerPWiHKWio9QjJqHXRap3gaGMN/GiMFHPOK/Pa/YMYfWuZqv/POSWzzbHbk3rotba5pZRm7JRzXToHPZecE=
X-Received: by 2002:aca:b604:0:b0:377:f944:a8b7 with SMTP id
 g4-20020acab604000000b00377f944a8b7mr43775oif.194.1674831205617; Fri, 27 Jan
 2023 06:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20221229074310.906556-1-masahiroy@kernel.org> <20221229074310.906556-2-masahiroy@kernel.org>
 <Y9PQxCTJGTRU1cuE@smile.fi.intel.com> <CAK7LNASJ6j7XEZ-poS+Qq+8nZ5iztLTuTSgkr+fMka7HYH8ekQ@mail.gmail.com>
 <Y9PioQHu2ShZ2veo@smile.fi.intel.com> <Y9PkupqarlpLbdm+@smile.fi.intel.com>
In-Reply-To: <Y9PkupqarlpLbdm+@smile.fi.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 Jan 2023 23:52:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOxXp9WxZUBbWRYeMJ=CXwxSAV60cEMBnxc+qCwu_o0g@mail.gmail.com>
Message-ID: <CAK7LNASOxXp9WxZUBbWRYeMJ=CXwxSAV60cEMBnxc+qCwu_o0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:50 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Jan 27, 2023 at 04:41:37PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 27, 2023 at 11:31:07PM +0900, Masahiro Yamada wrote:
> > > On Fri, Jan 27, 2023 at 10:25 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > >
> > > > On Thu, Dec 29, 2022 at 04:43:10PM +0900, Masahiro Yamada wrote:
> > > > > The top .gitignore comments about how to detect files breaking
> > > > > .gitignore rules, but people rarely care about it.
> > > > >
> > > > > Add a new W=1 warning to detect files that are tracked but ignored by
> > > > > git. If git is not installed or the source tree is not tracked by git
> > > > > at all, this script does not print anything.
> > > > >
> > > > > Running it on v6.2-rc1 detected the following:
> > > >
> > > > Since patch was published there is no sign it was ever meet Linux Next.
> > > > What's the plan?
> > >
> > > Oh?
> >
> > Sorry, my mistake. I need to understand why these patches do not fix
> > the issue I have.
>
> OK, after carefully reading the commit message it's actually the culprit of
> the warnings I have.
>
> So, it seems we need to wait maintainers / developers of the respective code
> to go and fix this. Is it your intention?


Yes.
I expect the 0day bot will block new breakages,
but actually the mainline got more warnings
under kselftest.




-- 
Best Regards
Masahiro Yamada
