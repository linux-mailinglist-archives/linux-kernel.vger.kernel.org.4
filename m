Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C268F303
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBHQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBHQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:17:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FE4DE1B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:17:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m2-20020a17090a414200b00231173c006fso2249076pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VtStxbDlv9BIEgeROEEUhW1VlT6VpQik7/+FSOLhuHQ=;
        b=xddZb9VszVX77kSSA+W9Zny20S5flI1egsRdjg7QmtTawVwVRFhpGLMSmSVpoV4lAW
         ii41mAuSjvpkxlvGl9Z5oPMnvnH0NBfBo5cZ8kPe3KkYmh0KQDJI7nFZ/sq7Wr+4E95b
         vz5+Gjovd05BsIDghjp7aVowE+AYRayXI5ZRMzWxWUVtHRh8XMjdFlEFMAhrP2xP+lWR
         UNobktvm2s++EzwNv/NHA4QWTdMMTLHTxA9tl+/mfj1e47M/gc2BKT3xONU+HGeT8X4g
         NzWDWnVFDwFH2qis9Hqs/mqLnmVV6mInJ9iM7hYPs8USrEC8pDac48af1VAvpnVNUquv
         L9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtStxbDlv9BIEgeROEEUhW1VlT6VpQik7/+FSOLhuHQ=;
        b=WzffkyfvCis2euCVJbZzOVv7qtGiPV1q1Tz6uCIkLVeJyOh885btTuu27lcW9PQpya
         fsSkdqO6tiFRAqU88QSSQsWHcAPhk4DsBcpIbGDORobH1DKa4pPPFp3/mD4rHIcUcRqc
         eL6XJDlid9xLPozHBxjr1O5Q7IGp/9O5slt+AN4JxLjPaB7p5yzB83lAtgqVXNxQX4hX
         GH5MbEbl90xLBLNf35Ai7eh/uzJGZwblzu3ux5QDDVqMPTagH9G47l70zN3uaqUqaAsU
         9fZsld2KjViUm02xAKoWKu71uWySoRLWUf2h1Apg58ROhpuXhKA63D+VX4vRijwmjN9s
         VUiQ==
X-Gm-Message-State: AO0yUKVTyN9/kCh/NSjuLFL/5XudUa+f28BfGtBVfUzzk2kvI0RBTXwR
        BsEa1/l2Nm+twVl3NrZZgA2FWhMonplsEoDCEgxgHQ==
X-Google-Smtp-Source: AK7set+v5cFZTu9K2iveiLOsQcYikW2XLnB4+6qmSThMMoL4p1PWQnloVuMATKDa63NrLFkmnjrPHHE06eWqkvT0oOg=
X-Received: by 2002:a17:902:6b88:b0:199:1458:6c67 with SMTP id
 p8-20020a1709026b8800b0019914586c67mr2130741plk.28.1675873027675; Wed, 08 Feb
 2023 08:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 8 Feb 2023 16:16:56 +0000
Message-ID: <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and sinks
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As this is a sysfs only update - would it not be easier to simply use
a shell script to iterate through coresight/devices/ looking for
disable_source / disable_sink files and setting those accordingly?

See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
script that does similar iteration to test coresight in perf

Regards

Mike

On Wed, 8 Feb 2023 at 11:16, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Add sysfs node to reset all the sources and sinks. When mltiple
> sources are enabled, write 1 to reset_source_sink node to disable
> all sources and sinks.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 106 +++++++++++++++++--
>  1 file changed, 99 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index d3bf82c0de1d..06741ed2dee7 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -458,6 +458,28 @@ static bool coresight_disable_source(struct coresight_device *csdev)
>         return !csdev->enable;
>  }
>
> +/**
> + * coresight_get_source - Get the source from the path
> + *
> + * @path: The list of devices.
> + *
> + * Returns the soruce csdev.
> + *
> + */
> +static struct coresight_device *coresight_get_source(struct list_head *path)
> +{
> +       struct coresight_device *csdev;
> +
> +       if (!path)
> +               return NULL;
> +
> +       csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> +       if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> +               return NULL;
> +
> +       return csdev;
> +}
> +
>  /*
>   * coresight_disable_path_from : Disable components in the given path beyond
>   * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
> @@ -1159,20 +1181,18 @@ int coresight_enable(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(coresight_enable);
>
> -void coresight_disable(struct coresight_device *csdev)
> +static void _coresight_disable(struct coresight_device *csdev)
>  {
>         int cpu, ret;
>         struct list_head *path = NULL;
>         u32 hash;
>
> -       mutex_lock(&coresight_mutex);
> -
>         ret = coresight_validate_source(csdev, __func__);
>         if (ret)
> -               goto out;
> +               return;
>
>         if (!csdev->enable || !coresight_disable_source(csdev))
> -               goto out;
> +               return;
>
>         switch (csdev->subtype.source_subtype) {
>         case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> @@ -1187,7 +1207,7 @@ void coresight_disable(struct coresight_device *csdev)
>                 path = idr_find(&path_idr, hash);
>                 if (path == NULL) {
>                         pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
> -                       goto out;
> +                       return;
>                 }
>                 idr_remove(&path_idr, hash);
>                 break;
> @@ -1198,8 +1218,12 @@ void coresight_disable(struct coresight_device *csdev)
>
>         coresight_disable_path(path);
>         coresight_release_path(path);
> +}
>
> -out:
> +void coresight_disable(struct coresight_device *csdev)
> +{
> +       mutex_lock(&coresight_mutex);
> +       _coresight_disable(csdev);
>         mutex_unlock(&coresight_mutex);
>  }
>  EXPORT_SYMBOL_GPL(coresight_disable);
> @@ -1761,8 +1785,76 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>  }
>  EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
>
> +/*
> + * Set the sink active status to false.
> + */
> +static int coresight_reset_sink(struct device *dev, void *data)
> +{
> +       struct coresight_device *csdev = to_coresight_device(dev);
> +
> +       if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +               csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
> +               csdev->activated)
> +               csdev->activated = false;
> +
> +       return 0;
> +}
> +
> +static void coresight_reset_all_sink(void)
> +{
> +       bus_for_each_dev(&coresight_bustype, NULL, NULL, coresight_reset_sink);
> +}
> +
> +static ssize_t reset_source_sink_store(struct bus_type *bus,
> +                                      const char *buf, size_t size)
> +{
> +       int id, cpu, ret = 0;
> +       unsigned long val;
> +       struct coresight_device *csdev;
> +       struct list_head *path = NULL;
> +
> +       ret = kstrtoul(buf, 10, &val);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&coresight_mutex);
> +
> +       /* Disable all per cpu sources */
> +       for_each_present_cpu(cpu) {
> +               path = per_cpu(tracer_path, cpu);
> +               if (path) {
> +                       csdev = coresight_get_source(path);
> +                       if (!csdev)
> +                               continue;
> +               }
> +               _coresight_disable(csdev);
> +       }
> +
> +       /* Disable all sources which aren't associated with CPU */
> +       idr_for_each_entry (&path_idr, path, id) {
> +               csdev = coresight_get_source(path);
> +               if (!csdev)
> +                       continue;
> +
> +               _coresight_disable(csdev);
> +       }
> +       /* Reset all activated sinks */
> +       coresight_reset_all_sink();
> +
> +       mutex_unlock(&coresight_mutex);
> +       return size;
> +}
> +static BUS_ATTR_WO(reset_source_sink);
> +
> +static struct attribute *coresight_reset_source_sink_attrs[] = {
> +       &bus_attr_reset_source_sink.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(coresight_reset_source_sink);
> +
>  struct bus_type coresight_bustype = {
>         .name   = "coresight",
> +       .bus_groups     = coresight_reset_source_sink_groups,
>  };
>
>  static int __init coresight_init(void)
> --
> 2.39.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
