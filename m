Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD0642029
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiLDW7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLDW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:59:24 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEAA10048
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 14:59:23 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id z23so622293vkb.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U1YCWugnt7NNcwN1mLvIio05PcYTCT5nH/7JzPuEAF4=;
        b=MeZNB9/YoNEJG11VARRGWae/1ItbIoyRu5aQ36YsOEIFBl+tv4RFRIPPcSVlt4uXg+
         rBrzktWDyGBkjcPeDJ64CNwJLYUUJAPYYhQ+0+hNxEodZIcyakPwB+BPPUtg6a+6G1+g
         X/pFg3jK9Cz1QBxXG1EQ65sMn80ePUeIXRqRGnuD/MUZBu/Fb+X8MqICRHfKLCcfPlMx
         f7Xdk9fvcyi73Bc6oycAEBanlqELODr6wnMTmzr3+jxo96XQuFg2ns+XsOG2Vtd+d46r
         34TyTzhfzWAPa3QPp5oRqSxIlKxM3VxCKph8Nwm64PySn+1p9w8HApHiwNEbuUNoSaVB
         tGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1YCWugnt7NNcwN1mLvIio05PcYTCT5nH/7JzPuEAF4=;
        b=Kes9rCieLM2uF/5GAlGppEIoCULA6/H38/0BujEMwIOkp9ZpBPsd41kKgmQ2vbN2kI
         74X/wb5vmf7SrTQ2fJHOFBMM7Zi8N9yJXj3SfiLkQ1YP6U8j6/Ah1oLWiNLdXhxd8+R+
         Nx6cX8Dv6F+J7MoZ4z0TzZAYYKK7h3cS/kMBW7HVq5+4P5+CuIACB1nmO/thA6Szzrsd
         BW3cZ2+PIC31OCOrEbWRFwz3qi/0gsdg6OKbkRSIij90g4lHfNhZKJqovlFpeutVEEMh
         dNR9DvLOiU/0+vduM2lr3symeJlWYBiPuTMu5PEBoGhSoVa64QVJFvrGke+i6fvshJeG
         aIww==
X-Gm-Message-State: ANoB5pmcqpwuB178WLrLGFQYznLnMiMAk6io4TYT8O0udEv7bVLYkTqY
        mX60C33ghORbvVg5D6/DgiKx5iPSpzoMjv/6pbDLA3XncDhBPQ==
X-Google-Smtp-Source: AA0mqf5x2PSpwgMuZHGI0b78Lrjpb6NlNe7Isuc6zHyZXrqZoLLufMiKNgYIEa8SLzR7fGAdy8XyYE8dK+xh80zTF9s=
X-Received: by 2002:a05:6122:1243:b0:3bd:730b:ef5a with SMTP id
 b3-20020a056122124300b003bd730bef5amr4334490vkp.29.1670194762270; Sun, 04 Dec
 2022 14:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20221202141630.41220-1-tcm1030@163.com> <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
In-Reply-To: <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 4 Dec 2022 15:58:46 -0700
Message-ID: <CAOUHufZaL2S6Aa1ey3Mk+h+bGr2Tbg_LxOkjbuj87psukPe-gQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: failed to disable numa balancing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tzm <tcm1030@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 1:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  2 Dec 2022 22:16:30 +0800 tzm <tcm1030@163.com> wrote:
>
> > It will be failed to  disable numa balancing policy permanently by passing
> > <numa_balancing=disable> to boot cmdline parameters.
> > The numabalancing_override variable is int and 1 for enable -1 for disable.
> > So, !enumabalancing_override will always be true, which cause this bug.

!enumabalancing_override is false when enumabalancing_override = -1
(numa_balancing=disable).

> That's really old code!
>
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2865,7 +2865,7 @@ static void __init check_numabalancing_enable(void)
> >       if (numabalancing_override)
> >               set_numabalancing_state(numabalancing_override == 1);
> >
> > -     if (num_online_nodes() > 1 && !numabalancing_override) {
> > +     if (num_online_nodes() > 1 && (numabalancing_override == 1)) {
> >               pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
> >                       numabalancing_default ? "Enabling" : "Disabling");
> >               set_numabalancing_state(numabalancing_default);
>
> Looks right to me.  Mel?
>
> After eight years, I wonder if we actually need this.

NAK.

The original code works as intended. This patch breaks my test with
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=n and numa_balancing=enable.
