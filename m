Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C15ED47A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiI1GHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI1GH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:07:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94821118B13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F6E4B81E8A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F197C433C1;
        Wed, 28 Sep 2022 06:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664345242;
        bh=wzLHBlAoXENDdYRhonxwHiNgupy+D9oRTtjJqug0AbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCJNTRpSElIlz18Tv7joZedq7GL08DgL1gHo0kFGlCndqiq5z/8IujuBaYdbsbj75
         v2fLxX5Gakt8Xl32Xh1mO8/xpwlrSxs7QpUF/80J+DD4RzLI1IzQhEW9/dqmh4loql
         qAHz/n9a9jlZ/hXk8kEck85Doff4bs28EnOzUUu4=
Date:   Wed, 28 Sep 2022 08:07:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [RESEND PATCH v10] firmware: google: Implement cbmem in sysfs
 driver
Message-ID: <YzPkvd8Xuux5T5sH@kroah.com>
References: <20220927205551.2017473-1-jrosenth@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927205551.2017473-1-jrosenth@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:55:51PM -0600, Jack Rosenthal wrote:
> The CBMEM area is a downward-growing memory region used by coreboot to
> dynamically allocate tagged data structures ("CBMEM entries") that
> remain resident during boot.
> 
> This implements a driver which exports access to the CBMEM entries
> via sysfs under /sys/firmware/coreboot/cbmem/<id>.
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
> /sys/firmware/coreboot/cbmem/<id>/mem, as the existing cbmem tooling
> updates this memory region, and envisioned use cases with crossystem
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
>  .../ABI/testing/sysfs-firmware-coreboot       |  49 ++++
>  drivers/firmware/google/Kconfig               |   8 +
>  drivers/firmware/google/Makefile              |   3 +
>  drivers/firmware/google/cbmem.c               | 225 ++++++++++++++++++
>  drivers/firmware/google/coreboot_table.c      |  10 +
>  drivers/firmware/google/coreboot_table.h      |  16 ++
>  6 files changed, 311 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
>  create mode 100644 drivers/firmware/google/cbmem.c
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
