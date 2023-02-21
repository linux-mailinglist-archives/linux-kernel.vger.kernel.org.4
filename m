Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C369E7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBUSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBUSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:39:00 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DAC168
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:38:59 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id x40so1208663uaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677004739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GTvDVfPxtXyqmctAMAXQWBEW0gmaPl4ijzzYuKFjZwA=;
        b=hDg20VImU6Q+gi5ZLq8NEysTMDtcN5ZZEuThmU5xqabdoEb+Pu8dEkS4vLD2rxOgS4
         KNraTM+2Zv0ovSweC5+JRvkdbjwyF+AXsCASN6/24RWOU15RW6KOZpQeIRtJxE+peJEH
         HFsTdO8jvgLPNexaB/CnCzd6vrWxouz+h7LMo5HYyqTaODbxy8+CrEI4vbO/mSDGUc+9
         Ltk+NNlHbhDcE2a5Gix8wTppfo+ZlVp17zy4vQBnSvj3uCCyxFfVWyOQ5xA8jOjxApi/
         sapg1F7t+DATJfoExBqlpml9SIs0iSxfcnyU6zWI6QkLhimXENnknS1SLN6sPIvErYCH
         VQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677004739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTvDVfPxtXyqmctAMAXQWBEW0gmaPl4ijzzYuKFjZwA=;
        b=5mXtdpPbWVUVmRnsasalP2TuLcCV+YlnD1CeD40NQ1nlQWRfZ4qXLjleBwgpPSSOdw
         tRH9wLrbTAFf/dcZi9zbxU/AtNcy12kOcAwyaT86RGYBhLcEGxRnYsQoH8UxyA/Urklf
         qS2HdlsIsGtMrUF0gIs+SK/4bt3qPsI3AdIWHZup3vthvUSXGZa+Ih1gpA92AG+FTbwG
         pSAST9CVB6DwsigTc1c/z4nkIIfoto7SJSLrEmnBBYAX7xhzr204DxKMRwVnzN3S3ew3
         OdBxPMhtqx4+q9LIhj4tTydE0cXNamloncVvmUkPCpe2mp+riJlzuZRSnSmxPnPhp4wy
         e/DA==
X-Gm-Message-State: AO0yUKWg0uh189KmWWwxGmwhFNxdw6gWVMyBMIkJaNr0/Xg//vIFVJrr
        FY1s0wQxIyyM3vlmmbj3F5fvnPPZmwFZO4QttVs6
X-Google-Smtp-Source: AK7set/Na0CE6HZujWX+qzUx9lwEP51SplrunjyTO0VDBAwjcplGgdKuuUP0gn2p8196NVmBFZ1fbwSA/LC3/QAZ0QE=
X-Received: by 2002:a1f:7f11:0:b0:401:87ef:e516 with SMTP id
 o17-20020a1f7f11000000b0040187efe516mr748005vki.16.1677004738831; Tue, 21 Feb
 2023 10:38:58 -0800 (PST)
MIME-Version: 1.0
References: <77bd4509-bd8b-3bcc-e94a-7593505e27c0@arm.com> <20230210234311.1661312-1-yabinc@google.com>
In-Reply-To: <20230210234311.1661312-1-yabinc@google.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Tue, 21 Feb 2023 18:38:47 +0000
Message-ID: <CALJ9ZPM_78fNKcyUn=NvrqYLxcSCNsKp2HNUXU+DwZoC1MhFvA@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc-etr: Handle enable failure in tmc_read_unprepare_etr
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for review?

On Fri, Feb 10, 2023 at 11:43 PM Yabin Cui <yabinc@google.com> wrote:
>
> It's similar to what we did in tmc_read_unprepare_etb.
>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 918d461fcf4a..b04f12079efd 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1763,6 +1763,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  {
>         unsigned long flags;
>         struct etr_buf *sysfs_buf = NULL;
> +       int rc = 0;
>
>         /* config types are set a boot time and never change */
>         if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
> @@ -1777,7 +1778,11 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>                  * buffer. Since the tracer is still enabled drvdata::buf can't
>                  * be NULL.
>                  */
> -               __tmc_etr_enable_hw(drvdata);
> +               rc = __tmc_etr_enable_hw(drvdata);
> +               if (rc) {
> +                       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +                       return rc;
> +               }
>         } else {
>                 /*
>                  * The ETR is not tracing and the buffer was just read.
> --
> 2.39.1.581.gbfd45094c4-goog
>
