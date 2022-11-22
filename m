Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB236343A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiKVSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiKVSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:31:29 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC87FF21;
        Tue, 22 Nov 2022 10:31:28 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id 11so11619722iou.0;
        Tue, 22 Nov 2022 10:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLf/Jej73pbXy0+YMDLop67VGOTWqbO44Re8jeCONjk=;
        b=zuCe34C2RvNH2OUEiLG/pILURn+tdDierOy1QXd1VgEgOaaKbTrT1CaLLMTggVU+ee
         EQNa4dwbwHCSEzJu0Yqx3pWlnNn3rbFxhTUKbhsQd5Xcblq1qmwabG1RSglKE2YgR07A
         NasfhurL9uhqZ5y2BRQLS2HTsddQifOG9OikPSxGDN0ZvxxkMJC3MIvkYy4l0BlNg+ZE
         r1Z1wboeSlniY4y45ZEdZ0WDffpXnbGh08de5QlN7QHVU7F1lyuoBwJ080df3mshlcpw
         xfr55CtikvMH9g2skAxkSU4wBEUDehBJOvoG5swMR9ByWp7nMcutdCyXyqSK9o2yOw2S
         P59w==
X-Gm-Message-State: ANoB5pmiqVnEaanL/uqErazfSqjZAJmLojpkY1kijD2Dv8pDoWirVNw3
        laZPYocpmhgZqda4yFVRyEhH6dlCMYGef1D4tf0=
X-Google-Smtp-Source: AA0mqf7NgTiy75wY+D7kXOalg+B3innPmZBo2zs2LHEnMddK/v39yObbysuA1S1QRlqe91m2kPzqjrEEu8txm1uMBdc=
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id
 k9-20020a5d97c9000000b006a2e3dfa40emr11439527ios.113.1669141887813; Tue, 22
 Nov 2022 10:31:27 -0800 (PST)
MIME-Version: 1.0
References: <202211222011006572179@zte.com.cn>
In-Reply-To: <202211222011006572179@zte.com.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Nov 2022 10:31:16 -0800
Message-ID: <CAM9d7ciTYqS0UzKbC-GPGCVi8Rq9Ooetvh-EKGkZe6A1f=qn0g@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf stat: use sysfs_streq() instead of strncmp()
To:     yang.yang29@zte.com.cn
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, james.clark@arm.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, cjense@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
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

Hello,

On Tue, Nov 22, 2022 at 4:11 AM <yang.yang29@zte.com.cn> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Replace the open-code with sysfs_streq().

I don't think it's equivalent to strncmp() and it seems not available
in the tools.

Thanks,
Namhyung

>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  tools/perf/util/stat-display.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index f5501760ff2e..1fd9f7e9d2a1 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -463,7 +463,7 @@ static bool valid_only_metric(const char *unit)
>  static const char *fixunit(char *buf, struct evsel *evsel,
>                            const char *unit)
>  {
> -       if (!strncmp(unit, "of all", 6)) {
> +       if (sysfs_streq(unit, "of all")) {
>                 snprintf(buf, 1024, "%s %s", evsel__name(evsel),
>                          unit);
>                 return buf;
> @@ -767,8 +767,7 @@ static void uniquify_event_name(struct evsel *counter)
>         int ret = 0;
>
>         if (counter->uniquified_name || counter->use_config_name ||
> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> -                                          strlen(counter->pmu_name)))
> +           !counter->pmu_name || sysfs_streq(counter->name, counter->pmu_name))
>                 return;
>
>         config = strchr(counter->name, '/');
> --
> 2.15.2
