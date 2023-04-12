Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13D6DFAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDLQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjDLQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:07:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9633A7EC8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:06:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-502739add9dso5613326a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681315617; x=1683907617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvx6pvkb5xNVyLTVIBmQPSTe0dxBLCsQTF8Sz8zSXIE=;
        b=lfrhePLb+I/IwcENNUxJndy4FMZYj9bsNmgQc7Pfc7fsR9TwS8NRnmsnfqiVEAjmm/
         5/b7Jxy37d2kIF9/nc9SIOa14U4EPQMuLHtdBhH7gqLGUTDfIcV8sZFXet1YV1ZTym5j
         3dB5j0NCl5f+8zIqwwu/5nLh0I8203jpvb/HrsnvovGe87uA1mLo37GTYYSR/xaHNQ3F
         dhX9WCmCskOd4SiJe3SGkHvePRD7/V6kNy56q3Qh3mb1CBkTdVmgZpjiAMmyAYyLU/N8
         UXhQheGdCBb4OD+l1SSHVhr9dAPa2IpPf/2HA/PAgTaMcut+PBvDSQFGATCFeoE8/dV7
         Nghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315617; x=1683907617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fvx6pvkb5xNVyLTVIBmQPSTe0dxBLCsQTF8Sz8zSXIE=;
        b=RL3qxtZX8K1FJCQPvgTcaws9cVFKtuancQeEwKmiAeychHjdNEz8DXL06UxuWG6Bmj
         Ye/ZBJrRF+NKZNvp2/WWmlDWjcWsLOo2tS8ZdAnffxxF7ACWrEON3qbM9cveI/5ELRi/
         KmltUp79Crl34imZjKqA9nqB7nPotHOhrdVem/9Us8n3BzIS6PMG7F8Ag72Wqd+X98Ch
         Sb67Mf8sARoYQ+XdJOtLePqaiBNgY0ljNF6viLV1+wAYxdysshwcXHLifsDRn/zKyyMC
         S7N1Sup1h8WmRvOGGWlx+I8U5poPoudN2Rj2OJcNImGcSclNWl1JJ5snBpRWWQWeURGS
         geLw==
X-Gm-Message-State: AAQBX9fMwT+NCUw3Kphn4BcFuB8m2cw5o06uoruoBJ9JZJimyHWypX/N
        BuNxWNTwUbOA1g+guhJbGwWMfDVDrs/L3RaE4CyefQ==
X-Google-Smtp-Source: AKy350ZmYoYIVRHmHqWjvFpqz6xIN4qlS2V7r/ZyfNlOdHayUZ7xQYLafuSJuqTUK/CRSDW++9/l1+6bmorlYUCGHoQ=
X-Received: by 2002:a50:d797:0:b0:502:49bf:7e8d with SMTP id
 w23-20020a50d797000000b0050249bf7e8dmr1470243edi.8.1681315617035; Wed, 12 Apr
 2023 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230404155121.1824126-1-james.clark@arm.com> <20230404155121.1824126-12-james.clark@arm.com>
In-Reply-To: <20230404155121.1824126-12-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 12 Apr 2023 17:06:43 +0100
Message-ID: <CAJ9a7VjRS4TeQKJ1ZNMkN9iXS2Tob9G3=9qhxAXXX9YTHTpD-A@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] coresight: Refactor out buffer allocation
 function for ETR
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, 4 Apr 2023 at 16:52, James Clark <james.clark@arm.com> wrote:
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
> index 689ba6abc70b..00a0c2aa8481 100644
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
> -               atomic_inc(&csdev->refcnt);
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
> +               atomic_inc(&csdev->refcnt);
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

Reviewed-by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
