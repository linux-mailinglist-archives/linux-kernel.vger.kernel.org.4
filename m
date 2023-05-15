Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36D702B71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjEOL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjEOL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FC1736;
        Mon, 15 May 2023 04:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B522C622BE;
        Mon, 15 May 2023 11:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9818CC433D2;
        Mon, 15 May 2023 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149961;
        bh=MBqNZwSUWIVyUFPu5xzrWq+IS+ipisPvB7leUbn8x7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFbji4AXA3hGRsqTwofLDZiiIfOsCOOHJjiwkI4H4/iGfs82EgkS5b1Xg0tLaoqh/
         tJ3DPhdMHBOVrCpMIZdlKFsIAa3H18C9ex5U3yjpI6X83AIpfcyksAvxVywqgfkpoW
         sVVLV0/2LJ5LaVTgNFNS6P+BrBxDDkogc2PQdFDVzskUrXiXZWJVGFGjU36gn8sAPZ
         t6feA4rv/otyZkO6Cim+P7ICaZ2Myn68JP356IAppwnzC+OuvMgyGYAQrGzLrvmCRv
         qE0XMb5fBJz9q9qUd785/TUka+DUI4OPC1H6/LMzHlne0JMH0BQC4YeL5q6bP8g4PM
         lr8KyMx0+2NpQ==
Date:   Mon, 15 May 2023 12:25:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <20230515112554.GA10825@google.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86mt29mt2m.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023, Marc Zyngier wrote:

> On Fri, 12 May 2023 16:39:33 +0100,
> Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > 
> > On Fri, May 12, 2023 at 04:10:05PM +0100, Marc Zyngier wrote:
> > > On Fri, 12 May 2023 13:28:35 +0100,
> > > Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > > > 
> > > > The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> > > > (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> > > > for portable applications. It provides a high dynamic range, stereo
> > > > DAC for headphone output, two integrated Class D amplifiers for
> > > > loudspeakers, and two ADCs for wired headset microphone input or
> > > > stereo line input. PDM inputs are provided for digital microphones.
> > > > 
> > > > The IRQ chip provides IRQ functionality both to other parts of the
> > > > cs42l43 device and to external devices that wish to use its IRQs.
> > > 
> > > Sorry, but this isn't much of an interrupt controller driver. A modern
> > > interrupt controller driver is firmware-driven (DT or ACPI, pick your
> > > poison), uses irq domains, and uses the irqchip API.
> > > 
> > 
> > Apologies but I really need a little help clarifying the issues
> > here. I am totally happy to fix things up but might need a couple
> > pointers.
> > 
> > 1) uses the irqchip API / uses irq domains
> > 
> > The driver does use both the irqchip API and domains, what
> > part of the IRQ API are we not using that we should be?
> > 
> > The driver registers an irq domain using
> > irq_domain_create_linear.  It requests its parent IRQ using
> > request_threaded_irq. It passes IRQs onto the devices requesting
> > IRQs from it using handle_nested_irq and irq_find_mapping.
> > 
> > Is the objection here that regmap is making these calls for us,
> > rather than them being hard coded into this driver?
> 
> That's one of the reasons. Look at the existing irqchip drivers: they
> have nothing in common with yours. The regmap irqchip abstraction may
> be convenient for what you are doing, but the result isn't really an
> irqchip driver. It is something that is a small bit of a larger device
> and not an interrupt controller driver on its own. The irqchip
> subsystem is there for "first class" interrupt controllers.

I'm not aware of another subsystem that deals with !IRQChip level IRQ
controllers.  Where do simple or "second class" interrupt controllers
go?

-- 
Lee Jones [李琼斯]
