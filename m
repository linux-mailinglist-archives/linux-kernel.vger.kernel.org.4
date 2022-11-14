Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCD62782F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiKNIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiKNIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:55:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CB1C93C;
        Mon, 14 Nov 2022 00:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB7360F33;
        Mon, 14 Nov 2022 08:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C008C433D6;
        Mon, 14 Nov 2022 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668416092;
        bh=pp5pDQZWN6NVccBVIUaPNVdc4w9kyJ+/i8wyV2Ao5/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TM6hdfxGKtq2rX9QM4eMo3x3NSdDkyzMnPsOCbXreJK/TyrHS4KSYoMz+xf7pwtkk
         BB3C/2v+PUUgk1g5sjiFKlIVfbONn1GP+52rmOXLLMVtQaTOTYVpgxAhziwfVXGtBX
         3LMbJDgJjWVDlPTKX0jxGvInveBsT4L6YKHOIK9gFYeqKWW/ZQmFb0mKYNpMKe8X7t
         Wea6I7lkAyN8mcjxJSINQDJfjYWq1vqnARWJ1+bcEUYl0aPQ+GUktHDKkUDXaMNmlB
         yMvle51AFzQqSDHvXM/oj9DIvGeFrZZBolNDZG4Ib8X55pIwoAVYL4qn416K0gd8lX
         EGKyUxf1ffXmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouVER-0001zw-7f; Mon, 14 Nov 2022 09:54:19 +0100
Date:   Mon, 14 Nov 2022 09:54:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/22] phy: qcom-qmp-combo: merge USB and DP
 configurations
Message-ID: <Y3ICOwr2ld9cdgrK@hovoldconsulting.com>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-18-johan+linaro@kernel.org>
 <5fd7a56f-db12-deb3-753a-22867526d90b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd7a56f-db12-deb3-753a-22867526d90b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 10:43:14AM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 11:56, Johan Hovold wrote:
> > It does not really make any sense to keep separate configuration
> > structures for the USB and DP parts of the same PHY so merge them.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 182 +++++++---------------
> >   1 file changed, 57 insertions(+), 125 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index b27d1821116c..249912b75964 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -798,10 +798,7 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
> >   
> >   struct qmp_phy;
> >   
> > -/* struct qmp_phy_cfg - per-PHY initialization config */
> >   struct qmp_phy_cfg {
> > -	/* phy-type - PCIE/UFS/USB */
> > -	unsigned int type;
> >   	int lanes;
> 
> int lanes doesn't really make sense here in my opinion. It should be 
> usb_lanes and dp_lanes.

It doesn't make much less sense than having it here currently do.

All of these USB-C PHYs are dual lane for bi-directional SS USB and
quad lane for uni-directional DP (even if only CC1 orientation and lanes
2 and 3 are currently supported).

I should probably just drop the lanes parameter completely, either as a
preparatory clean up or as follow-on one (e.g. also a bit depending on
if there are other reasons for respinning a v2).

Johan
