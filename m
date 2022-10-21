Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5333607D19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:59:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C9205E2;
        Fri, 21 Oct 2022 09:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B538FB82CA0;
        Fri, 21 Oct 2022 16:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD09C433D7;
        Fri, 21 Oct 2022 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666371573;
        bh=zXoZSLRo6mqWQl+SqpCeUt7n3oIRJaBB02GCsl97pmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MeulAqGnfa12piC1q/uSWkvw9NL3Xxa/WHR5NjvPhL87bxDnzFp69/bmitWr959WB
         K5lZyg7okV8RxMAk54qR1LbC35T2UEFperAHPqTvBP5Qw+VxcWmCxmXgfcpKc5i3C5
         5BlDGtu3S17VYNYoQejRzLFO0O5P6e/6FcifnCyQmeT6tCz740iwx8e3R7Um0fm7ye
         Fvn6gP9+uDUAOuEyB3FNkPwdMh41Zu9nkxoQxvn2/sEyAUeK+1JDCnVo8zVvnLxYHI
         UkvXp2XrhF2uxyMB+4T1a5u6FChqX4SDdSoCMSe3u2YpvTAfCiEy2naw1VhwH+6ETC
         Pd2MqFNI4Evjw==
Received: by mail-vk1-f181.google.com with SMTP id l8so1466449vko.11;
        Fri, 21 Oct 2022 09:59:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf2rsbMHBaSjjzjLQcpcp0FCKAfJTrNgRPnISl6v86wmSBNW9q46
        eaDMqrdGkbeTNdi89Ut/R7DgTZzSP4Iiap1Lyw==
X-Google-Smtp-Source: AMsMyM7bsRf7NAYJbwdShF/eQg9O/rEcc0Bmc19ET2w4pWsB3bnX0kUtnl1ALuyMiuToFS0ma0pesPnAhqk2kMhcnN4=
X-Received: by 2002:a1f:1442:0:b0:3ab:857c:cd8d with SMTP id
 63-20020a1f1442000000b003ab857ccd8dmr13079994vku.35.1666371572144; Fri, 21
 Oct 2022 09:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221014151302.27641-1-afd@ti.com> <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
 <CAMuHMdV2euzPQL35AqBsyeQTkMbkeFz4rk48wtyX7Hd6Lz5d-g@mail.gmail.com> <f8b2a45e-cb6c-60ec-047e-6934dd4c4e1d@ti.com>
In-Reply-To: <f8b2a45e-cb6c-60ec-047e-6934dd4c4e1d@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Oct 2022 11:59:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0zG9_sthMLKMEWjYzBdSDwjJ1D6SsZr3CDe3w8mKE+g@mail.gmail.com>
Message-ID: <CAL_JsqL0zG9_sthMLKMEWjYzBdSDwjJ1D6SsZr3CDe3w8mKE+g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow DTB overlays to built from .dtso named
 source files
To:     Andrew Davis <afd@ti.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 9:44 AM Andrew Davis <afd@ti.com> wrote:
>
> On 10/21/22 1:52 AM, Geert Uytterhoeven wrote:
> > Hi Rob,
> >
> > On Fri, Oct 21, 2022 at 12:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> >> On Fri, Oct 14, 2022 at 10:13 AM Andrew Davis <afd@ti.com> wrote:
> >>> Currently DTB Overlays (.dtbo) are build from source files with the same
> >>> extension (.dts) as the base DTs (.dtb). This may become confusing and
> >>> even lead to wrong results. For example, a composite DTB (created from a
> >>> base DTB and a set of overlays) might have the same name as one of the
> >>> overlays that create it.
> >>>
> >>> Different files should be generated from differently named sources.
> >>>   .dtb  <-> .dts
> >>>   .dtbo <-> .dtso
> >>>
> >>> We do not remove the ability to compile DTBO files from .dts files here,
> >>> only add a new rule allowing the .dtso file name. The current .dts named
> >>> overlays can be renamed with time. After all have been renamed we can
> >>> remove the other rule.
> >>
> >> There was a patch from Geert converting everything. I'd rather not
> >> support both ways.
> >
> > Actually that was a patch from Frank?
> >
>
> That series looks to have stalled?

Feel free to resurrect it if Frank is not going to.

>
> It won't be easy to convert all the files in one go, especially with series
> in-flight with both names, not sure how we avoid having both extensions for
> at least one cycle. Plus having both allowed lets rename the existing files
> in a more granular/bisectable way.

Fair enough. I'd propose a series adding the build support and
converting the unittest. Then I can provide a branch for arm-soc and
the dts conversions.

Rob
