Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96A72DD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjFMJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjFMJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:27:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06059E71
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:27:00 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33aa60f4094so18546975ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686648419; x=1689240419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYp2vyZT2cywAARdyCm9IEf7v0f+Ok+TOsPUs4YC8jM=;
        b=EEtcbJv9u5SGZWq8XPeS6PBV8b2VOznN1VeU4Abenfytw5WBGxZ1dtkKpFPUylls7s
         +uhbv5teINR0Ph763ti/q/iRZ1HDJWjzyDToH5uPxwY0UjUVyFBmJqCn0qyg7/muNBf+
         T3LG9uNqMCiHOoHvWVoQld7zc0nC4hroZlWvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648419; x=1689240419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYp2vyZT2cywAARdyCm9IEf7v0f+Ok+TOsPUs4YC8jM=;
        b=Nr1EHn8nAoSd4Myaf2HC8P22bWuxOrNmIxv6503cefFha6dHn6a+DP8TIo3Yycr9NU
         HeavhdSKzBcvcpMHLbpUY1uNRZJFTcF+WEOXisLLwGTKNeh5UeC5CqugOqWAzGLypgIo
         +lIPmGSkmlBOslu6EWBevbZHH/4BFC86at2m4OB5ehVWQmLpkiKsmjLPdwsa7GkjXNdz
         XwQwe7Jj/7Cz/ki7xhr+e+zcU9/hezA0FyJuWqXssoCG6AgDAn3B2DX8XX0vJr8gkxFn
         J1rx1r7H+F2cw2ev4BCYWgPrvxfmmUyW70NRpIPEHg+ze1S2tJ2O0dYt+oyef8ftbnkH
         2oKA==
X-Gm-Message-State: AC+VfDzD+CSCXI+daWVrwQRMsKgmLUvk/oo3AuBAOXuq7mQKkhT/olI1
        xX/gWUGyiSSwtLgY9WPhhlAgUVnFeJkidq+aNHCTGQ==
X-Google-Smtp-Source: ACHHUZ6CaCnnsXFqNf8wTBEDg+4Y0jfMbTs1+LQak0udGIxNEZCr7oVDxT5f5s5UH1Zyc2FqWOj8c7qZQ8wt2CoKgYw=
X-Received: by 2002:a92:dc03:0:b0:340:7643:d5a7 with SMTP id
 t3-20020a92dc03000000b003407643d5a7mr615743iln.4.1686648419396; Tue, 13 Jun
 2023 02:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <ZIewlkGJJJUXPFL0@google.com>
 <ZIfY5zhhHU9IgOqx@slm.duckdns.org>
In-Reply-To: <ZIfY5zhhHU9IgOqx@slm.duckdns.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 13 Jun 2023 17:26:48 +0800
Message-ID: <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Tejun Heo <tj@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, nhuck@google.com,
        agk@redhat.com, snitzer@kernel.org, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Tue, Jun 13, 2023 at 10:48=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jun 12, 2023 at 04:56:06PM -0700, Brian Norris wrote:
> > Thanks for the CC; my colleague tried out your patches (ported to 5.15
> > with some minor difficulty), and aside from some crashes (already noted
> > by others, although we didn't pull the proposed v2 fixes), he didn't
>
> Yeah, there were a few subtle bugs that v2 fixes.
>
> > notice a significant change in performance on our particular test syste=
m
> > and WiFi-throughput workload. I don't think we expected a lot though,
> > per the discussion at:
> >
> > https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/
>
> That's disappointing. I was actually expecting that the default behavior
> would restrain migrations across L3 boundaries strong enough to make a
> meaningful difference. Can you enable WQ_SYSFS and test the following
> configs?
>
>  1. affinity_scope =3D cache, affinity_strict =3D 1
>
>  2. affinity_scope =3D cpu, affinity_strict =3D 0
>
>  3. affinity_scope =3D cpu, affinity_strict =3D 1

I pulled down v2 series and tried these settings on our 5.15 kernel.
Unfortunately none of them showed significant improvement on the
throughput. It's hard to tell which one is the best because of the
noise, but the throughput is still all far from our 4.19 kernel or
simply pinning everything to a single core.

All the 4 settings (3 settings listed above plus the default) yields
results between 90 to 120 Mbps, while pinning tasks to a single core
consistently reaches >250 Mbps.
>
> #3 basically turns it into a percpu workqueue, so it should perform more =
or
> less the same as a percpu workqueue without affecting everyone else.
>
> Any chance you can post the toplogy details on the affected setup? How ar=
e
> the caches and cores laid out?

The core layout is listed at [1], and I'm not familiar with its cache
configuration either.

[1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/

Best regards,
Pin-yen
>
> Thanks.
>
> --
> tejun
