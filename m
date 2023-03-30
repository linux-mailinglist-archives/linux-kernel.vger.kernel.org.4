Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DD6CFD82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC3H5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC3H5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D118F;
        Thu, 30 Mar 2023 00:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97FA661EB8;
        Thu, 30 Mar 2023 07:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A076FC433EF;
        Thu, 30 Mar 2023 07:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680163062;
        bh=ZOAGwAmzYQ7qFd60V4QD6i1iD4nHw43HHmPMAztdHQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWborn+VVqZKn5dWcEeN6cVkDyluAGp8qeWDBcpiJW8tN9e5NNG4ZNni1WT2A0dF9
         6zkFtqDrGYRzFhKZSRiCC5CgpT+/oLwYFWWMehQkigUeW+zkswTK6N7SQJ2bVEi2tN
         6A5n4f0pee5iWVyvjkdw1wC9/6nKI416rnEHM0BE=
Date:   Thu, 30 Mar 2023 09:57:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     VaibhaavRam.TL@microchip.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Message-ID: <ZCVA8wE5aYXuvX6J@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-4-vaibhaavram.tl@microchip.com>
 <ZCQMh_TbPyLGhTD2@kroah.com>
 <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 05:28:43AM +0000, VaibhaavRam.TL@microchip.com wrote:
> On Wed, 2023-03-29 at 12:01 +0200, Greg KH wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Tue, Mar 28, 2023 at 08:10:06PM +0530, Vaibhaav Ram T.L wrote:
> > > From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> > > 
> > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> > > industrial, and automotive applications. This switch integrates OTP
> > > and EEPROM to enable customization of the part in the field.
> > > This patch adds EEPROM functionality to support the same.
> > 
> > Again, why not use the in-kernel eeprom api instead?
> Unlike other in-Kernel EEPROM APIs, this EEPROM is not accessible
> through any of the i2c/spi buses available to the kernel.
> 
> It is only accessible through the register interface available in the
> EEPROM controller of the PCI1XXXX device.
> 
> The architecture of the device was explained @
> https://lore.kernel.org/all/Y+9HOdHGqmPP%2FUde@kroah.com/

That shows the architecture, but I left it as "try using the EEPROM api
and let us know how it goes" and you never did that.

If you are going to create your own user/kernel api for something that
the kernel already has a user/kernel api for, you need to document it
in the changelog text really really really well why you can't use the
existing api, and why this new custom one really is the only way to
solve this issue, to explain all of this.

thanks,

greg k-h
