Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B5717919
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjEaHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjEaHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:54:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90510EF
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:53:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3982f09df74so3319328b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519581; x=1688111581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UYtfabK9rEsTGok2TzyMhX/E+I+F3V8JOXJHjl1lfgI=;
        b=qIW0QrxGu0n4gQYHf4fQMt0F08Qc4Arhwk+3M3GdRZT7P8sNY+OrZJBq7qDNgc49j3
         mkSOkcDQwHVU9OJY5JbgC98VAVP0rFy5kB4J1xtSOfSzUYl3DMgC6P/x7NTPO3A5ihu0
         64ELWWS5J/4DpsBcn+G4pO2j7/a0gj7xAYRFV/vxzqRhtAS6RMVuKq2OOr1eLw7NwMsE
         xRKuiAV8X9lg0T30o8Zf5Sp1W7ez9yIaTKMEeh4TdD2hrQleuH9Ebe8n0EkcKzwDweYD
         uZsav88RHHE1Qo4BBsYKYXPiZcva6lEe+WlpehweSrMAKHnqO8vrDOjK5ByGjhmtV8yj
         gxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519581; x=1688111581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYtfabK9rEsTGok2TzyMhX/E+I+F3V8JOXJHjl1lfgI=;
        b=LyUN7FTmGtUY2ZEtGuYoxcDOYdEk77I2UYsF+3a0TxHrL4af0eUO+IzNnfdh9czRnL
         uqmMMEJOq/2nOOmNpJwX104Y6Cu6n2DiagQCt1s5laDCzkikKSSvWzAvIQEQGj2lOy0i
         UHbFPvNGZq9Dr/JpNXYLT1AFHNJCmPYpASNI9zzLaWpVqkWpL/HvPPSJojvWkgRaVmaS
         vDqLiX0A/v6gWV4wktpJvj3xJhmxZhZT1z5h2BFRgptVxqWHZw2sRutriz6qQf3wewrr
         Oqo03YxO48z9J0bohaAcBeOixnuFJDRcLOybRvvXTlK0LLeHqcR7G7cD1elPu2RYKlZ1
         XC2g==
X-Gm-Message-State: AC+VfDyw/Dk/cQnt+dn9/v1nh1deKr5Q4oVg3TfP1Ig3D5YBcvpvSGKV
        KrPQx1ua52t4qJFc4Lmtc+JfoVa39XiniGFGIViMfQ==
X-Google-Smtp-Source: ACHHUZ41SqBhMW6XGZnae48iPo3F6W4fUDynA7adBMhxXvRYKnGD1gBEI7Diev44dhC3n3aH78bw+FYYvBF22FSAEVs=
X-Received: by 2002:a05:6358:9218:b0:125:80a4:4733 with SMTP id
 d24-20020a056358921800b0012580a44733mr1562533rwb.10.1685519580876; Wed, 31
 May 2023 00:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com> <20230526153508.6208-3-quic_jinlmao@quicinc.com>
In-Reply-To: <20230526153508.6208-3-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 31 May 2023 08:52:49 +0100
Message-ID: <CAJ9a7Vjj_pcr4bZsrdqTR1=u1RHDZ_t0wgtbdn62a5j64hYrdA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] coresight-tmc: byte-cntr: Add support for
 streaming interface for ETR
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 26 May 2023 at 16:35, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Add support for a streaming interface for TMC ETR to allow for continuous
> log collection to secondary storage. An interrupt based mechanism is used
> to stream out the data from the device. The streaming interface cannot be
> used in conjunction with the traditional ETR read operation.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../testing/sysfs-bus-coresight-devices-tmc   |   7 +
>  drivers/hwtracing/coresight/Makefile          |   2 +-
>  .../hwtracing/coresight/coresight-byte-cntr.c | 304 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-byte-cntr.h |  49 +++
>  drivers/hwtracing/coresight/coresight-csr.c   |  26 ++
>  drivers/hwtracing/coresight/coresight-csr.h   |  19 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |  66 ++++
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   8 +-
>  drivers/hwtracing/coresight/coresight-tmc.h   |  12 +-
>  9 files changed, 481 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 6aa527296c71..efb6b70ce322 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -91,3 +91,10 @@ Contact:     Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (RW) Size of the trace buffer for TMC-ETR when used in SYSFS
>                 mode. Writable only for TMC-ETR configurations. The value
>                 should be aligned to the kernel pagesize.
> +
> +What:          /sys/bus/coresight/devices/<memory_map>.tmc/block_size
> +Date:          May 2023
> +KernelVersion: 6.3
> +Contact:       Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:   (RW) Size of the ETR irq byte counter value. The value
> +               need to be greater than 4096.
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 956c642d05f6..4440c1e36e66 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -9,7 +9,7 @@ coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>                 coresight-syscfg-configfs.o coresight-trace-id.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> -                     coresight-tmc-etr.o
> +                     coresight-tmc-etr.o coresight-byte-cntr.o

This counter is not part of the architected TMC. Please move to the CSR driver.

>  obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
>  obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
>  obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
> diff --git a/drivers/hwtracing/coresight/coresight-byte-cntr.c b/drivers/hwtracing/coresight/coresight-byte-cntr.c
> new file mode 100644
> index 000000000000..125c97fb1e35
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-byte-cntr.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/fs.h>
> +#include <linux/of_irq.h>
> +#include <linux/moduleparam.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <linux/property.h>
> +
> +#include "coresight-csr.h"
> +#include "coresight-byte-cntr.h"
> +
> +/* Read the data from ETR's DDR buffer */
> +static void tmc_etr_read_bytes(struct byte_cntr *byte_cntr_data, long offset,
> +                              size_t bytes, size_t *len, char **bufp)
> +{
> +       struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
> +       struct etr_buf *etr_buf = tmcdrvdata->sysfs_buf;
> +       size_t actual;
> +
> +       if (*len >= bytes)
> +               *len = bytes;
> +       else if (((uint32_t)offset % bytes) + *len > bytes)
> +               *len = bytes - ((uint32_t)offset % bytes);
> +
> +       actual = tmc_etr_buf_get_data(etr_buf, offset, *len, bufp);
> +       *len = actual;
> +       if (actual == bytes || (actual + (uint32_t)offset) % bytes == 0)
> +               atomic_dec(&byte_cntr_data->irq_cnt);
> +}
> +
> +
> +static irqreturn_t etr_handler(int irq, void *data)
> +{
> +       struct byte_cntr *byte_cntr_data = data;
> +
> +       atomic_inc(&byte_cntr_data->irq_cnt);
> +       wake_up(&byte_cntr_data->wq);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* Read function for /dev/byte-cntr */
> +static ssize_t tmc_etr_byte_cntr_read(struct file *fp, char __user *data,
> +                              size_t len, loff_t *ppos)
> +{
> +       struct byte_cntr *byte_cntr_data = fp->private_data;
> +       struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
> +       char *bufp = NULL;
> +       int ret = 0;
> +
> +       if (!data)
> +               return -EINVAL;
> +
> +       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +
> +       if (byte_cntr_data->enable) {
> +               if (!atomic_read(&byte_cntr_data->irq_cnt)) {
> +                       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +                       if (wait_event_interruptible(byte_cntr_data->wq,
> +                               atomic_read(&byte_cntr_data->irq_cnt) > 0
> +                               || !byte_cntr_data->enable))
> +                               return -ERESTARTSYS;
> +                       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +               }
> +
> +               tmc_etr_read_bytes(byte_cntr_data, byte_cntr_data->offset,
> +                                  byte_cntr_data->block_size, &len, &bufp);
> +       } else {
> +               ret = -EINVAL;
> +               goto err0;
> +       }
> +
> +       if (copy_to_user(data, bufp, len)) {
> +               mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +               dev_dbg(&tmcdrvdata->csdev->dev,
> +                       "%s: copy_to_user failed\n", __func__);
> +               return -EFAULT;
> +       }
> +
> +       if (byte_cntr_data->offset + len >= tmcdrvdata->size)
> +               byte_cntr_data->offset = 0;
> +       else
> +               byte_cntr_data->offset += len;
> +
> +       goto out;
> +
> +err0:
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +       return ret;
> +out:
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +       return len;
> +}
> +
> +/* Start byte-cntr function. */
> +void tmc_etr_byte_cntr_start(struct byte_cntr *byte_cntr_data)
> +{
> +       if (!byte_cntr_data)
> +               return;
> +
> +       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +
> +       /*
> +        * When block_size is not set or /dev/byte-cntr
> +        * is being read, don't start byte-cntr function.
> +        */
> +       if (byte_cntr_data->block_size == 0
> +               || byte_cntr_data->read_active) {
> +               mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +               return;
> +       }
> +
> +       atomic_set(&byte_cntr_data->irq_cnt, 0);
> +       byte_cntr_data->enable = true;
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +}
> +
> +/* Stop byte-cntr function */
> +void tmc_etr_byte_cntr_stop(struct byte_cntr *byte_cntr_data)
> +{
> +       struct tmc_drvdata *tmcdrvdata;
> +
> +       if (!byte_cntr_data)
> +               return;
> +
> +       tmcdrvdata = byte_cntr_data->tmcdrvdata;
> +
> +       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +       byte_cntr_data->enable = false;
> +       byte_cntr_data->read_active = false;
> +       atomic_set(&byte_cntr_data->irq_cnt, 0);
> +       wake_up(&byte_cntr_data->wq);
> +       coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +}
> +
> +static int tmc_etr_byte_cntr_release(struct inode *in, struct file *fp)
> +{
> +       struct byte_cntr *byte_cntr_data = fp->private_data;
> +       struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
> +
> +       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +       byte_cntr_data->read_active = false;
> +
> +       atomic_set(&byte_cntr_data->irq_cnt, 0);
> +
> +       if (byte_cntr_data->enable)
> +               coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
> +
> +       disable_irq_wake(byte_cntr_data->byte_cntr_irq);
> +
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +
> +       return 0;
> +}
> +
> +static int tmc_etr_byte_cntr_open(struct inode *in, struct file *fp)
> +{
> +       struct byte_cntr *byte_cntr_data =
> +                       container_of(in->i_cdev, struct byte_cntr, dev);
> +       struct tmc_drvdata *tmcdrvdata = byte_cntr_data->tmcdrvdata;
> +
> +       mutex_lock(&byte_cntr_data->byte_cntr_lock);
> +
> +       if (byte_cntr_data->read_active) {
> +               mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +               return -EBUSY;
> +       }
> +
> +       if (tmcdrvdata->mode != CS_MODE_SYSFS ||
> +                       !byte_cntr_data->block_size) {
> +               mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +               return -EINVAL;
> +       }
> +

All the functions above are not really part of the standard tmc - but
of a separate helper device on the output of the TMC - as such please
adjust the nameing to be byte_cntr... as below.

> +       enable_irq_wake(byte_cntr_data->byte_cntr_irq);
> +       /*
> +        * IRQ is a '8- byte' counter and to observe interrupt at
> +        * block_size' bytes of data
> +        */
> +       coresight_csr_set_byte_cntr(tmcdrvdata->csr, (byte_cntr_data->block_size) / 8);
> +
> +       fp->private_data = byte_cntr_data;
> +       nonseekable_open(in, fp);
> +       byte_cntr_data->enable = true;
> +       byte_cntr_data->read_active = true;
> +       mutex_unlock(&byte_cntr_data->byte_cntr_lock);
> +       return 0;
> +}
> +
> +static const struct file_operations byte_cntr_fops = {
> +       .owner          = THIS_MODULE,
> +       .open           = tmc_etr_byte_cntr_open,
> +       .read           = tmc_etr_byte_cntr_read,
> +       .release        = tmc_etr_byte_cntr_release,
> +       .llseek         = no_llseek,
> +};
> +
> +static int byte_cntr_register_chardev(struct byte_cntr *byte_cntr_data)
> +{
> +       int ret;
> +       unsigned int baseminor = 0;
> +       unsigned int count = 1;
> +       struct device *device;
> +       dev_t dev;
> +
> +       ret = alloc_chrdev_region(&dev, baseminor, count, "byte-cntr");
> +       if (ret < 0) {
> +               pr_err("alloc_chrdev_region failed %d\n", ret);
> +               return ret;
> +       }
> +       cdev_init(&byte_cntr_data->dev, &byte_cntr_fops);
> +
> +       byte_cntr_data->dev.owner = THIS_MODULE;
> +       byte_cntr_data->dev.ops = &byte_cntr_fops;
> +
> +       ret = cdev_add(&byte_cntr_data->dev, dev, 1);
> +       if (ret)
> +               goto exit_unreg_chrdev_region;
> +
> +       byte_cntr_data->driver_class = class_create(THIS_MODULE,
> +                                                  "coresight-tmc-etr-stream");
> +       if (IS_ERR(byte_cntr_data->driver_class)) {
> +               ret = -ENOMEM;
> +               pr_err("class_create failed %d\n", ret);
> +               goto exit_unreg_chrdev_region;
> +       }
> +
> +       device = device_create(byte_cntr_data->driver_class, NULL,
> +                              byte_cntr_data->dev.dev, byte_cntr_data,
> +                              "byte-cntr");
> +
> +       if (IS_ERR(device)) {
> +               pr_err("class_device_create failed %d\n", ret);
> +               ret = -ENOMEM;
> +               goto exit_destroy_class;
> +       }
> +
> +       return 0;
> +
> +exit_destroy_class:
> +       class_destroy(byte_cntr_data->driver_class);
> +exit_unreg_chrdev_region:
> +       unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
> +       return ret;
> +}
> +
> +struct byte_cntr *byte_cntr_init(struct amba_device *adev,
> +                                struct tmc_drvdata *drvdata)
> +{
> +       struct device *dev = &adev->dev;
> +       struct device_node *np = adev->dev.of_node;
> +       int byte_cntr_irq;
> +       int ret;
> +       struct byte_cntr *byte_cntr_data;
> +
> +       byte_cntr_irq = of_irq_get_byname(np, "byte-cntr-irq");
> +       if (byte_cntr_irq < 0)
> +               return NULL;
> +
> +       byte_cntr_data = devm_kzalloc(dev, sizeof(*byte_cntr_data), GFP_KERNEL);
> +       if (!byte_cntr_data)
> +               return NULL;
> +
> +       ret = devm_request_irq(dev, byte_cntr_irq, etr_handler,
> +                              IRQF_TRIGGER_RISING | IRQF_SHARED,
> +                              "tmc-etr", byte_cntr_data);
> +       if (ret) {
> +               devm_kfree(dev, byte_cntr_data);
> +               dev_err(dev, "Byte_cntr interrupt registration failed\n");
> +               return NULL;
> +       }
> +
> +       ret = byte_cntr_register_chardev(byte_cntr_data);
> +       if (ret) {
> +               devm_free_irq(dev, byte_cntr_irq, byte_cntr_data);
> +               devm_kfree(dev, byte_cntr_data);
> +               dev_err(dev, "Byte_cntr char dev registration failed\n");
> +               return NULL;
> +       }
> +
> +       byte_cntr_data->tmcdrvdata = drvdata;
> +       byte_cntr_data->byte_cntr_irq = byte_cntr_irq;
> +       atomic_set(&byte_cntr_data->irq_cnt, 0);
> +       init_waitqueue_head(&byte_cntr_data->wq);
> +       mutex_init(&byte_cntr_data->byte_cntr_lock);
> +
> +       return byte_cntr_data;
> +}
> +
> +void byte_cntr_remove(struct byte_cntr *byte_cntr_data)
> +{
> +       device_destroy(byte_cntr_data->driver_class,
> +                               byte_cntr_data->dev.dev);
> +       class_destroy(byte_cntr_data->driver_class);
> +       unregister_chrdev_region(byte_cntr_data->dev.dev, 1);
> +}
> +
> diff --git a/drivers/hwtracing/coresight/coresight-byte-cntr.h b/drivers/hwtracing/coresight/coresight-byte-cntr.h
> new file mode 100644
> index 000000000000..c41343ba2c9b
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-byte-cntr.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _CORESIGHT_BYTE_CNTR_H
> +#define _CORESIGHT_BYTE_CNTR_H
> +
> +#include <linux/cdev.h>
> +#include <linux/mutex.h>
> +#include <linux/wait.h>
> +#include "coresight-priv.h"
> +#include "coresight-tmc.h"
> +
> +/**
> + * struct byte_cntr - Data of ETR's byte_cntr config
> + * @dev: cdev of byte_cntr node.
> + * @driver_class: class data for the dev node.
> + * @enable: byte_cntr enable or not.
> + * @read_active: Indicate that data is read from /dev/byte-cntr.
> + * @block_size: The counter value of byte_cntr irq.
> + * @byte_cntr_irq: irq number.
> + * @byte_cntr_lock: lock of the byte_cntr data.
> + * @offset: The offset of current read point.
> + * @wq: byte_cntr read work queue.
> + * @irq_cnt: counter number of the byte_cntr irq.
> + * @tmcdrvdata: ETR drvdata.
> + */
> +struct byte_cntr {
> +       struct cdev             dev;
> +       struct class    *driver_class;
> +       bool                    enable;
> +       bool                    read_active;
> +       u32                     block_size;
> +       int                     byte_cntr_irq;
> +       struct mutex            byte_cntr_lock;
> +       unsigned long           offset;
> +       wait_queue_head_t       wq;
> +       atomic_t                irq_cnt;
> +       struct tmc_drvdata              *tmcdrvdata;
> +};
> +
> +struct byte_cntr *byte_cntr_init(struct amba_device *adev,
> +                                struct tmc_drvdata *drvdata);
> +void tmc_etr_byte_cntr_start(struct byte_cntr *byte_cntr_data);
> +void tmc_etr_byte_cntr_stop(struct byte_cntr *byte_cntr_data);
> +
> +
> +#endif
> diff --git a/drivers/hwtracing/coresight/coresight-csr.c b/drivers/hwtracing/coresight/coresight-csr.c
> index a1403e8531ee..45a72426a549 100644
> --- a/drivers/hwtracing/coresight/coresight-csr.c
> +++ b/drivers/hwtracing/coresight/coresight-csr.c
> @@ -18,6 +18,29 @@ DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
>
>  static LIST_HEAD(csr_list);
>
> +#define to_csr_drvdata(c) container_of(c, struct csr_drvdata, csr)
> +
> +void coresight_csr_set_byte_cntr(struct coresight_csr *csr,
> +                                       uint32_t count)
> +{
> +       struct csr_drvdata *drvdata;
> +       unsigned long flags;
> +
> +       if (csr == NULL)
> +               return;
> +
> +       drvdata = to_csr_drvdata(csr);
> +       if (IS_ERR_OR_NULL(drvdata) || !drvdata->set_byte_cntr_support)
> +               return;
> +
> +       spin_lock_irqsave(&drvdata->spin_lock, flags);
> +       CS_UNLOCK(drvdata->base);
> +       writel_relaxed(count, drvdata->base + CSR_BYTECNTVAL);
> +       CS_UNLOCK(drvdata->base);
> +       spin_unlock_irqrestore(&drvdata->spin_lock, flags);
> +}
> +EXPORT_SYMBOL(coresight_csr_set_byte_cntr);
> +
>  /*
>   * Get the CSR by name.
>   */
> @@ -85,6 +108,9 @@ static int csr_probe(struct platform_device *pdev)
>         if (!drvdata->base)
>                 return -ENOMEM;
>
> +       drvdata->set_byte_cntr_support = of_property_read_bool(
> +                       pdev->dev.of_node, "qcom,set-byte-cntr-support");
> +
>         desc.type = CORESIGHT_DEV_TYPE_HELPER;
>         desc.pdata = pdev->dev.platform_data;
>         desc.dev = &pdev->dev;
> diff --git a/drivers/hwtracing/coresight/coresight-csr.h b/drivers/hwtracing/coresight/coresight-csr.h
> index 3fd24b8e28e8..c618c5ae4eaa 100644
> --- a/drivers/hwtracing/coresight/coresight-csr.h
> +++ b/drivers/hwtracing/coresight/coresight-csr.h
> @@ -10,6 +10,8 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>
> +#define CSR_BYTECNTVAL         (0x06C)
> +
>  struct coresight_csr {
>         const char *name;
>         struct list_head link;
> @@ -17,13 +19,14 @@ struct coresight_csr {
>
>  /**
>   * struct csr_drvdata - specifics for the CSR device.
> - * @base:      Memory mapped base address for this component.
> - * @pbase:     Physical address base.
> - * @dev:       The device entity associated to this component.
> - * @csdev:     Data struct for coresight device.
> - * @csr:       CSR struct
> - * @clk:       Clock of this component.
> - * @spin_lock: Spin lock for the data.
> + * @base: Memory mapped base address for this component.
> + * @pbase: Physical address base.
> + * @dev: The device entity associated to this component.
> + * @csdev: Data struct for coresight device.
> + * @csr: CSR struct
> + * @clk: Clock of this component.
> + * @spin_lock: Spin lock for the data.
> + * @set_byte_cntr_support: Support set byte contr value or not.
>   */
>  struct csr_drvdata {
>         void __iomem            *base;
> @@ -33,7 +36,9 @@ struct csr_drvdata {
>         struct coresight_csr    csr;
>         struct clk              *clk;
>         spinlock_t              spin_lock;
> +       bool                    set_byte_cntr_support;
>  };
> +
>  #if IS_ENABLED(CONFIG_CORESIGHT_CSR)
>  extern void coresight_csr_set_byte_cntr(struct coresight_csr *csr, uint32_t count);
>  extern struct coresight_csr *coresight_csr_get(const char *name);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index c106d142e632..fd2bda0445be 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -329,9 +329,59 @@ static ssize_t buffer_size_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(buffer_size);
>
> +static ssize_t block_size_show(struct device *dev,
> +                            struct device_attribute *attr,
> +                            char *buf)
> +{
> +       struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +       uint32_t val = 0;
> +
> +       /* Only permitted for TMC-ETRs */
> +       if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
> +               return -EPERM;
> +
> +       if (drvdata->byte_cntr)
> +               val = drvdata->byte_cntr->block_size;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n",
> +                       val);
> +}
> +
> +static ssize_t block_size_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf,
> +                             size_t size)
> +{
> +       struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +       unsigned long val;
> +
> +       if (kstrtoul(buf, 0, &val))
> +               return -EINVAL;
> +
> +       /* Only permitted for TMC-ETRs */
> +       if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
> +               return -EPERM;
> +
> +       if (!drvdata->byte_cntr)
> +               return -EINVAL;
> +
> +       if (val && val < 4096) {
> +               pr_err("Assign minimum block size of 4096 bytes\n");
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&drvdata->byte_cntr->byte_cntr_lock);
> +       drvdata->byte_cntr->block_size = val;
> +       mutex_unlock(&drvdata->byte_cntr->byte_cntr_lock);
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RW(block_size);
> +
>  static struct attribute *coresight_tmc_attrs[] = {
>         &dev_attr_trigger_cntr.attr,
>         &dev_attr_buffer_size.attr,
> +       &dev_attr_block_size.attr,
>         NULL,
>  };
>

This attribute is not appropriate for the TMC and makes no sense other
than on your specific device. It is an attribute of the CSR block -
controlling when the interrupt is signalled. Please move this to the
CSR driver.

> @@ -473,6 +523,21 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
>         }
>
> +       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
> +               ret = of_get_coresight_csr_name(adev->dev.of_node, &drvdata->csr_name);
> +               if (ret)
> +                       dev_dbg(dev, "No csr data\n");
> +               else {
> +                       drvdata->csr = coresight_csr_get(drvdata->csr_name);
> +                       if (IS_ERR(drvdata->csr)) {
> +                               dev_dbg(dev, "failed to get csr, defer probe\n");
> +                               return -EPROBE_DEFER;
> +                       }
> +
> +               }
> +
> +       }
> +

The connection and enabling on the CSR in relation to the TMC must be
done using the coresight helper device mechnisms. The mechanisms I
mentioned in the 0/3 patch of this set will automatically call enable
and disable on helper devices associated with the TMC when it is
enabled and disabled. Setup of CSR should be done in its own enable /
disable functions.

>         desc.dev = dev;
>         desc.groups = coresight_tmc_groups;
>
> @@ -492,6 +557,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 if (ret)
>                         goto out;
>                 idr_init(&drvdata->idr);
> +               drvdata->byte_cntr = byte_cntr_init(adev, drvdata);
>                 mutex_init(&drvdata->idr_mutex);
>                 dev_list = &etr_devs;
>                 break;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 918d461fcf4a..bded8d4abe77 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -925,7 +925,7 @@ static void tmc_free_etr_buf(struct etr_buf *etr_buf)
>   * Returns: The size of the linear data available @pos, with *bufpp
>   * updated to point to the buffer.
>   */
> -static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
> +ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
>                                     u64 offset, size_t len, char **bufpp)

This function is normally only called when the TMC is stopped or
disabled. How do you ensure that the running TMC does not overwrite
the area you are attempting to read?

>  {
>         /* Adjust the length to limit this transaction to end of buffer */
> @@ -1235,8 +1235,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>         if (free_buf)
>                 tmc_etr_free_sysfs_buf(free_buf);
>
> -       if (!ret)
> +       if (!ret) {
> +               tmc_etr_byte_cntr_start(drvdata->byte_cntr);

Again  - not appropriate for a  generic TMC - the helper device will
take care of this.

>                 dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
> +       }
>
>         return ret;
>  }
> @@ -1706,7 +1708,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
>         drvdata->perf_buf = NULL;
>
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -
> +       tmc_etr_byte_cntr_stop(drvdata->byte_cntr);

remove as above

>         dev_dbg(&csdev->dev, "TMC-ETR disabled\n");
>         return 0;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 01c0382a29c0..082657fbb14c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -13,6 +13,9 @@
>  #include <linux/mutex.h>
>  #include <linux/refcount.h>
>
> +#include "coresight-csr.h"
> +#include "coresight-byte-cntr.h"
> +
>  #define TMC_RSZ                        0x004
>  #define TMC_STS                        0x00c
>  #define TMC_RRD                        0x010
> @@ -187,6 +190,9 @@ struct etr_buf {
>   * @idr_mutex: Access serialisation for idr.
>   * @sysfs_buf: SYSFS buffer for ETR.
>   * @perf_buf:  PERF buffer for ETR.
> + * @csr:       CSR data struct of ETR.
> + * @csr_name:  CSR node name.
> + * @byte_cntr: Byte_cntr data of ETR.
>   */
>  struct tmc_drvdata {
>         void __iomem            *base;
> @@ -211,6 +217,9 @@ struct tmc_drvdata {
>         struct mutex            idr_mutex;
>         struct etr_buf          *sysfs_buf;
>         struct etr_buf          *perf_buf;
> +       struct coresight_csr    *csr;
> +       const char              *csr_name;
> +       struct byte_cntr        *byte_cntr;

This can be dropped when you move the byte counter functionality into
the CSR driver.

You will need some sort of interface into the TMC - but this should
only be to read the data, and ensure that the sysfs reads which you
say are not permitted are prevented when using the TMC in this mode,
and that the appropirate buffer has been created. As mentioned, your
code at present assumes that the TMC will always use a flat buffer
when using sysfs - and it does not check for buffer wrap and misses
out the sync operations that the standard sysfs read use to ensure DMA
synchronisation.

>  };
>
>  struct etr_buf_operations {
> @@ -276,7 +285,8 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etr_cs_ops;
>  ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>                                 loff_t pos, size_t len, char **bufpp);
> -
> +ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
> +                               u64 offset, size_t len, char **bufpp);
>
>  #define TMC_REG_PAIR(name, lo_off, hi_off)                             \
>  static inline u64                                                      \
> --
> 2.17.1
>

Regards

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
