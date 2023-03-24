Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603916C7EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCXNZx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjCXNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:25:51 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E8F970;
        Fri, 24 Mar 2023 06:25:47 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id o12so7888907edb.9;
        Fri, 24 Mar 2023 06:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs5p7KU8MZDhgEPLIw4GctxFoYHSsWDkapBxgIg25mM=;
        b=odztf994hdS2N6EDatW+qGQrvWGmF4Wa8TtQGvJZn9w0RxtMVd6B+TsYNFd4w3/Who
         thJyVJtiuP2i5hvqa78LwXPpJwi/HRqfZgRFK/CPFaXnMj5RPP7TRG12zAUgn+vGbjwm
         zwO3vC2ch4dEZgRbhRQ3ljPL8JoVF89L+TiEbRhBlyqkqx3E3byYuok2e6golbZ7SgSa
         l9OtZ5Z8/R0HGEdHpCKN571xwMBDUo2Uc358/m1W28uEA3y/gxgDUA08S3U/+Ruz3G8A
         wffSede2FNqUL/mUWuYwyfhAD9VwE29/OCCZZo0LaQCiyqKU22VAgWsSFHKlXLLvFyEW
         aUiA==
X-Gm-Message-State: AAQBX9fHDD04s9/IJ3GVpSdoOO0g73jfwgRkumbMdSiSWlnfIAVOL/ro
        9srbH0/SRcnhVTQ2Rqxied412nFRkHbAJarFKEc=
X-Google-Smtp-Source: AKy350YMSJU6zLRpLWqQpFrFbg91BO1NSfdzJd26+qMAVhIy1jvYl7bXtvD1KIOFXUGoDe2ZOUtBbowmEH7L33yV6FA=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr1441550ejc.2.1679664346366; Fri, 24 Mar
 2023 06:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230324070807.6342-1-rui.zhang@intel.com> <20230324070807.6342-4-rui.zhang@intel.com>
 <CAJZ5v0gXfHQmRGEiHsZRXxTB+=dTLca9fbyQA299gL49ysF6rg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXfHQmRGEiHsZRXxTB+=dTLca9fbyQA299gL49ysF6rg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:25:35 +0100
Message-ID: <CAJZ5v0iga+jWrDWCSUwws4Mu87m585RQdHZwgRAnn-cbZrTq1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal/core: Enforce paired .bind/.unbind callbacks
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 2:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 24, 2023 at 8:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
> >
> > The .bind/.unbind callbacks are designed to allow the thermal zone
> > device to bind to/unbind from a matched cooling device, with thermal
> > instances created/deleted.
> >
> > In this sense, .bind/.unbind callbacks must exist in pairs.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 5225d65fb0e0..9c447f22cb39 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1258,6 +1258,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
> >         if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
> >                 return ERR_PTR(-EINVAL);
> >
> > +       if ((ops->bind && !ops->unbind) || (!ops->bind && ops->unbind)) {
>
> This can be written as
>
>         if (!!ops->bind != !!ops->unbind) {

Or even

        if (!ops->bind != !ops->unbind) {

for that matter.

>
> > +               pr_err("Thermal zone device .bind/.unbind not paired\n");
>
> And surely none of the existing drivers do that?  Because it would be
> a functional regression if they did.
>
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> >         if (!thermal_class)
> >                 return ERR_PTR(-ENODEV);
> >
> > --
