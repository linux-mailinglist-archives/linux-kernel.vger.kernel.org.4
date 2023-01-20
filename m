Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC9675051
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjATJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:11:13 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237238F7E1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:10:34 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id q125so5076614vsb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZaS2jFjKgJPIvOoi38x6xVSa304xRVXmBfQSeerAQY=;
        b=oS34Rc5HqDn0y15rqvi/SJ7g/YzvXWq0oxQW3beFjIl1h0f2A1Hbkc6cYkGT/Qt9u7
         I2whoZrl78YFDiKZsS3Gp8hoc/MAtStyl8kT501tDSnjzejpUcrEAKrWvfWqqQCKhXn9
         BYvMzs3RTYs3I0fetVg4f0ujpF21vjBQ16sLDg1U8mo9AT2mWcgZ0yQC0k5VhelwF06a
         qLDRvDv7lVwx+PDEZtqTJ7YDDYNidzpcHtOf4XQfIQ9kNj2WfW8+nkCBq619uUKy0jGQ
         Jc6Y/SDX6V5/Z4L2J2ZrQgwmMY3PW96vmVnGwxDWhfQMQGTnSw+ZKu1K1MfE8GsC/20c
         cvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZaS2jFjKgJPIvOoi38x6xVSa304xRVXmBfQSeerAQY=;
        b=z5xmB/MYoHOED1NLWNcsYtekdcC6VEm5dRSGZRcbmuut/A+typDc5Qd2sM7Cq+trf9
         LhQ7yInjS+V371k5ZLRaXU+X6oGhBvfd/84PDZnun1QNHi6/tANX78mggeEtvAn2EZZ7
         L0r4jRCqZWLtxfvIMg7tj9ekqlauM1pXiRHABV5iD0PhiziNb/YZPKUowkHIlfyE9c44
         rjg10M4iXXaoZFCqN4jt2AbKiE1jl9jiIxdsZmooyjXdlDG2+kh68Qf8ajk7csiw8bmU
         DO7qSt8LDAB03f7184nQdC/wACDag9db37eiHNL51hYIStErRQwxTFQO3wdRGgmdDOtU
         pbqg==
X-Gm-Message-State: AFqh2koiS8TaCBDQtIhnYLIKWNE9r+btPlkBaIN4eLDEPkMDQisK8pFj
        vRlZwoNViZl4CqHLeRSuU09rCgSRHvlfouleUnkVew==
X-Google-Smtp-Source: AMrXdXuoNgBQTMIHd+dvijVuebGsbNf80ukIzQIavSmHvcpNOwe/UwQI7TD7lVbOmJjHW7p96DCDvNBXfraxk5DyG7M=
X-Received: by 2002:a67:f2da:0:b0:3d3:d90c:5ef2 with SMTP id
 a26-20020a67f2da000000b003d3d90c5ef2mr2358807vsn.17.1674205804654; Fri, 20
 Jan 2023 01:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20230118140825.242544-1-brgl@bgdev.pl> <20230118140825.242544-3-brgl@bgdev.pl>
 <4f65001a-b442-7425-dfa3-b1e9be81d566@linaro.org>
In-Reply-To: <4f65001a-b442-7425-dfa3-b1e9be81d566@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 20 Jan 2023 10:09:53 +0100
Message-ID: <CAMRc=MfnBF3Bnez7w+twmn8bzCk3HRRSq69mJ3NpSrQeQqpPDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add a driver for sa8775p
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:45 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 18.01.2023 15:08, Bartosz Golaszewski wrote:
> > From: Shazad Hussain <quic_shazhuss@quicinc.com>
> >
> > Introduce QTI SA8775P-specific interconnect driver.
> >
> > Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> > [Bartosz: made the driver ready for upstream]
> > Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/interconnect/qcom/Kconfig   |    9 +
> >  drivers/interconnect/qcom/Makefile  |    2 +
> >  drivers/interconnect/qcom/sa8775p.c | 2541 +++++++++++++++++++++++++++
> >  3 files changed, 2552 insertions(+)
> >  create mode 100644 drivers/interconnect/qcom/sa8775p.c
> >
> > diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> > index cd689b782f97..3132a03ca974 100644
> > --- a/drivers/interconnect/qcom/Kconfig
> > +++ b/drivers/interconnect/qcom/Kconfig
> > @@ -92,6 +92,15 @@ config INTERCONNECT_QCOM_RPMH_POSSIBLE
> >  config INTERCONNECT_QCOM_RPMH
> >       tristate
> >
> > +config INTERCONNECT_QCOM_SA8775P
> > +     tristate "Qualcomm SA8775P interconnect driver"
> > +     depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> > +     select INTERCONNECT_QCOM_RPMH
> > +     select INTERCONNECT_QCOM_BCM_VOTER
> > +     help
> > +       This is a driver for the Qualcomm Network-on-Chip on sa8775p-based
> > +       platforms.
> > +
> >  config INTERCONNECT_QCOM_SC7180
> >       tristate "Qualcomm SC7180 interconnect driver"
> >       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> > diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> > index 3fd4c2713c4a..75df2cf64c0b 100644
> > --- a/drivers/interconnect/qcom/Makefile
> > +++ b/drivers/interconnect/qcom/Makefile
> > @@ -13,6 +13,7 @@ qnoc-qcm2290-objs                   := qcm2290.o
> >  qnoc-qcs404-objs                     := qcs404.o
> >  qnoc-qdu1000-objs                    := qdu1000.o
> >  icc-rpmh-obj                         := icc-rpmh.o
> > +qnoc-sa8775p-objs                    := sa8775p.o
> >  qnoc-sc7180-objs                     := sc7180.o
> >  qnoc-sc7280-objs                        := sc7280.o
> >  qnoc-sc8180x-objs                    := sc8180x.o
> > @@ -39,6 +40,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_QDU1000) += qnoc-qdu1000.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
> > +obj-$(CONFIG_INTERCONNECT_QCOM_SA8775P) += qnoc-sa8775p.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) += qnoc-sc7280.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) += qnoc-sc8180x.o
> > diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
> > new file mode 100644
> > index 000000000000..da21cc31a580
> > --- /dev/null
> > +++ b/drivers/interconnect/qcom/sa8775p.c
> > @@ -0,0 +1,2541 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> > +
> > +#include "bcm-voter.h"
> > +#include "icc-rpmh.h"
> > +
> > +#define SA8775P_MASTER_GPU_TCU                               0
> Other drivers move these to socname.h
>

Why would they do it if the symbols are not meant to be used outside
of the driver?

> Otherwise, this lgtm:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>

[...]

Bart
