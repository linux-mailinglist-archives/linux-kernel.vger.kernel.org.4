Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC65BE1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiITJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiITJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502BE6CD04;
        Tue, 20 Sep 2022 02:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18F661DC6;
        Tue, 20 Sep 2022 09:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F92C433D6;
        Tue, 20 Sep 2022 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663666139;
        bh=c9tNWaX+fG4Wy0u/MHxZ7+cfWDSAeFQOc1Tp0X/dp30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBs016aYWv/9hPEvaf9RCowNRCwkfgSvgZ7FXp58il6YCQZHRDQdbJ3QF+GokU2rs
         UrY8lL9GIL3WSxvpcKol9BBH/PxXKlmw228u73oxfTbt68kcD3n2rUF+meD/+brhjf
         o8135p5R8VrhCW7O8GXaSvR/DkoEPgLvPjA9p7Cwu0bRzGwMsLaKZw2Lgqkd4apvNk
         /ZGuQbF9NHpTVNihvmN4C+qBWxXcKgL8trBUsYxsbyeXHfObkN3MJYxThz2i/QmIYj
         z09laYILSS8/AdN0SBWYYjPZL3dGE2NAuUo+KnHdrXwkJfsrXMHs49XTZUZ9c1h8RS
         qfCzkbC/9pcwQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaZYr-0002Wy-8G; Tue, 20 Sep 2022 11:29:01 +0200
Date:   Tue, 20 Sep 2022 11:29:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, kishon@ti.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix the SM8450 PCS registers
Message-ID: <YymH3XCz2r/pj0xY@hovoldconsulting.com>
References: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
 <YylhpBtz8d2dqJhv@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylhpBtz8d2dqJhv@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:15:56PM +0530, Vinod Koul wrote:
> On 10-09-22, 12:08, Manivannan Sadhasivam wrote:
> > In the PCS region, registers QPHY_V5_PCS_EQ_CONFIG4 and
> > QPHY_V5_PCS_EQ_CONFIG5 should be used instead of QPHY_V5_PCS_EQ_CONFIG2
> > and QPHY_V5_PCS_EQ_CONFIG3.
> > 
> > This causes high latency when ASPM is enabled, so fix it!
> > 
> > Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---

> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > index 61a44519f969..cca6455ec98c 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > @@ -11,7 +11,7 @@
> >  #define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
> >  #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
> >  #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
> > -#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
> > -#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4

Why are you removing these defines? (They are correct for sc8280xp.)

> > +#define QPHY_V5_PCS_EQ_CONFIG4				0x2e0
> > +#define QPHY_V5_PCS_EQ_CONFIG5				0x2e4
> 
> This conflicts with c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
> 
> where QPHY_V5_PCS_EQ_CONFIG5 was added as 0x1e0
> 
> Do we have a different v5 for SM8450 and SC8280XP?

I can confirm that the PCS_EQ_CONFIG defines added for sc8280xp matches
the vendor's headers for both the combo and USB PHYs.

Johan
