Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F436C4670
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCVJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCVJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AF5BDA3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:29:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so18700490pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679477388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JvXYjfZIZksyVY1mj/gCB2AUSy719t2h0+qLgOlCWP0=;
        b=C8BmvFhWd2feAtq2QGqBSlhm7Ke9PrbN5Zen9iblSVaAyF8iTHvGT8I9Pje99jMeGP
         K0SCxx60nAEe/gWh07UADJDD47SDCkzIcADtpSUwQz6wmWbcAbsiS9G+RGX1RfFkJxVe
         Q1dxlMsVeEDnL1HUITAmgLSSmXCfykD53/W//ZL916XYe+wd6JcBH51COn5jnA9Tijvp
         8uc6SrX7FqJTGUuNb0uJpM6wBb+lRfTdqNs/g1M5BYakd+fdpAOVmn5hPSZfGKMWo2eN
         PeTgbV7Kj3NazRwc6lMwHGfpifLBeDqDJpSYQOf9K9yPxKji+nFwiEnOw6ytq42vS+KX
         YgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvXYjfZIZksyVY1mj/gCB2AUSy719t2h0+qLgOlCWP0=;
        b=5SSYltNcpvKLwdphmE8VfoLKmTqlSY38n0tQHZ02YsG/Q4pLXFG1A4vTrs4sMRfPMa
         Bam4lO+2NtAsPZAxU+yj0XLlNPfNikB0GmYsVqFN3XI1sEfE3GEI6gVkwlzpqm78uyKe
         IqwllD1DC/DKupLvTd3B8Qg65YbUmiAeHTgNRL0i25bVWcFLUNqinqRFMRpTEHkxkynx
         LRutEozgprHEHYauXB0amTGxjVXhFKBXL4HqnsUBkpdVFW27pmRx6V/qET5tD7W92tlC
         4ylzV7ltfk+CzU6jTzzVprfL75YWtwiBirxNaTTE58KFq0uhmABrKcFHIdMipONrWecE
         0u7g==
X-Gm-Message-State: AO0yUKU+uRsd4j3mUM9HeryqK06dEc+Qd+11viACWwYnxvPmKeZVl2R0
        4AtnsHx8RfCw0BHdYMNUHnW7nNoGRc0ELwGBhLx+yw==
X-Google-Smtp-Source: AK7set8Yz+48n6K21dcnorhUdQzx1Snbz+kW2Sum2Oh4R0frlNAYeWf4wL3mo4FuCLYYlVrnRRudmRkxQaj0GhxWT3I=
X-Received: by 2002:a17:902:7291:b0:1a0:48ff:5388 with SMTP id
 d17-20020a170902729100b001a048ff5388mr737709pll.6.1679477387807; Wed, 22 Mar
 2023 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-9-james.clark@arm.com>
 <ca4dba90-8739-ad73-d3d7-681cf2326643@arm.com>
In-Reply-To: <ca4dba90-8739-ad73-d3d7-681cf2326643@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 22 Mar 2023 09:29:36 +0000
Message-ID: <CAJ9a7Vg+z50TOghys8mXpkLt1fO2YCr74PEk-8PMr61-s7R6xA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] coresight: Enable and disable helper devices
 adjacent to the path
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 11:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 10/03/2023 16:06, James Clark wrote:
> > Currently CATU is the only helper device, and its enable and disable
> > calls are hard coded. To allow more helper devices to be added in a
> > generic way, remove these hard coded calls and just enable and disable
> > all helper devices.
> >
> > This has to apply to helpers adjacent to the path, because they will
> > never be in the path. CATU was already discovered in this way, so
> > there is no change there.
> >
> > One change that is needed is for CATU to call back into ETR to allocate
> > the buffer. Because the enable call was previously hard coded, it was
> > done at a point where the buffer was already allocated, but this is no
> > longer the case.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-catu.c  | 34 ++++++++--
> >   drivers/hwtracing/coresight/coresight-core.c  | 68 ++++++++++++++++++-
> >   .../hwtracing/coresight/coresight-tmc-etr.c   | 28 --------
> >   include/linux/coresight.h                     |  3 +-
> >   4 files changed, 99 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> > index bc90a03f478f..24a08a2b96b1 100644
> > --- a/drivers/hwtracing/coresight/coresight-catu.c
> > +++ b/drivers/hwtracing/coresight/coresight-catu.c
> > @@ -395,13 +395,32 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
> >       return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
> >   }
> >
> > -static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> > +static struct coresight_device *
> > +catu_get_etr_device(struct coresight_device *csdev)
> > +{
> > +     int i;
> > +     struct coresight_device *tmp;
> > +
> > +     for (i = 0; i < csdev->pdata->nr_inconns; i++) {
> > +             tmp = csdev->pdata->in_conns[i].remote_dev;
> > +             if (tmp && tmp->type == CORESIGHT_DEV_TYPE_SINK &&
> > +                 tmp->subtype.sink_subtype ==
> > +                         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM)
> > +                     return tmp;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
> > +                       void *data)
> >   {
> >       int rc;
> >       u32 control, mode;
> > -     struct etr_buf *etr_buf = data;
> > +     struct etr_buf *etr_buf = NULL;
> >       struct device *dev = &drvdata->csdev->dev;
> >       struct coresight_device *csdev = drvdata->csdev;
> > +     struct coresight_device *etrdev;
> >
> >       if (catu_wait_for_ready(drvdata))
> >               dev_warn(dev, "Timeout while waiting for READY\n");
> > @@ -416,6 +435,12 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> >       if (rc)
> >               return rc;
> >
> > +     etrdev = catu_get_etr_device(csdev);
> > +     if (etrdev) {
> > +             etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
> > +             if (IS_ERR(etr_buf))
> > +                     return PTR_ERR(etr_buf);
> > +     }
>
> WARN_ON(!etrdev) ? We are not supposed to reach in the first place and
> return.
>
>
> >       control |= BIT(CATU_CONTROL_ENABLE);
> >
> >       if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
> > @@ -441,13 +466,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> >       return 0;
> >   }
> >
> > -static int catu_enable(struct coresight_device *csdev, void *data)
> > +static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
> > +                    void *data)
> >   {
> >       int rc;
> >       struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
> >
> >       CS_UNLOCK(catu_drvdata->base);
> > -     rc = catu_enable_hw(catu_drvdata, data);
> > +     rc = catu_enable_hw(catu_drvdata, mode, data);
> >       CS_LOCK(catu_drvdata->base);
> >       return rc;
> >   }
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index a8ba7493c09a..3e6ccd9e8d4e 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -441,6 +441,34 @@ static int coresight_enable_source(struct coresight_device *csdev,
> >       return 0;
> >   }
> >
> > +static int coresight_enable_helper(struct coresight_device *csdev,
> > +                                enum cs_mode mode, void *sink_data)
>
> minor nit: s/sink_data/data/ ? Though it is always either sink_data
> (perf mode) or NULL (sysfs mode), for the core code it is simply an
> opaque data.
>
> Rest looks fine to me.
>
> Suzuki
>
>
Reviewed by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
