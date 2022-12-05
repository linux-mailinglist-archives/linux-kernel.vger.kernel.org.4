Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70FD642C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiLEPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiLEPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21213D75;
        Mon,  5 Dec 2022 07:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60438B8113A;
        Mon,  5 Dec 2022 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937AFC433D6;
        Mon,  5 Dec 2022 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670255592;
        bh=ljntIpg75HkHsR3cg+6kKx8b082KUIAgJDZVFMhFUB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drx3svl1jdFTbc90PJ6PmVJyOjnaEcHf39vmYKmDstPEf46EWXPPXE1lv/U7byVdW
         ufC40X2PeTJVTT5VlcRmc70/2b4cb2aYP6Y72SPeKnDgTuPpvo7ydCfvW0mlwLKwjS
         juDIqq6znFg/TJTpeGC8yMWXjr5Z4897AO3i18OU=
Date:   Mon, 5 Dec 2022 16:53:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 5/5] drivers: Implement module modaliases for USB
Message-ID: <Y44T5k7RFXafva6t@kroah.com>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-5-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202224744.1447448-5-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:47:44PM -0600, Allen Webb wrote:
> Add the per-subsystem logic needed to print match-based modaliases to
> the USB subsystem, so the modalias sysfs attribute for modules will
> function for modules that register USB drivers.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  drivers/base/Makefile          |   2 +-
>  drivers/base/base.h            |   8 +
>  drivers/base/mod_devicetable.c | 257 +++++++++++++++++++++++++++++++++
>  drivers/usb/core/driver.c      |   2 +

It feels like you have a lot of USB-specific stuff here in the driver
core, and not enough in the usb core.  How is each different bus going
to do this?  Add code to the driver core?  It should be able to not
touch the driver core at all to add support for this for a new bus.

thanks,

greg k-h
