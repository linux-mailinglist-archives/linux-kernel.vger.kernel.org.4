Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948366B7D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCMQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCMQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:17:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF45B5EB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D003B81123
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D28C433D2;
        Mon, 13 Mar 2023 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678724221;
        bh=CMolYhczfZvETyHeB5vcMlBlylw8gzb1SYBCASB6Ews=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoUXkR1UYKDdH5exbM9MguN9JH63xARixk69icdEr/GDSZd1EYun+3Jrcyv6/y5h0
         /vPNWtFPFzXsext/hKiyiASjic8ZatLHtLBiSMFFhRka6zAQxrLZQLhBSi2nTfSQu3
         WBXSM54wfdAkSlQLFBDZ4hpvXNhdiLygz1W/uMAQ=
Date:   Mon, 13 Mar 2023 17:16:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     VaibhaavRam.TL@microchip.com
Cc:     arnd@arndb.de, Kumaravel.Thiagarajan@microchip.com,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <ZA9Me2d9IsoYGifp@kroah.com>
References: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
 <ZAm7PDSIUN5HMxUu@kroah.com>
 <DM4PR11MB62385D0541F7AF8EC7E9F6CE97B99@DM4PR11MB6238.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB62385D0541F7AF8EC7E9F6CE97B99@DM4PR11MB6238.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 04:01:15PM +0000, VaibhaavRam.TL@microchip.com wrote:
> > Again, default group will handle this automatically, you should never 
> > need to call a sysfs_*() call from a driver.  Otherwise something is usually very wrong.
> 
> Are you recommending similar to this snippet?
> 
> static struct bin_attribute *pci1xxxx_bin_attributes[] = {
> 	&pci1xxxx_otp_attr,
> 	&pci1xxxx_eeprom_attr
> 	NULL,
> };
> 
> static const struct attribute_group pci1xxxx_bin_attributes_group = {
> 	.bin_attrs = pci1xxxx_bin_attributes,
> };
> ..
> ..
> auxiliary_device.device.attribute_group = pci1xxxx_bin_attributes_group

Yes.

> This creates sysfs for both EEPROM and OTP at once and handles for its removal, right?
> But, In this case, I have to check whether EEPROM is responsive and only then create sysfs for it.
> 
> Can you please provide some guidance, on how to handle this situation without using sysfs_*().

Use the "is_visible" callback in your group to tell the driver core if
the specific attribute needs to be created or not.

thanks,

greg k-h
