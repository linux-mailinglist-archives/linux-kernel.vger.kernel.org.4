Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258415F421F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJDLl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJDLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:41:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8624DB71;
        Tue,  4 Oct 2022 04:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C66C8B81A0F;
        Tue,  4 Oct 2022 11:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2014C433D6;
        Tue,  4 Oct 2022 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664883680;
        bh=BHUnSAdIZ4XNBoipAEkQYLni7TzHVBXgscOTnj86v5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C046NSAyTFEKa4UhRxN5fjYVH5kpQi0qziS6kPAHf5yeiZy3BAe+CnUFHsu85kwqr
         ukXaDY9I9+V+xnC1gqt36Hy4IWv+MS5vRsyYjrZHFR6p3DEC2vhCsHE98ENaYE7Gqd
         xItkAUqc35pJWY28ac8fG4h4wvDdrdHfyzPV/egqD2T+zTKlKXRQnkg0Kn7K8RglWl
         YVqOFKCN/lPq7GiJ9rfCUwO85kqBPkpc5w/6MMB8PRgBJ1Xi/GpVpqYYAYmdPs5Jgx
         519m71GhqEIpCQ7nuqOsCmf8V481JzYuNIydeGnlo8xWBgJ6z3WjWztnBK+4DRcQWC
         XPf/UtbipovBg==
Date:   Tue, 4 Oct 2022 12:41:13 +0100
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
Message-ID: <Yzwb2e0/CK9QbV0n@google.com>
References: <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
 <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
 <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
 <YzQf7hf15vvLeGse@google.com>
 <CAE-0n50cX5ky3By976RTecKkpeMoAjoBA4tYuWSZ150JfS9wiQ@mail.gmail.com>
 <YzXdhVN/Zp7DDIzB@google.com>
 <CAE-0n53q-8u16_7KGZ0jbm9ES=dsSJL7rbGdz6hzLWf3xvm=bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n53q-8u16_7KGZ0jbm9ES=dsSJL7rbGdz6hzLWf3xvm=bQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Oct 2022, Stephen Boyd wrote:

> Quoting Lee Jones (2022-09-29 11:01:41)
> > On Wed, 28 Sep 2022, Stephen Boyd wrote:
> >
> > > Quoting Lee Jones (2022-09-28 03:20:30)
> > > > Wouldn't it make more sense to simply separate the instantiation of
> > > > the 2 I2C devices?  Similar to what you suggested [0] in v9.  That way
> > > > they can handle their own resources and we can avoid all of the I2C
> > > > dummy / shared Regmap passing faff.
> > > >
> > > > [0] https://lore.kernel.org/all/CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com/
> > > >
> > >
> > > You can continue reading the thread[1]. My understanding is it's one
> > > chip that responds on two i2c addresses, thus we don't describe that as
> > > two i2c device nodes in DT. Instead we describe one node and use the
> > > dummy API to make the second i2c device.
> > >
> > > [1] https://lore.kernel.org/all/Yk3NkNK3e+fgj4eG@sirena.org.uk/
> >
> > As Mark says, it's probably 2 separate dies that have been encased in
> > the same IC and are otherwise unconnected.  Not sure I understand the
> > comment about not requiring another 'struct device'.  It will still
> > require that whether it's a platform device or an I2C device, right?
> >
> 
> Yes a 'struct device' will be required for each i2c address no matter
> what happens.
> 
> It is also useful to describe the hardware as one device node in case
> there is a shared reset signal or power supply. That allows us to have
> one driver probe the DT node and deassert the reset/power the chip on. I
> think this device has one reset signal, so we really need to do this and
> not treat them as completely independent i2c devices (the 0x8 and 0x9
> addresses).
> 
> Can we move forward with my plan to have another i2c device made for
> 'pm8008-regulators' and have that driver be an i2c driver that probes an
> i2c device manually created in the pm8008 driver? I think that would
> handle the reset ordering problem because the pm8008 driver can deassert
> the reset and also handle the regmap passing stuff by letting the i2c
> device at 0x9 make its own regmap.

Sure, why not.  I'm pretty done talking about this now. :)

Please work with Satya to cobble something together.

-- 
Lee Jones [李琼斯]
