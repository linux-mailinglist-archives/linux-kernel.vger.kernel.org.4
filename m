Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C055BB2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIPTln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIPTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:41:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD21B3B37;
        Fri, 16 Sep 2022 12:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D88EB827DF;
        Fri, 16 Sep 2022 19:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F49C433D7;
        Fri, 16 Sep 2022 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663357292;
        bh=ZlGb0LoKM/ICSQuFuja1UlA2zoQePozS+j269pGKOhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COEyGyJQQxYPWLNATk2StL2043FDkW+qXyLzpEXEu/XfEkjEDdi45EEWBewZIesej
         2AYJcqGKx4fnogqojEOJNLTmjuquFURsZMRFw4P6WHQNQSnmuv9VW11GeoInLOoi/F
         eZHsrekfjyphbL8Nk5K5jdJprcWZ4CkB2dsGWnz3J5i76LefXGQ5TvkWciILGB1AR/
         9yhvJVYkfjOJjIcseDzGl3kV9k/cDx2/Yr6izIPB6pvWHB1e6yh1gOj8i00mM9BxO1
         NpGJ2kXbtt9GH7GbTxaJlLJ3d+rukBLgxlBWSp00uTLi98Dq1q6d6ZM4RQctaSUggF
         JEvZ4Jonv90vw==
Date:   Fri, 16 Sep 2022 14:41:29 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb
 gdsc
Message-ID: <20220916194129.nhkghyalyfoapabj@builder.lan>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
 <20220916102417.24549-2-quic_rjendra@quicinc.com>
 <20220916190658.2g7hegdkl6efda6r@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916190658.2g7hegdkl6efda6r@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:06:58PM -0500, Bjorn Andersson wrote:
> On Fri, Sep 16, 2022 at 03:54:16PM +0530, Rajendra Nayak wrote:
> > The USB controller on sc7180 does not retain the state when
> > the system goes into low power state and the GDSC is
> > turned off. This results in the controller reinitializing and
> > re-enumerating all the connected devices (resulting in additional
> > delay while coming out of suspend)
> > Fix this by updating the .pwrsts for the USB GDSC so it only
> > transitions to retention state in low power.
> > 
> > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > v2:
> > Updated the changelog
> > 
> >  drivers/clk/qcom/gcc-sc7180.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> > index c2ea09945c47..2d3980251e78 100644
> > --- a/drivers/clk/qcom/gcc-sc7180.c
> > +++ b/drivers/clk/qcom/gcc-sc7180.c
> > @@ -2224,7 +2224,7 @@ static struct gdsc usb30_prim_gdsc = {
> >  	.pd = {
> >  		.name = "usb30_prim_gdsc",
> >  	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > +	.pwrsts = PWRSTS_RET_ON,
> 
> I presume the same should be applied to gcc_usb30_sec_gdsc?
> 

Please ignore that, missed the '1' in the filename.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
