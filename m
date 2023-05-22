Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6270C346
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjEVQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEVQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1FFD;
        Mon, 22 May 2023 09:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC3F619D3;
        Mon, 22 May 2023 16:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C88C433EF;
        Mon, 22 May 2023 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684772807;
        bh=+QBgGjkSmT8IRp213R2vBwO0H73ayKuAs2FpmTLOpZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxrHeBumrrNbQQx/qlTcvAWuJT/nue/NAARfPjVnh2vHGeozCHZeTDBc9D2fl3lba
         fUqUbwyPSSUvAb0RgTdGN7itd6UpYdYhn2WgelZaDgksdoSjwfhBZpOk55DzSK36mQ
         nS70+0/UHNHwsaEKttRM3eajXI7AtC9J8FXKBvJI=
Date:   Mon, 22 May 2023 17:26:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023052215-skilled-polygraph-33dd@gregkh>
References: <20230522070343.3675581-1-rajat.khandelwal@linux.intel.com>
 <2023052216-railway-zipfile-680f@gregkh>
 <ab993b87-8475-7c71-f526-da9a0b5fa3a8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab993b87-8475-7c71-f526-da9a0b5fa3a8@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:24:13PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> On 5/22/2023 1:07 PM, Greg KH wrote:
> > On Mon, May 22, 2023 at 12:33:43PM +0530, Rajat Khandelwal wrote:
> > > IOM status has a crucial role during debugging to check the
> > > current state of the type-C port.
> > > There are ways to fetch the status, but all those require the
> > > IOM port status offset, which could change with platform.
> > > 
> > > Make a debugfs directory for intel_pmc_mux and expose the status
> > > under it per port basis.
> > > 
> > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > > 
> > > v4:
> > > 1. Maintain a root directory for PMC module and incorporate devices
> > > under it
> > > 2. Add the debugfs module under '/sys/kernel/debug/usb'
> > > 3. Use the platform device 'pmc->dev' to assign the device's name
> > > 
> > > v3: Allocate the debugfs directory name for the platform device with
> > > its ACPI dev name included
> > > 
> > > v2:
> > > 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
> > > 2. Remove explicitly defined one-liner functions
> > > 
> > >   drivers/usb/typec/mux/intel_pmc_mux.c | 54 ++++++++++++++++++++++++++-
> > >   1 file changed, 53 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > index 34e4188a40ff..f400094c76f2 100644
> > > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > @@ -15,6 +15,8 @@
> > >   #include <linux/usb/typec_mux.h>
> > >   #include <linux/usb/typec_dp.h>
> > >   #include <linux/usb/typec_tbt.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/usb.h>
> > >   #include <asm/intel_scu_ipc.h>
> > > @@ -143,8 +145,14 @@ struct pmc_usb {
> > >   	struct acpi_device *iom_adev;
> > >   	void __iomem *iom_base;
> > >   	u32 iom_port_status_offset;
> > > +
> > > +#ifdef CONFIG_DEBUG_FS
> > > +	struct dentry *dentry;
> > > +#endif
> > No need for the #ifdef anymore, right?  In fact, I think it will break
> > the build if you have it this way and CONFIG_DEBUG_FS is not enabled,
> > right?
> 
> I guess you're right. Maybe it'd have been fine if the rest of the
> debugfs stuff was also enclosed within the conditional macros.

Which is not needed and not good kernel coding style, so it's right that
they are not there.

> Anyways, removing it seems appropriate now.
> 
> Also, is it OK to send you v5 on the public list directly?

Where else would you send it?

confused,

greg k-h
