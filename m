Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A069A7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBQJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBQJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:18:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6942D78;
        Fri, 17 Feb 2023 01:18:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81DB61746;
        Fri, 17 Feb 2023 09:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B81C433D2;
        Fri, 17 Feb 2023 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676625533;
        bh=qE6h234e+xE/uBcGyAf4wfBiTVaCXy/6Q3WdTEI7wEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAlkFpgu6zPxpGJrNaro5DnW3P50NvThqxpSztJWZP1EIKRGArp2BTCADIezvawRl
         cPHfGE6kzG2f0qk/J/9Apy4dfoNnL/5vn9yHMe5qwmJ3Jq7PYAcmJ57WOLIBGPQ5I1
         16+lEDCCYQTgkC4I+bXNaxrxelPQYUO1amw4dfAg=
Date:   Fri, 17 Feb 2023 10:18:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        l.sanfilippo@kunbus.com, andy.shevchenko@gmail.com,
        peter_hong@fintek.com.tw, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: Add using BIOS IRQ default setting
Message-ID: <Y+9GelDBcbtDQwHl@kroah.com>
References: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:49:53PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> In 8250_fintek.c probe_setup_port(), we'll detect the IRQ trigger mode by
> irq_get_irq_data() and pass it to fintek_8250_set_irq_mode(). If detected
> Edge mode, we'll set the UART with Edge/High mode, otherwise Level/Low.
> 
> But in some motherboard, The APIC maybe setting to Level/High. In this case
> the driver will setting wrong configuration into UART. So we add a option
> to kernel parameter to control the driver as following:
> 
> 	fintek_uart_irq_mode_override= [SERIAL]
> 		{default, bios}
> 		If the parameter is "default", the driver will using
> 		former IRQ override methed(By IRQ trigger type).
> 		otherwise, we'll don't change the UART IRQ setting.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Also note, your From: line does not match this line, so I couldn't take
this patch anyway :(

And why are you sending patches through a random gmail account and not
your fintek.com.tw address?  Please use that one, so that we can easily
verify that this is coming from the proper address and no one is
impersonating you.

thanks,

greg k-h
