Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465F692F83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBKIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBKIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:45:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A5561D18;
        Sat, 11 Feb 2023 00:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59735B8265C;
        Sat, 11 Feb 2023 08:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C7EC433EF;
        Sat, 11 Feb 2023 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676105084;
        bh=e4p3EfDk6PE2hribcSKd91RgeGPv/7wNlON+CBw55wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHOqJ7Ek4jtd9+4Gmvyt4opibsuubv6BOkxW9APKkNpqF3Xz0u/x3FafVvE9Bm9Px
         BVgwRAZBbiLwSQh2jKdrZ7iVozVdNflJGqw12CQluQHLirBY2HqqBUdpN3wU0Y+RMa
         8gZWIs1jlvzXtlWZ6d6cK0HR6cd6dHVORtl06IrM=
Date:   Sat, 11 Feb 2023 09:44:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+dVeeSODu8w5ns9@kroah.com>
References: <20230209044237.3927293-1-tharunkumar.pasumarthi@microchip.com>
 <Y+S05tQ5e5pE9/v0@kroah.com>
 <PH7PR11MB59588BF687D7D2EDAC36E4899BDF9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59588BF687D7D2EDAC36E4899BDF9@PH7PR11MB5958.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 05:07:43AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, February 9, 2023 2:25 PM
> > To: Tharunkumar Pasumarthi - I67821
> > <Tharunkumar.Pasumarthi@microchip.com>
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > > +     } while (data & EEPROM_CMD_EPC_BUSY_BIT);
> > 
> > That's a very busy "sit and spin" loop here, what happens if the read of the
> > bit never actually succeeds?  You just locked up the system with no way to
> > interrupt it :(
> > 
> > Please provide some sort of timeout, or way to break out of this.
> > 
> > > +
> > > +     if (data & EEPROM_CMD_EPC_TIMEOUT_BIT) {
> > > +             dev_err(&priv->pdev->dev, "EEPROM write timed out\n");
> > 
> > How can the timeout bit happen if the busy bit was still set?
> > 
> > And what can userspace do about this if it is reported?
> 
> Hi Greg,
> If EEPROM_CMD_EPC_BUSY_BIT is set for more than 30ms, it will be cleared automatically by the hardware logic and EEPROM_CMD_EPC_TIMEOUT_BIT bit will be set to indicate the timeout. User space application will inform user about timeout on EEPROM write/read when this error occurs.

Ok, if the bit being set will notify userspace of the issue, then why
also spam the kernel error log?

thanks,

greg k-h
