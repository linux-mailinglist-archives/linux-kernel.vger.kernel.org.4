Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50C6D0DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjC3STs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjC3STq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:19:46 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598FEC5B;
        Thu, 30 Mar 2023 11:19:45 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id i5so80202839eda.0;
        Thu, 30 Mar 2023 11:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STSBMurQeIiaZJ0+aAMioO6okKVvv9dt5WY+P9P2Ffs=;
        b=oAomp/ERjeZ3KCykPrGL0ZpiUrj23h597cHdls85PFyudshwQczTOMCFPyn36ZuFCC
         PALhsuS6EZ9/9OOcyDZfr40uIYD7xQMNcIzrTVp6q8R618goyJrZ/PmatdW9zEciQz7b
         0nzxv5Zkz2VFnkgyjaQS5SwoD17W5YyYQsgMe3QsLkkZaBddjbGMBjDDfAZWUdvkR/ec
         ad5R8w/N0hnVqVSyeG9KJ8j0iabcNEJuc9b7KSecS4NyEnwut43XZtoVkgQcllv9PZLD
         RAwCvy5W1dKIqGhFkGqi5YkYyiIu+smdmNND5snSms6NfW+s+VLeutsQ84zl4ACoT49N
         YTiw==
X-Gm-Message-State: AAQBX9dwYkSORF9bDf6qBU3+KMgBnDsT6X8gUGmDog2DtSNu2HT2mAAa
        eiUJz2y4bfGeGwvkv7VcvPT4EVtoO5r5fa6A168=
X-Google-Smtp-Source: AKy350ZFlQ9uvB/2IZQZth1I/dMU9HgfQQVqbdU/38YFudco92YyBhJH7q0MdiUGPR+8VkkW71+dpX8o8y/D+HtoQoQ=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr12039537edi.3.1680200383708; Thu, 30
 Mar 2023 11:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230330141314.1364083-1-wyes.karny@amd.com>
In-Reply-To: <20230330141314.1364083-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 20:19:32 +0200
Message-ID: <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
Subject: Re: [PATCH] amd-pstate: Fix amd_pstate mode switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@amd.com>,
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

On Thu, Mar 30, 2023 at 4:13 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> amd_pstate mode can be changed by writing the mode name to the `status`
> sysfs. But some combinations are not working. Fix this issue by taking
> care of the edge cases.
>
> Before the fix the mode change combination test fails:
>
>  #./pst_test.sh
> Test passed: from: disable, to
> Test passed: from: disable, to disable
> Test failed: 1, From mode: disable, to mode: passive
> Test failed: 1, From mode: disable, to mode: active
> Test failed: 1, From mode: passive, to mode: active
> Test passed: from: passive, to disable
> Test failed: 1, From mode: passive, to mode: passive
> Test failed: 1, From mode: passive, to mode: active
> Test failed: 1, From mode: active, to mode: active
> Test passed: from: active, to disable
> Test failed: 1, From mode: active, to mode: passive
> Test failed: 1, From mode: active, to mode: active
>
> After the fix test passes:
>
>  #./pst_test.sh
> Test passed: from: disable, to
> Test passed: from: disable, to disable
> Test passed: from: disable, to passive
> Test passed: from: disable, to active
> Test passed: from: passive, to active
> Test passed: from: passive, to disable
> Test passed: from: passive, to passive
> Test passed: from: passive, to active
> Test passed: from: active, to active
> Test passed: from: active, to disable
> Test passed: from: active, to passive
> Test passed: from: active, to active
>
> Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")
>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Perry Yuan <Perry.Yuan@amd.com>

This is all fine, but you need to tell me how it interacts with the
amd-pstate changes in linux-next.

Does it affect the code in linux-next at all or is it only for 6.3-rc?

> ---
>  drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 73c7643b2697..8dd46fad151e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -840,22 +840,20 @@ static int amd_pstate_update_status(const char *buf, size_t size)
>
>         switch(mode_idx) {
>         case AMD_PSTATE_DISABLE:
> -               if (!current_pstate_driver)
> -                       return -EINVAL;
> -               if (cppc_state == AMD_PSTATE_ACTIVE)
> -                       return -EBUSY;
> -               cpufreq_unregister_driver(current_pstate_driver);
> -               amd_pstate_driver_cleanup();
> +               if (current_pstate_driver) {
> +                       cpufreq_unregister_driver(current_pstate_driver);
> +                       amd_pstate_driver_cleanup();
> +               }
>                 break;
>         case AMD_PSTATE_PASSIVE:
>                 if (current_pstate_driver) {
>                         if (current_pstate_driver == &amd_pstate_driver)
>                                 return 0;
>                         cpufreq_unregister_driver(current_pstate_driver);
> -                       cppc_state = AMD_PSTATE_PASSIVE;
> -                       current_pstate_driver = &amd_pstate_driver;
>                 }
>
> +               current_pstate_driver = &amd_pstate_driver;
> +               cppc_state = AMD_PSTATE_PASSIVE;
>                 ret = cpufreq_register_driver(current_pstate_driver);
>                 break;
>         case AMD_PSTATE_ACTIVE:
> @@ -863,10 +861,10 @@ static int amd_pstate_update_status(const char *buf, size_t size)
>                         if (current_pstate_driver == &amd_pstate_epp_driver)
>                                 return 0;
>                         cpufreq_unregister_driver(current_pstate_driver);
> -                       current_pstate_driver = &amd_pstate_epp_driver;
> -                       cppc_state = AMD_PSTATE_ACTIVE;
>                 }
>
> +               current_pstate_driver = &amd_pstate_epp_driver;
> +               cppc_state = AMD_PSTATE_ACTIVE;
>                 ret = cpufreq_register_driver(current_pstate_driver);
>                 break;
>         default:
> --
> 2.34.1
>
