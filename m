Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9163CF92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiK3HGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiK3HGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:06:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19958000;
        Tue, 29 Nov 2022 23:06:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFAB061A47;
        Wed, 30 Nov 2022 07:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D34C433B5;
        Wed, 30 Nov 2022 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669791991;
        bh=jx1GVgEKam2FNWsSssWOWOrXk2ds1Pc2DkdN2fdfBTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmkBFqCnTZV9cTBv3qi7J4NxMnLup0W+LN51Abegdci0Dybhj7Xxe6RAbihH83re7
         ArNEBoM0P9TVYb6rTv8JmT0m67gUViW99ZV/IPx9j80QYdLJY4cJ7yJX01Zrd7mJ0q
         nw5/48fJ/324JB2jBPb2SyKrveem+MhzNH/7o+Jg=
Date:   Wed, 30 Nov 2022 08:06:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] modules: add modalias file to sysfs for modules.
Message-ID: <Y4cA8y1NX1ZPTboF@kroah.com>
References: <CAJzde06+FXNpyBzT+NfS2GCfqEERMkGDpdsmHQj=v1foLJW4Cw@mail.gmail.com>
 <20221129224313.455862-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129224313.455862-1-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:43:13PM -0600, Allen Webb wrote:
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
> Change-Id: I83b6f0c30e06e65cbe223f1606187283fcb13215
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  drivers/base/Makefile          |   2 +-
>  drivers/base/base.h            |   8 ++
>  drivers/base/bus.c             |  42 ++++++
>  drivers/base/mod_devicetable.c | 249 +++++++++++++++++++++++++++++++++
>  drivers/usb/core/driver.c      |   2 +
>  include/linux/device/bus.h     |   8 ++
>  include/linux/module.h         |   1 +
>  kernel/module/internal.h       |   2 +
>  kernel/module/sysfs.c          |  88 ++++++++++++
>  kernel/params.c                |   2 +
>  10 files changed, 403 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/mod_devicetable.c
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
