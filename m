Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD506A7FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCBKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCBKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:20:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAC25960;
        Thu,  2 Mar 2023 02:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2020DB811FE;
        Thu,  2 Mar 2023 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E196C433EF;
        Thu,  2 Mar 2023 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677752439;
        bh=lQMm+/FLt0+xB66zWlowc7zNUj0a7PqTWyhgbygdyYQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=C07CajyK8YEAdda2kQsW3vadORDZ5t4wWEUN0wF3hw7g/6q1AbRbdFzr6y5CDHCPK
         2OjVysVC5uCQx8e9v8EfjIU5mbFAO4YdN5owSDrNXmPBYm3cOvt6I1bkUe50FUkcqT
         lnmOJ48REEDfGN4ur2YCYFu/Iof2RzsK4d/NVj1U=
Date:   Thu, 2 Mar 2023 11:20:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] driver core: bus: Handle early calls to bus_to_subsys()
Message-ID: <ZAB4dVeQEZyxhx3Z@kroah.com>
References: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
 <Y/3d/sfipoe130Hu@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/3d/sfipoe130Hu@ninjato>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:57:02AM +0100, Wolfram Sang wrote:
> On Tue, Feb 21, 2023 at 01:53:51PM +0100, Geert Uytterhoeven wrote:
> > When calling soc_device_match() from early_initcall(), bus_kset is still
> > NULL, causing a crash:
> > 
> >     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
> >     ...
> >     Call trace:
> >      __lock_acquire+0x530/0x20f0
> >      lock_acquire.part.0+0xc8/0x210
> >      lock_acquire+0x64/0x80
> >      _raw_spin_lock+0x4c/0x60
> >      bus_to_subsys+0x24/0xac
> >      bus_for_each_dev+0x30/0xcc
> >      soc_device_match+0x4c/0xe0
> >      r8a7795_sysc_init+0x18/0x60
> >      rcar_sysc_pd_init+0xb0/0x33c
> >      do_one_initcall+0x128/0x2bc
> > 
> > Before, bus_for_each_dev() handled this gracefully by checking that
> > the back-pointer to the private structure was valid.
> > 
> > Fix this by adding a NULL check for bus_kset to bus_to_subsys().
> > 
> > Fixes: 83b9148df2c95e23 ("driver core: bus: bus iterator cleanups")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Current top-of-head doesn't boot my Salvator-XS board, this patch fixed
> it.
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 

Great, now sent to Linus.

greg k-h
