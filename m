Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7765470A8A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjETPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjETPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A63116;
        Sat, 20 May 2023 08:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5524B61A3D;
        Sat, 20 May 2023 15:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7058DC4339B;
        Sat, 20 May 2023 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684594903;
        bh=tLjogWXF86MN3Wc59t6vESZAdEIOlnNt6P8HiDsHgec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1fIuBP6gu/D2w/SiVYjy4TnD7aaIC1eEn9ADLe0GOkzU+fMPql6JrGB+q8IcCkKj
         KgLDzyd+WQMGKwUT+exmGnahsuC7c9Foprd/H2bz5YrxJMe4nvwLoC+6eIfAL0eg/K
         nmsvt/1U/bcZK4DyGmZz53wDS4v2n/xWrQWy5ubrbM/BE+xptn9hs9w/lbpOjeTaWU
         aTBLkOynOJ3LJGcgzD1T5qc+/4lIOLerBuEPWmOrjzye0WZp2RrhZvVadVlhTMbuVa
         9S2NHvSqK0uO+8aKbj3YaXrCtI2kn4yOt4UkaalpwkA/2dBkUYNcqwXtimPScTIPhh
         04AyQyj9SFb2w==
Date:   Sat, 20 May 2023 16:17:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230520161753.28a8c128@jic23-huawei>
In-Reply-To: <20230519-variably-direction-cfa9a034e844@spud>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-2-marius.cristea@microchip.com>
        <20230519-variably-direction-cfa9a034e844@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 19:29:15 +0100
Conor Dooley <conor@kernel.org> wrote:

> Hey Marius,
> 
> On Fri, May 19, 2023 at 07:01:44PM +0300, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> > 
> > This is the device tree schema for iio driver for
> > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > Delta-Sigma ADCs with an SPI interface.  
> 
> Just one quick process bit, please try to CC all of the maintainers
> listed by get_maintainer.pl - you unfortunately managed to miss 2 of the
> 3 dt-binding maintainers :/ Perhaps you ran get_maintainer.pl using our
> vendor tree?
> 
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---  
> 
> > +  vref-supply:
> > +    description:
> > +      Some devices have a specific reference voltage supplied on a different
> > +      pin to the other supplies. Needed to be able to establish channel scaling
> > +      unless there is also an internal reference available (e.g. mcp3564r)  
> 
> Should this be marked as a required property for the non-r devices that
> do not have an internal reference?
> 
> > +  microchip,hw-device-address:  
> 
> Hopefully Rob or Jonathan etc can chime in as to whether a common
> property exists for this type of thing...
> 
Nope. This is a new one for me - there are devices that work on a daisy chain
principle but I think this one works by encoding stuff in the actual message
which is unusual for SPI.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 3
> > +    description:
> > +      The address is set on a per-device basis by fuses in the factory,
> > +      configured on request. If not requested, the fuses are set for 0x1.
> > +      The device address is part of the device markings to avoid
> > +      potential confusion. This address is coded on two bits, so four possible
> > +      addresses are available when multiple devices are present on the same
> > +      SPI bus with only one Chip Select line for all devices.  
> 
> ..although if it doesn't, it'd be good, I think, to add here where the
> property crops up in spi transfers. And if not in the description, in
> the commit message instead?
Agreed.  Top two bits of COMMAND BYTE which is first one on the wire I think.

Thanks,

J
> 
> Thanks,
> Conor.
> 

