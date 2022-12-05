Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035BA642918
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLENQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiLENQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:42 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42631BE89
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:16:38 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id m4so11004839vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/p1hDW7ZZDwcpl9SouWaIuS+vAB+pZ2gQFNYRUeUUs=;
        b=DlpXt/t3tTdMuZI6iiWADkIbwv1tHDPp333a6ikJcx+rw40UTir9i379/vBSnQ64qZ
         q8/oVbk8QgDontVXlTCGrT14n94z+V6nCrON9jT0+XUCY0gbQeGEbzi2dEWjrQixXWy3
         +I9W6UYMztLGUWirMoxSnjwFqe6vXXvn7GOZ3kEwe584Alk9XEJL8d/SuIZ5CcqZLuHJ
         9GQi76mcpWkjZjREQT2ZWIa7Uik8QlEFfE7jEuZY9DaTHEWOZg/h5lr5EZUsV8OhwwxD
         FRdYLHQiKXAoPZNpuPk9qbizfvB09oGjIl1JbIb6fGaFoPMql1ETPB54fDpok3Jub0mg
         ewkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/p1hDW7ZZDwcpl9SouWaIuS+vAB+pZ2gQFNYRUeUUs=;
        b=FmAwmO5L7Wuh+tjysI9GSo7iQYzsgAqP1W87JU6icmIiOamo+GX7dO4pKnppzB44bG
         eTLcn4QfiP5yk1vlFWHbaFuvpBCF1HLoK1UrqZTskaObctIgmB/spt1uQc0gvErF638b
         /SjRrS/iyQ61Z0O1q6g2zaBlhqKJ15lbNmjPv2gbIDJd/WuhPj7isi5W16EmmOW9O6NW
         c60Lt1HOhb7XCmEL2L3iW2Q2tVYHufzi5YZPF6tgxgykw/OlWwY8qRG1Qu4OzTqI/NwA
         ckLdbMWLyabcKd5EhBrp0esNLd04GW7DV2Lw49Fvn/KASKEnILFLe/vQQc76bfC7YGb1
         9xSg==
X-Gm-Message-State: ANoB5plH5Qn74cx4SY7fINLvy07OTIp439yoExR6GOESJlHmEJQus9AO
        10NmDWqmRQF7ipli9DhcULNeHcLSFw5FXGECV9qEsQ==
X-Google-Smtp-Source: AA0mqf5udK6VHhJT64GdXLx8okLYpi7z+fD8F9Z+74IvXw4xVWh4ZF1gOkXilOTBwD94sXzWtwqWo3kCpDtrCkrDyP0=
X-Received: by 2002:a67:fc4b:0:b0:3b1:298c:45f9 with SMTP id
 p11-20020a67fc4b000000b003b1298c45f9mr4265344vsq.61.1670246197822; Mon, 05
 Dec 2022 05:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20221205123903.159838-1-brgl@bgdev.pl> <Y43rPdus/9INC390@smile.fi.intel.com>
 <Y43rmRW1S8PvMJW4@smile.fi.intel.com>
In-Reply-To: <Y43rmRW1S8PvMJW4@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Dec 2022 14:16:27 +0100
Message-ID: <CAMRc=MchVprffNyue_ATaTr10xLTfRMjDXxK_DxSufNSg6LwzA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 2:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 05, 2022 at 02:59:42PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 05, 2022 at 01:39:01PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Linus Torvalds pointed out that using trylock here is wrong. This iteration
> > > drops it in favor of unconditional locks but keeps all the fixes that came
> > > later.
> > >
> > > I will also not send it for this release but make it part of the updates PR
> > > for v6.2 to give it some time in next.
> > >
> > > v7 -> v8:
> > > - don't use down_read_trylock(), just go straight for a full lock
> >
> > Yep, it was a good wrap-up explanation.
>
> But he also suggested to fold NULL check into call_*_locked(). Any points why
> you decided not to go that way?
>

Yes! Every read(), ioctl() and poll() variant extract a different
structure from file->private_data. I'm afraid we need to keep those in
the callbacks down the stack. I too thought it was a good idea but
that won't work.

Bart
