Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60D969A499
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBQEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQEBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:01:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA93800F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:01:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y20so13740ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ymeKyoEPaB2TlyXtYfKO3gw6CH1MjfygMlQz73O8po=;
        b=yCZKr8/p4yd+8jG2V8QlBXF9KW3dR7ZBJGXIWJ9S0PxxkGxs9p/hPwsoZBM80VHShR
         4LdrM/kudaLex8OpMLiIzw1ptqK2nTs2YGhlxQ5Glrfy7FmQ05XSKl97t8Gq/iXvM6AJ
         yDNiUDfIU66SA9X+POtTNQAOZcjVd8Ny9SomMb4vei22woi5WigkWY1cT+bEpD8fMhKg
         PGPeDPmBCbeT1P2TLuFTcAbz0u0uh9K7qWHe4LJ7l6BLT6UdVitFsnYNK4bmfQsQXtP7
         UHq+R9bx3po5ispQXnqo5ajbhz3Ay3UCnECMGO4K34Z6ZTdwKephGKsShTPCRA7I5cI5
         ZhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ymeKyoEPaB2TlyXtYfKO3gw6CH1MjfygMlQz73O8po=;
        b=28bBJE9lnhVHrMmJhou/fMtabvMm3VeZrl3BdTCQ1Plb5m4fauQTtMoScDBYbwoJ1H
         AiP79skeeJW32IHE7NXwdxZZNSuLYpd62yQL201770iQK1PC4uOMWTv7BvTrMkuJiN0a
         MMCozUwOZ03JLvacYHodEBEAxc9g3R3yFXXOFzDVBkcvfPBoZ0e920E7eBVTbEnvvbFJ
         efihxcielGkkze0RSvzmZMi1YGtbC4GZBYHYEly+7+ZgFlE3ysGOssE70Um80xGA6Len
         s8L9oJKMvCPEVW8gtCo9ai67NXe3GDGc3c8YZMd1Dg1AWP8E29/4idAkSPZzPHR2jwpa
         dHCQ==
X-Gm-Message-State: AO0yUKU3NEPoCyc4dW2eDPAZlMH4DsHm7AbahfZEJpd08XJ7J6gsYZ+c
        YfcRydbhChJh2J3sHdkklZa1jCeIfo3HKuEho2X+1Q==
X-Google-Smtp-Source: AK7set8K5xDrSpT9L0kqCyfqBz0MMroZlR6Mbt2q07zvqdmgztRyOjO1+YmLFjBskGBUQZJF1uyB0xVoL/svv7JZWJ8=
X-Received: by 2002:a05:651c:1719:b0:293:4e6d:f4f7 with SMTP id
 be25-20020a05651c171900b002934e6df4f7mr2283009ljb.3.1676606467219; Thu, 16
 Feb 2023 20:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
 <20220921030649.1436434-2-bhupesh.sharma@linaro.org> <a5b6255c-7282-32ed-8031-a4b841a78db7@linaro.org>
In-Reply-To: <a5b6255c-7282-32ed-8031-a4b841a78db7@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 17 Feb 2023 09:30:55 +0530
Message-ID: <CAH=2Ntw6XcyB2zy-cs35z3eOf8iTa28hGerhLndOgARrG05gJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize
 interconnect path
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     dmaengine@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 19:49, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> On 9/21/22 06:06, Bhupesh Sharma wrote:
> > From: Thara Gopinath <thara.gopinath@gmail.com>
> >
> > BAM dma engine associated with certain hardware blocks could require
> > relevant interconnect pieces be initialized prior to the dma engine
> > initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
>
> Apparently it's proven that the change description is incorrect, Qualcomm
> crypto engine is working fine on SM8250 and even more recent platforms,
> so far there is no obvious necessity in this change.

Since your v9 patchset produces no entry in $ cat /proc/crypto on
either RB5 (qrb5165) or (with an additional patch) on sm8150-mtp or
sa8115p-adp with the default arm64 defconfig with linux-next, I am not
sure we can conclude QCE is working with these changes.

Please share more details on how you tested this.

Regards,
Bhupesh

> > is passed on to the bam dma driver from dt via the "interconnects"
> > property. Add support in bam_dma driver to check whether the interconnect
> > path is accessible/enabled prior to attempting driver intializations.
> >
> > If interconnects are not yet setup, defer the BAM DMA driver probe().
> >
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > [Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
> > ---
> >   drivers/dma/qcom/bam_dma.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 2ff787df513e..a5b0cf28ffb7 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -26,6 +26,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/io.h>
> >   #include <linux/init.h>
> > +#include <linux/interconnect.h>
> >   #include <linux/slab.h>
> >   #include <linux/module.h>
> >   #include <linux/interrupt.h>
> > @@ -394,6 +395,7 @@ struct bam_device {
> >       const struct reg_offset_data *layout;
> >
> >       struct clk *bamclk;
> > +     struct icc_path *mem_path;
> >       int irq;
> >
> >       /* dma start transaction tasklet */
> > @@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
> >       if (IS_ERR(bdev->bamclk))
> >               return PTR_ERR(bdev->bamclk);
> >
> > +     /* Ensure that interconnects are initialized */
> > +     bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
> > +     if (IS_ERR(bdev->mem_path)) {
> > +             ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
> > +                                 "failed to acquire icc path\n");
> > +             return ret;
> > +     }
> > +
> >       ret = clk_prepare_enable(bdev->bamclk);
> >       if (ret) {
> >               dev_err(bdev->dev, "failed to prepare/enable clock\n");
>
> I'm resurrecting the comments on this change to emphasize the observation
> that the change is not needed at all to run QCE.
>
> --
> Best wishes,
> Vladimir
