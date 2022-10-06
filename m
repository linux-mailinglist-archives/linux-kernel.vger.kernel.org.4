Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326215F6899
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiJFNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJFNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:55:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A022124C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:55:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so1774882pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GNscnZawRSDQzcarRuJ7ggWN/Upkivk6LJB9jm7BUAk=;
        b=BESDIcpUHn+E7ivOxrUkidOviXvpwCq2MRue2gIuswNndgRPzvFaivL7Nd/p1iV567
         GGf+EpEIp2KMxGEW8fruwQ5jFG4mI6Ft4KsjARUxSyClS/fQ5tpsSyS2jQu4twNEtGj4
         f5cMJJjiuan4QmcrS0jyt8ImhHWj2q1DeED+5wyeDI/23l/hmv9mUQTkC99Afu8Jzw0j
         No8dK2IvE+tfUf69ikOdnNMPU5mVzos+Jubf1afaQynbFwOMlGK8MAetpYMaC5CZpscb
         ywjTc613OjeDjt07y9JvAz6R7QfECG5j8qGLy1E11EiT70KDdHpzQg4I7TZqAT1wO+4w
         k34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GNscnZawRSDQzcarRuJ7ggWN/Upkivk6LJB9jm7BUAk=;
        b=vNoSHMj5jAN2fDGJtqnTwpnw8IaRqawTgTQv6aOh0wJkhIwx1niwHvR2kwho0+ctsz
         i2i13RvQuw8wKA7HKn4Gar2baSF2S4wAm0YXll91EQBtlFGKu9DM1csoRdTNsUZ86zmr
         f/eIgxYJAhM+utpP8Ptzz0KaKmHo0nouhJzJ8GbukWjH3B0eylAmlVfmgqNxmmXm3oZZ
         2xMBGt5p6d8iAlOf2wDly4Qk+AB4JEmiRO0i+ZEOQG7DqoSi7WWLzcAqHKxHwJoePT0w
         W0Xnyggwm3+YmB9f+xN4GaWFA6WTElhtzl7hjXFaTdaZLgFLC2b7tqZAY0lmzCY65aGK
         xeAw==
X-Gm-Message-State: ACrzQf3E4JPomemAnEzDO0dtXHaW5OnmDgvwJekcLKwjVh5WMEb5RN3T
        Ll1QABMn/PHqAqp0h7TO4YjJVXmwoKyC/0gcrKUrGw==
X-Google-Smtp-Source: AMsMyM7w4WLaVjg1vKq7SIEJAdDjx6f75uDM8/Fw5Cc0L0xz/tWLHg/d+3Q1BFthTdn8Fc8zlzyJHq4Chz0n4BUZ7zY=
X-Received: by 2002:a17:902:6b04:b0:17a:15a:1229 with SMTP id
 o4-20020a1709026b0400b0017a015a1229mr4651252plk.24.1665064502039; Thu, 06 Oct
 2022 06:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-4-mike.leach@linaro.org>
 <65e70db9-9f85-7285-0602-f2d29887550a@arm.com>
In-Reply-To: <65e70db9-9f85-7285-0602-f2d29887550a@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Oct 2022 14:54:50 +0100
Message-ID: <CAJ9a7Vgz+0xEQO-MvGUzbsr_LBh4pDep7JJtFoA+cAeiAERJFw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, 3 Oct 2022 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 09/08/2022 23:33, Mike Leach wrote:
> > Updates the STM driver to use the trace ID allocation API.
> > This uses the _system_id calls to allocate an ID on device poll,
> > and release on device remove.
> >
> > The sysfs access to the STMTRACEIDR register has been changed from RW
> > to RO. Having this value as writable is not appropriate for the new
> > Trace ID scheme - and had potential to cause errors in the previous
> > scheme if values clashed with other sources.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
> >   1 file changed, 14 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> > index bb14a3a8a921..9ef3e923a930 100644
> > --- a/drivers/hwtracing/coresight/coresight-stm.c
> > +++ b/drivers/hwtracing/coresight/coresight-stm.c
> > @@ -31,6 +31,7 @@
> >   #include <linux/stm.h>
> >
> >   #include "coresight-priv.h"
> > +#include "coresight-trace-id.h"
> >
> >   #define STMDMASTARTR                        0xc04
> >   #define STMDMASTOPR                 0xc08
> > @@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
> >       val = drvdata->traceid;
> >       return sprintf(buf, "%#lx\n", val);
> >   }
> > -
> > -static ssize_t traceid_store(struct device *dev,
> > -                          struct device_attribute *attr,
> > -                          const char *buf, size_t size)
> > -{
> > -     int ret;
> > -     unsigned long val;
> > -     struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > -
> > -     ret = kstrtoul(buf, 16, &val);
> > -     if (ret)
> > -             return ret;
> > -
> > -     /* traceid field is 7bit wide on STM32 */
> > -     drvdata->traceid = val & 0x7f;
> > -     return size;
> > -}
> > -static DEVICE_ATTR_RW(traceid);
> > +static DEVICE_ATTR_RO(traceid);
> >
> >   #define coresight_stm_reg(name, offset)     \
> >       coresight_simple_reg32(struct stm_drvdata, name, offset)
> > @@ -819,14 +803,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
> >        */
> >       drvdata->stmsper = ~0x0;
> >
> > -     /*
> > -      * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
> > -      * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
> > -      * also reserved the STM trace ID needs to be higher than 0x00 and
> > -      * lowner than 0x10.
> > -      */
> > -     drvdata->traceid = 0x1;
> > -
> >       /* Set invariant transaction timing on all channels */
> >       bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
> >   }
> > @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
> >
> >   static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >   {
> > -     int ret;
> > +     int ret, trace_id;
> >       void __iomem *base;
> >       struct device *dev = &adev->dev;
> >       struct coresight_platform_data *pdata = NULL;
> > @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >               goto stm_unregister;
> >       }
> >
> > +     trace_id = coresight_trace_id_get_system_id();
> > +     if (trace_id < 0) {
>
> The above API returns "INVALID_ID" and not a negative error status.
> I think it is better to fix the API to return:
>
>    ret < 0  - If there is any error
>             - Otherwise a positive integer
> And the users should be kept unaware of which ID is valid or invalid.
>

coresight_trace_id_get_system_id() returns the ID if one can be
allocated or -EINVAL if not.

Not sure what you are looking at here.

Mike


> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
