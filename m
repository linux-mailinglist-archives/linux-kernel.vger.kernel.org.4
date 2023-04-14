Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D356E2A34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDNSn6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Apr 2023 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:43:56 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801FB8A74;
        Fri, 14 Apr 2023 11:43:55 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id c9so9059067ejz.1;
        Fri, 14 Apr 2023 11:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497834; x=1684089834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McbEA2OpJ6jOUiDyogw43V66/S8Du0pTDcqQpetxNCk=;
        b=DijGJVUPdXnOAuxmFyIkmYlvbANbgCrsoMEmeD1hLCp/WwyZBHamiyKpZc7m3xXRei
         P0/Lkgsb1UCRT7/WMWS+tM842Uj7ynrBe7MG4yB2eqoJVQUSk9lPewtFq12bVUn8dck+
         vDHnUjuhl0TmfRSmAiGsDd8cAoIOEsIFcqzQ6Ph2cNIF7aLNDKzQBCgOOBGNX6kZRByH
         Xs4gTjfdabxTGa+IacW8lmZVFwWzHv20/SoJ29l2SfeNfzbfRwMcJxhz9A2C77mQvaQV
         2Exzvn7v0qn0whv2zKshBoNxpJdKnrj+bOMKNMyG3JC7QS7rPmUz1JkMWsnEvHIPmfvq
         y5dQ==
X-Gm-Message-State: AAQBX9eI/6YVpx3C67iB00086+zedBi2VuEqIzyZA5lF4xFstK83ZMTd
        UEi8qmVeLmX5hLUHQ39QoRbRoUucDrWCfOeaD7+SUfGC
X-Google-Smtp-Source: AKy350a9mCU+qLfRhNEohaOPdo9gUyZvFfhQXZlP30P74TgOlIYg3BBUjPKSoHR9YqC1AO4tQFFs20VUsT7rRdiUS7k=
X-Received: by 2002:a17:906:f290:b0:94d:cf8c:1542 with SMTP id
 gu16-20020a170906f29000b0094dcf8c1542mr71781ejb.2.1681497833847; Fri, 14 Apr
 2023 11:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-10-daniel.lezcano@linaro.org> <CAJZ5v0hW1B7XmU16PHRE2B6z2e-qs=X8m4v8qb--MUttiPuGqw@mail.gmail.com>
 <a7cf78b9-84f3-a10a-d192-8f45565d85c9@linaro.org>
In-Reply-To: <a7cf78b9-84f3-a10a-d192-8f45565d85c9@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Apr 2023 20:43:42 +0200
Message-ID: <CAJZ5v0gT1FdH3wF1104wHLHzx7YnmhtqCnNtywO2L5y4jG00ZQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] thermal/core: Add a linked device parameter
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 9:01 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 27/03/2023 18:16, Rafael J. Wysocki wrote:
> > On Tue, Mar 7, 2023 at 2:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> Some drivers want to create a link from the thermal zone to the device
> >> sysfs entry and vice versa.
> >
> > Which device is this, exactly?
>
> ls -alh /sys/bus/acpi/drivers/thermal/LNXTHERM:00/
>
> [ ... ]
>
> lrwxrwxrwx    1         0 thermal_zone ->
> ../../../virtual/thermal/thermal_zone0
>
> [ ... ]
>
> The ACPI driver is the only one doing this AFAICT.
>
>
> >> That is the case of the APCI driver.
> >>
> >> Having a backpointer from the device to the thermal zone sounds akward
> >> as we can have the same device instantiating multiple thermal zones so
> >> there will be a conflict while creating the second link with the same
> >> name. Moreover, the userspace has enough information to build the
> >> dependency from the thermal zone device link without having this cyclic
> >> link from the device to thermal zone.
> >>
> >> Anyway, everything in its time.
> >>
> >> This change allows to create a these cyclic links tz <-> device as
> >> ACPI does and will allow to remove the code in the ACPI driver.
> >
> > Well, I'd rather have it in the driver than in the core TBH.
> >
> > If ACPI is the only user of this, let it do the dirty thing by itself.
> >
> > There are two cases which would justify making this change:
> > 1. There will be more users of it going forward (seems unlikely from
> > the description).
> > 2. It gets in the way of some other changes somehow.
> >
> > I kind of expect 2. to be the case, so how does it get in the way?
>
> Shall we do the same approach than 'Menlow' and add an option to remove
> the thermal zone link in the acpi sysfs directory ?

That depends on the answer to the question above.
