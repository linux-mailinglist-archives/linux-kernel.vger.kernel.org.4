Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B076AC01C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCFNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCFNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:01:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB52CC77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:00:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1921EB80E12
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20D7C4339B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107649;
        bh=FR9LK/FP4yvvDZiywDp6V/exeASxzzoZTFmOcIwSeiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jTY9tL/ibSVrYGppxlmU/dDfEPLZY/0IWLIghhXMrNnAniSRlOHDbBwWj+pxw313N
         m0ayoR1E8AJyZisnyZ/6U4kvbIo9OlUHvmQi1MOzE29XHTOQNFn3QQfohb8/+tMcms
         eZ01LjOIBvHRMbjQ9b7raGf39pHKPmwsMrGYuhF0NJBobicU8nc2iTpJOqNe2gpQlU
         eT21v8TH7sW0X7RX6FLMuGXHOAVkqYc+HoYNMPTRKShO4ueWG9wsJISMIId6GCrT9f
         zRqRDYTs+yMttk25fKwQbjyyTf75NlnMp5b62KsTPMmDBgizWDw7NwdY/cEL9rFHQA
         tmxdT0/3/wcjQ==
Received: by mail-lj1-f181.google.com with SMTP id h9so9534514ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:00:49 -0800 (PST)
X-Gm-Message-State: AO0yUKVlbtn6p6NoTqZne+DwLDLnnTAOiS33LePSxaOopqvB/QU3ial6
        e7AZVye5ts1NuaEzHZPYSY7cT0roV8nQl4B5ks0=
X-Google-Smtp-Source: AK7set+wbDFf+WwDxQQ6bFr3XpFIGU8j1NncOoc1eUk7rNo2LDtS1mTTZu+iIUgGEBSdB7CAmJLHcIaYFFttJVcm6Jg=
X-Received: by 2002:a2e:b988:0:b0:295:b80a:a953 with SMTP id
 p8-20020a2eb988000000b00295b80aa953mr3111489ljp.2.1678107647856; Mon, 06 Mar
 2023 05:00:47 -0800 (PST)
MIME-Version: 1.0
References: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
 <CGME20230306061057epcas1p17def087649be56b75c7830385ff2fb2f@epcas1p1.samsung.com>
 <1678081915-12599-2-git-send-email-js07.lee@samsung.com> <ZAXKHDb4QY1awyRA@shell.armlinux.org.uk>
 <076401d95025$305fb150$911f13f0$@samsung.com> <ZAXcdDBiQ9JVo4pY@shell.armlinux.org.uk>
In-Reply-To: <ZAXcdDBiQ9JVo4pY@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Mar 2023 14:00:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFESOz-M-93yRDE0LgbDiuFWy20NCwxFdeh75Mmqc1pSg@mail.gmail.com>
Message-ID: <CAMj1kXFESOz-M-93yRDE0LgbDiuFWy20NCwxFdeh75Mmqc1pSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in /proc/iomem
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jungseung Lee <js07.lee@samsung.com>, linus.walleij@linaro.org,
        amit.kachhap@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        js07.lee@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 13:28, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 06, 2023 at 09:14:23PM +0900, Jungseung Lee wrote:
> > Hi, Russell
> >
> > > -----Original Message-----
> > > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > > Sent: Monday, March 6, 2023 8:10 PM
> > > To: Jungseung Lee <js07.lee@samsung.com>
> > > Cc: linus.walleij@linaro.org; amit.kachhap@arm.com; ardb@kernel.org;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > keescook@chromium.org; js07.lee@gmail.com
> > > Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in
> > > /proc/iomem
> > >
> > > On Mon, Mar 06, 2023 at 02:51:55PM +0900, Jungseung Lee wrote:
> > > >  The resource reservations in /proc/iomem made for the kernel image
> > > > did  not reflect the gaps between text, rodata, and data.
> > > >  Add the "rodata" resource and update the start/end calculations.
> > > >
> > > >  Before :
> > > > 04000000-2f7fffff : System RAM
> > > >   04100000-04cfffff : Kernel code
> > > >   04e00000-05369a27 : Kernel data
> > > >
> > > >  After :
> > > > 04000000-2f7fffff : System RAM
> > > >   04100000-049fffff : Kernel code
> > > >   04a00000-04cb2fff : Kernel rodata
> > > >   04e00000-05369a27 : Kernel data
> > >
> > > NAK. This is API, and programs do read and parse this file. It is
> > > important that this file reports these parameters in a similar way to
> > > other architectures. Other architectures do not split up the
> > > individual regions.
> > >
> >
> > Sounds like an important point, but I failed to find which programs use it
> > as an API. Could you tell me which program uses it as an API?
> >
> > In fact, x86 architecture also split up the individual regions in this way.
> > In addition, most architectures separate the "Kernel bss" area, but arm does
> > not.
>
> Take a look at kexec-tools - that certainly does parse /proc/iomem
> looking for entries such as "Kernel code" and "Kernel data".
>
> It's fine for an architecture to decide to do something else if it
> started to do it early on, but not when something has been established
> for decades.
>

Agree with Russell here.

It would be helpful if you could explain why you think this needs to be changed.
