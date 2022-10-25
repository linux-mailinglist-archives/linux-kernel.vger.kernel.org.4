Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C4160D70C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiJYW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiJYW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:26:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842EFB706
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:26:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jo13so8639502plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVEPqaLVudNuaFpxbKtyRoGGYaYZMen60jyTQDmJ0k0=;
        b=K+FHUN+DhmHFK1V/WuSfv6mwiiQHXJjg1sZf/h/3SDbpDj6pyeIVX+ifv9e5rbB4nn
         7xwJgy2i0vtw4aKv/75RDvV95Tm2r1nRElNfDSCBSRJz82TaTUVW5e8ZwdKDcbon4eQ0
         SDWFUUlX1tMUlzGfAU+nySGlIs39X+hE7DUCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVEPqaLVudNuaFpxbKtyRoGGYaYZMen60jyTQDmJ0k0=;
        b=5Eji5p4M0L0dwgH42Co8LSYUi3oPXgZ8Z0bQYYJYtZx9APler4GJwRvXvtGHGbbN6a
         ZaHhA8B9AXeuTkNMWExZXf/ux1+/Vrtt7+tsx+pYyYzaXRAqpBxPwmE0xdvgLiS9sxME
         SA9ynB85Aia3rlPjDwKpkRR4+okumxV/OS+H5KBlFfPjZSFFYo6QvKMMhUiHzUM1U6w5
         2iHHxrTgVB6rC8Ho08MCmg6OzHLtUUPuIoYV9P4E1wAX9AVA603w8gbdOvGF4ssXM1M3
         8DrnJndOUxA8QE4MLxkxtNZ2VoYB1L+/moqzVaY0PY/EXAHuR44dERgAMBsmon9geVa0
         LUxg==
X-Gm-Message-State: ACrzQf01TmJ4alpnl1Q4le6llwgDM6UYMS6tThC8J2hMwnpmuzuUGnnu
        AZOjWneM/TvF+NI0wD8SqY5fXA==
X-Google-Smtp-Source: AMsMyM6gD0CPcY0vG7fGXAk8rMs0hZe+/EtLUVVDC9aYXK3R4Doan2SbfHHxcEtilRi8tbarYUldfA==
X-Received: by 2002:a17:90a:9a8f:b0:212:ea8d:dc34 with SMTP id e15-20020a17090a9a8f00b00212ea8ddc34mr624038pjp.30.1666736774027;
        Tue, 25 Oct 2022 15:26:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:efef:6660:5e20:5f6b])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001752216ca51sm1653302plt.39.2022.10.25.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:26:13 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:26:10 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
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
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y1higmSUMLsxvXyq@google.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
 <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:53:46PM -0700, Florian Fainelli wrote:
> On 10/25/22 14:45, Brian Norris wrote:
> > On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
> > > On 24/10/22 20:55, Brian Norris wrote:
> > > > diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> > > > index 8f1023480e12..6a282c7a221e 100644
> > > > --- a/drivers/mmc/host/sdhci_am654.c
> > > > +++ b/drivers/mmc/host/sdhci_am654.c
> > 
> > > > @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
> > > >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > >   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> > > > -	sdhci_reset(host, mask);
> > > > +	sdhci_and_cqhci_reset(host, mask);
> > > >   	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
> > > >   		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > 
> > > What about sdhci_reset in sdhci_am654_ops ?
> > 
> > Oops, I think you caught a big fallacy in some of my patches: I assumed
> > there was a single reset() implementation in a given driver (an unwise
> > assumption, I realize). I see at least sdhci-brcmstb.c also has several
> > variant ops that call sdhci_reset(), and I should probably convert them
> > too.
> 
> You got it right for sdhci-brcmstb.c because "supports-cqe" which gates the
> enabling of CQE can only be found with the "brcm,bcm7216-sdhci" compatible
> which implies using brcmstb_reset().

I don't see any in-tree device trees for these chips (which is OK), and
that's not what the Documentation/ says, and AFAICT nothing in the
driver is limiting other variants from specifying the "supports-cqe"
flag in their (out-of-tree) device tree. The closest thing I see is that
an *example* in brcm,sdhci-brcmstb.yaml shows "supports-cqe" only on
brcm,bcm7216-sdhci -- but an example is not a binding agreement. Am I
missing something?

Now of course, you probably know behind the scenes that there are no
other sdhci-brcmstb-relevant controllers that "support cqe", but AFAICT
I have no way of knowing that a priori. The driver and bindings give
(too much?) flexibility.

Poking around, I think the only other one I might have missed would be
gl9763e in sdhci-pci-gli.c. That also calls cqhci_init() but is
otherwise relying on the default sdhci_pci_ops. So I'd either have to
change the common sdhci_pci_ops, or else start a new copy/paste/modify
'struct sdhci_ops' for it... This really does start to get messy when
poking around on drivers I can't test. As in, it shouldn't be harmful
to change most sdhci_reset() to sdhci_and_cqhci_reset() (as long as they
aren't using some other CQE implementation), but the more invasive it
gets (say, rewriting a bunch of other ops), the easier it is to get
something wrong.

Thoughts welcome.

Brian
