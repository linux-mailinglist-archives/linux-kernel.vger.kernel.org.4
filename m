Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4826860D648
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJYVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJYVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:45:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621C65027
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b11so6016552pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kK+NVAKYFB6C/U0fnuGpM8AspYJ6lf21/N2Izhrn1vU=;
        b=i7hk6RlLYFhoNdnfaeM3c+PUUfWus8pPN2A+1zjhOq4kL2aJqpLInYimMayujafigH
         duFb79niGCvM1qlTPhk65GW/bCUT2Y7/vEMIu0CFbR5IjBMX9+8GGZtlZMrJ9h2NJTDx
         UjlBbu9Qksxx8OSaYnNQL0hXiQhZ0DkXC5RWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK+NVAKYFB6C/U0fnuGpM8AspYJ6lf21/N2Izhrn1vU=;
        b=cp6dr7QmZXwPU+F7iY4WQZQ7QSjU103vyozPQRoh1/t4LTocpPP0cjs+IIWRsgXA+D
         ol3azDu0O9epDgQxJNl8yRDKPNWvoyIGD53fegI/6nahDJxG5DetVFaU6cyPXeNRE8zX
         sW5CFTn8ZBUDPgdiY5dHiMRn2vpqqbRLD+unoiuWJhW2kf5ySTH9XppqYx2vMHRS7hQp
         FNiJFjulA4K0k18xGnFWi1tT0g6xgYXKlImiQyPF7F/pDk6eChfHlFE0CZF52sEr/719
         2GcKkxiVALI6KPmq2WffKcXyIQv6UNukA8vZiVyQCetSaWKvri6XIfMUr1dx4tIXA9BV
         oVNg==
X-Gm-Message-State: ACrzQf0TUpLl1mWLUTXoKfUozaqvEd2WGFDQhb/8Xmfu7HonNjR+I09I
        WhVw/f9leFqBAPy/pcnR4MZ5VQ==
X-Google-Smtp-Source: AMsMyM4QXUCeTzwk/K1scOMPNYxWriXPyjOuHRCp6R/Q8za6/v8YsQcna09gxCbRuqidYLxGoQ6hyg==
X-Received: by 2002:a17:902:cf12:b0:179:fafd:8a1c with SMTP id i18-20020a170902cf1200b00179fafd8a1cmr41527794plg.102.1666734315312;
        Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:efef:6660:5e20:5f6b])
        by smtp.gmail.com with ESMTPSA id h29-20020a63531d000000b0046eb1d42a7fsm1686197pgb.55.2022.10.25.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 14:45:14 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:45:11 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y1hY57vkkOhybwE1@google.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
> On 24/10/22 20:55, Brian Norris wrote:
> > diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> > index 8f1023480e12..6a282c7a221e 100644
> > --- a/drivers/mmc/host/sdhci_am654.c
> > +++ b/drivers/mmc/host/sdhci_am654.c

> > @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> >  
> > -	sdhci_reset(host, mask);
> > +	sdhci_and_cqhci_reset(host, mask);
> >  
> >  	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
> >  		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> 
> What about sdhci_reset in sdhci_am654_ops ?

Oops, I think you caught a big fallacy in some of my patches: I assumed
there was a single reset() implementation in a given driver (an unwise
assumption, I realize). I see at least sdhci-brcmstb.c also has several
variant ops that call sdhci_reset(), and I should probably convert them
too.

I'll take another pass through the series for v4, fixing this and the
other smaller cosmetic issues. I may retain some Acks, depending on
whether I think the changes are substantial.

Thanks,
Brian
