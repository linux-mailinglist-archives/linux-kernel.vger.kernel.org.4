Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD46E8EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjDTJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjDTJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D21702;
        Thu, 20 Apr 2023 02:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12521646C6;
        Thu, 20 Apr 2023 09:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CF8C4339B;
        Thu, 20 Apr 2023 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681984294;
        bh=jkY+rGqHlMnzIdFBaCebm4CNdrtL6O0UZs+Roo/GN9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njNaV26PJ7a0WsEnB0JXZEeOkmLaNdWsszrFFWO6Vyg2TRF3CwMJ1Ey9kmmbXAdJS
         PvFtQK25J2dcPT7LXOL5zRr02CivQzGxRkzmc/FTQPibaZnGDWLcfA5J5UDnvMAbHg
         xfaCC8bN9zl0UDjw1qnM6gN7TR6Zna4pnQVfYSRM=
Date:   Thu, 20 Apr 2023 11:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mcgrof@kernel.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 11/11] Documentation: add USB authorization document
 to driver-api
Message-ID: <ZEELJP_shBUF8tbu@kroah.com>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-12-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-12-allenwebb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:30PM -0500, Allen Webb wrote:
> There is a user-facing USB authorization document, but it is midding
> details a driver should have developer, so add them in a new document.

I'm sorry, but I can not parse this sentence :(

Can you rephrase it?

> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  .../driver-api/usb/authorization.rst          | 71 +++++++++++++++++++
>  Documentation/driver-api/usb/index.rst        |  1 +
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/driver-api/usb/authorization.rst
> 
> diff --git a/Documentation/driver-api/usb/authorization.rst b/Documentation/driver-api/usb/authorization.rst
> new file mode 100644
> index 000000000000..383dcc037a15
> --- /dev/null
> +++ b/Documentation/driver-api/usb/authorization.rst
> @@ -0,0 +1,71 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Device Authorization
> +====================
> +
> +This document is intended for driver developers. See
> +Documentation/usb/authorization.rst if you are looking for how to use
> +USB authorization.
> +
> +Authorization provides userspace a way to allow or block configuring
> +devices early during enumeration before any modules are probed for the
> +device. While it is possible to block a device by not loading the
> +required modules, this also prevents other devices from using the
> +module as well. For example someone might have an unattended computer
> +downloading installation media to a USB drive. Presumably this computer
> +would be locked to make it more difficult for a bad actor to access the
> +computer. Since USB storage devices are not needed to interact with the
> +lock screen, the authorized_default sysfs attribute can be set to not
> +authorize new USB devices by default. A userspace tool like USBGuard
> +can then vet the devices. Mice, keyboards, etc can be allowed by
> +writing to their authorized sysfs attribute so that the lock screen can
> +still be used (this important in cases like suspend+resume or docks)
> +while other devices can be blocked as long as the lock screen is shown.
> +
> +Sysfs Attributes
> +================
> +
> +Userspace can control USB device authorization through the
> +authorized_default and authorized sysfs attributes.
> +
> +authorized_default
> +------------------
> +
> +Defined in ``drivers/usb/core/hcd.c``
> +
> +The authorized_default sysfs attribute is only present for host
> +controllers. It determines the initial state of the authorized sysfs
> +attribute of USB devices newly connected to the corresponding host
> +controller. It can take on the following values:
> +
> ++---------------------------------------------------+
> +| Value | Behavior                                  |
> ++=======+===========================================+
> +|    -1 | Authorize all devices except wireless USB |
> ++-------+-------------------------------------------+
> +|     0 | Do not authorize new devices              |
> ++-------+-------------------------------------------+
> +|     1 | Authorize new devices                     |
> ++-------+-------------------------------------------+
> +|     2 | Authorize new internal devices only       |
> ++---------------------------------------------------+
> +
> +Note that firmware platform code determines if a device is internal or
> +not and this is reported as the connect_type sysfs attribute of the USB
> +port. This is currently supported by ACPI, but device tree still needs
> +an implementation. Authorizing new internal devices only can be useful
> +to work around issues with devices that misbehave if there are delays
> +in probing their module.
> +
> +authorized
> +----------
> +
> +Defined in ``drivers/usb/core/sysfs.c``
> +
> +Every USB device has an authorized sysfs attribute which can take the
> +values 0 and 1. When authorized is 0, the device still is present in
> +sysfs, but none of its interfaces can be associated with drivers and
> +modules will not be probed. When authorized is 1 (or set to one) a
> +configuration is chosen for the device and its interfaces are
> +registered allowing drivers to bind to them.

Why would a driver author care about any of this?  It's all user-facing,
so shouldn't it go into the other document?

thanks,

greg k-h
