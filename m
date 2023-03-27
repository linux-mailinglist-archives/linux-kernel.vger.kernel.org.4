Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334C6CABAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjC0RQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0RQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:16:36 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB330C4;
        Mon, 27 Mar 2023 10:16:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id r11so39183277edd.5;
        Mon, 27 Mar 2023 10:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E69YtaJGG3PZ50FVDkWxryJxhjmbz/OTHgrS+a7tcZs=;
        b=iRjYUKmuKEwS5tiymrmXJud87I/EYoDR164RRs0uzvcJhBeGU8VzEnmcGtBSuYecDe
         5tD7UFxfFVcFb1vCMf6BJChlDdVuCqPlW3p0eNqGSpET8r6O8xACiIuOPqB3guSxRDCL
         t2zz9rYCy71a9M+c655JPbY7FTdYFLwlj3JxWoq1il5+B33BckWzW3E4LeOG6oESfeA9
         0dBA1vSo89aWnkudBDxaDneaSCIEaaOdtgtGauFW6wQLD24+ZPmrPJHJNDUtM5UNwv+a
         9mObMQgsk20rb337mj0zt0hwloBsdV9l2bx6XDGLyPWg0NTjpFBS0TKxp2XEHrmuC7t4
         zGIw==
X-Gm-Message-State: AAQBX9ekMEm7d2Se6ZpeVCKe1VbL2W3VvBndW5GWdsLJBQYwux4DzukT
        BC3Kt0CMK02VHe/Ythtf+99EzsYDUMcvZSPCwx8yNLlP
X-Google-Smtp-Source: AKy350YvRfeUh32miYqdAPhCq2Po2+rNp47O24mQo0LBN6PkIbFYSwoLBpIVb8oEfGZ9on8km6YXCPVLLzulnQ/svHk=
X-Received: by 2002:a50:9f6f:0:b0:4fb:2593:846 with SMTP id
 b102-20020a509f6f000000b004fb25930846mr5868690edf.3.1679937394513; Mon, 27
 Mar 2023 10:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230314103357.26010-1-lukasz.luba@arm.com> <20230314103357.26010-2-lukasz.luba@arm.com>
In-Reply-To: <20230314103357.26010-2-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:16:23 +0200
Message-ID: <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
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

On Tue, Mar 14, 2023 at 11:34 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> In order to prepare the code for the modifiable EM perf_state table,
> refactor existing function em_cpufreq_update_efficiencies().
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Quite obviously, this series needs ACKs from the Energy Model people.

> ---
>  kernel/power/energy_model.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index f82111837b8d..265d51a948d4 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -240,10 +240,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>         return 0;
>  }
>
> -static void em_cpufreq_update_efficiencies(struct device *dev)
> +static void
> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>  {
>         struct em_perf_domain *pd = dev->em_pd;
> -       struct em_perf_state *table;
>         struct cpufreq_policy *policy;
>         int found = 0;
>         int i;
> @@ -257,8 +257,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>                 return;
>         }
>
> -       table = pd->table;
> -
>         for (i = 0; i < pd->nr_perf_states; i++) {
>                 if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>                         continue;
> @@ -400,7 +398,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>
>         dev->em_pd->flags |= flags;
>
> -       em_cpufreq_update_efficiencies(dev);
> +       em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>
>         em_debug_create_pd(dev);
>         dev_info(dev, "EM: created perf domain\n");
> --
> 2.17.1
>
