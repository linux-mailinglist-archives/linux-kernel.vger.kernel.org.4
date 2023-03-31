Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10B6D1B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCaJMe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjCaJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:12:17 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BF1E71A;
        Fri, 31 Mar 2023 02:12:12 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id i5so87217423eda.0;
        Fri, 31 Mar 2023 02:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikgiRsxaZelZuPk3v/sEzGG6Y7xqHAIP/w4zhpKwmXI=;
        b=56e0hMJVyxpMKARoXDqLizCeDWo82ZAW/4iSadhDqNofwnTM09C1HXO0JZZyhaxeeV
         qe/cZGX4/GoWctPN17BRhw8490klzSKRdff7OSZUNZdDBMs/VFQgAG1GzF9RwrIC1kR9
         U8s8Ic0V+7NhSEW/WQTigdlJkH1Rz8hB4ROc8iBoXnv6/wT/w9LJC5Fj4gUE0qOsybYH
         3KC9pmGQhdTla9xSO2qMXDYlBEIctKOPHNJROgNqFgk5nMyjLrRX+LkDI3nlS409IEIq
         umvIVsb6pWl1w27ixOBjgM1gqJtHyajJmbMK8Fc9Poncso8SAyiZJGupELEBm3jKyLzv
         hvYQ==
X-Gm-Message-State: AAQBX9eZJFnX3psD6bgk3IDn02W4AMlCsP3bPtsw5VbhTcXWWLIqy/ub
        4UllFdHh1BK980X6k6L9bt2UnRK0XrJBsmx64LPJtIFdv4I=
X-Google-Smtp-Source: AKy350Y6gB52boMc4pK35wFsmKlAmNkgG41NIwqi+DmZb79Xmhsd9aliU7haa+qoOggeZClg+cDCXB5zxVesgDPXOi0=
X-Received: by 2002:a50:cc94:0:b0:4fb:c8e3:1ae2 with SMTP id
 q20-20020a50cc94000000b004fbc8e31ae2mr13363269edi.3.1680253930767; Fri, 31
 Mar 2023 02:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230330141314.1364083-1-wyes.karny@amd.com> <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
 <ZCZ5zjw+O3gS6trx@bhagirati.amd.com>
In-Reply-To: <ZCZ5zjw+O3gS6trx@bhagirati.amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 11:11:59 +0200
Message-ID: <CAJZ5v0iwmvnTFVKhox11gKxM8UBR+=748zPB0tr_O5mPBbkpiA@mail.gmail.com>
Subject: Re: [PATCH] amd-pstate: Fix amd_pstate mode switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
        ray.huang@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
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

On Fri, Mar 31, 2023 at 8:12 AM Wyes Karny <wyes.karny@amd.com> wrote:
>
> Hi Rafael,
>
> On 30 Mar 20:19, Rafael J. Wysocki wrote:
> > On Thu, Mar 30, 2023 at 4:13 PM Wyes Karny <wyes.karny@amd.com> wrote:
> > >
> > > amd_pstate mode can be changed by writing the mode name to the `status`
> > > sysfs. But some combinations are not working. Fix this issue by taking
> > > care of the edge cases.
> > >
> > > Before the fix the mode change combination test fails:
> > >
> > >  #./pst_test.sh
> > > Test passed: from: disable, to
> > > Test passed: from: disable, to disable
> > > Test failed: 1, From mode: disable, to mode: passive
> > > Test failed: 1, From mode: disable, to mode: active
> > > Test failed: 1, From mode: passive, to mode: active
> > > Test passed: from: passive, to disable
> > > Test failed: 1, From mode: passive, to mode: passive
> > > Test failed: 1, From mode: passive, to mode: active
> > > Test failed: 1, From mode: active, to mode: active
> > > Test passed: from: active, to disable
> > > Test failed: 1, From mode: active, to mode: passive
> > > Test failed: 1, From mode: active, to mode: active
> > >
> > > After the fix test passes:
> > >
> > >  #./pst_test.sh
> > > Test passed: from: disable, to
> > > Test passed: from: disable, to disable
> > > Test passed: from: disable, to passive
> > > Test passed: from: disable, to active
> > > Test passed: from: passive, to active
> > > Test passed: from: passive, to disable
> > > Test passed: from: passive, to passive
> > > Test passed: from: passive, to active
> > > Test passed: from: active, to active
> > > Test passed: from: active, to disable
> > > Test passed: from: active, to passive
> > > Test passed: from: active, to active
> > >
> > > Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")
> > >
> > > Acked-by: Huang Rui <ray.huang@amd.com>
> > > Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > Cc: Perry Yuan <Perry.Yuan@amd.com>
> >
> > This is all fine, but you need to tell me how it interacts with the
> > amd-pstate changes in linux-next.
> >
> > Does it affect the code in linux-next at all or is it only for 6.3-rc?
> >
>
> This is only for 6.3-rc.
> The commit 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control
> support via sysfs") in linux-next may not apply cleanly after this fix.
> Please let me know if I need to rebase and send the guided mode patches [1].
>
> [1]: https://lore.kernel.org/linux-pm/20230307112740.132338-1-wyes.karny@amd.com/

Well, instead, you please let me know how to resolve the merge
conflict between the patch below and your series.

Can I simply assume that the code added by commit 3ca7bc818d8c
replaces the code modified by the $subject patch?

> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > index 73c7643b2697..8dd46fad151e 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -840,22 +840,20 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> > >
> > >         switch(mode_idx) {
> > >         case AMD_PSTATE_DISABLE:
> > > -               if (!current_pstate_driver)
> > > -                       return -EINVAL;
> > > -               if (cppc_state == AMD_PSTATE_ACTIVE)
> > > -                       return -EBUSY;
> > > -               cpufreq_unregister_driver(current_pstate_driver);
> > > -               amd_pstate_driver_cleanup();
> > > +               if (current_pstate_driver) {
> > > +                       cpufreq_unregister_driver(current_pstate_driver);
> > > +                       amd_pstate_driver_cleanup();
> > > +               }
> > >                 break;
> > >         case AMD_PSTATE_PASSIVE:
> > >                 if (current_pstate_driver) {
> > >                         if (current_pstate_driver == &amd_pstate_driver)
> > >                                 return 0;
> > >                         cpufreq_unregister_driver(current_pstate_driver);
> > > -                       cppc_state = AMD_PSTATE_PASSIVE;
> > > -                       current_pstate_driver = &amd_pstate_driver;
> > >                 }
> > >
> > > +               current_pstate_driver = &amd_pstate_driver;
> > > +               cppc_state = AMD_PSTATE_PASSIVE;
> > >                 ret = cpufreq_register_driver(current_pstate_driver);
> > >                 break;
> > >         case AMD_PSTATE_ACTIVE:
> > > @@ -863,10 +861,10 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> > >                         if (current_pstate_driver == &amd_pstate_epp_driver)
> > >                                 return 0;
> > >                         cpufreq_unregister_driver(current_pstate_driver);
> > > -                       current_pstate_driver = &amd_pstate_epp_driver;
> > > -                       cppc_state = AMD_PSTATE_ACTIVE;
> > >                 }
> > >
> > > +               current_pstate_driver = &amd_pstate_epp_driver;
> > > +               cppc_state = AMD_PSTATE_ACTIVE;
> > >                 ret = cpufreq_register_driver(current_pstate_driver);
> > >                 break;
> > >         default:
> > > --
> > > 2.34.1
> > >
