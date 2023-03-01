Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9C6A7804
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCAXxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAXxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:53:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BA2107
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:53:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a9so5658844plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677714798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UxHdhijEmH2EyOtzBINRHdLM65Pg4RR1uX5oWHJrGs=;
        b=iPAqlLP8wwKKO1WdZ9KFnFOEEXb3jqCD4xiFYMj8I5h7L2FZJFLV7XbQtWKWi0wZfP
         k/ypbOQ8iABno+EV3MAX0pkXD23QER5kEgGQYCZHeMDKxWhflUNZ9haRkBXqGvn1IigX
         DA8ipR0sGVFIlzUHEJiLhF+fcb6FtbqO3aZudsc7UXrMgeTb2V7PlwBXE38R4R68Dg88
         CpMrqZ0bt5NSTvo1UQnuH5Do+9VHosSKNcDVOFB7nhRQsEXgqVl18Vez8Q9mRryQZv6N
         2b2He5XXnDzDmZMCtLbH7py5tdRx51pi8rRl7+wT+eQpfxzSsAKoXFjRSdh/bXOhFJcW
         tiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UxHdhijEmH2EyOtzBINRHdLM65Pg4RR1uX5oWHJrGs=;
        b=AqaEpTt4aHndfKj7EW5PIwCGmOm9gjrBzhUb02v4YrJYIPUvmMyyruAe9ozQSYqgk/
         MDJSzga4uIpyTw6PXSshy6gvIbz3iLQMoFRvwzT2q4AjhPKo6S6DeB3M19wk/Rg3mCh8
         1x8QEVIhrZibtwYRYbH7YcpLEazx0wFFezYByoynbMTrUmDQ+HsLvEBV0r2pcs1z4Ebs
         8f5HdKzuCh8qeArj6uWpEWLqCTVxCYBhBwQOK3LEtzis/0rILAHx3zUjcI+gBcgnrEOO
         JT2V+i3xhk+dluJd7KJaubhGgjtFIzTvYIYJoW7raven6dFSMbbaNGhm875ncr1U5Pb6
         Evvw==
X-Gm-Message-State: AO0yUKWG58ADyQsNekHLSVVnvnXNdfctFsyUn9+6VccAa7iDE79ra8X9
        QJ6DeV4AxrEOR1v4Y6h8KSIzbS2okmd1IrUV3+FL/g==
X-Google-Smtp-Source: AK7set8OEP8qZ1fXhp8dBKMmkZESQT0zLW4ve3iPhJpUSUr5plbBBdGZeGBMNl9ORkTSS3FmOLJAAq3lrDXAhUnoAo0=
X-Received: by 2002:a17:903:2601:b0:19a:fdca:e3e9 with SMTP id
 jd1-20020a170903260100b0019afdcae3e9mr3055313plb.10.1677714798260; Wed, 01
 Mar 2023 15:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20230301012506.1401883-1-saravanak@google.com>
 <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org> <7cca9a24b24d849565cd6a4f40ddbee9.sboyd@kernel.org>
 <CAGETcx82r-YC7cBUY5xa57FCEOUP_BeGNp2zURG=HUJkUMSVPA@mail.gmail.com> <a3bde7aa1793c20638cbf2749f3209a2.sboyd@kernel.org>
In-Reply-To: <a3bde7aa1793c20638cbf2749f3209a2.sboyd@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Mar 2023 15:52:41 -0800
Message-ID: <CAGETcx8w=Fi3QSw7+i6QoNeKF03O8seL+urhZBGZuodhUGgL7g@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE* macros
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 2:45=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Saravana Kannan (2023-03-01 13:25:13)
> > On Wed, Mar 1, 2023 at 12:48=E2=80=AFPM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > Quoting Stephen Boyd (2023-03-01 12:40:03)
> > > > Quoting Saravana Kannan (2023-02-28 17:25:06)
> > > > > The CLK_OF_DECLARE macros sometimes prevent the creation of struc=
t
> > > > > devices for the device node being handled. It does this by
> > > > > setting/clearing OF_POPULATED flag. This can block the probing of=
 some
> > > > > devices because fw_devlink will block the consumers of this node =
till a
> > > > > struct device is created and probed.
> > > >
> > > > Why can't you use CLK_OF_DECLARE_DRIVER()?
> > >
> > > Ah I misunderstood. CLK_OF_DECLARE() _always_ prevents the creation o=
f a
> > > struct device for the device node being handled. The 'sometimes' thre=
w
> > > me off.
> >
> > The "sometimes" is because dependending on the macro we go back and
> > clear the flag.
>
> Ok. Maybe instead of this paragraph you can explain the problem being
> fixed, specifically ux500 container node not being marked as
> "initialized" and that preventing consumer devices from probing. That
> would help the reviewer understand the specific problem you're solving.

Ack

>
> >
> > > >
> > > > >
> > > > > Set the appropriate fwnode flags when these device nodes are init=
ialized
> > > > > by the clock framework and when OF_POPULATED flag is set/cleared.=
 This
> > > > > will allow fw_devlink to handle the dependencies correctly.
>
> This is the "what" and not the "why".
>
> > >
> > > How is this different from commit 3c9ea42802a1 ("clk: Mark fwnodes wh=
en
> > > their clock provider is added/removed")? Do you have some user of
> > > CLK_OF_DECLARE() that isn't registering an OF clk provider?
> >
> > So it looks like drivers don't always register the same node used for
> > CLK_OF_DECLARE() as the clock provider. So, this is covering for the
> > case when that's not true.
>
> Please add this information to the commit text. Otherwise the patch
> looks entirely unnecessary.

Ack.

> If the node used for CLK_OF_DECLARE() isn't the same as the node as the
> clock provider then how are we certain that the CLK_OF_DECLARE() probe
> function has actually registered a clk provider?

Whether it's registered or not, we can't wait for a struct device to
be created for it. That's what the flag is about. device link can't
work without devices.

> Should we simply remove the calls to fwnode_dev_initialized() in the OF
> clk provider functions

Not all clock providers are going through CLK_OF_DECLARE(). There are
so many ways to register a clock provider. So it's good to cover all
those cases and leave those existing calls in.

> and put the call in CLK_OF_DECLARE() (and
> specifically _not_ CLK_OF_DECLARE_DRIVER) as this patch does?

Between the time the clk provider is initialized and a new struct
device being created, we still don't want to block consumers from
probing because they might be dependent on the already registered
early clocks. So, we should set the flag in the DRIVER case too. And
then we clear it once it has been initialized because we allow the
struct device to be populated and it's okay to wait for those.

> What about
> bindings that are registering clks early with CLK_OF_DECLARE_DRIVER()
> and then probing something like a reset controller later with a platform
> device created by an MFD matching the same compatible as the
> CLK_OF_DECLARE_DRIVER() compatible?

I think I answered it above?

-Saravana
