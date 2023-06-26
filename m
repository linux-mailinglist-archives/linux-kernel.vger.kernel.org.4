Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697E73D90A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjFZIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7383
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E1B60AF3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5142AC433C0;
        Mon, 26 Jun 2023 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687766441;
        bh=hKiV/WwYl3DxovukHZrT5iE9tPCMqgKS1pslSEaZlPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/m36xCa94mTESoY+9sDnJQsZnr6LxV+XbpITivos/n0cT4sF7ZFD9cdM9cB/EVdd
         XnG22WpvkpqZPQkBoU+0bxEZgslNIjgczTZ9jOlQC7irtznCNvkDkJSiAEdqfA8Jxb
         x28dZrnM295VTOsociQbekQXTdGnKKQf8/Ror33c=
Date:   Mon, 26 Jun 2023 10:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
Subject: Re: [PATCH v2] cdx: add MSI support for CDX bus
Message-ID: <2023062612-navigate-hyphen-6fc7@gregkh>
References: <20230518114418.18025-1-nipun.gupta@amd.com>
 <ffb49486-4e29-a44d-97f6-18fea5386ba1@amd.com>
 <d866dba9-3b0f-3573-9baf-0d02f4049fcb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d866dba9-3b0f-3573-9baf-0d02f4049fcb@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:23:27PM +0530, Nipun Gupta wrote:
> 
> 
> On 6/6/2023 4:32 PM, Nipun Gupta wrote:
> > 
> > 
> > On 5/18/2023 5:14 PM, Nipun Gupta wrote:
> > > Add CDX-MSI domain per CDX controller with gic-its domain as
> > > a parent, to support MSI for CDX devices. CDX devices allocate
> > > MSIs from the CDX domain. Also, introduce APIs to alloc and free
> > > IRQs for CDX domain.
> > > 
> > > In CDX subsystem firmware is a controller for all devices and
> > > their configuration. CDX bus controller sends all the write_msi_msg
> > > commands to firmware running on RPU and the firmware interfaces with
> > > actual devices to pass this information to devices
> > > 
> > > Since, CDX controller is the only way to communicate with the Firmware
> > > for MSI write info, CDX domain per controller required in contrast to
> > > having a CDX domain per device.
> > > 
> > > Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> > > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > ---
> > > 
> > > Changes v1->v2:
> > > - fixed scenario where msi write was called asyncronously in
> > >    an atomic context, by using irq_chip_(un)lock, and using sync
> > >    MCDI API for write MSI message.
> > > - fixed broken Signed-off-by chain.
> > 
> > Hi Thomas,
> > 
> > Did you had a chance to look at patch v2. Please let me know in case
> > anything else is required to be updated.
> 
> Hi Thomas,
> 
> A gentle reminder, could you please have a look into this updated version of
> the patch?

It's the middle of the merge window, nothing we can do now with new
stuff.  Perhaps resend it after 6.5-rc1 is out and you have rebased it
against that release?

thanks,

greg k-h
