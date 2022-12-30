Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF3659BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiL3Tc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiL3TcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:32:24 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FE518681;
        Fri, 30 Dec 2022 11:32:23 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id g2so8607436ila.4;
        Fri, 30 Dec 2022 11:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9r/q/xkBcl0YbFZSmKypcL8QeNyZepAafv2DtpMqb5s=;
        b=FiDXi7hByRZPfV2KkM11mjsC0haaEtUG6e7odLmujLd2degXFFw7cbNnB5itVZDD5g
         5fJ+UluB+9jmxHjiKJWGMeKt3e6OEynPMfT4BkQYCKFnSzp/2Me8TbIRTqLC0MtXMT2z
         ZwamOyEZt+lmd6NxZ33dnZj+bJehVS23H+WHadREhd5E0QUTZxF/sbt+4JFF9MR1lRG3
         Tw0ceLlcp+v2ESq4AW8cWslr3hwPsNrelawegeK7n2159wUJq0gMfaNc/CwQR0kFiVu/
         o0BC5aSJDF/M5Zj6jNxGc6yCJQgsDkrJ9CdDNUb1Y6r4fl4YDvD4fmclpaKkl4U126RB
         kuZQ==
X-Gm-Message-State: AFqh2kq4+vleJO7Q8xeREfuwvicuCtfE4QyNrvqznQTerdhwWPQ2CPt9
        +wJDcT565jWmm9u0n+YwuwbbeUH4ryrY4ufv0Ks=
X-Google-Smtp-Source: AMrXdXuvZXHCRfN+sFbMNrkj8auqZQHs6XvQS2NuD/aHO16WbssK61ObmwU78/2QfW/Rv4aLYzji/zJZOlkALCgr5i0=
X-Received: by 2002:a92:d481:0:b0:30c:35b3:fa02 with SMTP id
 p1-20020a92d481000000b0030c35b3fa02mr166613ilg.145.1672428742400; Fri, 30 Dec
 2022 11:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
 <20221229125957.45923-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0j3Dv5DJh4oN+i2qXi=zU8PhGeMsUY2v-mZU5tKJWmsxg@mail.gmail.com> <CAHp75Vdca1bMJeJwrOK5fOp8+TnJYwus3z6PyYyvhg+LDgyufg@mail.gmail.com>
In-Reply-To: <CAHp75Vdca1bMJeJwrOK5fOp8+TnJYwus3z6PyYyvhg+LDgyufg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 20:32:10 +0100
Message-ID: <CAJZ5v0jeZ1VmJCXS306_ebtR5Rhuh2q-Ha6fBX7uuLjB-ex4Fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 8:23 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Dec 30, 2022 at 8:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Dec 29, 2022 at 1:59 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > There are a few drivers and might be more in the future that
> > > open code the functionality of proposed DEFINE_NOIRQ_DEV_PM_OPS()
> > > helper. From now on they may switch to the new helper and save
> > > a few lines of code.
>
> ...
>
> > > +#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > > +const struct dev_pm_ops name = { \
> > > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> > > +}
> >
> > There is NOIRQ_SYSTEM_SLEEP_PM_OPS(), so why is the above needed in addition?
>
> It defines the constant object of struct dev_pm_ops type with this
> included and as the commit message says, allows to save a few lines of
> code in each of the drivers that uses NOIRQ_SYSTEM_SLEEP_PM_OPS()
> currently. The examples on how to convert are provided in the patches
> 2 and 3.

So this is in analogy with _DEFINE_DEV_PM_OPS(), isn't it?  It would
be good to mention this in the changelog.

IMO the changelog is rather hard to follow in general and it should
not refer to the changes made in order to understand what's going on.
