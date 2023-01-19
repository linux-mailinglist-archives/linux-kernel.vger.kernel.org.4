Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31424673A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjASNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjASNYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:24:52 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309474E9F;
        Thu, 19 Jan 2023 05:24:47 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id az20so5679713ejc.1;
        Thu, 19 Jan 2023 05:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH1KCn8JjO7OsLFRLoHWM7ALUs/KihPCdUMgdMIvr+Y=;
        b=KYrZN7kOZyIBHtxhQsf3N+QSeQgTWm7gCsUPR61s2c0qYpq+XeQ/hZqwR2pHMCU/7q
         fQdivk0oCsl6JMqKyXPrZmMd0YW4yQkwnOD+k6qbJV+tkpmbvfOd5bOfpeU3a9fUtN20
         g3AMQTsZBsAZTovW032iYPYv7TPYAFS5UdELcsU+KI4PY1L0SyCzFEmy8mDvXzsGGwwO
         3DIvazd0QwqTbasnkvQUjJ0qhcf2e4mZtlE3s4W0q4EXnMCbZN/tPwJ3qpSF3Wzd340Y
         40gCmR2ne5Pa4uDcm2+kFvFX7HWuzDoC8yTEaqvV8aLSDzmBirPDzUIjxBevOVuE/OK6
         bq1g==
X-Gm-Message-State: AFqh2kr/LgED9hFx/Sjaa7us9K8FGqNFyChKlAUlm47C5WGNrjkVTZpM
        0qXvtcCx7Hw9kNfqDJSbS83IHcxZDmOUjjBsA94Q2Qag54M=
X-Google-Smtp-Source: AMrXdXuZw6sj+2XcP5BZDOugtSkrQnU9/a5nQfOlwLsT9ShoqiObRaT10UWU3/CnFQW1R8WBUvP1vOydDR9IRCxxpEk=
X-Received: by 2002:a17:906:64a:b0:84d:3c6a:4c55 with SMTP id
 t10-20020a170906064a00b0084d3c6a4c55mr1454744ejb.509.1674134685527; Thu, 19
 Jan 2023 05:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <20230118211123.111493-3-daniel.lezcano@linaro.org> <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
 <db701c97-883e-f231-68fa-c851c6a1a862@linaro.org> <CAJZ5v0jFQv09MQw8Z0gn1=Yf3JJD=BWKy3+Xy7RWUy1NXAK7wg@mail.gmail.com>
 <85e0a85d-6935-11cc-8396-4c3e425188f2@linaro.org>
In-Reply-To: <85e0a85d-6935-11cc-8396-4c3e425188f2@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:24:34 +0100
Message-ID: <CAJZ5v0gR-Z1DNcpRCkK6KapjU_F87RZKpE0ssQn1Y5BiH+sG_g@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 1:48 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/01/2023 13:11, Rafael J. Wysocki wrote:
> > On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 19/01/2023 08:41, Zhang, Rui wrote:
> >>> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
> >>>> If the thermal framework fails to initialize, the mutex can be used
> >>>> by
> >>>> the different functions registering a thermal zone anyway.
> >>>
> >>> Hmm, even with no governors and unregistered thermal sysfs class?
> >>>
> >>> IMO, thermal APIs for registering a thermal_zone/cooling_device should
> >>> yield early if thermal_init fails.
> >>> For other APIs that relies on a valid
> >>> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
> >>> be changed.
> >>>
> >>> what do you think?
> >>
> >> I think you are right.
> >>
> >> It would be nice if we can check if the thermal class is registered and
> >> bail out if not. But there is no function to check that AFAICS.
> >>
> >> Alternatively we can convert the thermal class static structure to a
> >> pointer and set it to NULL in case of error in thermal_init() ?
> >
> > It doesn't matter if this is a NULL pointer or a static object that's
> > clearly marked as unused.
>
> Without introducing another global variable, is it possible to know if
> the class is used or not ?

If thermal_class.p is cleared to NULL on class_register() failures in
thermal_init() (unfortunately, the driver core doesn't do that, but
maybe it should - let me cut a patch for that), then it can be used
for that.
