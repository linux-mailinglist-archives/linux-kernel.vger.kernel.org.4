Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE33B70FDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjEXSW1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjEXSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:22:25 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8E119;
        Wed, 24 May 2023 11:22:24 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso30969566b.0;
        Wed, 24 May 2023 11:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952543; x=1687544543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4Pq8c6/Mm0bTSYRc0nbUAYoxH/lC7NnfksnqYojmek=;
        b=Dk/RvGMmkkeFYu/TYhV+0L1eUQHFELoBUXmmp5Gz00N9QF+UHaMoXztA3XIDaFtcYJ
         QTXHdNc0pXXoUP1ZKQlb4/34gVrTeO7KZffedpyLjZ3ysaDYR+plG1qmblWgU2SpiA8O
         02s5I2vqRPWMGPxishAx8MZJOPpBOOXb5I9gZz7ZibfdTulmr/D6HYGnR8bQDMGhd5KR
         Vd1t8KQgTBLe3+3Rxi9Cfzojo02ddwpsJELRAR1SO+HD6/vEAkcapF6Tdq1Kjhwce0eM
         Z6TxzogmHoQHJ7aNVyzHfRLrhex9/FF69L461p+yit6F8cQj30ArxY6aHUxYS+foWS4o
         qr+A==
X-Gm-Message-State: AC+VfDyKWNCMiqlV0aqQRMlw8qH9lsldH+B9lKTT45q5s5ZPMJcfmdzC
        7UEJbogXNZi5BeUrMezD0XPL2xvps1QGfrLVzWo=
X-Google-Smtp-Source: ACHHUZ6JK09ysT7P+S7ivY0fKx/cBz2plGL4iP23ASoPbLZXi8ad/mXO0yWabZ9nLQuzu3MmY7E9fgnSN5hNUqXUO6A=
X-Received: by 2002:a17:906:5189:b0:96f:469d:19ba with SMTP id
 y9-20020a170906518900b0096f469d19bamr17370163ejk.2.1684952542768; Wed, 24 May
 2023 11:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-1-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 20:22:11 +0200
Message-ID: <CAJZ5v0i1bYu0aPWc-xTG9HxOm_Ysczfo_cJPPV40MCG7qOGRTQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] thermal: enhancements on thermal stats
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> Hello Rafael and Daniel
>
> After a long hiatus, I am returning to more frequent contributions
> to the thermal subsystems, as least until I drain some of the
> commits I have in my trees.
>
> This is a first series of several that will come as improvements
> on the thermal subsystem that will enable using this subsystem
> in the Baseboard Management Controller (BMC) space, as part
> of the Nitro BMC project. To do so, there were a few improvements
> and new features wrote.
>
> In this series in particular, I present a set of enhancements
> on how we are handling statistics. The cooling device stats
> are awesome, but I added a few new entries there. I also
> introduce stats per thermal zone here too.
>
> I tried to keep documentation as current as possible.
> I may have missed a thing or two, so please help me out here.
> Testing/Examples are in each code.
>
> Let me know any feeback,
>
> BR,
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> Cc: linux-kernel@vger.kernel.org (open list)
>
> Eduardo Valentin (7):
>   thermal: stats: track time each dev changes due to tz
>   thermal: stats: track number of change requests due to tz
>   thermal: stats: introduce thermal zone stats/ directory
>   thermal: stats: introduce thermal zone stats/min_gradient
>   thermal: stats: introduce tz time in trip
>   ythermal: core: report errors to governors
>   thermal: stats: add error accounting to thermal zone
>
>  .../driver-api/thermal/sysfs-api.rst          |  10 +
>  drivers/thermal/thermal_core.c                |  15 +-
>  drivers/thermal/thermal_core.h                |  16 +
>  drivers/thermal/thermal_helpers.c             |  11 +-
>  drivers/thermal/thermal_sysfs.c               | 495 +++++++++++++++++-
>  include/linux/thermal.h                       |   5 +
>  6 files changed, 539 insertions(+), 13 deletions(-)
>
> --

There are still some other things I need to take care of before I can
get to this series, but I will get to it.

Thanks!
