Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA832710E71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbjEYOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjEYOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:35:37 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85A195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:35:35 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-456d9652c24so418735e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685025334; x=1687617334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAogn6dT4b6m8+lLJAd5XLZlUe3QdLu7einTf1A+tIg=;
        b=olneRNt0QSWwgjhhvV/O7lXmLW+2Z9uuG9ZKZc988z4Tl6cH95KQuo0n9C0Ybbxv7D
         U9Z6WWaeCLzdQMhyJBfm/h5TCWirx+agFmWwI96Hc0meNcwmmStEpY/yK37l0uNrv/LD
         VHYKX9atO0lsz8JGcgKcNiUk0910Ur0BIRugXfF6zSXQ3K50r7sBcnfLjJW3gh5Vr4cU
         SQkVBc6E2nGiw84gGkHHYv4BwVcs9XLkjUHibjOFvAUQgTGL+Jwups8nyiSmG53GnFvJ
         oZIxh+UkuTiyo2kcpmHPYCEENHva6DjmbQafvJdNE1FhZmev/U/RnKJcJMNfLCZDHpIS
         5bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685025334; x=1687617334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAogn6dT4b6m8+lLJAd5XLZlUe3QdLu7einTf1A+tIg=;
        b=eWmBlPEY6BE2+jlkzTEauRnJB3AUIXbGe2BGfWsxHdZVeXxKAJl2GR3JvhtfhksF71
         Re2WaBNgm6+WbSXuFLN6CsPySasNFGcODdvwJwv2s+X87rLz4udIABc5ucjDmgT6LuYt
         wLwNrHquEm9Vk+mT/XyhpPDHn3DYDJUyaauNQQOUryrbWbwwS3JZnMIoe3wp5OQQUXtn
         asqiFcqvdtoeasijEiXQghGBnnBrh5Pd9OBRnMlOHwbCnrQln0voBOUR6MCl1ygIu8PM
         VVWFHrnCRAzID1EecC3w8yzaqH8Dsc+CiVdcuQJ4P2dSkWXyxT1MFRkoscdEk19x6DN/
         /Y9w==
X-Gm-Message-State: AC+VfDx/Xo29Bhu6O45JASc2tBOQ/gMyi67D3U2M65ndu/cG9MpG6n53
        hml9BG8e4nNq7AtWOAAZZWp63QkDgSQdpGkPa0jQ1g==
X-Google-Smtp-Source: ACHHUZ4qjNa/T2reNQHamvgq/FN+8eYf30P46YnDIhAQfq41TQFW6fcyaVASyBQ7p8xhGwBSUypu5WGUmvNEbQxN824=
X-Received: by 2002:a05:6122:141:b0:457:56a4:19e7 with SMTP id
 r1-20020a056122014100b0045756a419e7mr1164313vko.0.1685025334463; Thu, 25 May
 2023 07:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZGzsD_HMbMGhGwcr@surfacebook> <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol> <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
 <CAHp75VfVr0N4Fv=s_12vcTi8=pGWJgeWoXpxQvqSNWDcZauS=A@mail.gmail.com>
In-Reply-To: <CAHp75VfVr0N4Fv=s_12vcTi8=pGWJgeWoXpxQvqSNWDcZauS=A@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 25 May 2023 16:35:23 +0200
Message-ID: <CAMRc=Md2iFVMw14d4v-AjmcBniWF6r65VhcE5+HFsvH=VTdSxA@mail.gmail.com>
Subject: Re: using libgpiod to replace sysfs ABI (was Re: [PATCH] gpiolib:
 Avoid side effects in gpio_is_visible())
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Kent Gibson <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:13=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 25, 2023 at 2:53=E2=80=AFAM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 24/05/23 17:41, Kent Gibson wrote:
>
> ...
>
> > It'd also be great if there was some way of ensuring that a line's stat=
e
> > is kept after the application has released the request (i.e. the txdis
> > case I mentioned). But that probably needs work on the kernel side to
> > make such guarantees.
>
> Won't happen. It will require too much of strictness to be added into
> the kernel with likely breakage of the existing code and
> documentation. What is being discussed is a D-Bus (like?) daemon +
> Policy in user space that will allow user / process / cgroup / etc to
> "own" the line and track its state.
>

It's already WiP[1]. I'm trying to keep the footprint minimal with
only GLib and dbus required at run-time.

Bart

[1] https://github.com/brgl/libgpiod-private/tree/topic/dbus
