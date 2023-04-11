Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279966DDD53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDKOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDKOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:09:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481511FEB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:09:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so8111283pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681222190; x=1683814190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2H4cyUXjFd1sVbldEFnLS3eJhJb3gMZ1l+YTSGHHgw=;
        b=pJBI5vjp3qau4R7zt6cOLJ0KN17SX5KrRNSqst2pnRq7DZuYd4Dll3QW99BuIYyf82
         JOP8eOTk/qnqBmmRwKpcJ8ZpO/Az5h1TnIUsxsX95wdw1AeXdemK5jsZm20tYjHo8xkU
         8ZMAKxF5XMzQluTVQeHZSl/Opju2GHiLUh5Tmm7Cs0sWg6x7TeRfCS0OK6/By6ugy0zQ
         OqCnkU7z/pw0kSolg9O02XL8s9u+ldcrFxK0q6c+uPRLswQ/i96iqk6xuevBcIp9B1rE
         vbhBoqcs5zBFTZqhqgOwLhnCS6oEANtgCqnqF3vqaN1/s2TjafxHdlesavzDIEwf5ObN
         NyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222190; x=1683814190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2H4cyUXjFd1sVbldEFnLS3eJhJb3gMZ1l+YTSGHHgw=;
        b=n812VXQcukaziB7px7iDwafl5LWqWxcq1b1tc1N8K2jFwxQFJOCDXxd1qRf+WqPmI+
         n3uahoY6P0Ux1FiXA/xoWaKdv3DnTm5ga5KJDPSA/Z2jHPToIekSiK2NI4tLVUN/9DI3
         wgKVJX1M0KKsorcztiVBlJFSqxYnmaza5OU/O4uGosVjB413jNSiUlMOr6wnjVTmU1Ru
         mX309WHWpNDFcGDJWirIIaavJL8rJB1HjoecHTPktgSYhNWeRMHjkzeGMYh7tfddGwuY
         iWJv+1OGHElc3I8pgTYQy991r2GFbPIz80bsPjKTYkSQOktnNB43w6QDkppAKmb7dkWp
         zS2g==
X-Gm-Message-State: AAQBX9fWjei7R+UfwjAJVJuoxIq2WAmAuQYPamFtgJUC/uIOe18NDjc2
        sMlt6sEF1ByKbtD3GNMZCvWoPnshZnxXNtu+2yPfPA==
X-Google-Smtp-Source: AKy350aV31TYYUVd5tBfDPkK4ASMQQekcl7aVIoMujED5GwyXqxh1y+zT3/hLP7JPA7bp/jTojRBwkhKaFSZx0Lb+fw=
X-Received: by 2002:a17:903:22cc:b0:19f:30be:e9f6 with SMTP id
 y12-20020a17090322cc00b0019f30bee9f6mr4781269plg.6.1681222187546; Tue, 11 Apr
 2023 07:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230410133930.30519-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20230410133930.30519-1-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 11 Apr 2023 15:09:35 +0100
Message-ID: <CAJ9a7VjgpkfYFUQtB3drZdgjaSk9PzWbJfvgZfuFf5y5WR0eQQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: Add support of setting trace id
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Apr 2023 at 14:40, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> With a growing number of trace sources, the number of source could
> be greater than 127 in future. There will be lack of ids. There could
> be also trace id reserved for some trace HW. With this change,
> trace id will be only configured when enable the source. Trace id
> will be dynamically allocated when traceid of driver data is not
> set when enable source. Once traceid of driver data is set when
> enable source, the traceid will be set as the specific value.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  35 +++---
>  .../coresight/coresight-etm4x-sysfs.c         |  30 +++++
>  drivers/hwtracing/coresight/coresight-stm.c   |  67 ++++++++---
>  drivers/hwtracing/coresight/coresight-tpda.c  | 107 ++++++++++++++----
>  drivers/hwtracing/coresight/coresight-tpda.h  |   4 +-
>  .../hwtracing/coresight/coresight-trace-id.c  |  56 +++++++++
>  .../hwtracing/coresight/coresight-trace-id.h  |  24 ++++
>  7 files changed, 274 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1ea8f173cca0..8f2e4d2b0fc2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -233,25 +233,32 @@ static int etm4_cpu_id(struct coresight_device *csdev)
>
>  int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>  {
> -       int trace_id;
> +       int trace_id, ret = 0;
>
> -       /*
> -        * This will allocate a trace ID to the cpu,
> -        * or return the one currently allocated.
> -        * The trace id function has its own lock
> -        */
> -       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> -       if (IS_VALID_CS_TRACE_ID(trace_id))
> -               drvdata->trcid = (u8)trace_id;
> -       else
> -               dev_err(&drvdata->csdev->dev,
> -                       "Failed to allocate trace ID for %s on CPU%d\n",
> -                       dev_name(&drvdata->csdev->dev), drvdata->cpu);
> -       return trace_id;
> +       if (!drvdata->trcid) {
> +               /*
> +                * This will allocate a trace ID to the cpu,
> +                * or return the one currently allocated.
> +                * The trace id function has its own lock
> +                */
> +               trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +               if (IS_VALID_CS_TRACE_ID(trace_id))
> +                       drvdata->trcid = (u8)trace_id;
> +               else {
> +                       ret = -EINVAL;
> +                       dev_err(&drvdata->csdev->dev,
> +                               "Failed to allocate trace ID for %s on CPU%d\n",
> +                               dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +               }
> +       } else
> +               ret = coresight_trace_id_set_cpu_id(drvdata->cpu, drvdata->trcid);
> +
> +       return ret;
>  }

This change is redundant. coresight_trace_id_get_cpu_id() will
allocate a trace id to the cpu if none is currently mapped, otherwise
it will return the currently mapped trace id.
There is no need to remap the id to the cpu every time.

>
>  void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
>  {
> +       drvdata->trcid = 0;
>         coresight_trace_id_put_cpu_id(drvdata->cpu);
>  }
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 5e62aa40ecd0..bd342e63868c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2335,6 +2335,35 @@ static ssize_t ts_source_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(ts_source);
>
> +static ssize_t traceid_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       int val;
> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       val = drvdata->trcid;
> +       return sysfs_emit(buf, "0x%x\n", val);
> +}
> +


This is also redundant. It replicates the trctraceid_show function

> +static ssize_t traceid_store(struct device *dev,
> +                           struct device_attribute *attr,
> +                           const char *buf, size_t size)
> +{
> +       int ret;
> +       unsigned long val;
> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       ret = kstrtoul(buf, 16, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (!drvdata->csdev->enable)
> +               drvdata->trcid = val;
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RW(traceid);
> +

Users are not permitted to set trace id values manually in this way.
This will potentially set an ID that is already used for another
device.


>  static struct attribute *coresight_etmv4_attrs[] = {
>         &dev_attr_nr_pe_cmp.attr,
>         &dev_attr_nr_addr_cmp.attr,
> @@ -2390,6 +2419,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
>         &dev_attr_vmid_masks.attr,
>         &dev_attr_cpu.attr,
>         &dev_attr_ts_source.attr,
> +       &dev_attr_traceid.attr,
>         NULL,
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 66a614c5492c..1291f5f39ab1 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -192,10 +192,29 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
>         CS_LOCK(drvdata->base);
>  }
>
> +static int stm_configure_trace_id(struct stm_drvdata *drvdata)
> +{
> +       int traceid, ret = 0;
> +
> +       if (!drvdata->traceid) {
> +               traceid = coresight_trace_id_get_system_id();
> +               if (traceid < 0)
> +                       return traceid;
> +
> +               drvdata->traceid = traceid;
> +       } else
> +               ret = coresight_trace_id_set_system_id(drvdata->traceid);
> +
> +       return ret;
> +
> +}
> +

again the mapping function remain with the id reserved till the put id
is called, so no need to set the id every time once allocated.

>  static int stm_enable(struct coresight_device *csdev,
>                       struct perf_event *event, u32 mode)
>  {
>         u32 val;
> +       int ret;
> +
>         struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
>         if (mode != CS_MODE_SYSFS)
> @@ -207,6 +226,10 @@ static int stm_enable(struct coresight_device *csdev,
>         if (val)
>                 return -EBUSY;
>
> +       ret = stm_configure_trace_id(drvdata);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_get_sync(csdev->dev.parent);
>
>         spin_lock(&drvdata->spinlock);
> @@ -261,6 +284,8 @@ static void stm_disable(struct coresight_device *csdev,
>         struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>         struct csdev_access *csa = &csdev->access;
>
> +
> +       coresight_trace_id_put_system_id(drvdata->traceid);

Enabling and releasing trace Ids in this way is potentially
problematical if the device is enabled and disabled multiple times
during a single trace recording session. Differnt IDs could be used.

We enable this ID at probe time as we expect there to be only a single
STM on any system - so allocating an ID for the lifetime of the driver
is reasonable.
If this change is required, then the sysfs model of allovate on read
or enable, release on sysfs reset should be followed.

>         /*
>          * For as long as the tracer isn't disabled another entity can't
>          * change its status.  As such we can read the status here without
> @@ -268,6 +293,7 @@ static void stm_disable(struct coresight_device *csdev,
>          */
>         if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
>                 spin_lock(&drvdata->spinlock);
> +               drvdata->traceid = 0;
>                 stm_disable_hw(drvdata);
>                 spin_unlock(&drvdata->spinlock);
>
> @@ -608,7 +634,33 @@ static ssize_t traceid_show(struct device *dev,
>         val = drvdata->traceid;
>         return sprintf(buf, "%#lx\n", val);
>  }
> -static DEVICE_ATTR_RO(traceid);
> +
> +static ssize_t traceid_store(struct device *dev,
> +                            struct device_attribute *attr,
> +                            const char *buf, size_t size)
> +{
> +       int ret;
> +       unsigned long val;
> +       struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       ret = kstrtoul(buf, 16, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (!IS_VALID_CS_TRACE_ID(val)) {
> +               dev_err(&drvdata->csdev->dev, "Invalid trace id\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!drvdata->csdev->enable)
> +               drvdata->traceid = val;
> +       else
> +               dev_err(&drvdata->csdev->dev, "Device must be enabled! %s\n",
> +                               __func__);
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RW(traceid);
>

Again do not do this - you are overriding the trace id mapping. Users
are not permitted to set arbitrary trace id values in this way

>  static struct attribute *coresight_stm_attrs[] = {
>         &dev_attr_hwevent_enable.attr,
> @@ -806,7 +858,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>
>  static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  {
> -       int ret, trace_id;
> +       int ret;
>         void __iomem *base;
>         struct device *dev = &adev->dev;
>         struct coresight_platform_data *pdata = NULL;
> @@ -890,22 +942,12 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>                 goto stm_unregister;
>         }
>
> -       trace_id = coresight_trace_id_get_system_id();
> -       if (trace_id < 0) {
> -               ret = trace_id;
> -               goto cs_unregister;
> -       }
> -       drvdata->traceid = (u8)trace_id;
> -
>         pm_runtime_put(&adev->dev);
>
>         dev_info(&drvdata->csdev->dev, "%s initialized\n",
>                  (char *)coresight_get_uci_data(id));
>         return 0;
>
> -cs_unregister:
> -       coresight_unregister(drvdata->csdev);
> -
>  stm_unregister:
>         stm_unregister_device(&drvdata->stm);
>         return ret;
> @@ -915,7 +957,6 @@ static void stm_remove(struct amba_device *adev)
>  {
>         struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>
> -       coresight_trace_id_put_system_id(drvdata->traceid);
>         coresight_unregister(drvdata->csdev);
>
>         stm_unregister_device(&drvdata->stm);
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index f712e112ecff..41f83a5de3f2 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -21,6 +21,28 @@
>
>  DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>
> +static int tpda_configure_trace_id(struct tpda_drvdata *drvdata)
> +{
> +       int traceid, ret;
> +       /*
> +        * TPDA must has a unique atid. This atid can uniquely
> +        * identify the TPDM trace source connected to the TPDA.
> +        * The TPDMs which are connected to same TPDA share the
> +        * same trace-id. When TPDA does packetization, different
> +        * port will have unique channel number for decoding.
> +        */
> +       if (!drvdata->traceid) {
> +               traceid = coresight_trace_id_get_system_id();
> +               if (traceid < 0)
> +                       return traceid;
> +
> +               drvdata->traceid = traceid;
> +       } else
> +               ret = coresight_trace_id_set_system_id(drvdata->traceid);
> +

redundant call - system ids are reserved till put system id is called.

> +       return ret;
> +}
> +

See above comments get_system_id is sufficient. If you choose to do
this on enable, then simply do not call the put till the trace session
is finished.

You have a potential race here between devices using the system id
calls trying to re-claim an id previously released.

>  /* Settings pre enabling port control register */
>  static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>  {
> @@ -28,8 +50,9 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>
>         val = readl_relaxed(drvdata->base + TPDA_CR);
>         val &= ~TPDA_CR_ATID;
> -       val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
> +       val |= FIELD_PREP(TPDA_CR_ATID, drvdata->traceid);
>         writel_relaxed(val, drvdata->base + TPDA_CR);
> +
>  }
>
>  static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
> @@ -52,11 +75,17 @@ static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>         tpda_enable_port(drvdata, port);
>
>         CS_LOCK(drvdata->base);
> +
>  }
>
>  static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
>  {
>         struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +       int ret;
> +
> +       ret = tpda_configure_trace_id(drvdata);
> +       if (ret)
> +               return ret;
>
>         spin_lock(&drvdata->spinlock);
>         if (atomic_read(&csdev->refcnt[inport]) == 0)
> @@ -87,7 +116,11 @@ static void tpda_disable(struct coresight_device *csdev, int inport,
>  {
>         struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> +       coresight_trace_id_put_system_id(drvdata->traceid);
>         spin_lock(&drvdata->spinlock);
> +
> +       drvdata->traceid = 0;
> +
>         if (atomic_dec_return(&csdev->refcnt[inport]) == 0)
>                 __tpda_disable(drvdata, inport);
>
> @@ -105,27 +138,63 @@ static const struct coresight_ops tpda_cs_ops = {
>         .link_ops       = &tpda_link_ops,
>  };
>
> -static int tpda_init_default_data(struct tpda_drvdata *drvdata)
> +static ssize_t traceid_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
>  {
> -       int atid;
> -       /*
> -        * TPDA must has a unique atid. This atid can uniquely
> -        * identify the TPDM trace source connected to the TPDA.
> -        * The TPDMs which are connected to same TPDA share the
> -        * same trace-id. When TPDA does packetization, different
> -        * port will have unique channel number for decoding.
> -        */
> -       atid = coresight_trace_id_get_system_id();
> -       if (atid < 0)
> -               return atid;
> +       int val;
> +       struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       drvdata->atid = atid;
> -       return 0;
> +       val = drvdata->traceid;
> +       return sysfs_emit(buf, "0x%x\n", val);
>  }
>
> -static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
> +static ssize_t traceid_store(struct device *dev,
> +                                           struct device_attribute *attr,
> +                                           const char *buf, size_t size)
>  {
>         int ret;
> +       unsigned long val;
> +       struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       ret = kstrtoul(buf, 16, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (!IS_VALID_CS_TRACE_ID(val)) {
> +               dev_err(drvdata->dev, "Invalid trace id\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!drvdata->csdev->enable)
> +               drvdata->traceid = val;
> +       else
> +               dev_err(drvdata->dev, "Device must be enabled! %s\n", __func__);
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RW(traceid);

This may override the mapping from the trace id API - there is no
guarantee that the value here will be available.
In general setting trace IDs via sysfs is prohibited.

The CPU / ETM4 sysfs will allocate on traceid read, or enable, and
then release the ID on sysfs reset on the device. This ensures that
teh user can read a sysfs id value that will be retained over the
trace session and viewable before or after the session is complete

> +
> +static struct attribute *coresight_tpda_attrs[] = {
> +       &dev_attr_traceid.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group coresight_tpda_group = {
> +       .attrs = coresight_tpda_attrs,
> +};
> +
> +static const struct attribute_group *coresight_tpda_groups[] = {
> +       &coresight_tpda_group,
> +       NULL,
> +};
> +
> +static void tpda_init_default_data(struct tpda_drvdata *drvdata)
> +{
> +       drvdata->traceid = 0;
> +}
> +
> +static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
> +{
>         struct device *dev = &adev->dev;
>         struct coresight_platform_data *pdata;
>         struct tpda_drvdata *drvdata;
> @@ -151,9 +220,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>
>         spin_lock_init(&drvdata->spinlock);
>
> -       ret = tpda_init_default_data(drvdata);
> -       if (ret)
> -               return ret;
> +       tpda_init_default_data(drvdata);
>
>         desc.name = coresight_alloc_device_name(&tpda_devs, dev);
>         if (!desc.name)
> @@ -164,6 +231,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.pdata = adev->dev.platform_data;
>         desc.dev = &adev->dev;
>         desc.access = CSDEV_ACCESS_IOMEM(base);
> +       desc.groups = coresight_tpda_groups;
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev))
>                 return PTR_ERR(drvdata->csdev);
> @@ -178,7 +246,6 @@ static void tpda_remove(struct amba_device *adev)
>  {
>         struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>
> -       coresight_trace_id_put_system_id(drvdata->atid);
>         coresight_unregister(drvdata->csdev);
>  }
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 0399678df312..5de6dc92f450 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -22,14 +22,14 @@
>   * @dev:        The device entity associated to this component.
>   * @csdev:      component vitals needed by the framework.
>   * @spinlock:   lock for the drvdata value.
> - * @enable:     enable status of the component.
> + * @traceid:    the atid value of TPDA.
>   */
>  struct tpda_drvdata {
>         void __iomem            *base;
>         struct device           *dev;
>         struct coresight_device *csdev;
>         spinlock_t              spinlock;
> -       u8                      atid;
> +       u8                      traceid;
>  };
>
>  #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index af5b4ef59cea..192626efcb01 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -110,6 +110,19 @@ static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map
>         return id;
>  }
>
> +static int coresight_trace_id_set(int id, struct coresight_trace_id_map *id_map)
> +{
> +       if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
> +               return -EINVAL;
> +       if (WARN(test_bit(id, id_map->used_ids), "ID is already used: %d\n", id))
> +               return -EINVAL;
> +       set_bit(id, id_map->used_ids);
> +
> +       DUMP_ID_MAP(id_map);
> +
> +       return 0;
> +}
> +
>  static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
>  {
>         if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
> @@ -195,6 +208,37 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>         return id;
>  }
>
> +static int coresight_trace_id_map_set_cpu_id(int cpu, int id, struct coresight_trace_id_map *id_map)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&id_map_lock, flags);
> +
> +       if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id)) {
> +               spin_unlock_irqrestore(&id_map_lock, flags);
> +               return -EINVAL;
> +       }
> +
> +       if (WARN(test_bit(id, id_map->used_ids), "ID is already used: %d\n", id)) {
> +               spin_unlock_irqrestore(&id_map_lock, flags);
> +               return -EINVAL;
> +       }
> +
> +       set_bit(id, id_map->used_ids);
> +
> +       /* allocate the new id to the cpu */
> +       atomic_set(&per_cpu(cpu_id, cpu), id);
> +
> +       cpumask_clear_cpu(cpu, &cpu_id_release_pending);
> +       clear_bit(id, id_map->pend_rel_ids);
> +
> +       spin_unlock_irqrestore(&id_map_lock, flags);
> +       DUMP_ID_CPU(cpu, id);
> +       DUMP_ID_MAP(id_map);
> +
> +       return 0;
> +}
> +

This is redundant and simply replicates the existing code. cpu mapped
IDs are retained for the full trace session, across multiple
enable/disable operations.
For perf, the IDs will be retained for the entire perf trace session,
during which the etm can be enabled and disabled multiple times.
For sysfs, the ids will be allocated on enable and retained till the
user writes to the sysfs reset function in the ETM4X.


>  static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         unsigned long flags;
> @@ -251,6 +295,12 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>
>  /* API functions */
>
> +int coresight_trace_id_set_cpu_id(int cpu, int id)
> +{
> +       return coresight_trace_id_map_set_cpu_id(cpu, id, &id_map_default);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_set_cpu_id);
> +

Redundant API, Ids are allocated and persistent as described above.

>  int coresight_trace_id_get_cpu_id(int cpu)
>  {
>         return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> @@ -269,6 +319,12 @@ int coresight_trace_id_read_cpu_id(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
>
> +int coresight_trace_id_set_system_id(int id)
> +{
> +       return coresight_trace_id_set(id, &id_map_default);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_set_system_id);
> +

This is unnecessary unless you have a device that has a specific trace
id hardcoded into the device that cannot be changed.

If there is such a case then we will have to implement a reservation
mechanism that reserves an ID to that specific device. To prevent race
conditions this would have to occur at device probe time and be
retained throughout the lifetime of the device driver.

If you need to retain system Ids across multiple enable / disable
cycles for sysfs then follow the model in the ETM4x driver.

Regards

Mike


>  int coresight_trace_id_get_system_id(void)
>  {
>         return coresight_trace_id_map_get_system_id(&id_map_default);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 3797777d367e..5dab9a473266 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -61,8 +61,21 @@ struct coresight_trace_id_map {
>         DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
>  };
>
> +
>  /* Allocate and release IDs for a single default trace ID map */
>
> +/**
> + * Set the CoreSight Trace Id for the CPU.
> + *
> + * Set CoreSight Trace Id associated with the CPU.
> + *
> + * @cpu: The CPU index for the id.
> + * @id: Coresight Trace ID value.
> + *
> + * return: 0 if set successfully or -EINVAL if fail to set.
> + */
> +int coresight_trace_id_set_cpu_id(int cpu, int id);
> +
>  /**
>   * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
>   *
> @@ -111,6 +124,17 @@ void coresight_trace_id_put_cpu_id(int cpu);
>   */
>  int coresight_trace_id_read_cpu_id(int cpu);
>
> +/**
> + * Set trace id for a system component.
> + *
> + * Set the trace id if system component needs a static id for the trace.
> + *
> + * @id: value of trace ID.
> + *
> + * return: 0 if set successfully or -EINVAL if fail to set.
> + */
> +int coresight_trace_id_set_system_id(int id);
> +
>  /**
>   * Allocate a CoreSight trace ID for a system component.
>   *
> --
> 2.39.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
