Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB255EEEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiI2H0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiI2HZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:25:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44C13D76;
        Thu, 29 Sep 2022 00:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAD66B8233F;
        Thu, 29 Sep 2022 07:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA7C433D7;
        Thu, 29 Sep 2022 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664436350;
        bh=JZDOgB1vIukfHv5av9y47wgB68bL740uiqdRbkiYGmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtKAJlztbKYrxvmZ6j0cNGroPxCeHi9j66jkxA55GIN0p0IXXYj0ksD+l8aTTSSuH
         qgs7mWjUK/BzOdP7HVMDNjk7KqT89GwQNbmuv7I4BIDRTxIo0rjOxW6E0btmRqyq7v
         ACLYmPF3QrctN5vUOvx4ilOoUeH27Dw5gm2fiiTqbhXMFOC9DiVzoUwnfM0wSko1U5
         mJhwE7hg4h+GU8YyiVIdHvjReB6oJMoXe5AUWnwCMHtYhiHD869sxJjwJNvqjDjAsi
         3FOalncqgUaOF3XBXxQLFkwYNcy9LIEUEPIQiLVc+zKsVtLEI+RiCMW2hi53IEib4E
         GRM57lDC5g7Bw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odnvg-0006Yb-PH; Thu, 29 Sep 2022 09:25:56 +0200
Date:   Thu, 29 Sep 2022 09:25:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] phy: qcom-qmp-pcie: clean up power-down handling
Message-ID: <YzVIhK5z3I6hjzLU@hovoldconsulting.com>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-8-johan+linaro@kernel.org>
 <c3d39c4e-2099-b09a-8486-8abae7336611@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d39c4e-2099-b09a-8486-8abae7336611@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:15:46PM +0300, Dmitry Baryshkov wrote:
> On 28/09/2022 18:28, Johan Hovold wrote:
> > Always define the POWER_DOWN_CONTROL register instead of falling back to
> > the v2 offset during power on and power off.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++--------------
> >   1 file changed, 6 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index eea66c24cf7e..47cdb9ed80cd 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -90,12 +90,14 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
> >   	[QPHY_SW_RESET]			= 0x00,
> >   	[QPHY_START_CTRL]		= 0x08,
> >   	[QPHY_PCS_STATUS]		= 0x174,
> > +	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
> >   };
> 
> Without symbolic names it's not obvious that 0x04 (and thus this 
> regs_layout) can be used for v2 and v3, but not for v4.

It's no less obvious than it was when we were falling back to the v2
define when it wasn't in the table.

> @@ -1872,13 +1874,8 @@ static int qmp_pcie_init(struct phy *phy)
>       if (ret)
>               goto err_assert_reset;
> -     if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
> -             qphy_setbits(pcs,
> -                             cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -                             cfg->pwrdn_ctrl);
> -     else
> -             qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
> -                             cfg->pwrdn_ctrl);
> +     qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +                     cfg->pwrdn_ctrl);

This is the cruft I'm getting rid of.

Johan
