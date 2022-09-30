Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADC5F04D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiI3Gc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI3Gcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:32:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D461F8C09
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EF91B8242D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1036C433D6;
        Fri, 30 Sep 2022 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664519569;
        bh=8d0GTDlEDmWyR/tsAL8f28K9BeG0QlXD4nZBVLr4Du4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv4Wo1KMxmXelaaWQbeUASxSgXqrJW9FOn+QTYw09LLPIzb1ana1M/QhFZNHRYtqF
         Zwpje9BIG9PoOPXs2WbcJO0IbMcCs5455RZR5WfX6MIwYwcHbPXEl0wSpcz0o6Cjtf
         AebpYzZaWD3ZTGsf2NLdyinZCZ9CX/RGBhyVBi0k=
Date:   Fri, 30 Sep 2022 08:32:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v11] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YzaNjlqc0GqmJt68@kroah.com>
References: <20220929234432.3711480-1-jrosenth@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929234432.3711480-1-jrosenth@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:44:32PM -0600, Jack Rosenthal wrote:
> The CBMEM area is a downward-growing memory region used by coreboot to
> dynamically allocate tagged data structures ("CBMEM entries") that
> remain resident during boot.
> 
> This implements a driver which exports access to the CBMEM entries
> via sysfs under /sys/firmware/cbmem/<id>.
> 
> This implementation is quite versatile.  Examples of how it could be
> used are given below:
> 
> * Tools like util/cbmem from the coreboot tree could use this driver
>   instead of finding CBMEM in /dev/mem directly.  Alternatively,
>   firmware developers debugging an issue may find the sysfs interface
>   more ergonomic than the cbmem tool and choose to use it directly.
> 
> * The crossystem tool, which exposes verified boot variables, can use
>   this driver to read the vboot work buffer.
> 
> * Tools which read the BIOS SPI flash (e.g., flashrom) can find the
>   flash layout in CBMEM directly, which is significantly faster than
>   searching the flash directly.
> 
> Write access is provided to all CBMEM regions via
> /sys/firmware/cbmem/<id>/mem, as the existing cbmem tooling updates
> this memory region, and envisioned use cases with crossystem
> can benefit from updating memory regions.
> 
> Link: https://issuetracker.google.com/239604743
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Tested-by: Jack Rosenthal <jrosenth@chromium.org>
> Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
> ---
> Changes in v11:
> * Changed /sys/firmware/coreboot/cbmem -> /sys/firmware/cbmem
> * cbmem.c uses attribute groups to initialize files, which is much
>   cleaner.  The attributes are added under the device kobject, which
>   is now symlinked into /sys/firmware/cbmem.

symlink?  Ick, no, do not do that at all please.

As these are device attributes, just stick with them.  Don't do a crazy
symlink into a non-device-attribute portion of the sysfs tree, by doing
that you break all userspace tools and stuff like libudev will never
even see these attributes.


> * Changed documentation text as suggested by greg k-h
> 
>  .../ABI/testing/sysfs-firmware-cbmem          |  43 +++++
>  drivers/firmware/google/Kconfig               |   8 +
>  drivers/firmware/google/Makefile              |   3 +
>  drivers/firmware/google/cbmem.c               | 180 ++++++++++++++++++
>  drivers/firmware/google/coreboot_table.h      |  16 ++
>  5 files changed, 250 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-cbmem
>  create mode 100644 drivers/firmware/google/cbmem.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-cbmem b/Documentation/ABI/testing/sysfs-firmware-cbmem
> new file mode 100644
> index 000000000000..f769104ac4cd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-cbmem
> @@ -0,0 +1,43 @@
> +What:		/sys/firmware/cbmem/
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		Coreboot provides a variety of data structures in CBMEM.  This
> +		directory contains each CBMEM entry, which can be found via
> +		Coreboot tables.

What happened to the coreboot name?

Why cbmem?  What is CBMEM?

And just stick with the attributes under the cbmem coreboot device in
the device tree, don't use /sys/firmware/.

Also, I asked before, but some note about "exposing all of these bios
values to userspace is not a security issue at all" would be nice, if
only to point at in a few years and say "wow we were naive"...

thanks,

greg k-h
