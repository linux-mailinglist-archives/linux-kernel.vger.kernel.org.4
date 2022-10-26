Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674060E718
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiJZSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiJZSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:18:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C53C45BA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:18:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso2919537pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YP8jpqbbIYZxZWSoeoFbOkeJPwCMijsPk6P/JiUcvP4=;
        b=GdEZnBhNeLS3QFsCKyyIKFOJSw4RhzT4wX54Iz+TZXK6p5hKwk6YFm/wOebhWl/ger
         Tx7QNrcB6aJx5HErg/rVYPyyRaPtZWnn6eeqLyv5aVOlfuvztFMYltiBrcvlnc/ztjAD
         XOufFWlUHHnz+mNy0Q/K2qZXWkeQF4dMfvAq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP8jpqbbIYZxZWSoeoFbOkeJPwCMijsPk6P/JiUcvP4=;
        b=UjJdZaN1yggr6EZrtcSk+zQJaX8WVEF+8l9OKwyBOIwRIvJ2enzlI6GX70LRxzPvph
         E/IPIC4e8OclrF9Jm+7tcZ5TgDLdRwAQxwF6qk2CgScQK8vNw4jmoP5Mlk1nUxNncWRu
         wR2G8JHI+FCUPNmJHvYl5+joqs+mEqS3gxr8sBL3zftk4mhRQcUSmq5Or9xTEefjtVcI
         liyci1IQAWnoG3rSpg9azNOE1LUTFGBRuR1jjnHXzx1CXd0USkC9pcQX+kvfF9a+bOVq
         rLdxwoG1Xzzybcfho0Bnbi7IJvPKdCpaeZkYhXuFDPJgw0HGyORFuN6P7sY2c21W5WrD
         RNgA==
X-Gm-Message-State: ACrzQf1pDQa7FpmhwqDKpyq6Xz3LBmJKYJefsxYylFKLv5imoAYhOxP4
        jMduTk7lNW1XZp4bAs56+7o/iQ==
X-Google-Smtp-Source: AMsMyM6dLJd6E7h/F0+/aOt92HNYIp4+1kEGsJEox48TAdqkhmOa0QYlOyAryLYM348bQd5wCsctDg==
X-Received: by 2002:a17:90b:3887:b0:213:566a:1417 with SMTP id mu7-20020a17090b388700b00213566a1417mr4549636pjb.225.1666808320852;
        Wed, 26 Oct 2022 11:18:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b00186a2444a43sm3223958plg.27.2022.10.26.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:18:40 -0700 (PDT)
Date:   Wed, 26 Oct 2022 11:18:37 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y1l5/U3WnbDIIMOj@google.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
 <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
 <Y1higmSUMLsxvXyq@google.com>
 <7db0a98e-36c8-afee-5b0d-16b836ac8de0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db0a98e-36c8-afee-5b0d-16b836ac8de0@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Oct 26, 2022 at 08:36:48AM +0300, Adrian Hunter wrote:
> On 26/10/22 01:26, Brian Norris wrote:
> > On Tue, Oct 25, 2022 at 02:53:46PM -0700, Florian Fainelli wrote:
> >> On 10/25/22 14:45, Brian Norris wrote:
> >>> On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
> >>>> On 24/10/22 20:55, Brian Norris wrote:
> >>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> >>>>> index 8f1023480e12..6a282c7a221e 100644
> >>>>> --- a/drivers/mmc/host/sdhci_am654.c
> >>>>> +++ b/drivers/mmc/host/sdhci_am654.c
> >>>
> >>>>> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
> >>>>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> >>>>> -	sdhci_reset(host, mask);
> >>>>> +	sdhci_and_cqhci_reset(host, mask);
> >>>>>   	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
> >>>>>   		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> >>>>
> >>>> What about sdhci_reset in sdhci_am654_ops ?
> >>>
> >>> Oops, I think you caught a big fallacy in some of my patches: I assumed
> >>> there was a single reset() implementation in a given driver (an unwise
> >>> assumption, I realize). I see at least sdhci-brcmstb.c also has several
> >>> variant ops that call sdhci_reset(), and I should probably convert them
> >>> too.
> 
> I checked and found only sdhci_am654_ops

And...how about sdhci_j721e_8bit_ops in that same driver?

> >> You got it right for sdhci-brcmstb.c because "supports-cqe" which gates the
> >> enabling of CQE can only be found with the "brcm,bcm7216-sdhci" compatible
> >> which implies using brcmstb_reset().
> > 
> > I don't see any in-tree device trees for these chips (which is OK), and
> > that's not what the Documentation/ says, and AFAICT nothing in the
> > driver is limiting other variants from specifying the "supports-cqe"
> > flag in their (out-of-tree) device tree. The closest thing I see is that
> > an *example* in brcm,sdhci-brcmstb.yaml shows "supports-cqe" only on
> > brcm,bcm7216-sdhci -- but an example is not a binding agreement. Am I
> > missing something?
> 
> It was mentioned in the patch from the Fixes tag.

OK, good note. If I don't patch the other seemingly-unaffected variants
in brcmstb, I'll at least update the commit message, since the code
doesn't tell me they're unaffected.

> > Now of course, you probably know behind the scenes that there are no
> > other sdhci-brcmstb-relevant controllers that "support cqe", but AFAICT
> > I have no way of knowing that a priori. The driver and bindings give
> > (too much?) flexibility.
> > 
> > Poking around, I think the only other one I might have missed would be
> > gl9763e in sdhci-pci-gli.c. That also calls cqhci_init() but is
> > otherwise relying on the default sdhci_pci_ops. So I'd either have to
> 
> It uses sdhci_gl9763e_ops not the default sdhci_pci_ops.  It looks OK
> to me.

Ugh, of course you're right. I think I'm mixing up past history and
stuff I'm trying to patch now. I *am* patching gl9763e already in this
series, but simply as a refactor, and not any additional bugfix.

> > change the common sdhci_pci_ops, or else start a new copy/paste/modify
> > 'struct sdhci_ops' for it... This really does start to get messy when
> > poking around on drivers I can't test. As in, it shouldn't be harmful
> > to change most sdhci_reset() to sdhci_and_cqhci_reset() (as long as they
> > aren't using some other CQE implementation), but the more invasive it
> > gets (say, rewriting a bunch of other ops), the easier it is to get
> > something wrong.
> 
> AFAICS it was just sdhci_am654_ops

Agreed it's less to change than I thought. But I think you (and I) also
missed sdhci_j721e_8bit_ops.

Assuming I'm not totally off-base yet again...v4 is coming sooner or
later.

Brian
