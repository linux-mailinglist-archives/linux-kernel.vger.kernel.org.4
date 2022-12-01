Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80063EB08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLAI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLAI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B463D6E;
        Thu,  1 Dec 2022 00:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9B8B81E5D;
        Thu,  1 Dec 2022 08:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2E9C433D6;
        Thu,  1 Dec 2022 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669883199;
        bh=0v/dpeMN0p7fo5PgE4B1pGCBv2KmNGUMHOEOdHV/Zcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jyhZPFK+Ep5/C8SwcvxvjaUpqP3wVecqIt3iOEpBEHfwytXWcrGv2Y8h0qNJ+PyS
         yZuDjbrw5B2mRJav6voN0z7ZbKftXRo/2/28TTHXT7wApSGISs6fQVcjJpR+5HGNQj
         Tu3oiOA+lhflmdRFuauNEZdHU5uL2t4sF/+imUE4=
Date:   Thu, 1 Dec 2022 07:06:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] modules: add modalias file to sysfs for modules.
Message-ID: <Y4hEUP31sbGl5vw8@kroah.com>
References: <Y4cA8y1NX1ZPTboF@kroah.com>
 <20221130221447.1202206-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130221447.1202206-1-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:14:47PM -0600, Allen Webb wrote:
> USB devices support the authorized attribute which can be used by
> user-space to implement trust-based systems for enabling USB devices. It
> would be helpful when building these systems to be able to know in
> advance which kernel drivers (or modules) are reachable from a
> particular USB device.
> 
> This information is readily available for external modules in
> modules.alias. However, builtin kernel modules are not covered. This
> patch adds a sys-fs attribute to both builtin and loaded modules
> exposing the matching rules in the modalias format for integration
> with tools like USBGuard.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  drivers/base/Makefile          |   2 +-
>  drivers/base/base.h            |   8 +
>  drivers/base/bus.c             |  42 ++++++
>  drivers/base/mod_devicetable.c | 257 +++++++++++++++++++++++++++++++++
>  drivers/usb/core/driver.c      |   2 +
>  include/linux/device/bus.h     |   8 +
>  include/linux/module.h         |   1 +
>  kernel/module/internal.h       |   2 +
>  kernel/module/sysfs.c          |  88 +++++++++++
>  kernel/params.c                |   7 +
>  10 files changed, 416 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/mod_devicetable.c
> 
> Fixed another kernel config incompability identified by:
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> Fixed a couple CHECK messages from checkpatch.pl.
> 
> There are still some CHECK messages that are by design in a macro that
> depends on modifying a parameter and string literal concatenation.
> 
> There is also a maintainer file update warning for a new file, but that
> file is already covered by an existing maintainers entry.
> 

Again, please read the kernel documentation for how to list changes that
have happened since the 1st version you submitted, it's impossible to
know what has changed in each version here, right?  Also how has this
changed based on the reviews of the first release where people pointed
you at other alternatives?  How did they not work out?

You might need to start including a 0/1 email with all of this
information as it needs an introduction in places, right?

thanks,

greg k-h
