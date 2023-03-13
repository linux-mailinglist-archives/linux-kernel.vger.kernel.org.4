Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D56B7ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCMOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCMOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:47:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479271420F;
        Mon, 13 Mar 2023 07:47:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q15so9561005oiw.11;
        Mon, 13 Mar 2023 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678718825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=923lbrDnlGJSqSY3Xt8v6D4PUhcMD5WLpjqFY9Dv+lQ=;
        b=N6JPqulPkDgn21ORqIZqJ56J1lBbYUaeHV0aEIemOsHOhKxKuf3/iru8tdPyO7R0H1
         QFzf0lEcpgB79Bu2NByEFGGIPtq348JwvO1PfstrN1dtLTKtrA9fcIUf4yQn6S7dt02o
         jalgj97ykc1GBx0mp+fb4Uq/sAGxsPlk4+Wb3soj3besvYBfIG4PIihVtbNny4orImCN
         82LbcI35gstnU64OECe7g4KBBxw6nqQsc5CVs8s4rt4rSLRY7emXIQ8WTNpO3Qmf6SjD
         4G7MY6RfnzMXYV91AKB1wVIr23FRKpxvNMDLPvnGhfUwpr76C7JROHqze7au8tSF52pX
         /pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=923lbrDnlGJSqSY3Xt8v6D4PUhcMD5WLpjqFY9Dv+lQ=;
        b=znrIpoyDW/subfIPoDFInnhnx5OIfIt3i9AzTCNq9jM0+saoS9MVO3whQxG2ptw502
         rich+raNMK7vja0Sfd6TPGbA2k+LGRkEQgBjZJ8tV5YYfieupbYYZ3se8mECQALMlZXS
         Gs2UfpRU6BrH2tNoZtiToiyHvvILqJ571tmphx3j5ff+2Bf6Yrw58YD1OIu0tHo3VSC3
         Sd/sHy4EtNIWrw1VjlD0xi7QSbuWQR16IuG1xdfxWle31D2msZCd2xJhm9GpOT3KUEKO
         1kvr0FMZMGQgGGLixYD1u4kjO3D97khi26Wsg2mABu2oFgDRIbBckc+KDTRvgf9sFEw3
         LZTA==
X-Gm-Message-State: AO0yUKU8hr37AnZsLrCN1czYZQXuH3zRTTFDhrOZCUhtFQpoL0DQtQH2
        aCo0EypYjr7jA8tFia/qVxTvDBvZLYa8cMLar2s=
X-Google-Smtp-Source: AK7set+t6Zd0ULAt1RXgYIU+6YQcPZGwFKu1FRMUu2gsq4o+CZmjaWhnRZBvBJFJVHUMQWkpBWPI8LlTbokFdPkkWH4=
X-Received: by 2002:a05:6808:220a:b0:383:db64:65 with SMTP id
 bd10-20020a056808220a00b00383db640065mr5427713oib.4.1678718824817; Mon, 13
 Mar 2023 07:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230312204150.1353517-1-robdclark@gmail.com> <20230312204150.1353517-11-robdclark@gmail.com>
 <CAJZ5v0gEmFj5Yrm0OZx5XhvGStHXx1OsPXGQqmbFQpeYSADkwA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gEmFj5Yrm0OZx5XhvGStHXx1OsPXGQqmbFQpeYSADkwA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 13 Mar 2023 07:46:53 -0700
Message-ID: <CAF6AEGvDf0R3xhjhQn9Qub16FmP0wEM=vTO7xTmcQc4s0iY1cA@mail.gmail.com>
Subject: Re: [PATCH 10/13] PM / QoS: Teach lockdep about dev_pm_qos_mtx
 locking order
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 5:31=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sun, Mar 12, 2023 at 9:42=E2=80=AFPM Rob Clark <robdclark@gmail.com> w=
rote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Annotate dev_pm_qos_mtx to teach lockdep to scream about allocations
> > that could trigger reclaim under dev_pm_qos_mtx.
>
> So why is this needed?

Because it allows lockdep to warn about problems even if it hasn't
seen recursion into shrinker yet.

BR,
-R

> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/base/power/qos.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> > index 9cba334b3729..d4addda3944a 100644
> > --- a/drivers/base/power/qos.c
> > +++ b/drivers/base/power/qos.c
> > @@ -1012,3 +1012,14 @@ void dev_pm_qos_hide_latency_tolerance(struct de=
vice *dev)
> >         pm_runtime_put(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> > +
> > +static int __init dev_pm_qos_init(void)
> > +{
> > +       /* Teach lockdep about lock ordering wrt. shrinker: */
> > +       fs_reclaim_acquire(GFP_KERNEL);
> > +       might_lock(&dev_pm_qos_mtx);
> > +       fs_reclaim_release(GFP_KERNEL);
> > +
> > +       return 0;
> > +}
> > +early_initcall(dev_pm_qos_init);
> > --
> > 2.39.2
> >
