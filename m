Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E56C4FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCVP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCVP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:56:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A72C4781A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:56:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5447d217bc6so346012707b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MymAbv0zYoQMvFCzSIAej0Xhn9LluGmrGGKSGBtxMc=;
        b=RyY53vBPKhy9mfp/7fx9wpJnu6FxEj/aCSK+SloR5uu5jAU2f21HsGqLf1bXRE/R56
         zJIQzUuZns7mbsQx4yiYrVcM3lBwZHLrMFZ4sY1dSqPVB0baSHqkY28bWS+nTTCMupE+
         7Q+DzRy+doIjLyb8aVD/UCgQ8KXalasag7iWr1SqR+Nhawf8wY8eJsVwV7TkYb2n8Kpz
         z9vuXtz/o/3ucx0Z598Z2QRoGivVJ8WjAN/umwJNes5BdVOLcl0BlGWcnhYxTvTnUD5y
         hZIhg2HHI5ThSSlcmRLDcUy1Gh84MPCW6gZazsWS+uJERDv8OPq8ExLCY+S9flpWZGAo
         mmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MymAbv0zYoQMvFCzSIAej0Xhn9LluGmrGGKSGBtxMc=;
        b=wU/umSkqGFpq86tjObdW2roWGrT/VbWTlAkbAwBpvVBBaDWUC7KKGHkpQGJWjhhehf
         AOn+4nrEHzDoiycT0mj18muNdOEgHUx7yjL+G8WuLyp9NZO5WVo1jw+WGqTDvuzPZ6Mq
         nERdvHLKcCupiVlr4k9ABao7skC6BcXa/5e/yEEt4ZiUuyfEdpWsG1N45YiQG363+Fja
         11d7L1B6mZa8rtZzpRxbgsdSsVDzerlqrU0a9qipd6LbQnOfYTKiEwGqR9Aw8iPqoTiZ
         +0INd78wBaZ+XyrnMMBgOxg9LUW+WESeSJJSph31Bb/eT96xeM07AZkT4GpvreKkWV81
         hppA==
X-Gm-Message-State: AAQBX9eV/wXnOu9Xk7vX0u0Uiet8i5d7/Y1h9o3eywhGgWgJc1wUJUqf
        zVJt/hIRahk++vh4mCpWDwHarvboW4HmRoXx8K8=
X-Google-Smtp-Source: AKy350Zc82VZ5ER4KskJz4D6FJJuaS9LDHF9H/Mdz1o8n/OVwwZGa9rxqn+ioDHgLB8Jsj25587VizCbXZsiZpVViGg=
X-Received: by 2002:a81:c406:0:b0:541:9063:8e9e with SMTP id
 j6-20020a81c406000000b0054190638e9emr191710ywi.2.1679500579527; Wed, 22 Mar
 2023 08:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley> <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
 <755a8541-adf5-4454-9bd5-9ea439a5a4ea@roeck-us.net>
In-Reply-To: <755a8541-adf5-4454-9bd5-9ea439a5a4ea@roeck-us.net>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Wed, 22 Mar 2023 16:56:08 +0100
Message-ID: <CABDcavb+W1x5ppQzzX3M09TNTr5vOnsNKuuMrpyNQ_vrTQyWKw@mail.gmail.com>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El mi=C3=A9, 22 mar 2023 a las 16:05, Guenter Roeck (<linux@roeck-us.net>) =
escribi=C3=B3:
>
> On Wed, Mar 22, 2023 at 09:33:32AM +0100, Guillermo Rodriguez Garcia wrot=
e:
> > Hi Petr,
> >
> > El vie, 17 mar 2023 a las 13:51, Petr Mladek (<pmladek@suse.com>) escri=
bi=C3=B3:
> > >
> > > On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> > > > Hi all,
> > > >
> > > > We have several embedded systems where pass console=3D or console=
=3Dnull
> > > > in production to disable the console.
> > > >
> > > > Later we check for this in user space: in our inittab we check if f=
d0
> > > > is "associated with a terminal" (test -t 0); if so, we are in
> > > > development mode and we open a debug shell; otherwise (console
> > > > disabled) we just start the application.
> > > >
> > > > Recently [1] this behaviour has changed and now if we pass console=
=3D or
> > > > console=3Dnull, the new ttynull driver is used. This breaks the che=
ck we
> > > > were doing (test -t 0 always true now).
> > > >
> > > > [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> > >
> > > This is actually exactly the problem that the change tried to solve.
> > > Some systems failed to boot when there was no console and they tried
> > > to write something at stdout.
> >
> > Well, I did not have any problem before this change.
> >
> > I understand that some systems had a problem (many others didn't, and
> > setting console=3D or console=3Dnull has been standard practice for a l=
ong
> > time). Since this change in behaviour could (and did) break things in
> > user space, perhaps it should have been made opt-in...
> >
> > >
> > > > Is there a way to get the previous behaviour? If not, is there an e=
asy
> > > > way for userspace to detect whether the console device is a "real" =
tty
> > > > or ttynull (other than trying to parse the kernel boot args, which
> > > > would be a bit fragile).
> > >
> > > A solution would be to check that /proc/consoles has ttynull as the
> > > only registred console, for example:
> > >
> > > grep -q ttynull /proc/consoles && test `cat /proc/consoles | wc -l` -=
eq 1
> > >
> > > Would this work for you, please?
> >
> > I was trying to avoid something like this as it feels like userspace
> > now needs to have too much knowledge of what the kernel is doing
> > internally, however I guess this is the best option.
> >
> > The suggested check seems to work but now I am seeing a different
> > (related?) issue: when I try to reboot from the console (using
> > busybox's reboot command), the system reboots normally if I am using a
> > "normal" console (e.g. console=3DttyXXX), however when using
> > console=3Dttynull, the command takes 20-25 seconds to complete. I am no=
t
> > sure why this would happen; if I understand correctly, for userspace
> > ttynull is just like a regular tty driver, so why would there be a
> > difference?
> >
>
> I think we may have seen something similar, causing us to revert the
> upstream patches in ChromeOS. We did not try to find out what exactly
> caused the problems.

If you have any further details on this that would be very helpful,
even if you didn't get to pinpoint the actual cause of the problem.

Thanks,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
