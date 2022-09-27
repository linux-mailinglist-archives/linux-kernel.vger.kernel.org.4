Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90A5EBFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiI0Ki7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0Ki4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:38:56 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161498D16;
        Tue, 27 Sep 2022 03:38:54 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id l14so5941812qvq.8;
        Tue, 27 Sep 2022 03:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kX5SsvItwtik0crXdwEH89DQ7N/9bD9yRLz11HcdMMU=;
        b=GwUiR/oWg15X4N0IBsv9qBqliFaiRJfuKgPMw+uJ9fZ8Gxx0qyCwOwxvReE63FMq6F
         ml1CscVxDuYH8IVDVC8bgL3mtZnHZAQ4NEqj3dRM3OqqyeBW3s/7HKIxILDee/glGrGg
         JK5sI+0N6mVHeKFDhE2qrYSvu9oiWM3TJy1fJhD2GULNl2Z57NISmqH2GZxoNbUT4Jkf
         AgLY33yuvW/eZ264frsNH4pOMhw9JWxivCnqC9qeokV7eyVu6MliJ/bD5rC064kIWbpM
         PKd1W5gf7hVv7Pvj1zBagr1ezyhLl6BpJqp3gH4RpbDxeOPFID3SoBYuX7A7cf59ZRGt
         9lHA==
X-Gm-Message-State: ACrzQf2c6RlN74KWDx6OO+dxKkIPNE0+JnSAqnwVtTPDnEXYuUCTNBtC
        g0G7JsFiXScQs8wBnhQnk5XYIyRy8/+kKmrPgJU=
X-Google-Smtp-Source: AMsMyM6eXHvorHWyd2/8T2irhrU9CXmww7UFYFSubiezFPNtHm2+hLnikXbndyicr9ou7FEbzzDmee3HAOqSvbJQ7BE=
X-Received: by 2002:ad4:4ea3:0:b0:4af:646a:9787 with SMTP id
 ed3-20020ad44ea3000000b004af646a9787mr9686646qvb.15.1664275133856; Tue, 27
 Sep 2022 03:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-4-daniel.lezcano@linaro.org> <CAJZ5v0hJ7Tq1pU1hSqswPF_+KZOt1jNKvmqTeF5=1npReqmA3A@mail.gmail.com>
 <ee9ea160-ae77-112b-5302-74179e372387@linaro.org>
In-Reply-To: <ee9ea160-ae77-112b-5302-74179e372387@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Sep 2022 12:38:42 +0200
Message-ID: <CAJZ5v0gATxtX5RW0oHbhT_hjUoEC3V39tQpJi74eg8iXhrwZKg@mail.gmail.com>
Subject: Re: [PATCH v5 03/30] thermal/core: Add a generic thermal_zone_set_trip()
 function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:11 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/09/2022 21:25, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> +       if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {
> >
> > The inner parens are not needed here and below.
> >
> >> +
> >
> > And the extra empty line is not needed here (and below) too IMO.
> >
> >> +               ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> >> +               if (ret)
> >> +                       goto out;
> >> +       }
> >
>
> Without the parens, the following happens:
>
>
> warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
>   1229 |         if ((t.temperature != trip->temperature) &&
> tz->ops->set_trip_temp)
>        |         ^~
> note: ...this statement, but the latter is misleadingly indented as if
> it were guarded by the ‘if’
>   1231 |                 if (ret)
>        |                 ^~

This is about indentation, though, so it looks like white space is
mangled somehow.

As a matter of correctness, the inner parens are not needed.

> >> +       if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
> >> +
> >> +               ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
> >> +               if (ret)
> >> +                       goto out;
> >> +       }
> >> +
> >> +       if (((t.temperature != trip->temperature) ||
> >> +            (t.hysteresis != trip->hysteresis)) && tz->trips)
> >> +               tz->trips[trip_id] = *trip;
> >
> > I would write this as
> >
> > if (tz->trips && (t.temperature != trip->temperature || t.hysteresis
> > != trip->hysteresis))
> >          tz->trips[trip_id] = *trip;
>
> Ok, sure
>
> > But
> >
> > 1. Do we want to copy the trip type here too?
>
> The function thermal_zone_set_trip() is called from thermal_sysfs.c, it
> is the unique call site. However, I think it is a good idea to check the
> type of the trip point is not changed, even if it is not possible with
> the actual code.
>
> > 2. If tz->trips is set, do we still want to invoke ->set_trip_temp()
> > or ->set_trip_hyst() if they are present?
>
> No but there are bogus drivers setting the interrupt with these ops
> instead of using the set_trips ops (eg. [1][2][3]). So in order to keep
> those working ATM, I'm keeping them and when all the drivers will be
> changed, I'll wipe out the set_trip_* ops from everywhere.

Do those drivers set tz->trips?  If not, the tz->trips check can go
before the ops ones.

> [1] drivers/thermal/samsung/exynos_tmu.c
> [2] drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> [3] drivers/thermal/imx_thermal.c
