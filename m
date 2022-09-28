Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB45ED9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiI1KVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiI1KVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:21:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F94DF2C;
        Wed, 28 Sep 2022 03:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04FD0CE1DF8;
        Wed, 28 Sep 2022 10:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B28C433D6;
        Wed, 28 Sep 2022 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664360437;
        bh=02Nc3lwRfKOpCLR9xKRHRLQevx+nIiW23nOTuHf7wqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmnDPSIDKdt96Vmr6EE3B9hUMl2je3ULkA5piFlmofsRsD8siKYVGGGS+NvtgfZws
         7lMyNzm2DQPt2M3JB03vqxLpoWpTx8GPqdgHNAMH7sjgjTRuowPBCP4Ov0KhsMDUuf
         wxHwUIH/TtD5AIet5Aa+v5HFqthb9r6ckbPpnfERZR2+Nkw7aB0unWCPnJWg2nfBrO
         WzthXKvf96t1gBn0v3rO0D2YD8teV0wevj51slwELW7nIcWgRiw2UEGa8ki/dV98ST
         yJ8h/h4xgGT7oUrIbI0oH0KZLtplMk6W3FM401Z8xB8WBLFEA6i9VZ08/0gpcPGky+
         dBDk8cyxNMTbg==
Date:   Wed, 28 Sep 2022 11:20:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <YzQf7hf15vvLeGse@google.com>
References: <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com>
 <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
 <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
 <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Stephen Boyd wrote:

> Quoting Lee Jones (2022-08-05 03:51:39)
> > On Tue, 02 Aug 2022, Satya Priya Kakitapalli (Temp) wrote:
> >
> > >
> > > On 7/27/2022 6:49 AM, Stephen Boyd wrote:
> > > > Quoting Satya Priya Kakitapalli (Temp) (2022-07-21 23:31:16)
> > > > >               regulator-name = "pm8008_l6";
> > > > >           };
> > > > >
> > > > >           pm8008_l7: ldo7@4600 {
> > > > >               reg = <0x4600>;
> > > > >               regulator-name = "pm8008_l7";
> > > > >           };
> > > > >       };
> > > > > };
> > > > >
> > > > >
> > > > > Stephen/Mark, Please do let me know if you are OK with this design.
> > > > >
> > > > I was happy with the previous version of the DT node. That had one node
> > > > for the "pm8008 chip", which is important because it really is one
> > > > package. Why isn't that possible to implement and also register i2c
> > > > devices on the i2c bus for the second address?
> >
> > If devices have different addresses, they should have their own nodes, no?
> 
> There are nodes for the devices at different addresses in the design we
> had settled on earlier.
> 
>         pm8008: pmic@8 {
>                 compatible = "qcom,pm8008";
>                 reg = <0x8>;
>                 #address-cells = <2>;
>                 #size-cells = <0>;
>                 #interrupt-cells = <2>;
> 
>                 pm8008_l1: ldo1@1,4000 {
>                         compatible = "qcom,pm8008-regulator";
>                         reg = <0x1 0x4000>;
>                         regulator-name = "pm8008_ldo1";
>                 };
> 
> 		...
> 
> 	};
> 
> pmic@8 is the i2c device at i2c address 8. ldo1@1,4000 is the i2c device
> at address 9 (8 + 1) with control for ldo1 at register offset 0x4000.
> 
> I think your concern is more about the fact that the regulator sub-nodes
> are platform device drivers instead of i2c device drivers. I'm not an
> i2c expert but from what I can tell we only describe one i2c address in
> DT and then do something like this to describe the other i2c addresses
> when one physical chip responds to multiple addresses on the i2c bus.
> See i2c_new_dummy_device() and i2c_new_ancillary_device() kerneldoc for
> slightly more background.
> 
> It may need some modifications to the i2c core to make the regulator
> nodes into i2c devices. I suspect the qcom,pm8008 i2c driver needs to
> look at the 'reg' property and translate that to the parent node's reg
> property (8) plus the first cell (1) to determine the i2c device's final
> i2c address. Then the i2c core needs to register i2c devices that are
> bound to the lifetime of the "primary" i2c device (pmic@8). The driver
> for the regulator can parse the second cell of the reg property to
> determine the register offset within that i2c address to use to control
> the regulator. That would make it possible to create an i2c device for
> each regulator node, but I don't think that is correct because the
> second reg property isn't an i2c address, it's a register offset inside
> the i2c address.
> 
> It sort of looks like we need to use i2c_new_ancillary_device() here. IF
> we did that the DT would look like this:
> 
>         pm8008: pmic@8 {
>                 compatible = "qcom,pm8008";
>                 reg = <0x8>, <0x9>;
> 		reg-names = "core", "regulators";
>                 #address-cells = <2>;
>                 #size-cells = <0>;
>                 #interrupt-cells = <2>;
> 
>                 pm8008_l1: ldo1@1,4000 {
>                         compatible = "qcom,pm8008-regulator";
>                         reg = <0x1 0x4000>;
>                         regulator-name = "pm8008_ldo1";
>                 };
> 
> 		...
> 
> 	};
> 
> And a dummy i2c device would be created for i2c address 0x9 bound to the
> dummy i2c driver when we called i2c_new_ancillary_device() with
> "regulators" for the name. The binding of the dummy driver is preventing
> us from binding another i2c driver to the i2c address. Why can't we call
> i2c_new_client_device() but avoid binding a dummy driver to it like
> i2c_new_ancillary_device() does? If that can be done, then the single
> i2c device at 0x9 can be a pm8008-regulators (plural) device that probes
> a single i2c driver that parses the subnodes looking for regulator
> nodes.
> 
> Note: There is really one i2c device at address 0x9, that corresponds to
> the regulators, but in DT we need to have one node per regulator so we
> can configure constraints.

Wouldn't it make more sense to simply separate the instantiation of
the 2 I2C devices?  Similar to what you suggested [0] in v9.  That way
they can handle their own resources and we can avoid all of the I2C
dummy / shared Regmap passing faff.

[0] https://lore.kernel.org/all/CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com/

-- 
Lee Jones [李琼斯]
