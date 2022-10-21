Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA66073A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJUJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:12:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314D13C1F2;
        Fri, 21 Oct 2022 02:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51321B81CFB;
        Fri, 21 Oct 2022 09:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDB4C433D7;
        Fri, 21 Oct 2022 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666343517;
        bh=dH8fnaw2bSgqdWXeyJfw+/qCj6MLAJ4Vv/QAwOnPRW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovwbLCMioT0HuD/yB6BI0yUisLfj+eLYmAQoMXr7PGCoJjfB2P17Ekhw14UjaEeRc
         rWsDxUtOWmNvSdTeF6UFE3rxc+U8WAEUvPJt1VGerMj/jEmcPYgHdHvvGNDX+AoXa7
         WFJOj2GyKXQccHSCQlyWicOA3dHq1AKh12XbEQacnsz90F5XrYqCUp2TzPsMTbdqt4
         arqMiXio8oL0P1HY7AcrcfD26KZyFDfwWTbKkA4gAFObjN+8Fkh5rqlTZ44noDS8sS
         JkYOIlIfDSO+wBOM3wrjLk7EtRzI1RTPSIgpJn3r8Z0fuIN/zKIasmQwikKT8jS7Up
         2R3N/BWIsFA7g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olo47-0003Mc-2U; Fri, 21 Oct 2022 11:11:43 +0200
Date:   Fri, 21 Oct 2022 11:11:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] phy: qcom-qmp-pcie: fix initialisation reset
Message-ID: <Y1JiT7qKERR7ktSs@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-13-johan+linaro@kernel.org>
 <02a879d4-cc7a-ca8e-7334-755873baa3e7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a879d4-cc7a-ca8e-7334-755873baa3e7@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:52:29PM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 14:35, Johan Hovold wrote:
> > Add the missing delay after asserting reset. This is specifically needed
> > for the reset to have any effect on SC8280XP.
> > 
> > The vendor driver uses a 1 ms delay, but that seems a bit excessive.
> > Instead use a 200 us delay which appears to be more than enough and also
> > matches the UFS reset delay added by commit 870b1279c7a0 ("scsi:
> > ufs-qcom: Add reset control support for host controller").
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 2f4bdef73395..9c8e009033f1 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1866,6 +1866,8 @@ static int qmp_pcie_init(struct phy *phy)
> >   		goto err_disable_regulators;
> >   	}
> >   
> > +	usleep_range(200, 300);
> > +
> 
> If there is a v3, I'd kindly ask to add a comment about vendor using 1ms 
> here.

No, I'm going to leave this is as is. The vendor driver is just a
reference implementation with a wide range of differences which there's
little point in documenting in mainline.

This information will continue to be available in the git logs if anyone
wonders were these numbers came from.

If it turns out that some other platform needs a longer delay, we can
consider increasing the delay unconditionally after verifying
experimentally.

And anyone with access to actual documentation is of course free to
suggest a different delay from the start.

> >   	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> >   	if (ret) {
> >   		dev_err(qmp->dev, "reset deassert failed\n");

Johan
