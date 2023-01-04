Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036965CB52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjADBUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbjADBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:20:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0FA1D8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:20:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j16so14064569edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtynKgHKK/QGiMahjs2wAyzlhZQp4DgmrYzcxItQDpM=;
        b=QeS7niR/OrwJ9uSxVne/IMbRPfZlNwm8fGqft3B216G0BGxcuGcVr9YERFjfc4qvwf
         zuY7SgBXvvCz9Hh+PYR/t2/eLotDpWZzRP+6XdLeHIXzW8TSYkAzGcvXveK9wF+Tl/6V
         tBIW3dF1XKC60dTmscSrGhu9o4Z37kQjs2nyn5cGCl6AuCO1mNFtq2MDhydzBmHzblZ+
         FPBllDmod5H2Lu3vyO+GXA55ZJowIJ1SuNAX7JjnjgeQldM9J2TH80nTRG6YuKtbiRcM
         DwvZx0aAUo91hlEPuOhot92wwkzGAzRf3qmK2uWVflYgi6/NGZ2XyYzFKYR+KeWlfnpt
         obtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtynKgHKK/QGiMahjs2wAyzlhZQp4DgmrYzcxItQDpM=;
        b=ywfgJAfy88PUGcJfqLflXeJpchcrSBNSPOuR/XoGt9Hrh3GTWidQPunFMeVTgd7fwf
         VfXh6R+MqtSoGwlRoUmZbj5x/U+ows8nuCFy/SvU6yfup85zWAFUYgtxS8y4fZTvkDjC
         9Ix2E0FYvcbegZVMA3Q0RxdgYilp54MqnZSBZAWh/qRsV87p6bI2NfxrJgmsF/OWBPJ0
         0b50pUMLbMMCTFJO+dBpypCXlaByinMEIu4wl7UPgFNhQowyc/hdiqW7liJjgDThClPq
         67cILwWC/GpqpUurV6Z2U4t2DYrhsKuYF73D9YtGdOr3d6POfMxMrkTw2csHUYeV8Wey
         aIJw==
X-Gm-Message-State: AFqh2kpvmb3JrG81vmcWO1DQdIxISkAmgSqER9KxawtmUAw7ElyXa6iy
        sR6C8DDoG/Erdcz5bd+S+kfuy51cde/pKaFb7K6/nA==
X-Google-Smtp-Source: AMrXdXt2a4i2MLKPACRV4r6g9f6Y2xxSpK4cgK3e7AzJptfR7gAZzLbKlfQVAZvxCOMcUjXFy1NtTOmbMr2RCLvEo4Q=
X-Received: by 2002:aa7:de9a:0:b0:48e:ef30:a81 with SMTP id
 j26-20020aa7de9a000000b0048eef300a81mr178064edv.135.1672795224681; Tue, 03
 Jan 2023 17:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20221221185540.2265771-1-robbarnes@google.com>
 <CACeCKafZu=46NE--r9W-wtJWAhj8=s46yCBO4N4u5nt4COqYAQ@mail.gmail.com>
 <CA+Dqm30XF=wDVcdUabbHySp-fwf+zFNqXpdYDW3bDTOwRbkiZw@mail.gmail.com>
 <CACeCKafGg5=1MQQdCtXDm-3LE2VsixHPsUDngRwQXUvAwQ=u=Q@mail.gmail.com>
 <CA+Dqm33CAjWv=DFhp0+iee2-EugJzjWOYcyfieaULq2H9egheA@mail.gmail.com> <CACeCKad+cdVLi8Qq1R2j+jkRkyF6Mktu_64oq4Ewi0TWXSKJ-g@mail.gmail.com>
In-Reply-To: <CACeCKad+cdVLi8Qq1R2j+jkRkyF6Mktu_64oq4Ewi0TWXSKJ-g@mail.gmail.com>
From:   Rob Barnes <robbarnes@google.com>
Date:   Tue, 3 Jan 2023 18:19:48 -0700
Message-ID: <CA+Dqm33ZE77nqfNcDA91noZtrx_35G=usCXd5CiCi8HbtceZjg@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Handle CrOS EC panics
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 4:28 PM Prashant Malani <pmalani@chromium.org> wrote=
:
>
> On Tue, Jan 3, 2023 at 3:15 PM Rob Barnes <robbarnes@google.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 5:38 PM Prashant Malani <pmalani@chromium.org> =
wrote:
> > >
> > > On Wed, Dec 21, 2022 at 3:55 PM Rob Barnes <robbarnes@google.com> wro=
te:
> > > >
> > > > On Wed, Dec 21, 2022 at 12:23 PM Prashant Malani <pmalani@chromium.=
org> wrote:
> > > > >
> >
> > >
> > > It's just I find having a notifier for a single use case overkill(eve=
n
> > > 2 would be fine); one could get away with exposing a method
> > > in cros_typec_debugfs via a local .h file (it can compile to a stub i=
f
> > > cros_typec_debugfs is not compiled to the kernel);
> > > the LPC code can then just call that method instead of invoking a not=
ifier.
> >
> > My first implementation did make a direct call to cros_ec_debugfs.c,
> > but an internal reviewer recommended using an event notifier instead.
> > So I'm histent to go back to a direct call.
> >
> > There may be other sub drivers that want to handle EC panics. So I
> > think keeping this as a separate notifier makes sense given the
> > constraints.
>
> The issue with that reasoning vis-=C3=A0-vis your implementation is that
> the panic notifier is tied to cros_ec_debugfs. What if another
> (sub)-driver wants to use the
> panic notifier to do something, but that system doesn't have CONFIG_DEBUG=
FS
> enabled?

There isn't a dependency between cros_ec_debugfs.c and
`panic_notifier` inside `cros_ec_proto.h`. So (sub)-drivers can handle
EC panics when CONFIG_DEBUGFS is not enabled.

>
> Having a direct/explicit dependency avoids that issue; LPC depends on
> debugfs being compiled
> to have the log printed out (a stub is used when debugfs is not
> enabled), but nothing else
> relies on debugfs for a panic notifier.
>
> BR,
>
> -Prashant
