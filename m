Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B806052E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiJSWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiJSWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:19:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36988B1EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:19:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so1485366pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaGv7LlJBdgHofmM5ORri4ochUXzvI+2qUpKqb/vueI=;
        b=XPXW0AcauLG0R9ecSLc8KU3XGw73i+SHfDt8loROSQA6cTZ5b9EowD9Wn/KEgzCYVM
         O+03dmnQNBXaDLT3Y7U2d6SG4dgsB/7nJwvHYw97536Qclx3ik8mriTR1G4zV1244QIn
         KcXdlV+SOBPKJCSbTBZgkU6c5qlVP/oGs7aec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaGv7LlJBdgHofmM5ORri4ochUXzvI+2qUpKqb/vueI=;
        b=cw/e7p+wU+24IDMVYqoM85ypjQIFD8G8fEkmJ8Xz8IVVWHNEoL8teORlb3+POqvuHE
         KL3TqHAzHy1SvXgA9G7+mXq2sSGPtf+vBX9vHoMDlXrX2jjhnO3Wuhkr1KtNx+Pegq/N
         y8RAJ13OTX/gIzrWQ4lF/zCXBLmrEUHMlracQzu1baZxAYeEg7XsqHUQ+1n4fbhpliZe
         WBDcoDZ0t+05tz5GSonIKEPvx5e+fvFhTeMZUgwSOuW4KhlION10JwTC/yOeS/KvZf34
         MyV8I1FrRiaUxtk96HKZsH5uppNujs9ecYm2GZ8TmzmLc5i4SWMS5TlAtAacmW7Gr12M
         95PQ==
X-Gm-Message-State: ACrzQf1jwC26HIzbvotOKhaoaVXhdBRwKx6NsfJ/ic9wOnhIrYtAB1kT
        tTQ4EMIbKY3iFH9UCUW9TNmVmg==
X-Google-Smtp-Source: AMsMyM6m0qybDJCJSqtG9j3D5wrv8KHuP86ID2eiErDwVgap0Kq2QZsnamY56NRwNhc9lqyG+NYllg==
X-Received: by 2002:a17:90a:9381:b0:20a:79b7:766a with SMTP id q1-20020a17090a938100b0020a79b7766amr48854405pjo.33.1666217963650;
        Wed, 19 Oct 2022 15:19:23 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm11458401plc.283.2022.10.19.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:19:23 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:19:20 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for
 CQHCI
Message-ID: <Y1B36AnqJtolGQEP@google.com>
References: <20221019215440.277643-1-briannorris@chromium.org>
 <20221019145246.v2.2.I29f6a2189e84e35ad89c1833793dca9e36c64297@changeid>
 <14efb3e6-96cf-f42e-16aa-c45001ec632e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14efb3e6-96cf-f42e-16aa-c45001ec632e@gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 02:59:39PM -0700, Florian Fainelli wrote:
> On 10/19/22 14:54, Brian Norris wrote:
> > The same bug was already found and fixed for two other drivers, in v5.7
> > and v5.9:
> > 
> > 5cf583f1fb9c mmc: sdhci-msm: Deactivate CQE during SDHC reset
> > df57d73276b8 mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers
> > 
> > The latter is especially prescient, saying "other drivers using CQHCI
> > might benefit from a similar change, if they also have CQHCI reset by
> > SDHCI_RESET_ALL."

> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -366,6 +366,9 @@ static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >   	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> > +	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
> > +		cqhci_deactivate(host->mmc);
> > +
> >   	sdhci_reset(host, mask);
> 
> Cannot this be absorbed by sdhci_reset() that all of these drivers appear to
> be utilizing since you have access to the host and the mask to make that
> decision?

It potentially could.

I don't know if this is a specified SDHCI behavior that really belongs
in the common helper, or if this is just a commonly-shared behavior. Per
the comments I quote above ("if they also have CQHCI reset by
SDHCI_RESET_ALL"), I chose to leave that as an implementation-specific
behavior.

I suppose it's not all that harmful to do this even if some SDHCI
controller doesn't have the same behavior/quirk.

I guess I also don't know if any SDHCI controllers will support command
queueing (MMC_CAP2_CQE) via somethings *besides* CQHCI. I see
CQE support in sdhci-sprd.c without CQHCI, although that driver doesn't
set MMC_CAP2_CQE.

Brian
