Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7765B74BA0E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGXcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:32:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E52107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:32:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401d1d967beso59601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688772723; x=1691364723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOBOLIBzFAwDLduiu2hU8oNdG8T1usGeYWckVLDVtBs=;
        b=4i4wUDykCHdowjc9OVsnSLFOllYUiHjxg5q6fIHm8XPcl1ESUn4OD0Po/S8gqV3P55
         3uzRsgUndAaikVwKtenhEO10w7v1I+8M/JOjUlWB8gPp3TQrg7f4RrVbxqUfJ4GrgILc
         xeeY6qlWGFNu6dpKsBWNthRIKDx3bvVfqWswGpt6mxAoPdN/fNCqKuu7bxWOj19PUdPL
         8pC0MsmZ5DVS0a4PNYIssubkbvaBgpowMaCKmcgBSrbZM/4pBA+V6fJknxkkSRBnOYux
         m0CS+BbRDutKHE6ob+j5KgtkT9bClBBFDA+7rKDtpyjprmb/NCgRca+2eNOWzxO0Fnt6
         eYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688772723; x=1691364723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOBOLIBzFAwDLduiu2hU8oNdG8T1usGeYWckVLDVtBs=;
        b=f8FqG6FItDdAe6UJnXz8wtU9N3TbV/YIbTaXOySF7O6Dvh/IBreSXLFkSKQuQJAKYc
         t1QR/NO0/h29QEBH+h30lvZoq3FXVwMZv0dl8tB6KKv+DPxkgNkvJFKfq8SNT71XKeHV
         f6B3leTAZgjqwTNzkpVPUdgytGRG2+uZzyC0dF+ilY5BmvswV5sYS07xgJ+oiCcG83rB
         nh5KT366BGIZtc4jw9AvG1V/b0DJ+eHtsk5fdChehXr7oSDmzQZoXGA8S6jPJX7IBINY
         FZ3xbkceIVWlWFPp49AM6k05X+y8FrDfgKhkBpXF4R/IGlJtYstqvScrqLfnWB8NSa+9
         4CPg==
X-Gm-Message-State: ABy/qLaMnjXk3ZID1e6ag6S/Gp0HvJxZzZ0eqmyYUu5Q46tKCCIAwppX
        ZMqyhwiBnK7LCC6PoqXdcohjTXQyyiV32Fim0c19vz42sN0orpd85Lv/
X-Google-Smtp-Source: APBJJlHBIDPM/Hazl8urEzsyM0w+pYQOKQrGlLrgQOo2WVu0le20UkfTPQmGnWabubAw1j5Fp3JNmR66chwuF575ZfY=
X-Received: by 2002:ac8:5b09:0:b0:3ed:6bde:9681 with SMTP id
 m9-20020ac85b09000000b003ed6bde9681mr94914qtw.0.1688772723281; Fri, 07 Jul
 2023 16:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230630171052.985577-1-peter.hilber@opensynergy.com> <20230630171052.985577-4-peter.hilber@opensynergy.com>
In-Reply-To: <20230630171052.985577-4-peter.hilber@opensynergy.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 7 Jul 2023 16:31:52 -0700
Message-ID: <CANDhNCoi4OrtXdqs4UErhM0ofecdg94-Yew2NETxhpKkDojt4A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] timekeeping: Fix cross-timestamp interpolation
 for non-x86
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
> So far, get_device_system_crosststamp() unconditionally passes
> system_counterval.cycles to timekeeping_cycles_to_ns(). But when
> interpolating system time (do_interp =3D=3D true), system_counterval.cycl=
es is
> before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
> expectations.
>
> On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
> interpolating, setting delta to 0. With delta =3D=3D 0, xtstamp->sys_mono=
raw
> and xtstamp->sys_realtime are then set to the last update time, as
> implicitly expected by adjust_historical_crosststamp(). On other
> architectures, the resulting nonsense xtstamp->sys_monoraw and
> xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
> adjust_historical_crosststamp().
>
> Fix this by always setting the delta to 0 when interpolating.
>
> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supp=
orting slower devices")
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  kernel/time/timekeeping.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 7e86d5cd784d..7ccc2377c319 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1259,10 +1259,15 @@ int get_device_system_crosststamp(int (*get_time_=
fn)
>                                       tk_core.timekeeper.offs_real);
>                 base_raw =3D tk->tkr_raw.base;
>
> -               nsec_real =3D timekeeping_cycles_to_ns(&tk->tkr_mono,
> -                                                    system_counterval.cy=
cles);
> -               nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw,
> -                                                   system_counterval.cyc=
les);
> +               if (do_interp) {
> +                       nsec_real =3D timekeeping_delta_to_ns(&tk->tkr_mo=
no, 0);
> +                       nsec_raw =3D timekeeping_delta_to_ns(&tk->tkr_raw=
, 0);
> +               } else {
> +                       nsec_real =3D timekeeping_cycles_to_ns(
> +                               &tk->tkr_mono, system_counterval.cycles);
> +                       nsec_raw =3D timekeeping_cycles_to_ns(
> +                               &tk->tkr_raw, system_counterval.cycles);
> +               }

Rather than adding another conditional branch here to go through, why
not just use "cycles" instead of system_counterval.cycles as it seems
to be set properly already?

thanks
-john
