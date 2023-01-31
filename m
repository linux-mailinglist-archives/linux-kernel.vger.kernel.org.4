Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAD6829FC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjAaKKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjAaKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C255A0;
        Tue, 31 Jan 2023 02:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97ABE614A0;
        Tue, 31 Jan 2023 10:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B461C433EF;
        Tue, 31 Jan 2023 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675159800;
        bh=nwkS/pbOsJuXffQqTETQVuoDDHsBxdfFjcAQA16lTkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wuq0S0qvVUihSCU+NDx02COKCc5IJJC4eZdalM6tZzBlXH4QGYwTMn/lvt/53pg7Z
         Rf3pI4t/s6uhidvQ5/v4dF/rks2jN2GVRzozS08NKXeIwFgWpTySPKtQAR1JCp9FWY
         fWk6Fy0Ne1B28LEFi+H2YOpNlaa76YscZJJhlKfI=
Date:   Tue, 31 Jan 2023 11:09:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y9jo9bTnmejWYoH2@kroah.com>
References: <20230116080002.47315-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116080002.47315-1-tony@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:59:58AM +0200, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct device for the serial core controller
> as suggested by Greg and Jiri. The serial core controller devices are
> children of the physical serial port device. The serial core controller
> device is needed to support multiple different kind of ports connected
> to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.

Looking better, but why is this new device a platform device?  That
feels odd, you should never have a platform device hanging off of a
non-platform device, right?

What does the sysfs tree look like now with this patch applied?

thanks,

greg k-h
