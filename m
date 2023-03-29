Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9696CDC94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjC2Oaz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjC2Oa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:30:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA73D33F;
        Wed, 29 Mar 2023 07:24:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so64030796edd.5;
        Wed, 29 Mar 2023 07:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680099709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmRo+NafXGk22CkfJXsfBkVrEYvm9hmVJrwasIeU3lY=;
        b=pEM7nA9JEh5kVKLwkZDEDl2qnbsBTJkLLFiLbojkyHBGq2ilnO+YjFk+teq+VBpbA/
         CxTGQVJJkVUHZHNZ04lSn5jjBSYkeD5CJe3x2hKPU/JysgVHvZqj401Fcx/xXyKNCQVG
         xlz6A18TCeYBKLrXyS0m39f081mqqnn21s5D0zo4fxrOyrqz2zkgUGn+Jc132e5/sZwB
         SaWZ64OWqU5n4dm12/8ye6HmsmifWY/eJmWZf+XzIfv+Hmi98N7j5HV8iJrM4BP1FTPC
         +l+IhjgoDhu+nlK/vepKZohEEOfVmoIOJEytwRTEovbIPyGJSNQ6ThXMW7SyipTkhO74
         HPow==
X-Gm-Message-State: AAQBX9d2erQalbBN+qxvfs83Nkd+J6jivisjuBfAg7UMzkwRnFieV12F
        O2aCuzoY/EXnWptxdv0RB634rV+y6gBlNfPspN7x4rlVcTk=
X-Google-Smtp-Source: AKy350aDOvP+p0DCaD0+pvuyPF857ampGTy7Q2ZBwuX/zgoufPF04rd62Yrt4dcat+1umeuz69Ocx7OdXrLjS6butp8=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr8892099ejc.2.1680099709231; Wed, 29
 Mar 2023 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230329133600.908723-1-yajun.deng@linux.dev>
In-Reply-To: <20230329133600.908723-1-yajun.deng@linux.dev>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 16:21:38 +0200
Message-ID: <CAJZ5v0iWkJw3KP7sfyDOyYsEkdOxxPhkYiYZMvd78geofGEECQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in __cpufreq_driver_target()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 3:36 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> __resolve_freq() may be return target_freq if policy->freq_table is
> NULL. In this case, it should return -EINVAL before __target_index().

Even so, __target_index() itself doesn't dereference freq_table
AFAICS, so arguably the driver should be prepared to deal with a NULL
freq_table which comes from it after all.

Or, if you want to argue that drivers providing ->target_index() must
also provide freq_table that is not NULL, a check to that effect needs
to be done at the driver registration time IMO.

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c0e5be0fe2d6..308a3df1a940 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2299,7 +2299,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                 return cpufreq_driver->target(policy, target_freq, relation);
>         }
>
> -       if (!cpufreq_driver->target_index)
> +       if (!cpufreq_driver->target_index || !policy->freq_table)
>                 return -EINVAL;
>
>         return __target_index(policy, policy->cached_resolved_idx);
> --
