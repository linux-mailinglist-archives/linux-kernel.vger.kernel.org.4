Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14CA6441F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiLFLSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLFLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:18:07 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10484B7FC;
        Tue,  6 Dec 2022 03:18:07 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id j13so5635338qka.3;
        Tue, 06 Dec 2022 03:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWX+0gFTn6vrtIsh2oO/disr1cRqUl9RDmGpALVIz7s=;
        b=EPnS16Tqg7JUY2o2d14dUFv7YmPh24k50qwRyAwYBkzDVIHFgl+CwciPlO7sXO7/XQ
         QkYrHax/tCApBVaB0ewHPzjMW4L1xYlhR3pHpT6geDaPWSMIqZzn8AR2GJ+hmB7vUpzz
         uFN0YetX6giIva1+ZjTVYoOIUp8bghg5YPvaB9LY3YuuDZI3R3LyoSbUaY+DDmkTp5gQ
         4yrGmEpD3UwnPIiA8sOAy7ka3rNuo5XvrWkOsYgAmQdppxtrIhknRTViLPv/hMf+qwjf
         LRLf6ZDTb3JqWCwXi7Ig9TgMF+rHTXX8YA1/zRh6v5M2txYndXk39yvyIh8ilbmo78rw
         3VhQ==
X-Gm-Message-State: ANoB5pmVqSM3CocvgHAFMDAwt31zwMy7+04L0VKXj8RURcgY183vQbBR
        c8xRLp+2ttPZNh2wLxR/3Vz+6SQFPxdatB0Hd8wvfcPa
X-Google-Smtp-Source: AA0mqf7lGO4TlJnMxS604hbIToUZ9HaxYoRRgjM3tC075xWBc2rPnLLVESE8MBgYWc1LcrC6YH5m2UoCxn97uAC6SSI=
X-Received: by 2002:a37:ad0c:0:b0:6ee:91b3:2484 with SMTP id
 f12-20020a37ad0c000000b006ee91b32484mr74295385qkm.648.1670325486178; Tue, 06
 Dec 2022 03:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20221205175744.9746-1-stuart.w.hayes@gmail.com>
 <e5e024a2-a530-9f4f-76f4-5f239b3608a3@gmail.com> <Y48XUjSMWVvohIy3@zn.tnic>
In-Reply-To: <Y48XUjSMWVvohIy3@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:17:54 +0100
Message-ID: <CAJZ5v0gfVgUOqJxyxDuNhNAhZoi3ODZBeUL_iz0o5eA+ZgfQng@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Only set boost MSRs on supported CPUs
To:     Borislav Petkov <bp@alien8.de>,
        stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 11:20 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Dec 05, 2022 at 12:07:05PM -0600, stuart hayes wrote:
> >
> >
> > On 12/5/2022 11:57 AM, Stuart Hayes wrote:
> > > Stop trying to set boost MSRs on CPUs that don't support boost.
> > >
> > > This corrects a bug in the recent patch "Defer setting boost MSRs".
> > >
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > ---
> > >   drivers/cpufreq/acpi-cpufreq.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > > index bb58175a8d40..a7c5e312340e 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -888,7 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > >     if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
> > >             pr_warn(FW_WARN "P-state 0 is not max freq\n");
> > > -   set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> > > +   if (acpi_cpufreq_driver.set_boost)
> > > +           set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> > >     return result;
> >
> > My apologies--adding Boris, I forgot to put him on the "to" list.
>
> Yap, that does it.
>
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

OK, applied, thanks!
