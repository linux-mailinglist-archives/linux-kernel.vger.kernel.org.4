Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11160440B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiJSL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiJSLyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:54:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424B1B76F5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:34:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu25so27647842lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvBLWk5C5odh/9kdFJYc5TXBeYmjOJo6M2fyyPPdQz0=;
        b=akUtTjpyCFF0OTjTKaSIQN2KoiVQHuw3JGDlzrnyu0NzeMhwuzuXmpGGmD+ESE3PBI
         RReEckn5zOjjdqhGk8OVBXTXotszYUd4J8SxnEzWBkC9WzyzjltWt2Od3JVh3Zv0dPaH
         4IC9aqglZd4gzo6fTO6SrYC7SrQNesAB7OIJaz3SWYKvabXBWlYDJc9QaO7d2TZHiRQa
         lC630l6a+fE3eBpcy1VNUtd3jEh6y5O2e2T7u57xfbXCfYGNKueXe2ZYmcccI6Q9VT2M
         r/7fYthOqh44MSR/Ori7NBAh4X/4RqGqmqpf96lc3iyM9hGetlQTxNrsG/fJbfZ6IwDL
         LVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvBLWk5C5odh/9kdFJYc5TXBeYmjOJo6M2fyyPPdQz0=;
        b=SkqXlIG91hFK1O7uboeaJALDsl8r2VncOZLzAGZiy9LfAfP1ikMdP6mVpyhGKC0fuk
         cBCaJ+E9ewVXtaPQ0ozbObyLqF1/dy+rgAma+CJA+N5qfDEfe4bG4WTb5jwtHlW0lt2i
         22ZqfWNkbFMfPDDoJzjkUIhCpkaMc0YKRPxPj4wMp2CrfwN0aITjGbPlIjsL5v8X71SO
         gW2g5HFx5lqz0NogxyckZHZ4hx+o17DjV8f/f9C6Yqd09QJJz8xmNmGi4D4514UdMwiG
         e25NhfC/zOmc6ADbV0iL+0JbchYVHkRaWjxm58hzD2NHkXNrSuDMmmk3xAT+ENCPdqBY
         kdUg==
X-Gm-Message-State: ACrzQf27KitP8OLEGc/yoe6QbTfwYJWEnIu5UpN1fgrs50nRGdtk867H
        1sTC5g0bPXDp3yVZSkXMjaLIXfIf2mdqHMkHtz+cdUuvIkE=
X-Google-Smtp-Source: AMsMyM411CtY5BP9UL9rEn1N96fK8eVNrW/afhn4tK4lAgLSapONCchtqYdva/IWjvHFfuQKS3tURWKmwIugqNo87Bg=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr6924119edb.46.1666177002887; Wed, 19
 Oct 2022 03:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com> <Y06cvrpcHn0jwZxU@smile.fi.intel.com>
In-Reply-To: <Y06cvrpcHn0jwZxU@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Oct 2022 12:56:31 +0200
Message-ID: <CACRpkdZZZp5Li7OSybv8F7a8F5iik_gRumwR__BAwpWddfctxQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 2:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 17, 2022 at 10:41:01PM -0700, Dmitry Torokhov wrote:
> > In preparation to converting several drivers to gpiod API, and to keep
> > existing DTS working, this series adds additional quirks to locate
> > gpio lines with legacy names.
> >
> > Additionally the quirk handling has been reworked (once again) to pull
> > all simple renames (ones that do not involve change of indices or other
> > complex manipulations) into a single quirk with a table containing
> > transformations. This should make adding new quirks easier.
> > When using legacy names gpiolib will emit a message to nudge users to
> > update DTSes (when possible).
> >
> > Note that the last patch requires the following change from the OF tree:
> >
> >         88269151be67 ("of: base: make of_device_compatible_match() accept const device node")
> >
> > The change is also available in mainline - it has been merged in 6.1
> > merge window.
>
> I was wondering if we can use the approach that ACPI chose for itself,
> i.e.  the separate data that can be filled by the corresponding driver
> and then GPIO OF common code may use it. In that case each driver knows
> the exact list of compatible strings and associated quirks.

I actually deliverately chose the other way around, to centralize all quirks,
so that drivers look nice and simple and the ugly historical errors of the
device tree be hidden away in gpiolib-of.c.

Yours,
Linus Walleij
