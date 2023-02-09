Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769F69073F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjBIL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBILZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:25:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14A5D1C2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:19:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so5334301ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nz56ImgJrv1CC3lx6MAOTCnqrbrf9AATvSrQft4alFo=;
        b=bqSJjTGTuxIMIR4TEuGifUiSeNSVXHjZn6T82NW25CPqgM7Ws7Fj6QjXMocmNyF/2f
         n2VKBj746pJRNvKAJ/SD1LtfTaGIKTXD+V9pD79k03qJwWEOU1TtOYPLiwDt9+54lfqb
         E0T4Sn+NaDz0Vnlq5AuhGCSKFSdHHcqjKpDKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nz56ImgJrv1CC3lx6MAOTCnqrbrf9AATvSrQft4alFo=;
        b=Dk2lX2qp/brfWToVWbHmlerdSKbgZgzp3/lZauBig+y0FHYNbDFKMP2Y0rjuh5kQ3a
         atNrkXjjaBT6Pg5qoZUPZ9e3xoOad3C3oN/HgKVm8XmEOGAnI5RHD5Tjf2ChKJefN4jF
         N7kGavGE4mvYQ8x9ZFa2wXtQ/RHm5/D+qe+e+s8Z+LwUAo+OtIYGazWf/aZtVl8r4wr0
         ZCGefNKYj1dO4zx32tQt74KwDomT2hqUWsXJiW6fuguDcohTP4uI6lxHO1Osq5jwIkeg
         S+ev3he6Z0l98Uz0pz0yX6Yh87qnE8pq10rfKYB2JsvvMaEoEztCBcY1PCkRyR603W3q
         qhZQ==
X-Gm-Message-State: AO0yUKXOfMIbIerKHVL2su1flGgBfYAbIeUclkrwcstpdVG9VmaJKQ82
        ySjcMyAgZU3tlkis+Uwxyq1fkRn2zwDATxhfJFKOCg6V1jAh6A==
X-Google-Smtp-Source: AK7set8lh5QP9lwmqrh7PbHYgxC9D3m31I6V/lHZRre+hf+eSv2OnOz60v7CGC5f8+EUqeBIDpAxPCMJuoMiFiWX6sQ=
X-Received: by 2002:a17:906:27c4:b0:888:7a3e:1d7f with SMTP id
 k4-20020a17090627c400b008887a3e1d7fmr411199ejc.12.1675941568493; Thu, 09 Feb
 2023 03:19:28 -0800 (PST)
MIME-Version: 1.0
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de> <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de> <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
 <Y+O+VBSNywC7LKhn@panicking> <87edr02fsc.ffs@tglx>
In-Reply-To: <87edr02fsc.ffs@tglx>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 9 Feb 2023 12:19:17 +0100
Message-ID: <CAOf5uwn1SKBR+pREZy9f-wnQf6Lw3epyHxiX_hjf_pOaiiSDWA@mail.gmail.com>
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time delta
 is zero
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael <michael@mipisi.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Wed, Feb 8, 2023 at 7:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Michael!
>
> On Wed, Feb 08 2023 at 16:23, Michael Trimarchi wrote:
> > On Wed, Sep 04, 2019 at 12:49:21AM +0200, Thomas Gleixner wrote:
> >> On Tue, 3 Sep 2019, Michael wrote:
> >> >
> >> > thank you very much for your patch. Unfortunately currently I can only test it
> >> > with a kernel 4.1.52 but i've tried to patch
> >> > your new logic into my older kernel version.
> >>
> > Is this patch valid on mainline too? because apply it was let rtc
> > working 100% of the time
>
> I wrote that patch against the back then mainline code. No idea if it's
> still applying, but the underlying issue is still the same AFAICT.
>
> It needs some polishing and a proper changelog.
>

Ok, I will try to update it on some mainline kernel in my environment
and test it back. I need
a little information if it's possible. Consider that I have no
experience in this area. I understand how
code was designed in general but the part around the freezer and all
those code you remove, what was the logic behind in the removed code?

Michael

> Thanks,
>
>         tglx
>
>



--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
