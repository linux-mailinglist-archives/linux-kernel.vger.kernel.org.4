Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8433627F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiKNM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiKNM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:59:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF163CC;
        Mon, 14 Nov 2022 04:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2627EB80EAF;
        Mon, 14 Nov 2022 12:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DE9C433D6;
        Mon, 14 Nov 2022 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430741;
        bh=mIg23pKPFLK0PkpdC5Bu9BP433GCopKjuM2NT2OEBkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hunFjVVaaFzGk6JM0HXJ8MBdy6SzFWI7ep8GBUNhJAbBwVoTvhCW4OHaFO8Jf197E
         gRDy1/VrbzJy8R0Zb5IXYMHy2P8Te234zqWgo2EjCTQ3n8sKcV7/oaK93b70cilCSU
         OWmeIeDpOEraOmZTQTdqsBMgiaiLs7ec1LsM3G8uvmx1Ug4sRh5Ts/e0FizD/KXDlN
         21HwQIK+hKBofGTrVlfL+NbrKv2Uai0XBQjKsUtZF64Z9IoD8HrkP//zJ+cX3sPoT6
         4Cz6takmhNOuZSADFFAZJBrRue4yBJyCOx/sjkSQbIdVvnIteiEYgJr7S6tW0CaO4J
         sg28H5aBKr+Dw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouZ2j-0002VJ-Tt; Mon, 14 Nov 2022 13:58:29 +0100
Date:   Mon, 14 Nov 2022 13:58:29 +0100
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
Subject: Re: [PATCH 14/14] phy: qcom-qmp-combo: add support for updated
 sc8280xp binding
Message-ID: <Y3I7deJYKRAUc0Q6@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-15-johan+linaro@kernel.org>
 <ae61af60-46ef-e455-6063-e47238c608b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae61af60-46ef-e455-6063-e47238c608b1@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:36:23PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > Add support for the new SC8280XP binding.
> > 
> > Note that the binding does not try to describe every register subregion
> > and instead the driver holds the corresponding offsets.
> > 
> > Also note that (possibly) unlike on earlier platforms, the TX registers
> > are used by both the USB and DP implementation.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 143 ++++++++++++++++++++--
> >   1 file changed, 133 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 0a4d53e6c586..544a7e55bf14 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -798,9 +798,25 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
> >   
> >   struct qmp_combo;
> >   
> > +struct qmp_combo_offsets {
> > +	u16 com;
> > +	u16 txa;
> > +	u16 rxa;
> > +	u16 txb;
> > +	u16 rxb;
> 
> 
> Yes, txa/txb are more in spite of the vendor headers. I'd sill suggest 
> to use tx/tx2 and rx/rx2 as used everywhere in the QMP driver.

I don't see any reason for making up names when we can use names that
match the hardware and do the conversion in one place when parsing the
devicetree.

If anything we should probably rename tx/tx2 at some point (as either
tx0/tx1 or txa/txb).

> > +	u16 usb3_serdes;
> > +	u16 usb3_pcs_misc;
> > +	u16 usb3_pcs;
> > +	u16 usb3_pcs_usb;
> > +	u16 dp_serdes;
> > +	u16 dp_dp_phy;
> > +};
> > +

Johan
