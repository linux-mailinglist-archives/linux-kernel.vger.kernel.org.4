Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C30738D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFURpW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFURog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:44:36 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604819B7;
        Wed, 21 Jun 2023 10:44:25 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98771dde617so152722466b.1;
        Wed, 21 Jun 2023 10:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369463; x=1689961463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPP0mPj5nbFg1qXiSwWCfH7vtlRuQT6WtSGooLQEenE=;
        b=dJt8mEb8pTfWU2BZviQVW+B5Noy/HU/yyvktioqCNW+7PHrv5hXx08AqHKZGWCjVcK
         LlY3nFLQfAGmBhxWc073QHIJdh93q1EAGl0jBjY6K+iTofnSmch8Tf8M3MYtfy6sxb8F
         bwZQTjk/e6ZoY2YfTKCM02/tOM8UMRxCGxrpU9DqkdKZ8AiRqWxkw7Qziw3CceZ7Nw8L
         sIlyMqYPRl0A8eTteKbsgSF5SZGwv/fs6W3Odtm9/AY8Tnfi73cmSsL54hRe/0ZBx6H2
         1RQfPK4Oa/N/riqGtyCcL9LDXQBpdenvw+285SWwuSfrfHNEZ8SLfOq/1SBdOvD6ufL9
         3sLQ==
X-Gm-Message-State: AC+VfDxLVdeGYi0r/pmkn6+Z8B6VO1GrmE/0bB0slrf+QH6pkbCepl12
        P+XuivoYtYhxOIRVgFYIIPERZI4J0Hh82aoScPM=
X-Google-Smtp-Source: ACHHUZ5dKfCgP20hTSW+uzRzj2RfHqhSIXk/XQ2ZkO3iV0NLw98udJ1Tz6fze1M62rYMh43Neqdr6diLfxGix27ZIrk=
X-Received: by 2002:a17:906:5198:b0:987:6960:36c8 with SMTP id
 y24-20020a170906519800b00987696036c8mr10037606ejk.7.1687369463296; Wed, 21
 Jun 2023 10:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230621065839.635809-1-tero.kristo@linux.intel.com>
In-Reply-To: <20230621065839.635809-1-tero.kristo@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 19:44:12 +0200
Message-ID: <CAJZ5v0j8nebEAjC3L--Dz-2UkHUDAPxMTJ5P2zAh+=yVW4ASyg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix energy_performance_preference
 for passive
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Neronin <niklas.neronin@intel.com>
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

On Wed, Jun 21, 2023 at 8:59 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> If the intel_pstate driver is set to passive mode, then writing the
> same value to the energy_performance_preference sysfs twice will fail.
> This is caused by the wrong return value used (index of the matched
> energy_perf_string), instead of the length of the passed in parameter.
> Fix by forcing the internal return value to zero when the same
> preference is passed in by user. This same issue is not present when
> active mode is used for the driver.
>
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> Reported-by: Niklas Neronin <niklas.neronin@intel.com>
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..f29182512b98 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -824,6 +824,8 @@ static ssize_t store_energy_performance_preference(
>                         err = cpufreq_start_governor(policy);
>                         if (!ret)
>                                 ret = err;
> +               } else {
> +                       ret = 0;
>                 }
>         }
>
> --

Applied as 6.5 material, thanks!
