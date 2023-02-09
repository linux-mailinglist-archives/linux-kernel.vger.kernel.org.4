Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853769028E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBIIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBIIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66356484;
        Thu,  9 Feb 2023 00:55:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F6161949;
        Thu,  9 Feb 2023 08:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AFFC433EF;
        Thu,  9 Feb 2023 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675932905;
        bh=zt7Y7HnHpASdaS3oqAwBrAieLVQQiB023LB2aYtnvyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfaZ4yA8EWHMHhJfOvzEaaeVm+piMBPx1+9NXGHsDVdNQmEiduw+COAwUUUuTopto
         oZjqFvH6uHJ4qBMV6Cohz97JtwTcwijTVQJSNDa6f0ZHqhCnAti0YqzaYPYzr/nBku
         +7X4R94xWUILdiq6jJ6UxlJ9Hl1jLCBioI1MzMUg=
Date:   Thu, 9 Feb 2023 09:55:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+S05tQ5e5pE9/v0@kroah.com>
References: <20230209044237.3927293-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209044237.3927293-1-tharunkumar.pasumarthi@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:12:37AM +0530, Tharun Kumar P wrote:
> +static int e2p_device_write_byte(struct pci1xxxx_otp_e2p_device *priv,
> +				 unsigned long byte_offset, u8 value)
> +{
> +	u32 data;
> +
> +	/* Write the value into EEPROM_DATA_REG register */
> +	writel(value, priv->reg_base + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
> +	data = EEPROM_CMD_EPC_TIMEOUT_BIT | EEPROM_CMD_EPC_WRITE | byte_offset;
> +
> +	/* Write the data into EEPROM_CMD_REG register */
> +	writel(data, priv->reg_base + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +	/* Set the EPC_BUSY bit of EEPROM_CMD_REG register */
> +	writel(EEPROM_CMD_EPC_BUSY_BIT | data, priv->reg_base +
> +	       MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +	/* Wait for the EPC_BUSY bit to get cleared */
> +	do {
> +		data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +	} while (data & EEPROM_CMD_EPC_BUSY_BIT);

That's a very busy "sit and spin" loop here, what happens if the read of
the bit never actually succeeds?  You just locked up the system with no
way to interrupt it :(

Please provide some sort of timeout, or way to break out of this.

> +
> +	if (data & EEPROM_CMD_EPC_TIMEOUT_BIT) {
> +		dev_err(&priv->pdev->dev, "EEPROM write timed out\n");

How can the timeout bit happen if the busy bit was still set?

And what can userspace do about this if it is reported?

> +		return -EFAULT;

This return value is ONLY for when we have memory faults from reading
to/from userspace and the kernel.  It's not a valid return value for a
device error, sorry.  -EIO maybe?

You return this error in a number of other places in the driver that
shouldn't, please fix this up.

Also the loop issue is in your read_byte call and the same review
comments apply there.

thanks,

greg k-h
