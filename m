Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654B68FC6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBIBJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjBIBJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:09:07 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6FF75F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:09:05 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id r28so183776vka.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 17:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6H62EB6tLaeHvjzAo97rklqjg6bi1dWWBwTc9aeeMf4=;
        b=Mz93eF9A50Xglc3ieDZV3lw5xl6YJIzwHqC2TWPxVu7KTwwuWB2NI56Ru2DdFZMr1r
         povm8JkEeDnglueKGrnCQZGZLU70+u122ZOgH5rtDRgz3DabCFhxuxtXG7zw4nr/KaC8
         dalnMHTZ9zLJoVBqBURUOLLmPCcVDzMe9heghM36nKFBmargkqZdBMYzB0hP33SDzRNE
         I51LRAPshAaDl3ow8vqZyjl/hDF0fbIhJ8gIrsQn48s6oCfgvqvTHxmQwmMqKPlyaU9a
         M5E96H4Lkwa2f5eP8F5rkIhwY4fi8RZfQ4rHmwsxCMyBP5QVKAm25K9OIr6dupiuczrC
         2yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6H62EB6tLaeHvjzAo97rklqjg6bi1dWWBwTc9aeeMf4=;
        b=OqB1cpDibDwLGgEdWFEhpJ5opPEtnz202VQBKf76w0Ib7TbTXYuYtNfr+sxgmBAtYn
         +9ktrh3drAPlYLcfHNidOkcwfleDZwsKaQomBsuvW3YX1u8F4wQJ0d3ShFU6LyW+PDw7
         tlGaUUCFlR0cWPTlGbJch99ytxaz7Nntkh9dvl4KZLIwl76Sba7NY/J8/9N3MbK/2WsD
         JfsjBA9REbMdyj1uTQ6Run9JpX9eJutQJppl7w/ZCwA3b8DP9VLX5ex6Ea42KsvA5ekM
         NLxLIVhy/7pIoqmDpVyumbebMdyxF5fA3fSQliCRVFklD3pcFJ4vdi5QrHqCMDh6qIM+
         rkLQ==
X-Gm-Message-State: AO0yUKVQaGWyRaxQ8hBmMDImgMPTUK5PCtOBQGIURxU3y4YUDmnAjq2C
        FypfKOG6DtzthaDHeCQFcEtHHI2U8NLMscgYrMeg
X-Google-Smtp-Source: AK7set9JSOg1tA8Pr8vC4LCcGfcLTYG59TkHq24Y4OhEr+zDQg/hulqzFt9qwgRPSP4yc0Wu/iGT109021bVdwUbv4I=
X-Received: by 2002:a1f:2e88:0:b0:3ea:2187:d41f with SMTP id
 u130-20020a1f2e88000000b003ea2187d41fmr2219906vku.0.1675904944256; Wed, 08
 Feb 2023 17:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CALJ9ZPNrF-HhUNskr=_MJ1CrnO+0xzSN8pMpER3FMqf5Pd0idg@mail.gmail.com>
 <20230202214633.12584-1-yabinc@google.com>
In-Reply-To: <20230202214633.12584-1-yabinc@google.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Wed, 8 Feb 2023 17:08:53 -0800
Message-ID: <CALJ9ZPPte1Gso7LYA6eAVifZJDgdZP+QPdSKUJEpz=+v2S0cag@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: tmc: Don't enable TMC when it's not ready.
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

Friendly ping?

On Thu, Feb 2, 2023 at 1:46 PM Yabin Cui <yabinc@google.com> wrote:
>
> If TMC ETR is enabled without being ready, in later use we may
> see AXI bus errors caused by accessing invalid addresses.
>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> V1 -> V2: Make change to all TMCs instead of just ETR
> V2 -> V3: Handle etr enable failure in tmc_read_unprepare_etr
>
>  .../hwtracing/coresight/coresight-tmc-core.c  |  4 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 43 +++++++++++++++----
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 25 +++++++++--
>  drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
>  4 files changed, 59 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 07abf28ad725..c106d142e632 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>  DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>  DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>
> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>         struct coresight_device *csdev = drvdata->csdev;
>         struct csdev_access *csa = &csdev->access;
> @@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>         if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>                 dev_err(&csdev->dev,
>                         "timeout while waiting for TMC to be Ready\n");
> +               return -EBUSY;
>         }
> +       return 0;
>  }
>
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 4c4cbd1f7258..2840227e9135 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -16,12 +16,19 @@
>  static int tmc_set_etf_buffer(struct coresight_device *csdev,
>                               struct perf_output_handle *handle);
>
> -static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> +static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
> +       int rc = 0;
> +
>         CS_UNLOCK(drvdata->base);
>
>         /* Wait for TMCSReady bit to be set */
> -       tmc_wait_for_tmcready(drvdata);
> +       rc = tmc_wait_for_tmcready(drvdata);
> +       if (rc) {
> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
> +               CS_LOCK(drvdata->base);
> +               return rc;
> +       }
>
>         writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>         writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
> @@ -33,6 +40,7 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>         tmc_enable_hw(drvdata);
>
>         CS_LOCK(drvdata->base);
> +       return rc;
>  }
>
>  static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> @@ -42,8 +50,10 @@ static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>         if (rc)
>                 return rc;
>
> -       __tmc_etb_enable_hw(drvdata);
> -       return 0;
> +       rc = __tmc_etb_enable_hw(drvdata);
> +       if (rc)
> +               coresight_disclaim_device(drvdata->csdev);
> +       return rc;
>  }
>
>  static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
> @@ -91,12 +101,19 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>         coresight_disclaim_device(drvdata->csdev);
>  }
>
> -static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
> +static int __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  {
> +       int rc = 0;
> +
>         CS_UNLOCK(drvdata->base);
>
>         /* Wait for TMCSReady bit to be set */
> -       tmc_wait_for_tmcready(drvdata);
> +       rc = tmc_wait_for_tmcready(drvdata);
> +       if (rc) {
> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
> +               CS_LOCK(drvdata->base);
> +               return rc;
> +       }
>
>         writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
>         writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
> @@ -105,6 +122,7 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>         tmc_enable_hw(drvdata);
>
>         CS_LOCK(drvdata->base);
> +       return rc;
>  }
>
>  static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
> @@ -114,8 +132,10 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>         if (rc)
>                 return rc;
>
> -       __tmc_etf_enable_hw(drvdata);
> -       return 0;
> +       rc = __tmc_etf_enable_hw(drvdata);
> +       if (rc)
> +               coresight_disclaim_device(drvdata->csdev);
> +       return rc;
>  }
>
>  static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
> @@ -639,6 +659,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>         char *buf = NULL;
>         enum tmc_mode mode;
>         unsigned long flags;
> +       int rc = 0;
>
>         /* config types are set a boot time and never change */
>         if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
> @@ -664,7 +685,11 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>                  * can't be NULL.
>                  */
>                 memset(drvdata->buf, 0, drvdata->size);
> -               __tmc_etb_enable_hw(drvdata);
> +               rc = __tmc_etb_enable_hw(drvdata);
> +               if (rc) {
> +                       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +                       return rc;
> +               }
>         } else {
>                 /*
>                  * The ETB/ETF is not tracing and the buffer was just read.
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 867ad8bb9b0c..4952425dd6e4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>         etr_buf->ops->sync(etr_buf, rrp, rwp);
>  }
>
> -static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> +static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
>         u32 axictl, sts;
>         struct etr_buf *etr_buf = drvdata->etr_buf;
> +       int rc = 0;
>
>         CS_UNLOCK(drvdata->base);
>
>         /* Wait for TMCSReady bit to be set */
> -       tmc_wait_for_tmcready(drvdata);
> +       rc = tmc_wait_for_tmcready(drvdata);
> +       if (rc) {
> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
> +               CS_LOCK(drvdata->base);
> +               return rc;
> +       }
>
>         writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
>         writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
> @@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>         tmc_enable_hw(drvdata);
>
>         CS_LOCK(drvdata->base);
> +       return rc;
>  }
>
>  static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> @@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>         rc = coresight_claim_device(drvdata->csdev);
>         if (!rc) {
>                 drvdata->etr_buf = etr_buf;
> -               __tmc_etr_enable_hw(drvdata);
> +               rc = __tmc_etr_enable_hw(drvdata);
> +               if (rc) {
> +                       drvdata->etr_buf = NULL;
> +                       coresight_disclaim_device(drvdata->csdev);
> +                       tmc_etr_disable_catu(drvdata);
> +               }
>         }
>
>         return rc;
> @@ -1750,6 +1762,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  {
>         unsigned long flags;
>         struct etr_buf *sysfs_buf = NULL;
> +       int rc = 0;
>
>         /* config types are set a boot time and never change */
>         if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
> @@ -1764,7 +1777,11 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
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
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 66959557cf39..01c0382a29c0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -255,7 +255,7 @@ struct tmc_sg_table {
>  };
>
>  /* Generic functions */
> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>  void tmc_enable_hw(struct tmc_drvdata *drvdata);
>  void tmc_disable_hw(struct tmc_drvdata *drvdata);
> --
> 2.39.1.519.gcb327c4b5f-goog
>
