Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44A68893F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjBBVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjBBVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:50:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B410C6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:49:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so5068350lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDgDu4Pg6Xihc/t0MuyIpqIzGcYpSCTohlnE5v2ocN4=;
        b=E1GIRojfvxs42+81MLxR/crCAkmGa0m7dglBBaSPcKfBcrb70wqCF4vLE0F5FRVIcz
         YxqXb0Z8Esm5uf3ctMLJVPXZFter8aeyB90SEQT1Y0dxU1Eic2jaxjmERcPwB+tyIVMU
         DtgPX32JZJxL2eaOEVtlLcpeqwueU9dKrXMoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDgDu4Pg6Xihc/t0MuyIpqIzGcYpSCTohlnE5v2ocN4=;
        b=wiuWR/DmDcQOxVMQHjWiN46Qm4BiFC8qNbZbuERT0uXqr/ZzemA+yEKgMItZMNKx4o
         KMuCquYRB1bR1NqrYGjFF3v92LehAfqrt2FPu1o8eeQV43qFit+46o29D7lnLJ3xRZKs
         v3pP2I2l+cUmw3pj+WfSGjYrrzCm90LXtpDLcElZOVYLl5qg3ba8BAn0RF7oPmKmA0dI
         z32EQVGeETYhJPTpAPf/C8g/4cJ+PsaRB5RR67LMGl1wj4+KNy9z2bjNYsR8qL3ZJoHo
         vM+fht+9ikDHIAzIYwczbQuMEaOQEfRBtjhCa4exkILlfBj69zwb1W+LEjhU/7c0wLPU
         XZBA==
X-Gm-Message-State: AO0yUKUVKfoYFXwI7RYz9F+dLtrzpuP+B8NuclIx3ouy1SB4aOK+ovVk
        kg2sj5w6Vc62FfA/4n2MuD155sef+jm7O7jLzwVXIQ==
X-Google-Smtp-Source: AK7set8tw6glWzk+9yeJqW1TWOCmFoiQcVBfgfEBkbXcPo7ThefbfwmGxv6nVfCiz4o5sPmEjXJ7Pl4PU3COKQNMYv8=
X-Received: by 2002:a19:7005:0:b0:4d8:7552:2c19 with SMTP id
 h5-20020a197005000000b004d875522c19mr1166727lfc.34.1675374587154; Thu, 02 Feb
 2023 13:49:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Feb 2023 13:49:46 -0800
MIME-Version: 1.0
In-Reply-To: <Y85l4aQmEW0iOHHa@hovoldconsulting.com>
References: <20230113204548.578798-1-swboyd@chromium.org> <20230113204548.578798-6-swboyd@chromium.org>
 <Y85l4aQmEW0iOHHa@hovoldconsulting.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 2 Feb 2023 13:49:46 -0800
Message-ID: <CAE-0n52ky-ugoOe4yWZNNsma=HSp1MbTT+A=Bu9+R_=jBeTNoA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y v2 5/5] phy: qcom-qmp-combo: fix runtime suspend
To:     Johan Hovold <johan@kernel.org>
Cc:     stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2023-01-23 02:48:01)
> On Fri, Jan 13, 2023 at 12:45:48PM -0800, Stephen Boyd wrote:
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > index b8646eaf1767..64a42e28e99f 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -4985,15 +4985,11 @@ static void qcom_qmp_phy_disable_autonomous_mode(struct qmp_phy *qphy)
> >  static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
> >  {
> >       struct qcom_qmp *qmp = dev_get_drvdata(dev);
> > -     struct qmp_phy *qphy = qmp->phys[0];
> > +     struct qmp_phy *qphy = qmp->usb_phy;
> >       const struct qmp_phy_cfg *cfg = qphy->cfg;
> >
> >       dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
> >
> > -     /* Supported only for USB3 PHY and luckily USB3 is the first phy */
> > -     if (cfg->type != PHY_TYPE_USB3)
> > -             return 0;
>
> This is still not correct as this code would now be executed also for
> PCIe and UFS PHYs, which wasn't the case before.

Ah right. So weirdly, the conditional should be kept.
