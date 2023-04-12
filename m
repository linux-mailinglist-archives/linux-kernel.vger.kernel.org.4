Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4116DF18A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDLKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjDLKER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A37A9E;
        Wed, 12 Apr 2023 03:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACC063283;
        Wed, 12 Apr 2023 10:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E94C4339B;
        Wed, 12 Apr 2023 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293855;
        bh=OrehFqW8/NTBq41+buEdl7J1qPg50LFC9ahWXbWfHL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4Z9/965eaQPtuSLS4ih4Sbt0T0+A81oGGb8DSGiMqueah9K6KQNOL2IHfo37QeyP
         V6EQ41XvoDQ1YXrvyQFRdvIc7u1JlXXh3aKaPyR6PemQczLljoBRxhflyBqLodEtCb
         DR0JybIjy5f22YW/9LXebGSVI3EgpehVNmWdBvxlWfq8pkHAMuAvPdkGO8e7WocFa9
         y9ib62FVyf99KyvgiZ+gstK94X9NV6JVdGjsVJwEXo8dWt5s3bJLv9L+zlcu+OnJep
         bsJZtWurhdbonr47xtnX7DXsiL/fJaMiz3ri81k9EQHoXv7rSHIw+gWF1vnxZBwtug
         KaRMmc1bEDmHw==
Date:   Wed, 12 Apr 2023 11:04:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20230412100407.GA8371@google.com>
References: <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230403140950.GF548901@google.com>
 <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
 <20230405133938.GD8371@google.com>
 <MN2PR03MB51681CCFD911F63CE32E914AE7949@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR03MB51681CCFD911F63CE32E914AE7949@MN2PR03MB5168.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Apr 2023, Sahin, Okan wrote:

> >On Wed, 05 Apr 2023, Andy Shevchenko wrote:
> >
> >> On Mon, Apr 03, 2023 at 03:09:50PM +0100, Lee Jones wrote:
> >> > On Mon, 03 Apr 2023, Sahin, Okan wrote:
> >>
> >> ...
> >>
> >>
> >> > > In fact, one of the maintainers suggested assigning chip_info to data
> >> > > instead of enumeration. Then I added chip_info and put devices into
> >> > > sub-structure above. I will replace chip_info with id structure in max77541
> >> > > device structure, right? I will use enumeration for data as I will assign
> >> > > it to id, and distinguish different devices.
> >> >
> >> > Yes, that's correct.  Please remove chip_info altogether.
> >>
> >> Then it will provoke casting in the OF ID table which I believe is not what
> >> we want. I would agree on your first suggestion to have a plain number in I²C
> >> ID table, but I'm against it in OF and/or ACPI ID table.
> >
> >And I'm against passing MFD information through the OF/ACPI APIs.
> >
> >You can put through raw platform data or a device descriptor.
> >
> >Ref: git grep -A5 "struct of_device_id.*{" -- drivers/mfd
> >
> >--
> >Lee Jones [李琼斯]
>
> Hi Lee,
>
> Right now, as you suggested I rewrote code like below
> For of_device_id,
> 	. data = (void *)MAX77540,
> 	.data = (void *)MAX77541,
> For i2c_device_id,
> 	.data  = MAX77540,
> 	.data = MAX77541
> I also rewrote other part as chip_info is excluded. I want to be sure before
> sending new patch.
>
> Does it seem correct?

This is one suitable method, yes.

--
Lee Jones [李琼斯]
