Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62E6867FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBAOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBAOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:08:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5A49564
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:08:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a184so12680697pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8ihYsabv6FaCkZlvJjrpqfzbw0j+BAuZu4TGOzb3Wc=;
        b=wZr8IXRvFmr1P4okOUsClwu3fvZSrYNl5laSrqV6rhDYXsSFpVJn3aenwvoDtDCMsF
         78aRNpZc7o+Yrk0DTrq3exRArljuq6Bp6eVYQxzoA1/gSFLweevRETG1H3cfaVAT2uyi
         kjqMZSHC5em6IFqDMUIon+3uSzbinAn4/+WTonJdTQHoA4BtwtVQp+gqnN5ifiLjHT2S
         ow4/Px4dY0IQa+SYKjrM2NRv9BvI8Pj9Sn860sozPwgmX4GHk2NYziG+wFWmhyliAtYM
         zc5lwiEJJxt6NehLue8vhjnS1bTjYcHLn5aO2HRlcMCPC6h+VjHcPZOpxBaNU1Gmk7Mn
         7l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8ihYsabv6FaCkZlvJjrpqfzbw0j+BAuZu4TGOzb3Wc=;
        b=0pR6ZmMHnVCmN46tg0FQpE8LLj4yhsCPn2jSOz0prCMROJC4qbwj8ard+t1VUIU2G2
         FPsAk1JSv+xXpTVzOi9hdQWBHvlNQ4LUIlKrULj2hjYV4QSnTWS49ph+HnmbW4UzkeMm
         N7O8dGO6FYuWJzYPMRrOi3es4yHlzsRuq86cQZh/l7p77746ekPFPvDETO6uTf1YeXwm
         lXxbUdpWtGTzO1aZ20HaC81BIJmwMfhlD2lbCVM6aIKxq6jsM5fT/AwJKzStRTwimSt4
         PsMHmg+MiWiKOQIdq3ribL6rFkldmXN6CfZDKufBam1Hg7LuXsC2rhppYqqNXibce9LG
         lhGg==
X-Gm-Message-State: AO0yUKVQMKFrRTX0Y+PxDwv1IjkOVo8i7MTxEyjESgNLR4n+PsRXrSFf
        yQ3FkXXJnP1T7Xz/HlOvOb0OfTSdGLry1X+gXHjLjg==
X-Google-Smtp-Source: AK7set/hxn7sAfblMpdpMPWHyLNDxBQTxnDdGtDdgs0nJfpnRDUKJhUHAHezrgSwMNAg6vv4MsSFeNhbD/acHeXiqCA=
X-Received: by 2002:aa7:8215:0:b0:593:92e9:991e with SMTP id
 k21-20020aa78215000000b0059392e9991emr610338pfi.43.1675260511059; Wed, 01 Feb
 2023 06:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20230201125642.624255-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230201125642.624255-1-gregkh@linuxfoundation.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 1 Feb 2023 15:08:20 +0100
Message-ID: <CADYN=9LPvuxr6EjQtiGqnT8XA7FvurBmzYjfXz1yxvr+D+TN8w@mail.gmail.com>
Subject: Re: [PATCH] maple: remove unneeded maple_bus_uevent() callback.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 at 13:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The driver core recently changed the uevent bus callback to take a const
> pointer, and the maple_bus_uevent() was not correctly fixed up.  Instead
> of fixing the function parameter types, just remove the callback
> entirely as it does not do anything, so it is not necessary.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for the quick fix.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
> sh maintainers, I'll take this through my tree as that's where the
> offending commit is that causes the build breakage.
>
>  drivers/sh/maple/maple.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index e24e220e56ee..e05473c5c267 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -760,12 +760,6 @@ static int maple_match_bus_driver(struct device *devptr,
>         return 0;
>  }
>
> -static int maple_bus_uevent(struct device *dev,
> -                           struct kobj_uevent_env *env)
> -{
> -       return 0;
> -}
> -
>  static void maple_bus_release(struct device *dev)
>  {
>  }
> @@ -782,7 +776,6 @@ static struct maple_driver maple_unsupported_device = {
>  struct bus_type maple_bus_type = {
>         .name = "maple",
>         .match = maple_match_bus_driver,
> -       .uevent = maple_bus_uevent,
>  };
>  EXPORT_SYMBOL_GPL(maple_bus_type);
>
> --
> 2.39.1
>
