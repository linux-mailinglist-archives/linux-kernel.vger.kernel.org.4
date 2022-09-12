Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A995B5F29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiILRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiILRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:21:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986843F338
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:21:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c2so9236624plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=8omfsmP1AXfXjnxGxM02yiToDjwPr5oGBetF8GZ8Gwo=;
        b=UymwzJMzKZGvgG4wWFyAidoZLx/3/MFqOGgUk2pPWIqsT2w3bhGoT1aZRLc/z+0i4C
         Iw+WvLcI6T5d6ujicxBOfU6/mgtnCfI4beWHhi7e8gyCzC6KOQpFCHR7ZqocjXw928/4
         94XfwSXSWTIFkidkMjoN7nJbxQMXgpuYJ0AC5WXdCbVa+PVRNV93/nnQ6Q6riosWpSL3
         iFx5j9SjF0HbDXiW2e0z4z8DDI64G3O97M2Bq4ipl8yVYEsX0hTYHLsuqWPq7tFPXW17
         nNgOfw0aipxV/WMy+l9MvFdU3lQeTpSyK2bFTycUBr/O64VcprKDVOzYRTrC8MhvdqIy
         3Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8omfsmP1AXfXjnxGxM02yiToDjwPr5oGBetF8GZ8Gwo=;
        b=swgtIM84GFrDUvOtrE0fERO5HnsK8dyFDvpTcrv6SYcgecpls8K7GgaFEUnNiLQ2ui
         394TcCkHfIxnPuP84KKr2C7mJArh5Yk3LZ/8SKQ7fNm3ZciCJQSkYHsm4Rs0wXYB+/P+
         K71OUsJn7wc2NdeJ5eao/5w6RXqoYuTdVBOcxxPOBz1N4av9htTrIUvMeEK4elspkAr3
         ZYtTvqZp9GplYSL6fVme9+RvCcGgOVIsNIXC9+jZHwcsEanAOh2k2eqbJbgBPITMvsAn
         49vkSCLweODr7J5sJgsMQt46isXUBJrANwLTxF0+6FXm1n5rL48uFt72zNGC4SbkBsIz
         XV2w==
X-Gm-Message-State: ACgBeo1+6X+u7h3a3xhRmKFNDk4swRafw6DFjy2COqfkp4akzVrN68Iq
        qMVvM6gecpWqaxn1DJITB6C9
X-Google-Smtp-Source: AA6agR5asszcZ71zyiNjcSyvWK8TtaEaE997jarGwHUI8RjDIXhh00O1ui19e3GpE6sURmPGkJqxgQ==
X-Received: by 2002:a17:902:7c05:b0:178:1f92:288e with SMTP id x5-20020a1709027c0500b001781f92288emr11118902pll.92.1663003300577;
        Mon, 12 Sep 2022 10:21:40 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b00174ce512262sm6373814plg.182.2022.09.12.10.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 10:21:39 -0700 (PDT)
Date:   Mon, 12 Sep 2022 22:51:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Message-ID: <20220912172134.GA25849@workstation>
References: <af79fc4d-4996-bb2c-7388-2d9afd991e7a@quicinc.com>
 <20220912170806.GA512933@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220912170806.GA512933@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:08:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 12, 2022 at 09:40:30PM +0530, Krishna Chaitanya Chundru wrote:
> > On 9/10/2022 1:21 AM, Bjorn Helgaas wrote:
> > > On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
> > > > Add suspend and resume syscore ops.
> > > > 
> > > > When system suspends, and if the link is in L1ss, disable the clocks
> > > > and power down the phy so that system enters into low power state by
> > > > parking link in L1ss to save the maximum power. And when the system
> > > > resumes, enable the clocks back and power on phy if they are disabled
> > > > in the suspend path.
> > > > 
> > > > we are doing this only when link is in l1ss but not in L2/L3 as
> > > > nowhere we are forcing link to L2/L3 by sending PME turn off.
> > > > 
> > > > is_suspended flag indicates if the clocks are disabled in the suspend
> > > > path or not.
> > > > 
> > > > There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> > > > (getting hit by affinity changes while making CPUs offline during suspend,
> > > > this will happen after devices are suspended (all phases of suspend ops)).
> > > > When registered with pm ops there is a crash due to un-clocked access,
> > > > as in the pm suspend op clocks are disabled. So, registering with syscore
> > > > ops which will called after making CPUs offline.
> > > > 
> > > > Make GDSC always on to ensure controller and its dependent clocks
> > > > won't go down during system suspend.
> > > > 
> > > > Krishna chaitanya chundru (5):
> > > >    PCI: qcom: Add system suspend and resume support
> > > >    PCI: qcom: Add retry logic for link to be stable in L1ss
> > > >    phy: core: Add support for phy power down & power up
> > > >    phy: qcom: Add power down/up callbacks to pcie phy
> > > >    clk: qcom: Alwaya on pcie gdsc
> > >
> > > This seems fairly ugly because it doesn't fit nicely into the PM
> > > framework.  Why is this a qcom-specific thing?  What about other
> > > DWC-based controllers?
> >
> > We wanted to allow system S3 state by turning off all PCIe clocks
> > but at the same time retaining NVMe device in D0 state and PCIe link
> > in l1ss state.
> >
> > Here nothing really specific to DWC as PCIe controller remains intact.
> > 
> > And the Qcom PHY allows this scheme  (that is to retain the link
> > state in l1ss even though all pcie clocks are turned off).
> 
> Is there somewhere in the PCIe spec I can read about how a link with
> clocks turned off can remain in L1.1 or L1.2?
> 

This part is Qcom specific. On Qcom platforms there are two power domains used,
CX and MX. CX domain is sourcing the PCIe controller and MX is sourcing PCIe
PHY.

Both PCIe and PHY drivers don't control MX domain and only control CX.
So even though this patch is turning off all of the PCIe clocks, that
only helps in powering down the CX domain for achieving the low power
usecase while still keeping MX domain powered on.

So at the end of suspend, the PCIe controller would've turned off but
the link stays in L1SS state due to it being backed by MX.

> > Since clocks are completely managed by qcom platform driver, we are
> > trying to manage them during S3/S0 transitions with PM callbacks.
> 
> I'm looking at this text in PCIe r6.0, sec 5.4.1:
> 
>   Components in the D0 state (i.e., fully active state) normally keep
>   their Upstream Link in the active L0 state, as defined in § Section
>   5.3.2 . ASPM defines a protocol for components in the D0 state to
>   reduce Link power by placing their Links into a low power state and
>   instructing the other end of the Link to do likewise. This
>   capability allows hardware-autonomous, dynamic Link power reduction
>   beyond what is achievable by software-only controlled (i.e., PCI-PM
>   software driven) power management.
> 
> How does this qcom software management of clocks fit into this scheme?
> It seems to me that if you need software to turn clocks off and on,
> that is no longer ASPM.
> 

The PCIe link automatically transitions to L1SS if there is no activity
on the link but still the clocks sourced to the PCIe controller needs to be
turned off. PCIe spec only covers the link specifics and the controller is
platform dependent.

Thanks,
Mani

> Bjorn
