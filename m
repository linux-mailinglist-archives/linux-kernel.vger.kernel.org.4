Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C46CEC59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjC2PGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjC2PGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE93C1E;
        Wed, 29 Mar 2023 08:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A1D61D6D;
        Wed, 29 Mar 2023 15:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28642C433EF;
        Wed, 29 Mar 2023 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680102373;
        bh=5vjINNeKe6LiQmi33iXc8oeTqq9Ju4aWWGikWY46LX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3L0kzPOYcISf2hQru30jp3nqSOsML9n7nxJXTRKCsmM325BTEgdUgGTTdKXq9ACB
         nejfaSLtVvX0PbrYWO3EZGE3OcPxbSC7CELGE/dOupr44RQRqSJ63N0dKvQBFc8AZ9
         b6UQs8mDb5LVd1h4m9soDbPGAEOE+aSuYtraelvJIBePUTNzz/tm2oErLly1dtVzfV
         EAxsdJ6aijQG5BHYFX0mS4PpBYKtg7T8Uc/+VolQnVjV/rUc1wBMqtyQCYc6NpOA0d
         sb2R1/supusKN+77bFDe7s+PQT7rDlTPFRRSmEs7zPZKeNR/4bHH1TwGUtTlSCuvLJ
         Itni8mXraPbfg==
Date:   Wed, 29 Mar 2023 16:06:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230329150605.GW2673958@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <ZCROpw0il1VQCLPu@smile.fi.intel.com>
 <20230329145636.GV2673958@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329145636.GV2673958@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023, Lee Jones wrote:

> On Wed, 29 Mar 2023, Andy Shevchenko wrote:
>
> > On Wed, Mar 29, 2023 at 03:36:15PM +0100, Lee Jones wrote:
> > > On Tue, 28 Mar 2023, Sahin, Okan wrote:
> > > > >On Wed, 15 Mar 2023, Lee Jones wrote:
> > > > >> On Tue, 07 Mar 2023, Okan Sahin wrote:
> >
> > ...
> >
> > > > +static const struct i2c_device_id max77541_i2c_id[] = {
> > > > +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
> > > > +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
> > >
> > > Just 'MAX77540' is fine.
> >
> > I tend to disagree.
> >
> > There is an error prone approach esp. when we talk with some functions
> > that unifies OF/ACPI driver data retrieval with legacy ID tables.
> > In such a case the 0 from enum is hard to distinguish from NULL when
> > the driver data is not set or not found. On top of that the simple integer
> > in the legacy driver data will require additional code to be added in
> > the ->probe().
>
> Use a !0 enum?
>
> The extra handling is expected and normal.

I've always disliked mixing platform initialisation strategies.  Passing
pointers to MFD structs through I2C/Device Tree registration opens the
doors to all sorts of funky interlaced nonsense.

Pass the device ID and then match in C-code please.

--
Lee Jones [李琼斯]
