Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19D628179
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiKNNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiKNNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:37:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E790818355;
        Mon, 14 Nov 2022 05:37:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AC26109A;
        Mon, 14 Nov 2022 13:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F5C433D7;
        Mon, 14 Nov 2022 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668433063;
        bh=8xlvfxt+WaMoXb0PloFzlKYuUCFDJMFOMn18gRmNUkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFsIXnztJNWhDOQjelLnWyBCH0WcRnDeGD6wUW8Mh0APpIY5LGZd/esWLNNA8iZ2H
         qbC1aBChs6QEDaIwkOpjTEftm4L2VrfmR/tOdURHzgpNN9hV3hBA9HOgstID2w7/xI
         ziGZOuWPz2DtKrkrq1tBgvl3kmDTGhrDoA0TjTOR4PeYYw0beeMWXE1Es64Ay/v7WG
         ojd8+mh6sZyIKGGMUWzGJ/VokWlsjCjWpTKs2FuCdD7+5KYEQ+WEOw+q/ymWI6St54
         rFptWZ9E91BCX4sfEOLDDH04PxasjKhDzsmBzma4kksRPJY7tSH3c8k2K+Aa7QQPu8
         jt7RBMnSRe3/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouZeB-0002y2-B7; Mon, 14 Nov 2022 14:37:12 +0100
Date:   Mon, 14 Nov 2022 14:37:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3JEh7wO394kepXq@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <ace91d8b-9a14-5569-7c59-344e9751fa96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace91d8b-9a14-5569-7c59-344e9751fa96@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:43:03PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > The current QMP USB3-DP PHY bindings are based on the original MSM8996
> > binding which provided multiple PHYs per IP block and these in turn were
> > described by child nodes.
> > 
> > The QMP USB3-DP PHY block provides a single multi-protocol PHY and even
> > if some resources are only used by either the USB or DP part of the
> > device there is no real benefit in describing these resources in child
> > nodes.
> > 
> > The original MSM8996 binding also ended up describing the individual
> > register blocks as belonging to either the wrapper node or the PHY child
> > nodes.
> > 
> > This is an unnecessary level of detail which has lead to problems when
> > later IP blocks using different register layouts have been forced to fit
> > the original mould rather than updating the binding. The bindings are
> > arguable also incomplete as they only the describe register blocks used
> > by the current Linux drivers (e.g. does not include the PCS LANE
> > registers).
> > 
> > This is specifically true for later USB4-USB3-DP QMP PHYs where the TX
> > registers are used by both the USB3 and DP parts of the PHY (and where
> > the USB4 part of the PHY was not covered by the binding at all). Notably
> > there are also no DP "RX" (sic) registers as described by the current
> > bindings and the DP "PCS" region is really a set of DP_PHY registers.
> > 
> > Add a new binding for the USB4-USB3-DP QMP PHYs found on SC8280XP which
> > further bindings can be based on.
> > 
> > Note that the binding uses a PHY type index to access either the USB3 or
> > DP part of the PHY and that this can later be used also for the USB4
> > part if needed.
> > 
> > Similarly, the clock inputs and outputs can later be extended to support
> > USB4.
> > 
> > Also note that the current binding is simply removed instead of being
> > deprecated as it was only recently merged and would not allow for
> > supporting DP mode.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  clock-output-names:
> > +    items:
> > +      - const: usb3_pipe
> > +      - const: dp_link
> > +      - const: dp_vco_div
> > +
> > +  "#phy-cells":
> > +    const: 1
> > +    description: |
> > +      PHY index
> > +        - PHY_TYPE_USB3
> > +        - PHY_TYPE_DP
> 
> I'm stepping on Rob's and Krzysztof's ground here, but it might be more 
> logical and future proof to use indices instead of phy types.

Why would that be more future-proof?

I initially added defines for these indexes to a QMP header, but noticed
that we already have PHY drivers that use the PHY types for this. So
there's already a precedent for this and I didn't see any real benefit
to adding multiple per-SoC defines for the same thing.

> Just for my understanding, would USB4 support add another qserdes+tx/rx 
> construct or would it be the same USB3 register space?

The TX/RX registers are shared by the all three parts of the PHY (USB4,
USB3, DP), while USB4 has two dedicated sets of PLL (serdes) and PCS
registers.

Johan
