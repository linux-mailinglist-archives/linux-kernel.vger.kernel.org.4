Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6C6278C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiKNJLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiKNJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:11:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2CADA;
        Mon, 14 Nov 2022 01:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA87B80D61;
        Mon, 14 Nov 2022 09:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990CFC433C1;
        Mon, 14 Nov 2022 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668417100;
        bh=r080h8KU/XtGpx0cVglKaA/pa0l8puS3wdIJjS1J0wU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz11if5uMrkfJibSZXith2NeuQjLir5jLL5p9oJidhpUb+zcxh+3JycuHz0JlewaX
         H7CJd0vuEzj8PbYRPojslcIR6tYTjiNu2CjEYctlbruAg9GzHY5DWpCPRe7tZVJJwb
         gMY2Dlt9u8N1NCfxRQdp/2Ego2QbcDWgIEb6AoVbF/thUiqirKbix+Laa0ymV/6qoj
         I/oovB2nA6rRcdUpU67IZbI5Wof/lwPgwDi/P0g8LLp+9umHpUmSuE0RCdoJZILYL5
         +2KLXaMyh0qJmeKqk/ohh+C81QBtYgy3tPrDbH4sts316gjMXs4pGood+oK7BU+VRD
         P+H+xqlbwjxDQ==
Date:   Mon, 14 Nov 2022 09:11:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v8 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <Y3IGR887iuyP2SoL@google.com>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
 <20221103213425.2474772-3-Naresh.Solanki@9elements.com>
 <Y2jRm2J4tvK5ET1e@google.com>
 <f5e5a2d3-d985-f351-78e0-8a479a6d896a@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5e5a2d3-d985-f351-78e0-8a479a6d896a@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022, Naresh Solanki wrote:
> On 07-11-2022 03:06 pm, Lee Jones wrote:
> > On Thu, 03 Nov 2022, Naresh Solanki wrote:
> > 
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > 
> > > Implement a regulator driver with IRQ support for fault management.
> > 
> > This is not a "regulator driver".
> > 
> > > Written against documentation [1] and [2] and tested on real hardware.
> > > 
> > > Every channel has its own regulator supplies nammed 'vss1-supply' and
> > > 'vss2-supply'. The regulator supply is used to determine the output
> > > voltage, as the smart switch provides no output regulation.
> > > The driver requires the 'shunt-resistor-micro-ohms' property to be
> > > present in Device Tree to properly calculate current related
> > > values.
> > > 
> > > Datasheet links:
> > > 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> > > 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> > > 
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

[...]

> > > +static const struct of_device_id max597x_of_match[] = {
> > > +	{ .compatible = "maxim,max5970", .data = (void *)MAX597x_TYPE_MAX5970 },
> > > +	{ .compatible = "maxim,max5978", .data = (void *)MAX597x_TYPE_MAX5978 },
> > 
> > Where is .data used?
> The .data isn't used.

Then why add it?

[...]

> > > +#include <linux/device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +/* Number of switch based on chip variant */
> > 
> > This comment is superfluous.
> You mean this comment should be removed ?

I do.

> > > +#define MAX5970_NUM_SWITCHES 2
> > > +#define MAX5978_NUM_SWITCHES 1
> > > +/* Both chip variant have 4 indication LEDs used by LED cell */
> > 
> > Here too I think.
> > 
> > > +#define MAX597X_NUM_LEDS     4
> > > +
> > > +enum max597x_chip_type {
> > > +	MAX597x_TYPE_MAX5978 = 1,
> > 
> > Why 1?
> MAX5978 & single power switch wheres MAX5970 has two.

That's not what this enum means.

You are just describing the type to be matched on.

The value should be arbitrary, no?

[...]

> > > +#define  OC_STATUS_WARN(ch)				BIT(ch)
> > > +
> > > +#define MAX5970_REG_CHXEN				0x3b
> > > +#define  CHXEN(ch)						(3 << (ch * 2))
> > > +
> > > +#define MAX5970_REG_LED_FLASH			0x43
> > 
> > Do these all need to be shared?
> > 
> > Or can they be isolated into, say, the Regulator driver?
> > 
> Shared reg.

Where else are they used?

-- 
Lee Jones [李琼斯]
