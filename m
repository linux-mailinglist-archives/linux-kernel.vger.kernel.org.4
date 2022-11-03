Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2361795B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiKCJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKCJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:06:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1220BE2D;
        Thu,  3 Nov 2022 02:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5CE1B823C1;
        Thu,  3 Nov 2022 09:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472E2C433D6;
        Thu,  3 Nov 2022 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667466399;
        bh=mq89lDSCjzvWLmDVVgCplEqijbSaS32v3s0UtQjTo6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdoWxSg/odQ8/yEIYEb5jT4AS7KkEdZC4DtJbcj3LedphlBZDJ/uTOE1WNExEhur2
         bv3bfuV7kup2ls0ldwSnV8UAKUzkM2r2FDWbtqFJd/l5F57MA2jKoIsRzC+DxLbekA
         FXWxCTTGVdZzpKu8iK1DNHUiUzjHdOaXUN3tbkb+gsPv9EWpE5S5KcLYbJFcTItg9q
         4WAsyAeGmTzHGbtbnwV9S6zcBZOwA3Fs1L1GtpSRuV5xvOPdfrf4gnPD/qZm86cZUW
         6bsYpjd4b/K7g6nMf1J6GJOadtRrGgkQjEPV2w2phM7WOs12+jhiSEyX6n0rEmldVE
         m4Ga3S3UuHpyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqWB2-0000EN-FY; Thu, 03 Nov 2022 10:06:21 +0100
Date:   Thu, 3 Nov 2022 10:06:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>, bmasney@redhat.com,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <Y2OEjNAPXg5BfOxH@hovoldconsulting.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
 <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
 <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
 <bb590bfb-07a4-97c1-e5c0-d00d840e2e11@quicinc.com>
 <Y2I3tekSAO42r0xR@hovoldconsulting.com>
 <20221103024949.lw4g2tavk7uw5xt4@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103024949.lw4g2tavk7uw5xt4@builder.lan>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:49:49PM -0500, Bjorn Andersson wrote:
> On Wed, Nov 02, 2022 at 10:26:13AM +0100, Johan Hovold wrote:
> > On Wed, Nov 02, 2022 at 02:15:26PM +0530, Shazad Hussain wrote:
> > > On 11/2/2022 1:43 PM, Johan Hovold wrote:
> > 
> > > > Right, but if the PHYs really requires CX and it is not an ancestor of
> > > > the refclk then this should be described by the binding (and not be
> > > > hidden away in the clock driver).
> > 
> > > This makes sense, will be posting v2 post for the same.
> > > I assume this should use the Fixes tag then !
> > 
> > Yeah, I guess to you can add a fixes tag for the commits adding support
> > for sc8280xp to the UFS PHY binding and driver.
> > 
> > But please do check with the hardware documentation first so we get this
> > right this time.
> > 
> > I've already asked Bjorn to see what he can dig out as it is still not
> > clear how the two "card" refclocks (GCC_UFS_CARD_CLKREF_CLK and
> > GCC_UFS_1_CARD_CLKREF_CLK) are supposed to be used.
> > 
> 
> We've come full circle and Shazad's patch came from that discussion :)

Ah, good. :)

> In line with the downstream dts, we have GCC_UFS{,_1}_CARD_CLKREF_CLK
> providing a reference clock to the two phys. Then GCC_UFS_REF_CLKREF_CLK
> feeds the UFS refclock pads (both of them), which connect to the memory
> device(s).
> 
> In other words, GCC_UFS{,_1}_CARD_CLKREF_CLK should be "ref" in
> respective phy.
> 
> GCC_UFS_REF_CLKREF_CLK is the clock to the devices, but as we don't
> represent the memory device explicitly it seems suitable to use as
> "ref_clk" in the ufshc nodes - which would then match the special
> handling of the "link clock" in the UFS driver.

Thanks for clearing that up. Using GCC_UFS_REF_CLKREF_CLK as ref_clk for
the controller sounds reasonable.

I guess the only missing piece is which "card" ref clock is used by
which PHY.

The ADP dts uses:

	phy			ref clock

	phy@1d87000 (UFS_PHY)	GCC_UFS_CARD_CLKREF_CLK
	phy@1da7000 (UFS_CARD)	GCC_UFS_1_CARD_CLKREF_CLK

but that is not what the firmware on ADP and CRD seem to enable.

Both the ADP and CRD fw leaves GCC_UFS_1_CARD_CLKREF_CLK enabled, while
GCC_UFS_CARD_CLKREF_CLK is only enabled on ADP (which unlike the CRD
also uses the UFS_CARD controller).

Does the ADP dts have these clocks switched or is the firmware confused?

(Also note that experiments suggest that neither refclock appears to
has to be explicitly enabled for the controllers to function.)

> All three clocks are sourced off the CXO pad, so I would like this patch
> to cover at least all of these. And
> 
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> 
> seems to be in order for such patch.
> 
> 
> @Johan, would you mind writing a dts patch flipping the clocks around
> and Shazad can update this patch?

I'll do so, but I'll wait with posting until you can confirm which
clkref is which.

Johan
