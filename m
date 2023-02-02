Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C476884B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBBQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBBQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:44:32 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199254B8B5;
        Thu,  2 Feb 2023 08:44:31 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id n6so2607407edo.9;
        Thu, 02 Feb 2023 08:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px1xcB23kP4MnnGGoCIIfo3EkxqRE3bJUNzTnkZ3uHA=;
        b=Ah8n2j73pdE0qNLJQ2I9u5mr5YcI7m+cfiffNlFnUrwiZy5zNSWima8F3/U215l7fy
         4xProjV97YXHAeVRbe+bxqdDkpiEnH6smQZv8XK2mWwy2zqPdFitZu8ySn0oxp9eRmYx
         UUYgaDoJ254rC70IeooVvsXe3JDYdjZHYXtD5MhiVjnIDJguMt3lVLXgewa9/P8+P9g0
         iVpoc1nY81r+N/9ZNVnomkSp+7xfVVsKil2J6WN110WW3FSjQGH/nbdwDNLNmgZhzYw0
         NbQkeWBUvdxDA937HpQLlGlaP+QlsoWrSvLdpVWg6IAFRvjgGd9cPs4zrzDEzH2fb+RF
         zJIw==
X-Gm-Message-State: AO0yUKVEGaazu0RGtAaOSq48l4lhJXTozMMqtHTK0MjtjLg+LhGxAjiX
        Hrb43zncZWQgpoOngjA6XYorIWYm2TvxPas4YSU=
X-Google-Smtp-Source: AK7set+jGfvAz09eI0nUDLd85R5enTo+FwH49qmQ0GzuaFTkZ68NhlEqlk632rxiUxb99M/+E3qXdk/UVwVl/IORYJQ=
X-Received: by 2002:a05:6402:22ee:b0:4a2:1d19:ca14 with SMTP id
 dn14-20020a05640222ee00b004a21d19ca14mr2180460edb.68.1675356269576; Thu, 02
 Feb 2023 08:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20230201210712.2170312-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230201210712.2170312-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 17:44:18 +0100
Message-ID: <CAJZ5v0ieQocb2oe1ggDCOos4HtkmypsadMkXCwH2J5XmRUdVyQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Return last requested state as cur_state
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
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

On Wed, Feb 1, 2023 at 10:07 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the user is reading cur_state from the thermal cooling device for
> Intel powerclamp device:
> - It returns the idle ratio from Package C-state counters when
> there is active idle injection session.
> - -1, when there is no active idle injection session.
>
> This information is not very useful as the package C-state counters vary
> a lot from read to read. Instead just return the last requested cur_state.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 2f4cbfdf26a0..72a45cf2708c 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -590,17 +590,7 @@ static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
>  static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long *state)
>  {
> -       if (clamping) {
> -               if (poll_pkg_cstate_enable)
> -                       *state = pkg_cstate_ratio_cur;
> -               else
> -                       *state = set_target_ratio;
> -       } else {
> -               /* to save power, do not poll idle ratio while not clamping */
> -               *state = -1; /* indicates invalid state */
> -       }
> -
> -       return 0;
> +       return set_target_ratio;

*state = set_target_ratio;
return 0;

>  }
>
>  static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
> --

And please rebase it on top of the idle_inject series (which is being
added to my bleeding-edge branch right now).
