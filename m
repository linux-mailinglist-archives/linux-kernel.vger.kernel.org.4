Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA4713C18
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE1TEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjE1TEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C990;
        Sun, 28 May 2023 12:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E701D6121B;
        Sun, 28 May 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED4BC433EF;
        Sun, 28 May 2023 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685300645;
        bh=nIBce03AcX7Ltp7Gg6I7jXmqQZFIZAlznjSi44mm3fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TgXYg2bd0QKCHdUG9oBT2EzflVFcs9buJslhGq02xzoRj1J22LKMUowCnBbfDDy+p
         u00FoI1lz0RvmCj6Wm5ziE/Eb4XHIOucxy/iL2J6tBNWcGydjjRAGO3+LZ3mcXN+1T
         lqxLfFZH/eI8AZ4UyCHUUIzVdrm1Gm7OH63MJiduIhXPA9yGO+jjqWmwE+cwcleBdS
         rs7KAVzYVgL/MaexHQJgCavDwxIfiW9bng8Kmh3m4LHapgbZMBP4fY1+OwJ2+aF43S
         y2grnw0YfrXaK0lbgGr2Eovyg+Tq/WhnNxL1oNgRBNvsroiB81bw2MPtmEhW+Jxiur
         uV1mXCUpC5DfQ==
Date:   Sun, 28 May 2023 20:20:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230528202024.0ade4595@jic23-huawei>
In-Reply-To: <915a5d31-5eb4-54b9-3fc9-ff69836f3d76@topic.nl>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-3-marius.cristea@microchip.com>
        <915a5d31-5eb4-54b9-3fc9-ff69836f3d76@topic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > +
> > +static inline u8 mcp356x_reg_fast_cmd(u8 chip_addr, u8 cmd)
> > +{
> > +	return ((chip_addr << 6) | (cmd << 2));
> > +}
> > +
> > +static int mcp356x_read(struct mcp356x_state *adc, u8 reg, u32 *val, u8 len)
> > +{
> > +	int ret;
> > +	u8 tmp_reg;
> > +
> > +	tmp_reg = mcp356x_reg_read(adc->dev_addr, reg);
> > +
> > +	ret = spi_write_then_read(adc->spi, &tmp_reg, 1, val, len);  
> 
> I had issues with spi_write_then_read not communicating properly with the 
> device. This may be due to the SPI controller (Xilinx IP in FPGA) though.

That's a bit worrying!  Shouldn't be a problem unless there is something
fiddly required with the chip select or similar.

> 
> I had to use spi_sync() to get reliable answers. Also has the added benefit of 
> giving access to the interrupt flags.

> 
> > +
> > +#define MCP3564_CHANNELS(depth) {			\
> > +	MCP356X_V_CHANNEL(0, 0, depth),			\
> > +	MCP356X_V_CHANNEL(1, 1, depth),			\
> > +	MCP356X_V_CHANNEL(2, 2, depth),			\
> > +	MCP356X_V_CHANNEL(3, 3, depth),			\
> > +	MCP356X_V_CHANNEL(4, 4, depth),			\
> > +	MCP356X_V_CHANNEL(5, 5, depth),			\
> > +	MCP356X_V_CHANNEL(6, 6, depth),			\
> > +	MCP356X_V_CHANNEL(7, 7, depth),			\
> > +	MCP356X_T_CHAN(depth),				\
> > +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 2, 0x02, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 3, 0x03, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 2, 0x12, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 3, 0x13, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 3, 0x23, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 0, 0x20, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 0, 0x30, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 1, 0x21, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 1, 0x31, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 2, 0x32, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 4, 0x04, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 5, 0x05, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 6, 0x06, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(0, 7, 0x07, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 4, 0x14, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 5, 0x15, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 6, 0x16, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(1, 7, 0x17, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 4, 0x24, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 5, 0x25, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 6, 0x26, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(2, 7, 0x27, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 4, 0x34, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 5, 0x35, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 6, 0x36, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(3, 7, 0x37, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 5, 0x45, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 6, 0x46, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 7, 0x47, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 6, 0x56, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 7, 0x57, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 7, 0x67, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 0, 0x40, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 0, 0x50, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 0, 0x60, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 0, 0x70, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 1, 0x41, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 1, 0x51, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 1, 0x61, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 1, 0x71, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 2, 0x42, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 2, 0x52, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 2, 0x62, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 2, 0x72, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(4, 3, 0x43, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 3, 0x53, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 3, 0x63, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 3, 0x73, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(5, 4, 0x54, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 4, 0x64, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 4, 0x74, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(6, 5, 0x65, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 5, 0x75, depth),	\
> > +	MCP356X_V_CHANNEL_DIFF(7, 6, 0x76, depth)	\
> > +}  
> 
> Nice that the chip can do full 8x8 mux delivering 56 channels, but I don't 
> think that will be useful to many people.
> 
> Also I'd want to see buffer support added to the device, which only works for 
> the channels as in the table in the datasheet, so only 4 differential ones. 
> It'd be annoying to have 56 channels but only be able to contiuously read 4 
> specific ones.

One common solution to this is to push the channel setup to firmware
as it corresponds to 'what is wired'.  See the channel bindings
in Documentation/devicetree/bindings/iio/adc/adc.yaml
and various examples in tree.

Thanks for combining efforts btw - should give us the best overall
result but I feel for you when you discovered the duplication :(

Jonathan
