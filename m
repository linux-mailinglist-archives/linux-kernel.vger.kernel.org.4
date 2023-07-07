Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936374B9C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGGXCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjGGXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:02:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D12125
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:02:38 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401d1d967beso55161cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688770957; x=1691362957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+K8jUTarrByXmmsnRfK7DcoN/PO/VOKS+RdUKK8a0Q=;
        b=eI+lLVHX85DjIdjuDQ5/v+Ln0iKjCHoIOgBNo1053obTJcA2/4JDePjLL12DKNFEKq
         lTW9l06TpAFmYzOTI4HQuG9OYEXgMkUUvA0uUb6EsbzqSwjIkS52PHb5rSl84GxunLUh
         gwfisSmzI0nNzQfuqMUxjpaJAxWj5kHS210xHXvv+Fh3RNTXg+UzIT+hrAm0aQb01/Fx
         EnHpIIgWWBgWGPEOgxxn8gnyN1hir83rDzbnBrMphlyQ93lXxBNnKVUgzGTZkNiHHILR
         wKt6/IGuriubG5hJTnaz2Y70D5MAPGcL7t30vmP3bw4ZGTJ3vvHeUP9EsVlMDN5+HrBT
         QCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688770957; x=1691362957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+K8jUTarrByXmmsnRfK7DcoN/PO/VOKS+RdUKK8a0Q=;
        b=bwfS6/GIJm8zR3j32BQ8+EGGZCe1wnOuJATDX0GtHUwCzmSMG6Q5XM5ytntQ03gNIs
         JqATiM21lcv9tyPYubMIno/jgic86an6GLrb+ZiAuhOAW4k/v7/HEFq+KKhF9FfU9uOM
         AZ3SVjuTppK+BELkVzCHO+jAvJAzkGg8ofw+PzBQSFFv71gJBK8pMglTKbdTmG5JYELe
         1giAGLhzhJQeX1zCUL+0wgweDwfTICjoS3SMb4NyHt+jWRdTWpcB80itUKwMVvCqcfTe
         wHpPNbBJjnnu37g66vyl4rLSuHj0/gyNlEnwfMxd3usvEdp8uGODyETGsIm7NIqdSAhH
         9f7Q==
X-Gm-Message-State: ABy/qLZEODSq6Sm0UR4bNv53fVeelVFzo2T5DSzSdDRq+e4XyEjvEOmj
        dH3Z9CkB9giC38ZkJJA5ZObhZi9D9mXy3TdoCUfn
X-Google-Smtp-Source: APBJJlGG4RUNc3IYVZSxpDh+GahFNhoSuywqyQntBa+e67cbTiHBg9AMUgPyRcFXhxk3paFjtALqjJLQsVijyu7MwG0=
X-Received: by 2002:ac8:5993:0:b0:3f3:75c2:7466 with SMTP id
 e19-20020ac85993000000b003f375c27466mr22992qte.8.1688770957227; Fri, 07 Jul
 2023 16:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230630171052.985577-1-peter.hilber@opensynergy.com> <20230630171052.985577-3-peter.hilber@opensynergy.com>
In-Reply-To: <20230630171052.985577-3-peter.hilber@opensynergy.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 7 Jul 2023 16:02:26 -0700
Message-ID: <CANDhNCpN_abA6YGHuFy32pxeT06quNSVBgyXnmPW09xTLe4XAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] timekeeping: Fix cross-timestamp interpolation
 corner case decision
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:12=E2=80=AFAM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> cycle_between() decides whether get_device_system_crosststamp() will
> interpolate for older counter readings. So far, cycle_between() checks if
> parameter test is in the open interval (before, after), when disregarding
> the special case before > after.
>
> The only cycle_between() user, get_device_system_crosststamp(), has the
> following problem with this: If interval_start =3D=3D cycles,
> cycle_between(interval_start, cycles, now) returns false. If a
> history_begin was supplied to get_device_system_crosststamp(), it will
> later call cycle_between() again, with effective argument values
> cycle_between(history_begin->cycles, cycles, cycles). Due to the test
> against the open interval, cycle_between() returns false again, and
> get_device_system_crosststamp() returns -EINVAL, when it could have
> succeeded.
>
> Fix this by testing against the closed interval in cycle_between(). This
> disables interpolation if interval_start =3D=3D cycles. For the special c=
ase
> before > after, similar arguments hold. Fix this in a similar way.
>
> At the second cycle_between() call site, add an extra condition in order =
to
> effectively check a half-open interval, which keeps the condition
> documented above the call site satisfied.

I'm having a little bit of a hard time following this commit message.
Do you think you might be able to take another swing at it to make it
a bit clearer?

I get you're going from exclusive to inclusive intervals, but it's not
very clear why this change is needed.

> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supp=
orting slower devices")
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  kernel/time/timekeeping.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 8f35455b6250..7e86d5cd784d 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1180,13 +1180,13 @@ static int adjust_historical_crosststamp(struct s=
ystem_time_snapshot *history,
>  }
>
>  /*
> - * cycle_between - true if test occurs chronologically between before an=
d after
> + * cycle_between - true if test occurs chronologically in [before, after=
]
>   */
>  static bool cycle_between(u64 before, u64 test, u64 after)
>  {
> -       if (test > before && test < after)
> +       if (test >=3D before && test <=3D after)
>                 return true;
> -       if (before > after && (test > before || test < after))
> +       if (before > after && (test >=3D before || test <=3D after))
>                 return true;
>         return false;
>  }

I'm with you here.

> @@ -1282,6 +1282,7 @@ int get_device_system_crosststamp(int (*get_time_fn=
)
>                  * clocksource change
>                  */
>                 if (!history_begin ||
> +                   history_begin->cycles =3D=3D system_counterval.cycles=
 ||
>                     !cycle_between(history_begin->cycles,
>                                    system_counterval.cycles, cycles) ||
>                     history_begin->cs_was_changed_seq !=3D cs_was_changed=
_seq)
> --

Roughly I see you're trying to preserve the behavior here for the case
a =3D=3D b, which used to fail with cycles_between(a, b, c) but now
passes.
But it's unclear *why* we're making the change to begin with.


thanks
-john
