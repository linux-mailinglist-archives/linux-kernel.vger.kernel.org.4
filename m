Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB516E5E78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjDRKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDRKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96B72A9;
        Tue, 18 Apr 2023 03:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC526246F;
        Tue, 18 Apr 2023 10:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F932C433D2;
        Tue, 18 Apr 2023 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681813111;
        bh=f7WQeUPr7EZ2TV3v82hvL9dpcq4Mo3m/octT6SzdFMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9zynw61gpDZqZz5uHtZLFmLsoygm5NLmioBjBUfHB9PjxmJWqR1xCp8sDtjFhBhG
         oKDpA9Ioyg6YERaEY8tvKS7bNFWhluJL6gC9QYPYUjVBq75xsDphaUdZJDAKuOFVuP
         hjxpQqnxEPq/AKCuzr+RP7HMZEe7i7a4FJ1QLvDE=
Date:   Tue, 18 Apr 2023 12:18:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023041859-humpback-thespian-e28c@gregkh>
References: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
 <ZDo2mzmjZpWIKbxk@kroah.com>
 <2c960f0c-5cbb-4c2d-07cb-dafd94d22414@linux.intel.com>
 <ZDzjVG7QZP1z9gNX@kroah.com>
 <20cc057d-6b2b-5fc1-524f-c2c579c96a6b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cc057d-6b2b-5fc1-524f-c2c579c96a6b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:10:47PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> On 4/17/2023 11:42 AM, Greg KH wrote:
> > On Mon, Apr 17, 2023 at 11:28:18AM +0530, Rajat Khandelwal wrote:
> > > Hi,
> > > 
> > > On 4/15/2023 11:01 AM, Greg KH wrote:
> > > > On Fri, Apr 14, 2023 at 01:49:10PM +0530, Rajat Khandelwal wrote:
> > > > > IOM status has a crucial role during debugging to check the
> > > > > current state of the type-C port.
> > > > > There are ways to fetch the status, but all those require the
> > > > > IOM port status offset, which could change with platform.
> > > > > 
> > > > > Make a debugfs directory for intel_pmc_mux and expose the status
> > > > > under it per port basis.
> > > > > 
> > > > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > > > ---
> > > > > 
> > > > > v2:
> > > > > 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
> > > > > 2. Remove explicitly defined one-liner functions
> > > > > 
> > > > >    drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
> > > > >    1 file changed, 34 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > index 34e4188a40ff..1d43b111781e 100644
> > > > > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > @@ -15,6 +15,7 @@
> > > > >    #include <linux/usb/typec_mux.h>
> > > > >    #include <linux/usb/typec_dp.h>
> > > > >    #include <linux/usb/typec_tbt.h>
> > > > > +#include <linux/debugfs.h>
> > > > >    #include <asm/intel_scu_ipc.h>
> > > > > @@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
> > > > >    	return 0;
> > > > >    }
> > > > > +static int port_iom_status_show(struct seq_file *s, void *unused)
> > > > > +{
> > > > > +	struct pmc_usb_port *port = s->private;
> > > > > +
> > > > > +	update_port_status(port);
> > > > > +	seq_printf(s, "0x%08x\n", port->iom_status);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +DEFINE_SHOW_ATTRIBUTE(port_iom_status);
> > > > > +
> > > > > +static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
> > > > > +				      struct dentry *pmc_mux_debugfs_root)
> > > > > +{
> > > > > +	struct dentry *debugfs_dir;
> > > > > +	char name[6];
> > > > > +
> > > > > +	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
> > > > > +
> > > > > +	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
> > > > > +	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
> > > > > +			    &port_iom_status_fops);
> > > > > +}
> > > > > +
> > > > >    static int pmc_usb_probe(struct platform_device *pdev)
> > > > >    {
> > > > >    	struct fwnode_handle *fwnode = NULL;
> > > > > +	struct dentry *pmc_mux_debugfs_root;
> > > > >    	struct pmc_usb *pmc;
> > > > >    	int i = 0;
> > > > >    	int ret;
> > > > > @@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
> > > > >    	if (ret)
> > > > >    		return ret;
> > > > > +	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
> > > > What happens when you have more than one device in the system at the
> > > > same time?
> > > I'm sorry I didn't understand the question. We would have separate directories
> > > for all the ports which would contain the 'iom_status' file, thus representing
> > > status for all the ports individually.
> > > Can you rephrase the question since I guess you had something else in mind?
> > Can you please show the output of the directory
> > /sys/kernel/debug/intel_pmc_mux/ with multiple pmc devices in the system
> > at the same time?
> 
> Sorry, I don't own a system with multiple PMCs. Anyways, do we even have
> a system with such design?

You might tomorrow.  So please don't create problems like this when you
do not have to.

greg k-h
