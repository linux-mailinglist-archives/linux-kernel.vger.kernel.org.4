Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BE6C38D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCUSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCUSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:02:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277E244A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:02:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so9476356plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679421721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jWtWrnrzaIfd5LC7mI25Hn+1QUzF8TMpFsdv793e5sg=;
        b=YShEYReiyZgTjyrMmULJufa+vnxdFyYuyNE2f5o/Q/pIx88yD4Y1rf6+/JYc+MXjRi
         Q/QRgfkNETpcUCOLPGmOfN/MFsPbYyogcOD3vSlXsmmsjtkrmU3I5kxBYyI5NSCWvpGa
         lpLjUjL57UgI//BrR70Yu91TtfdfmAVwkT7BGUgwyPguTE6MxIHIhhWCBUCTH+sPmJI0
         bjqsVhWyeLtSvoDbMBWV7CIff8yCHek4vR5lhLj/14fNAA1RXcfGkBVHH+37gFjrCTwU
         QTPCWo1D9sxYL0h+s68z8xaZeyuaMXS8lE7o78wzUD+nDqLBuu6598ulqG+DYYQRvgH8
         UyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWtWrnrzaIfd5LC7mI25Hn+1QUzF8TMpFsdv793e5sg=;
        b=Ko+TJwjhk9c8vUIKzSxRaEelpZGfh1FJsqUN4Mv679i3IMTdId1H2f2Kesafn7uC7y
         Im4XSItpXeKaLj3zW3jbgpt2g2NK49Igs1YaEF9bkPEMxAFQFVtuxiIGkFhEXvPuutdF
         RQoGddbeQPx+K3FuXiI2nVDSh7giltYgXNNNYMJOqgsPaTuEBiriRkoWUXqYecyeqyKW
         v1bQv2ou7ICdB9s+fFSMTWHb+qlNK3Vl0ewuJRVC3q8t/Mp9//U9GRk9AuntHCCKrtL9
         qJwMaDjl/I2PCEfWWIiVGQX+QxbPwycZ8PlIQYIuJVHmI9L9bnTFO0nYvSU0sSRWexb/
         s4xQ==
X-Gm-Message-State: AO0yUKXir9Ha870X5Lh7TBwB7uA1NwDi9q4ElqqBu7MHeM/hcCr9VTAv
        OrUAHPYRmyA9wZeGKHiWpvoKVRDQX6jWHwkBrn/fLQ==
X-Google-Smtp-Source: AK7set+DU5xn7sgl+n/B5/lhFka/klVqp2ShMebJh2ItQUraVTL4kIADNA73/YVnZEbSpnBzPHyrF4tk3q818PvM0is=
X-Received: by 2002:a17:902:ec87:b0:19f:3b0f:4d97 with SMTP id
 x7-20020a170902ec8700b0019f3b0f4d97mr5936plg.6.1679421721283; Tue, 21 Mar
 2023 11:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-8-james.clark@arm.com>
In-Reply-To: <20230310160610.742382-8-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 18:01:50 +0000
Message-ID: <CAJ9a7VjgbgaufYiVR+N62WKOVVKU=0iEoxai3JLEiwXcMDsv7g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] coresight: Refactor out buffer allocation function
 for ETR
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 16:07, James Clark <james.clark@arm.com> wrote:
>
> When CATU is moved to the generic enable/disable path system in the
> next commit, it will need to call into ETR and get it to pre-allocate
> its buffer so add a function for it.
>
> No functional changes
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 50 ++++++++++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
>  2 files changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 223081dc3ad4..cb9621003aef 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1169,7 +1169,7 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>         drvdata->etr_buf = NULL;
>  }
>
> -static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
> +static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>  {
>         int ret = 0;
>         unsigned long flags;
> @@ -1192,7 +1192,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>                 /* Allocate memory with the locks released */
>                 free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
>                 if (IS_ERR(new_buf))
> -                       return PTR_ERR(new_buf);
> +                       return new_buf;
>
>                 /* Let's try again */
>                 spin_lock_irqsave(&drvdata->spinlock, flags);
> @@ -1223,17 +1223,33 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>                 drvdata->sysfs_buf = new_buf;
>         }
>
> -       ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
> -       if (!ret) {
> -               drvdata->mode = CS_MODE_SYSFS;
> -               atomic_inc(csdev->refcnt);
> -       }
>  out:
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         /* Free memory outside the spinlock if need be */
>         if (free_buf)
>                 tmc_etr_free_sysfs_buf(free_buf);
> +       return ret ? ERR_PTR(ret) : drvdata->sysfs_buf;
> +}
> +
> +static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
> +{
> +       int ret;
> +       unsigned long flags;
> +       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
> +
> +       if (IS_ERR(sysfs_buf))
> +               return PTR_ERR(sysfs_buf);
> +
> +       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
> +       if (!ret) {
> +               drvdata->mode = CS_MODE_SYSFS;
> +               atomic_inc(csdev->refcnt);
> +       }
> +
> +       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         if (!ret)
>                 dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
> @@ -1241,6 +1257,26 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>         return ret;
>  }
>
> +struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> +                                  enum cs_mode mode, void *data)
> +{
> +       struct perf_output_handle *handle = data;
> +       struct etr_perf_buffer *etr_perf;
> +
> +       switch (mode) {
> +       case CS_MODE_SYSFS:
> +               return tmc_etr_get_sysfs_buffer(csdev);
> +       case CS_MODE_PERF:
> +               etr_perf = etm_perf_sink_config(handle);
> +               if (WARN_ON(!etr_perf || !etr_perf->etr_buf))
> +                       return ERR_PTR(-EINVAL);
> +               return etr_perf->etr_buf;
> +       default:
> +               return ERR_PTR(-EINVAL);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(tmc_etr_get_buffer);
> +
>  /*
>   * alloc_etr_buf: Allocate ETR buffer for use by perf.
>   * The size of the hardware buffer is dependent on the size configured
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 01c0382a29c0..b97da39652d2 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -332,5 +332,7 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
>
>  void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
>  void tmc_etr_remove_catu_ops(void);
> +struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> +                                  enum cs_mode mode, void *data);
>
>  #endif
> --
> 2.34.1
>

Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
