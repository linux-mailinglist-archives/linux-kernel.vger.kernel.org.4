Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAA5F4571
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJDO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJDO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:28:05 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D295D0F4;
        Tue,  4 Oct 2022 07:28:04 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id mg6so3504836qvb.10;
        Tue, 04 Oct 2022 07:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tmKm3hNoJxc0O1Q5BBVSWd2FFBMoTD9nMoF5l3BzG4=;
        b=OaIPreBcJ8Kt3qjd7UPbp1s4UCc5V3gxv8kGXus274/qH07zh7CvuOTVJeLkccgndV
         aAoKp4uF+lkcWahvgid2/xc3dFIGccFuyjtAzbn03UstT4xLq4RCe+hSi/5G9b55E6MZ
         bq5ndGyCqX9KTiEwgWWe8y2gKd9krGus1hgRiRajnZoPhIlFv2ictpMCGgNxKylfBhd7
         nAG5uwRwzvVMaOXE10/4cOUtnNi77tMxA67NSNlGFLa8DgQ1zaTxxicTsb84uMxhg//O
         yvNqxItjuVlugIQH0yjb/oGXA378foXdZGg+Ccm3HQmmiZZJvuQ04DtHgO34GIgDiVRx
         Soww==
X-Gm-Message-State: ACrzQf05qxpngZAuml+5tgMZlRyrKWd+BZeuMDkWt6MtfQYYbwcknGYy
        FO4BBL1r6A76r6HrQcB81wSOiC1e++dbYV/Yc/xD7x4T
X-Google-Smtp-Source: AMsMyM5aLO+96lpnyBwinDVMZD6T/3HZtM5VR4yfs+0tL4RBgHeK61dkjdKeI7gmeR46Bh/Kj2E28P8Zg6vitdNVZvY=
X-Received: by 2002:a0c:9d91:0:b0:4b1:7809:4825 with SMTP id
 s17-20020a0c9d91000000b004b178094825mr13627846qvd.130.1664893683824; Tue, 04
 Oct 2022 07:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220929154214.7305-1-johan+linaro@kernel.org> <CAPDyKFoW5HLykzRdtF4a_7=RNXu6LTfABxDX2P3hotsXQwCUMg@mail.gmail.com>
In-Reply-To: <CAPDyKFoW5HLykzRdtF4a_7=RNXu6LTfABxDX2P3hotsXQwCUMg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:27:53 +0200
Message-ID: <CAJZ5v0jqOatDb=gE_BvZrzVAn4pf51zjUGnSK8G8oAJmYrZX3Q@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: log failures to register always-on domains
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 29 Sept 2022 at 17:42, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Always-on PM domains must be on during initialisation or the domain is
> > currently silently rejected.
> >
> > Print an error message in case an always-on domain is not on to make it
> > easier to debug drivers getting this wrong (e.g. by setting an always-on
> > genpd flag without making sure that the state matches).
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 6.1-rc material, thanks!

> > ---
> >  drivers/base/power/domain.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >
> > Both myself and Matthias have hit this with the Qualcomm GCC drivers
> > when updating static genpd flags directly instead of using/adding driver
> > specific flags to propagate the setting.
> >
> > Johan
> >
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index bbfbf05b3446..7200e307effb 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2087,8 +2087,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >
> >         /* Always-on domains must be powered on at initialization. */
> >         if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
> > -                       !genpd_status_on(genpd))
> > +                       !genpd_status_on(genpd)) {
> > +               pr_err("always-on PM domain %s is not on\n", genpd->name);
> >                 return -EINVAL;
> > +       }
> >
> >         /* Multiple states but no governor doesn't make sense. */
> >         if (!gov && genpd->state_count > 1)
> > --
> > 2.35.1
> >
