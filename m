Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD2682969
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjAaJrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjAaJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:47:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12446718
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6772DCE1C83
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464FAC4339B;
        Tue, 31 Jan 2023 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675158383;
        bh=drj8Q7DR3ak/2XdNo8GhguQIPXGnSMqZd36bxWhjgJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWaQXUYUEfz4egILmZZ2iaXcX3R4PnrswWeeN8w15k8dwM3uISKalaK0uHey2TaUw
         qxJZCo+DLP89CRFh8k7dOPzxdtaJ0mkaH1D7nJImRrkQ0xMulzJSNMXpDWLi+0Qt8J
         JeYeJpayWG4/OYwAYDGXGSQt8zb9LltHVPnLlpAo=
Date:   Tue, 31 Jan 2023 10:46:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian.Gromm@microchip.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: fix kernel-doc warnings
Message-ID: <Y9jjbMWKlRkCzzSe@kroah.com>
References: <20230113063947.23174-1-rdunlap@infradead.org>
 <Y8lsvtoSYFj/8/U/@kroah.com>
 <7e79c3bb823ab54b7440129b8d5a1897cfa01dd2.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e79c3bb823ab54b7440129b8d5a1897cfa01dd2.camel@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:31:56AM +0000, Christian.Gromm@microchip.com wrote:
> 
> On Thu, 2023-01-19 at 17:15 +0100, Greg Kroah-Hartman wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Jan 12, 2023 at 10:39:47PM -0800, Randy Dunlap wrote:
> > > Fix various W=1 kernel-doc warnings in drivers/most/:
> > >
> > > drivers/most/most_usb.c:669: warning: Excess function parameter 'data' description in 'link_stat_timer_handler'
> > > drivers/most/most_usb.c:769: warning: cannot understand function prototype: 'const struct file_operations hdm_usb_fops = '
> > > drivers/most/most_usb.c:776: warning: cannot understand function prototype: 'const struct usb_device_id usbid[] = '
> > > drivers/most/most_cdev.c:301: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > >  * Initialization of struct file_operations
> > > drivers/most/most_cdev.c:414: warning: Function parameter or member 'args' not described in 'comp_probe'
> > > drivers/most/most_snd.c:56: warning: Function parameter or member 'pcm_hardware' not described in 'channel'
> > > drivers/most/most_snd.c:56: warning: Function parameter or member 'copy_fn' not described in 'channel'
> > > drivers/most/most_snd.c:404: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > >  * Initialization of struct snd_pcm_ops
> > > drivers/most/most_snd.c:514: warning: Function parameter or member 'device_name' not described in 'audio_probe_channel'
> > > drivers/most/most_snd.c:703: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > >  * Initialization of the struct most_component
> > >
> > >
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Christian Gromm <christian.gromm@microchip.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > Also: what does MOST mean? Can that be added to drivers/most/Kconfig,
> > >     in a prompt or help text?
> > > Also: how about a MAINTAINERS entry for drivers/most/?
> > 
> > That would be good, Christian, can you send a patch for that?
> > 
> 
> Sure, I can do that. But since I am not working for the automotive divison
> within the company anymore I need to indentify the right person for that first.

Should we just remove these files if no one is using them anymore and
there's no one to maintain them?

thanks,

greg k-h
