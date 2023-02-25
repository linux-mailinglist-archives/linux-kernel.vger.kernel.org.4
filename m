Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598426A2AF5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBYRFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBYRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670E16AFE;
        Sat, 25 Feb 2023 09:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF22560B56;
        Sat, 25 Feb 2023 17:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A026BC433D2;
        Sat, 25 Feb 2023 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677344731;
        bh=nRxQ484Tsz4sgw71v2y9d/+AzKSz+s9aoe3rWsw1Xgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ad87l8ZFRMLWvC0cK4/biiaZUy60/ywy9l4GZudO3ARuiKTm08ex2v5ojHW9n7vx5
         3ftNa6t7Pa0kyKN1SMih9fS/KNFEoANyfuyStwl4BsH0drW5dVFTB6KCAer8/S4S2h
         ZZITXUinshR8QJoI+msyjv1Z1vwe/F+8zaNUp4L7hYVDYYybKLwWhbnzD662YYEPAQ
         VFpwJhTFj787XfUCEqo3h5NnNQJeC9xSOm8MkeEnDj+48Z3IeD+4ABQM3mhOOAh7cs
         I2UNbAVTjsnjUpldvObcR2+/mIVLCJnQX5fB20tzTLnRjKTjtQVBT0GX+33JvzgDR/
         XsxofKPJwGHHg==
Date:   Sat, 25 Feb 2023 17:19:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <20230225171954.06d396f3@jic23-huawei>
In-Reply-To: <8ad45f24-dc78-dfc4-23d2-ad5a5d0e42d4@kernel.org>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-3-marius.cristea@microchip.com>
        <8ad45f24-dc78-dfc4-23d2-ad5a5d0e42d4@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 14:46:08 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 20/02/2023 13:32, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> > 
> > This is the iio driver for Microchip
> > PAC193X series of Power Monitor with Accumulator chip family.
> > 
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---
> >  MAINTAINERS               |    7 +
> >  drivers/iio/adc/Kconfig   |   12 +
> >  drivers/iio/adc/Makefile  |    1 +
> >  drivers/iio/adc/pac193x.c | 2072 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 2092 insertions(+)
> >  create mode 100644 drivers/iio/adc/pac193x.c
> >   
> 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +
> > +#define PAC193X_NEG_PWR_CH1_BIDI(x)	((x) ? BIT(7) : 0)
> > +#define PAC193X_NEG_PWR_CH2_BIDI(x)	((x) ? BIT(6) : 0)
> > +#define PAC193X_NEG_PWR_CH3_BIDI(x)	((x) ? BIT(5) : 0)
> > +#define PAC193X_NEG_PWR_CH4_BIDI(x)	((x) ? BIT(4) : 0)
> > +#define PAC193X_NEG_PWR_CH1_BIDV(x)	((x) ? BIT(3) : 0)
> > +#define PAC193X_NEG_PWR_CH2_BIDV(x)	((x) ? BIT(2) : 0)
> > +#define PAC193X_NEG_PWR_CH3_BIDV(x)	((x) ? BIT(1) : 0)
> > +#define PAC193X_NEG_PWR_CH4_BIDV(x)	((x) ? BIT(0) : 0)
> > +
> > +/*
> > + * Universal Unique Identifier (UUID),
> > + * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
> > + * reserved to Microchip for the PAC193X and must not be changed
> > + */
> > +#define PAC193X_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
> > +
> > +enum pac193x_ids {
> > +	pac1934,
> > +	pac1933,
> > +	pac1932,
> > +	pac1931  
> 
> Enums are usually uppercase.

I'm not sure there is anything in coding standard around that and a grep finds
a mixture of the two when it comes to ones used for IDs.  Mind you uppercase
is fine :)


> 
> 
> 
> Best regards,
> Krzysztof
> 

