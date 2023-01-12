Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD0667D50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbjALSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjALSC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:02:29 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD755648;
        Thu, 12 Jan 2023 09:25:16 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id az20so27375390ejc.1;
        Thu, 12 Jan 2023 09:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRAo6X3Gzu+d8rohxmVob5wOtGI7yz4wlOWRro7CXUA=;
        b=gFKeHQ4wgG4hygkRVSzeRu0IwaITX4sdnPbQDt+LgJWqcdzCcogb8y4hx7xds8ncqJ
         snrtzvVlxAkliyCeFUC5eNEzrHGXkGQj8XVkRhSSp/yhJr0LO+xMyAjMun3dBWniXxAY
         zA88GHE2+fdhPL96RGgrQoJi0T7eUIEGJLUZ+dz+VikCjf7wHtiEDsPJQDPWGfPVX/Tt
         +vj2WzitgysJ0thVR8n7vvguPrG73xFV4J11QFnE4dQ2zt8uwxPmYYXFV/mp/QsrLON0
         7avXG4KYki0ZL93SqPKRNlpfYqORYqQnspNuD1Wvw4UwCDewAyTSyQYuIJh2g0Z47fat
         2IJw==
X-Gm-Message-State: AFqh2koXBDpkffC7JJ1ZEwHvB2CNcuzdYCpIksqOaY4IcZOOD/wbhDao
        DK7guY1T7zfFlPnMNjxB/MQvAnJZ3YMFn8J7V1E=
X-Google-Smtp-Source: AMrXdXsK8Tvqwl2au4/lOh3+aakXmuw3EHFLXbSEAFqucw4DdRf3FjdYtrCyRjiAp75YomeCO2m2YqYfXNZscUXXWxA=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr1137894ejc.390.1673544315331; Thu, 12
 Jan 2023 09:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
 <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com> <CAJZ5v0jSL3bbEHJLxpn_Liu4DcNeMFG=iQJA_AgophmtXpzMGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jSL3bbEHJLxpn_Liu4DcNeMFG=iQJA_AgophmtXpzMGQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 18:25:04 +0100
Message-ID: <CAJZ5v0gbNv-SgTEHpjiQEwk7qELg6EkByd-8en0=wZ=abFD2JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete callbacks
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 3:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > The actual idle percentage can be less than the desired because of
> > interrupts.
>
> This is somewhat unclear.
>
> > Since the objective for CPU Idle injection is for thermal
> > control, there should be some way to compensate for lost idle percentage.
>
> What does "lost idle percentage" mean here?
>
> > Some architectures provide interface to get actual idle percent observed
> > by the hardware. So, the idle percent can be adjusted using the hardware
> > feedback. For example, Intel CPUs provides package idle counters, which
> > is currently used by intel powerclamp driver to adjust idle time.
> >
> > The only way this can be done currently is by monitoring hardware idle
> > percent from a different software thread. This can be avoided by adding
> > callbacks.
> >
> > Add a capability to register a prepare and complete callback during idle
> > inject registry. Add a new register function idle_inject_register_full()
> > which also allows to register callbacks.
> >
> > If they are not NULL, then prepare callback is called before calling
> > play_idle_precise() and complete callback is called after calling
> > play_idle_precise().
> >
> > If prepare callback is present and returns non 0 value then
> > play_idle_precise() is not called to avoid over compensation.
>
> This mechanism isn't particularly straightforward, but maybe there's
> no better way.
>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> > v2
> > - Replace begin/end with prepare/complete
> > - Add new interface idle_inject_register_full with callbacks
> > - Update kernel doc
> > - Update commit description
> >
> >  drivers/powercap/idle_inject.c | 62 +++++++++++++++++++++++++++++++---
> >  include/linux/idle_inject.h    |  4 +++
> >  2 files changed, 62 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> > index dfa989182e71..f48e71501429 100644
> > --- a/drivers/powercap/idle_inject.c
> > +++ b/drivers/powercap/idle_inject.c
> > @@ -63,13 +63,31 @@ struct idle_inject_thread {
> >   * @idle_duration_us: duration of CPU idle time to inject
> >   * @run_duration_us: duration of CPU run time to allow
> >   * @latency_us: max allowed latency
> > + * @prepare: Callback function which is called before calling
> > + *             play_idle_precise()
> > + * @complete: Callback function which is called after calling
> > + *             play_idle_precise()
>
> What about:
>
> @prepare: Optional callback deciding whether or not to skip idle
> injection in the given cycle.
> @complete: Optional callback updating the state after idle injection.

One more thing: ->complete() is not even used by powerclamp AFAICS, so
I wouldn't add it at this time, because it isn't clear if it's going
to be useful at all.
