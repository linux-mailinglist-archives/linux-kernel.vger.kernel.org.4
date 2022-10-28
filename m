Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E916119E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJ1SJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJ1SJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:09:28 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415BB2679;
        Fri, 28 Oct 2022 11:09:27 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id n18so4567619qvt.11;
        Fri, 28 Oct 2022 11:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg4lijVp4M44rm7xpeYVgDNZw9lPyznKpJvDGVTFJGA=;
        b=VrHb1hV/N4h95/kp/Us7QTFZdhM/RkiM21x7Vomr5bnAuk0qRhVVli+X0Bm6EAH/X0
         ig7RZ7+m+7VKAfi8ZSjS+BJGeu7Om5Maf0CJTb7yHisosffTGkwRXwLf9Loo2OYqjZcn
         c9dbdLbZ5AVFsaHu35R8xlUPflmGqCa2QXtaiXU9i/Wa8JLxZc2jDt24sqGTaL0Zvcrm
         fSSj3Ap02b4B1kHBv6VCOox49eaE4a+HRm9vMksYTuD0bSj/saFnTVrLPQJBsh82kd1Y
         uNRMkjkzGfCQtcrx0LNv8TRD8e6ztfO7aiWW1lXPmnlldOHErX+awUG6D8K/JizQI6xL
         b7rg==
X-Gm-Message-State: ACrzQf1djRtPoG4McQ+WBhcvAuu8aj55nVaWmrwZg3IcSkWX4QBR6rBy
        S8EiDNM0I8AxMwDaSTntTZHpuTrv3llSJKkyCIOdbEdK
X-Google-Smtp-Source: AMsMyM4Hxqm3WhctEhuDjsH3P7E7+gQLMNNDrYTdWP0j8coHS75zlgsS8GSIn8bkkj9G1/8vQ+/w5iVIO+56X1S5vpo=
X-Received: by 2002:a0c:e44d:0:b0:4bb:6814:cacc with SMTP id
 d13-20020a0ce44d000000b004bb6814caccmr753711qvm.73.1666980566349; Fri, 28 Oct
 2022 11:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221020115513.93809-1-ulf.hansson@linaro.org>
 <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com> <CAPDyKFpo_JhpGRZwJExMxPoit7yzp_LByfUEbkkLZxgUdNGRFw@mail.gmail.com>
In-Reply-To: <CAPDyKFpo_JhpGRZwJExMxPoit7yzp_LByfUEbkkLZxgUdNGRFw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:09:15 +0200
Message-ID: <CAJZ5v0iQmOZAV_zXq=GkDsf3yc=LMhnfdTc3sozfC4w+APeEPw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Oct 2022 at 15:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 20, 2022 at 1:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > It's useful to understand whether we are using OS-initiated (OSI) mode or
> > > Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> > > Therefore, let's extend the print in the log after a successful probe with
> > > this information.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 821984947ed9..c80cf9ddabd8 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 goto remove_pd;
> > >
> > > -       pr_info("Initialized CPU PM domain topology\n");
> > > +       pr_info("Initialized CPU PM domain topology using %s mode\n",
> > > +               use_osi ? "OSI" : "PC");
> > >         return 0;
> > >
> > >  put_node:
> > > --
> >
> > Am I expected to pick up this one?
>
> Yes, please!

Done, thanks!
