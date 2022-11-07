Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A061ECC8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKGIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:20:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BDE24;
        Mon,  7 Nov 2022 00:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23382B80E34;
        Mon,  7 Nov 2022 08:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7194BC433C1;
        Mon,  7 Nov 2022 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809239;
        bh=HsumuHWGEkVvYRJ9gfr46c7MJjHktceqJIjdDmY63pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhgh6OeHVpRaa1eETr2Fq35BwwgvCURF3ehZ26Z4+wA6YYGGi5pYgeOZF8CDgrc9f
         w7kzJ5KJkDmmskVaaC5wfP4CZ+XqEz8UMFc+CNBDOhc4xVRE+x1UFjg6CLKQa3qbIZ
         FxmG2ChDjQxtKYvfHIa5eBJjCe+eBz4+NOAEzb/XQD28O9Tcfjwue3kfHzE33+L2CN
         2jRdn7+eFhTSUlZYmkcnvgcOIVrGF3R2byH9L0QkkGkoixH6+Gb/VXHn5fL0ulaf0l
         kv+WscTG0c6qmxqUefWxlDwfgI/Gm9cW5osIFPgp1OSjjOibbVKKwEWBWkz5MQdhW6
         NXYPRqg652E/A==
Date:   Mon, 7 Nov 2022 08:20:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        u.kleine-koenig@pengutronix.de, dvhart@infradead.org,
        andy@infradead.org, lenb@kernel.org, arnd@arndb.de,
        peterhuewe@gmx.de, kys@microsoft.com, kronos.it@gmail.com,
        dmitry.torokhov@gmail.com, bleung@chromium.org,
        sujith.thomas@intel.com, vithampi@vmware.com,
        wim@linux-watchdog.org, jgross@suse.com, davem@davemloft.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] acpi: make remove callback of acpi driver void
Message-ID: <Y2i/zy8CVzTb6qdE@google.com>
References: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Nov 2022, Dawei Li wrote:

> For bus-based driver, device removal is implemented as:
> 1 device_remove()->
> 2   bus->remove()->
> 3     driver->remove()
> 
> Driver core needs _no_ inform from callee(bus driver) about the
> result of remove callback. In that case,
> commit <fc7a6209d571> ("bus: Make remove callback return void")
> forces struct bus_type::remove() be void-returned.
> 
> Now we have the situation that both 1 & 2 of calling chain are
> void-returned, so it does _not_ make much sense for 3(driver->remove)
> to return non-void to its caller.
> 
> So the basic idea behind this change is making remove() callback of
> any bus-based driver to be void-returned.
> 
> This change itself, is for device drivers based on acpi-bus.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  arch/ia64/hp/common/aml_nfw.c                 |  4 ++--
>  arch/x86/platform/olpc/olpc-xo15-sci.c        |  3 +--
>  drivers/acpi/ac.c                             |  8 +++-----
>  drivers/acpi/acpi_pad.c                       |  3 +--
>  drivers/acpi/acpi_video.c                     |  8 +++-----
>  drivers/acpi/battery.c                        |  5 ++---
>  drivers/acpi/button.c                         |  5 ++---
>  drivers/acpi/ec.c                             |  5 ++---
>  drivers/acpi/hed.c                            |  3 +--
>  drivers/acpi/nfit/core.c                      |  3 +--
>  drivers/acpi/sbs.c                            |  9 ++++-----
>  drivers/acpi/sbshc.c                          |  7 +++----
>  drivers/acpi/thermal.c                        |  7 +++----
>  drivers/acpi/tiny-power-button.c              | 10 +++++++---
>  drivers/char/sonypi.c                         |  3 +--
>  drivers/char/tpm/tpm_crb.c                    |  4 +---
>  drivers/hv/vmbus_drv.c                        |  4 +---
>  drivers/hwmon/acpi_power_meter.c              |  5 ++---
>  drivers/hwmon/asus_atk0110.c                  |  6 ++----
>  drivers/input/misc/atlas_btns.c               |  4 +---
>  drivers/net/fjes/fjes_main.c                  |  4 +---
>  .../platform/chrome/chromeos_privacy_screen.c |  3 +--
>  drivers/platform/chrome/wilco_ec/event.c      |  4 +---
>  drivers/platform/surface/surfacepro3_button.c |  3 +--
>  drivers/platform/x86/asus-laptop.c            |  3 +--
>  drivers/platform/x86/asus-wireless.c          |  3 +--
>  drivers/platform/x86/classmate-laptop.c       | 20 +++++++++----------
>  drivers/platform/x86/dell/dell-rbtn.c         |  6 ++----
>  drivers/platform/x86/eeepc-laptop.c           |  3 +--
>  drivers/platform/x86/fujitsu-laptop.c         |  4 +---
>  drivers/platform/x86/fujitsu-tablet.c         |  3 +--
>  drivers/platform/x86/intel/rst.c              |  4 +---
>  drivers/platform/x86/lg-laptop.c              |  4 +---
>  drivers/platform/x86/panasonic-laptop.c       |  8 +++-----
>  drivers/platform/x86/sony-laptop.c            |  9 +++------
>  drivers/platform/x86/system76_acpi.c          |  4 +---
>  drivers/platform/x86/topstar-laptop.c         |  3 +--
>  drivers/platform/x86/toshiba_acpi.c           |  4 +---
>  drivers/platform/x86/toshiba_bluetooth.c      |  6 +++---
>  drivers/platform/x86/toshiba_haps.c           |  4 +---
>  drivers/platform/x86/wireless-hotkey.c        |  3 +--
>  drivers/platform/x86/xo15-ebook.c             |  3 +--
>  drivers/ptp/ptp_vmw.c                         |  3 +--
>  drivers/thermal/intel/intel_menlow.c          |  8 +++-----

>  drivers/video/backlight/apple_bl.c            |  3 +--

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/watchdog/ni903x_wdt.c                 |  4 +---
>  drivers/xen/xen-acpi-pad.c                    |  3 +--
>  include/acpi/acpi_bus.h                       |  2 +-
>  48 files changed, 88 insertions(+), 149 deletions(-)

-- 
Lee Jones [李琼斯]
