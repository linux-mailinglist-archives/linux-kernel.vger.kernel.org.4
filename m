Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34837297AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbjFILBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjFILAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:00:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC72697
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:00:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba8151a744fso1642225276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686308433; x=1688900433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4Y48r3j1MQPLlV/kjC9yfsXr4I31wdq934Y1dJ0Nsk=;
        b=Bq0+pzwMrRaOH2aSm04bqk6dDxzo7qINbAi33GZ7y6PikMkHTdzyGsUbVtNyBGkfKu
         XbJLppmitzUnNRUYBC2L+BI8p03SqtbhvCa6fOnF9uZRj0TSC9LoivAn0TkDxoD0E8Sj
         yk7nnh5LQmwaM6GKwI7y8T50m7+g4L3BUH6OCb9O3R3N24ThjsP4udl1ISI7k00FwWhG
         t+keiDdmVTnPz1k+YiXJbYfYEHS020ohkT8i8RpfUjq5pUQX0zxRQ73bVmnC0BvBPJul
         q2zN4voQg2fIszHR1GDhnvwcCFz6NnyxXeGIZ9IUUXAyVL0KhfhVbWLQ0rf5m3OzKg8F
         cvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308433; x=1688900433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4Y48r3j1MQPLlV/kjC9yfsXr4I31wdq934Y1dJ0Nsk=;
        b=VkEWxlLt56ArZ7g2tipykPRUCghine/vOsGyyTQZDWypksR7pkHzUU1uae13HoJPt8
         q+i7M2KGMTQYjaAK/voqtY6UOq6TKq9VgD86R8y44MFTPdSazzQqj0pObz+Asx4UYMcG
         IspZ+JKgHnzCmozTnVJOqKRJ3hhySlnAF+nlEyMqs93nsXKRtfm02yoNpYfs7M1+sfIM
         GmYrLSv/X0P0god3XUkPAVYUFhPVSrjGhq+8QfKSp+aU7eRmxeoRjqXGrQoYUhNM5zfO
         RlGuF261S8wuftXfDcBrpYiurZ7Rw9xpPp7zRF1MQgfcukEZkwEJ1BW1hd5FadVM6L6u
         /JVw==
X-Gm-Message-State: AC+VfDzoc+byXAelegvvKrJwhCDUjMDt8eVC6HGIz1l7nc/rK3i1dbTV
        Gv70vk5/zyocAK+n0rUNL4D0HSPci0u0D0CWfN6sEw==
X-Google-Smtp-Source: ACHHUZ7tJfEx3W5/3301HQ0zS8Igb3M5tusRxraMhy4mbwMtzbL2oMSIfqUeiAMPzKKjwpGEgDq1PmpMtn28IjP0fGY=
X-Received: by 2002:a0d:f944:0:b0:55a:c62:3a92 with SMTP id
 j65-20020a0df944000000b0055a0c623a92mr749035ywf.29.1686308433306; Fri, 09 Jun
 2023 04:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org> <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
 <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com>
 <20230608104540.tykxtvwhoyogthw5@vireshk-i7> <CAPDyKFrbpm0W1Hdv+85MqMAC2-UbPOE6qp26L0UvVF0sSL2ayA@mail.gmail.com>
 <20230609051005.fxuvp4ilcjvhhrkc@vireshk-i7>
In-Reply-To: <20230609051005.fxuvp4ilcjvhhrkc@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 12:59:57 +0200
Message-ID: <CAPDyKFobvMr0LBr0PW3L-A=dtE2jnd2RxHktN85Z9dLsi8u3TQ@mail.gmail.com>
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 at 07:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-06-23, 13:45, Ulf Hansson wrote:
> > Okay, if I understand your point you want to avoid creating OPPs for
> > each device, but rather coupling them with the genpd provider's OPP
> > table. Right?
>
> Not exactly :)
>
> > Note that, there is no such thing as a "required opp" in the SCMI
> > performance protocol case. A device is compatible to use all of the
> > OPPs that its corresponding SCMI performance domain provides. Should
> > we rename the required opp things in the OPP core to better reflect
> > this too?
>
> Not really :)

I think it may be confusing, but okay, let's leave it as is.

>
> > That said, we still need to be able to add OPPs dynamically when not
> > based on DT. The difference would be that we add the OPPs when
> > initializing the genpd provider instead of when attaching the devices.
> > In other words, we still need something along the lines of the new
> > dev_pm_opp_add_dynamic() API that $subject series is introducing, I
> > think.
>
> That's fine.
>
> > Moreover, to tie the consumer device's OPP table to their genpd
> > provider's OPP table (call it required-opp or whatever), we need
> > another OPP helper function that we can call from the genpd provider's
> > ->attach_dev() callback. Similarly, we need to be able to remove this
> > connection when genpd's ->detach_dev() callback is invoked. I will
> > think of something here.
>
> Something like set/link/config_required_opp()..
>
> > Finally, I want to point out that there is work going on in parallel
> > with this, that is adding performance state support for the ACPI PM
> > domain. The ACPI PM domain, isn't a genpd provider but implements it's
> > own PM domain. The important point is, that it will have its own
> > variant of the dev_pm_genpd_set_performance_state() that we may need
> > to call from the OPP library.
>
> Okay.
>
> Let me explain how structures are linked currently with help of below (badly
> made) drawing. The 'level' fields are only set for Genpd's OPP entries and not
> devices. The genpd OPP table normally has only this information, where it
> presents all the possible level values, separate OPP for each of them.
>
> Now the devices don't have `level` set in their OPP table, DT or in C
> structures. All they have are links for required OPPs, which help us find the
> required level or performance state for a particular genpd.
>
>   +-----------------+                    +------------------+
>   |  Device A       |                    | GENPD OPP Table  |
>   +-----------------+  required-opps     +------------------+   required-opps
>   |OPP1: freq: x1   +--------------------+ OPP1:            +--------------+
>   +-----------------+                    |      level: 1    |              |
>   |OPP2: freq: y1   +-----------+        +------------------+              |
>   +-----------------+           |        | OPP2:            +---------+    |
>   |OPP3: freq: z1   +--------+  +--------+      level: 2    |         |    |
>   +-----------------+        |           +------------------+         |    |
>                              |           | OPP3:            +--+      |    |
>                              |           |      level: 3    |  |      |    |
>                              |           +------------------+  |      |    |
>   +-----------------+        |           | OPP4:            |  |      |    |
>   |  Device B       |        +-----------+      level: 4    |  |      |    |
>   +-----------------+                    +------------------+  |      |    |
>   |OPP1: freq: x2   +------------------------------------------+      |    |
>   +-----------------+                                                 |    |
>   |OPP2: freq: y2   +-------------------------------------------------+    |
>   +-----------------+                                                      |
>   |OPP3: freq: z2   +------------------------------------------------------+
>   +-----------------+
>

Thanks for taking the time to explain things further! It's not
entirely easy to follow all the things in the OPP library.

However, I think you are mixing up the "level" field with the "pstate"
field in the struct dev_pm_opp. The pstate field is solely for genpd
and the required opps, while level is *generic* for all types of
devices. Right?

More precisely, _read_opp_key() parses for the "opp-level" property
from DT to set the ->level field. Additionally, the generic OPP
helpers functions, like dev_pm_opp_get_level(),
dev_pm_opp_find_level_exact(), dev_pm_opp_find_level_ceil() allows any
type of consumer driver to operate on the level for an OPP for its
device. Please have a look at the apple-soc-cpufreq, for example.

>
> What I am asking you to do now is, create an OPP table for the Genpd first, with
> OPPs for each possible level. Now the Genpd layer creates the OPP table for
> Device A, where it won't fill the levels, but all other fields and then use a
> new API to add required OPPs for the device's OPP, which will point into Genpd's
> OPP entries. And with that the existing code will work fine without any other
> modifications.
>
> Does this help ?

Well, I think what you propose may be doable, but I fail to understand
the benefit of implementing it like that.

As I said earlier, there is no such thing as a required OPP for the
SCMI performance domain and neither are the OPP tables described in
DT.

Moreover, as I understand it, we already have the generic "level" to
use, why not use it here?

Kind regards
Uffe
