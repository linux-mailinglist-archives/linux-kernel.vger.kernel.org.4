Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4A69115E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBITbA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBITa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:30:58 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F56192;
        Thu,  9 Feb 2023 11:30:57 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id u21so3063330edv.3;
        Thu, 09 Feb 2023 11:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRNBZ9IKSCzIf3bDsBgwoDNrUF4puPgR64KPFao4n1E=;
        b=BQXj9L9DSp6h3IaKEW/oMvbCnHroEWrtkSMhs0Jg3Vhr1Tr5byOlpDT6kyVcd/ZOkC
         tywuLBvEiN6DFBwb8KQb8yc460LYxeKSK+3zP16fY6prgFpc/DebM7p6qYLpHdFEvZdA
         3uYLAFL1Nn9gSoiBMkNEySt5gf8uSYpyOKxgXQ/pNwT/M03HiqvaK1bhHVxFKP3wyaSo
         tOldVuGeVI6vAx+LFDH9y0qhMIWO8ssnFb+JbMWfRZKh5eKzp7+/SJylXU2ovYNIYmNX
         p5RUXWhuoJ0OKy/d92sLqiATZ5aQbMJqyEGX4FvUONfJ5kIH+Z5kudO2Slr8K6TQqrYA
         t6Pw==
X-Gm-Message-State: AO0yUKUYyLW94OYsyfT/BCrOCVZKm++uLSpAIcQh9/cxTNm41UJoTduk
        pdt2z6evCDiyk1waSkM+LaV2meel1WHUhq48yGb0U09b
X-Google-Smtp-Source: AK7set83zyaVsmviZsytUfEdR6S+LSDAFDI/reqhFy9DAnj4nCNrtWk3adJNlx15QYVsuZHzzsz/jFQToKQyI5/f79o=
X-Received: by 2002:a50:9ecb:0:b0:49d:ec5d:28b4 with SMTP id
 a69-20020a509ecb000000b0049dec5d28b4mr2826212edf.6.1675971056200; Thu, 09 Feb
 2023 11:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20230207-kobj_type-cpufreq-v1-1-c7fa2dbd0754@weissschuh.net> <20230208050411.2byi4nfsfiyakfyq@vireshk-i7>
In-Reply-To: <20230208050411.2byi4nfsfiyakfyq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:30:45 +0100
Message-ID: <CAJZ5v0h3E7x-0FkLG0fDv0qi-8W+GCS6gmpJtvxPWTVLTWH_KQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Make kobj_type structure constant
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 8, 2023 at 6:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-02-23, 19:58, Thomas Weißschuh wrote:
> > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > the driver core allows the usage of const struct kobj_type.
> >
> > Take advantage of this to constify the structure definition to prevent
> > modification at runtime.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 7e56a42750ea..ceb1574417f9 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -993,7 +993,7 @@ static const struct sysfs_ops sysfs_ops = {
> >       .store  = store,
> >  };
> >
> > -static struct kobj_type ktype_cpufreq = {
> > +static const struct kobj_type ktype_cpufreq = {
> >       .sysfs_ops      = &sysfs_ops,
> >       .default_groups = cpufreq_groups,
> >       .release        = cpufreq_sysfs_release,
> >
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.3 material, thanks!
