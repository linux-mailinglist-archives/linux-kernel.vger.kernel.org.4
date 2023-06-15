Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60769730EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjFOF62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjFOF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:58:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421E126AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:58:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f98276f89cso108491cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808703; x=1689400703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywIR2okuzUn+UloyaEbaMZoO6ny14Ojn9IKly/pkEhg=;
        b=7OzgtenjDpipdLe/714hBAAyEAXGuPtp5jcuUFIgYrsVYJSZZ5iKtI35h182NuuHeK
         GyPHEgvBjl7VyTMKuso/Tb/ZOWj5q4ScTlfMPDgYnDBpvabw+KpcEQ3KS8EUaGUb7odU
         EwLNltQYLDMjAXk6y/p3fHVDzp/8yFMsDvCpmkF8SvwUIavV6jkBBU8z4lSW4/O/Dejn
         Ylt4dtN78kUBj3GVfbzq2Ek/TU9EYmGd7tv05LZtAtrdFinc+qYiGPTXktd6DsnFXkEB
         q0IujfLxPLsaqnIOy8ikSUpKb8ytXsQ/+Py5Aw/3Et2jBIMlyFY5Gd5GnpsAXtl2WIFQ
         vcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808703; x=1689400703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywIR2okuzUn+UloyaEbaMZoO6ny14Ojn9IKly/pkEhg=;
        b=EAD5Hq8vzaiSQxi1ll8hU3lM5yDJZr/ySr+zbC5cQ4aAa/VWdE/v7mxe1+Upl29pwj
         Q463xQ3KPVYnoThc0F/HGkxmwZsaF3JmGsam7gLuu4V7ox7j5tXOxmnJGA0tIFw5lLP3
         cPUJe9yhNZnH/F9/ov1FlyaH8Fi1T76AYNlveoO2kp8jiBBipg7Tyhrvn4+/TMFaxTP/
         0g+RLxnYMqASvNX8ATMvyXZiRsOZbPbaV7Pn8xN5F7lEkeKaP8dhc+g9HiCanUnsVZx9
         XRUhLejla8WMzpeuQvqp+b3xBym8dnBg4c5PTyHGrM9Jv65IeAckI+KYCYJjP9RfmC5G
         o7DQ==
X-Gm-Message-State: AC+VfDzpH0Anfkek4J529t7PBZ5Yfg042j/MW3BYVhvhmLCSiV4oBpXl
        uHLm1UsX+GMON6Rq87RTthuCfj5dE2Kgilkb8vcK0w==
X-Google-Smtp-Source: ACHHUZ6QKdJfG6KScQN8pr9K5TFheV6IfI/yze7eHAI2tr+pQSUUx7lR+j8QvvJYlpwIwB/lYtZHxauUiqAswy3i5pE=
X-Received: by 2002:a05:622a:589:b0:3ed:210b:e698 with SMTP id
 c9-20020a05622a058900b003ed210be698mr67856qtb.7.1686808703249; Wed, 14 Jun
 2023 22:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-7-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-7-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:58:11 -0700
Message-ID: <CAP-5=fVooOBWHWa8=73uS+eS1kW-qF5cp=WRV5O83SRE=oC6wQ@mail.gmail.com>
Subject: Re: [PATCH V2 6/8] pert tests: Update metric-value for perf stat JSON output
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> There may be multiplexing triggered, e.g., e-core of ADL.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index 5e9bd68c83fe..ea55d5ea1ced 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -66,10 +66,10 @@ def check_json_output(expected_items):
>    for item in json.loads(input):
>      if expected_items !=3D -1:
>        count =3D len(item)
> -      if count !=3D expected_items and count >=3D 1 and count <=3D 4 and=
 'metric-value' in item:
> +      if count !=3D expected_items and count >=3D 1 and count <=3D 6 and=
 'metric-value' in item:
>          # Events that generate >1 metric may have isolated metric
> -        # values and possibly other prefixes like interval, core and
> -        # aggregate-number.
> +        # values and possibly other prefixes like interval, core,
> +        # aggregate-number, or event-runtime/pcnt-running from multiplex=
ing.
>          pass
>        elif count !=3D expected_items and count >=3D 1 and count <=3D 5 a=
nd 'metricgroup' in item:
>          pass
> --
> 2.35.1
>
