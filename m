Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A371FB22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjFBHky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjFBHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37E195;
        Fri,  2 Jun 2023 00:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFE664D00;
        Fri,  2 Jun 2023 07:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21A1C433EF;
        Fri,  2 Jun 2023 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685691648;
        bh=QWLCTnUxuk/bgCq8TXw/6CiD075kLmr0khRTXCmFoDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia+ogJXFPRRxmNYYif7JFvwThMXOpsbSDPPDX31kmuuHTFWlXqQM31dRsedh0P9+1
         Nwe0teuf+kbxrzMKrFXNKAPiqlU2KVQhHGD0EbOiKRf/UnP32b8OCFkqDw7W401o6w
         hUfegvmYvdCE211kxJDqH3J54QRitYAaN845R4Hc=
Date:   Fri, 2 Jun 2023 08:40:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     andy.shevchenko@gmail.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <2023060209-scouts-affection-f54d@gregkh>
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
 <ZHkQDTvk6I2q-9CF@surfacebook>
 <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 08:51:50AM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> CC GregKH
> 
> On Thu, Jun 1, 2023 at 11:40 PM <andy.shevchenko@gmail.com> wrote:
> > Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang kirjoitti:
> > > This is a sloppy logic analyzer using GPIOs. It comes with a script to
> > > isolate a CPU for polling. While this is definitely not a production
> > > level analyzer, it can be a helpful first view when remote debugging.
> > > Read the documentation for details.
> >
> > One note since I have done recent review and realize one issue with debugfs.
> >
> > ...
> >
> > > +     priv->debug_dir = debugfs_create_dir(devname, gpio_la_poll_debug_dir);
> >
> > If this fails with NULL...
> >
> > > +     debugfs_create_blob("meta_data", 0400, priv->debug_dir, &priv->meta);
> > > +     debugfs_create_ulong("delay_ns", 0600, priv->debug_dir, &priv->delay_ns);
> > > +     debugfs_create_ulong("delay_ns_acquisition", 0400, priv->debug_dir, &priv->acq_delay);
> > > +     debugfs_create_file_unsafe("buf_size", 0600, priv->debug_dir, priv, &fops_buf_size);
> > > +     debugfs_create_file_unsafe("capture", 0200, priv->debug_dir, priv, &fops_capture);
> > > +     debugfs_create_file_unsafe("trigger", 0200, priv->debug_dir, priv, &fops_trigger);
> >
> > ...and any of these is not, we will end up with the file in a root folder of debugfs...
> >
> > > +     dev_info(dev, "initialized");

Nit, please remove this line.  Drivers are quiet when they work
properly, don't add to a mess in the kernel log.

> > ...
> >
> > > +static int gpio_la_poll_remove(struct platform_device *pdev)
> > > +{
> > > +     struct gpio_la_poll_priv *priv = platform_get_drvdata(pdev);
> > > +
> > > +     mutex_lock(&priv->lock);
> > > +     debugfs_remove_recursive(priv->debug_dir);
> >
> > ...and this one won't remove it.
> >
> > > +     mutex_unlock(&priv->lock);
> > > +     mutex_destroy(&priv->lock);
> > > +
> > > +     return 0;
> > > +}
> >
> > ...
> >
> > However, I haven't checked if it's pure theoretical issue with the current code
> > base of debugfs or a potential problem. Easy fix is to check an error code and
> 
> I think debugfs_create_dir() can only fail reasonably due to OOM.
> 
> > skip the files creation. Not sure if driver will be useful in that case.
> 
> Having to add such error checks would really be unfortunate, because
> one of the design principles of debugfs is that there is never a need
> to check for errors.

If you really want, you can check the return value of the directory
creation and just return and keep going forward (do NOT propagate an
error upwards as drivers need to keep working if debugfs is hosed).

But really, the only way the call can fail is if you did something wrong
and tried to create a directory that was already there, so don't even
worry about checking the return value, all is fine.

thanks,

greg k-h
