Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF0622CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiKINpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKINpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:45:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329BD13D47;
        Wed,  9 Nov 2022 05:45:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE1CEB81EC6;
        Wed,  9 Nov 2022 13:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A91C433D6;
        Wed,  9 Nov 2022 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668001513;
        bh=E27wU8CHwv3ph1+Lgq64qqtraNEyNswv/8Z7MWYYWxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pq2FSoOQFazxaPMW/IG7R+nPNOQZwBB6RzA4oHece//Rw6OlsnZpWUBcnZ9GIaikT
         5AfEKyeL8SpUgaHcBK0HKvns8BHwK/5dlvIdd88q7hx8+osRPeyqmKcNm3dcNJ49bj
         +jpUmZznxU+eVTxvrl3DkbLgyhTN1eXZ/IFBzS+k=
Date:   Wed, 9 Nov 2022 14:45:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     rafael@kernel.org, u.kleine-koenig@pengutronix.de,
        dvhart@infradead.org, andy@infradead.org, lenb@kernel.org,
        arnd@arndb.de, peterhuewe@gmx.de, kys@microsoft.com,
        kronos.it@gmail.com, dmitry.torokhov@gmail.com,
        bleung@chromium.org, sujith.thomas@intel.com, vithampi@vmware.com,
        lee@kernel.org, wim@linux-watchdog.org, jgross@suse.com,
        davem@davemloft.net, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] acpi: make remove callback of acpi driver void
Message-ID: <Y2uu5Q7mLzS0w9VR@kroah.com>
References: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 10:57:53PM +0800, Dawei Li wrote:
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

As RFC patches don't mean to be applied, I'll wait for a real version to
be submitted before reviewing this.

thanks,

greg k-h
