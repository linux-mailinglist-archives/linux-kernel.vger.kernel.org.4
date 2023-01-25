Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B867B3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjAYOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjAYOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:04:09 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE37B458;
        Wed, 25 Jan 2023 06:04:07 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id mp20so47852676ejc.7;
        Wed, 25 Jan 2023 06:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaQLLyWQMu0cYP6O6gnotQPF1R1OOQ10sIq9rkF2ReQ=;
        b=u93EQ5/n9/qkhDkPsma/1fABZjnfVaJSOxoXdfB8HNQsnVlo0siI1wymnfq1tTQtge
         dTkvjmFG/BH9V8d1JObQAL+1RPkHK24cDVuBvK/hM1Nq17zxrd+XpbzsyuH34/LJCndt
         A2DgzuPQ93KVhyv2j2OapX2V9Na4A7uo5Z9XHaKow0FNrc5lLc+AAtB646DKqo3p7cAM
         h3K4ac546pclgthEJAGYlgcqf63PEKykGfn7r8K75mDkwcRBT60hL4U4BJUDFjgZUyfr
         1B7FuOuWRxcWIEEaioN/AqT+lW5TrokavRNz9sKj5IWw5Dt7hSyNVdFqfT3Q+NG8n+AF
         u74w==
X-Gm-Message-State: AFqh2kocYAx3rgfy17btlA6sh2FSW4vqP3mAtQ+kPsAiwRujEfFrRiP0
        wBumwopbO9B4oBbufbRBvuGms9+eDse38UKpzIM=
X-Google-Smtp-Source: AMrXdXvc6pde4wRliLQh07o2Rero2AincHDkvUZhLpLTyEkQCpZyRbSkfS1vi99Kj+jYmmiKjE4rIAQAgzHrWPOpaY4=
X-Received: by 2002:a17:906:d101:b0:84d:3813:fb8 with SMTP id
 b1-20020a170906d10100b0084d38130fb8mr4509019ejz.384.1674655446166; Wed, 25
 Jan 2023 06:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org> <3e2c6c44-f562-28ff-26cc-933f386e9719@linaro.org>
In-Reply-To: <3e2c6c44-f562-28ff-26cc-933f386e9719@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Jan 2023 15:03:54 +0100
Message-ID: <CAJZ5v0iH283yXWdzTN1Gb2xBUjy0E04zEgrny1N6QcsAwsJyyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Misc thermal cleanup and fixes
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jan 25, 2023 at 12:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> will you take this series on your branch ?

Yes, I'm planning to do that, if I don't find any issues with it (not
likely though).

> On 23/01/2023 16:27, Daniel Lezcano wrote:
> > This series is based on linux-pm/thermal
> >
> > It unregisters the netlink generic family for thermal in case the thermal
> > framework fails to initialize, removes a unneeded ida_destroy() call and moves
> > the thermal trip code in a separate file.
> >
> > A couple of changes have been removed from the previous version:
> >
> >   - Ordering the trip points. Some consolidation is needed in the set_trip_temp
> >     ops before ordering the trip points, so this change is postpone
> >
> >   - Remove the mutex destroy call. Even if the call is not needed, the
> >     justification of the change is not accurate. So it is postponed also.
> >
> >   V2:
> >     - Removed ordering the trip points change
> >     - Removed mutex destroy change
> >     - Added "No functional change intented" as requested by Rui
> >     - Added the function declaration for_each_thermal_trip
> >
> > Daniel Lezcano (3):
> >    thermal/core: Fix unregistering netlink at thermal init time
> >    thermal/core: Remove unneeded ida_destroy()
> >    thermal/core: Move the thermal trip code to a dedicated file
> >
> >   drivers/thermal/Makefile          |   4 +-
> >   drivers/thermal/thermal_core.c    |  93 +--------------
> >   drivers/thermal/thermal_core.h    |   4 +
> >   drivers/thermal/thermal_helpers.c |  62 ----------
> >   drivers/thermal/thermal_netlink.c |   5 +
> >   drivers/thermal/thermal_netlink.h |   3 +
> >   drivers/thermal/thermal_trip.c    | 182 ++++++++++++++++++++++++++++++
> >   7 files changed, 199 insertions(+), 154 deletions(-)
> >   create mode 100644 drivers/thermal/thermal_trip.c
> >
>
> --
