Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6626E5EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDRKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjDRKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:37:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BB4234;
        Tue, 18 Apr 2023 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681814257; x=1713350257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=olvbMIAds1r3OfML+pqLtKkuDpNWkp+Wct/C4ieNxcI=;
  b=GVH8MV/3vPGmvq09YKu1b97I1oX0/kMeU8L014SD3DPYWdI/X0MGAtYe
   UiUo8fPh3uqwfybhtV0hmpqhb+tTD8HiN0Vt6siW1Y4/7Ow+pqvH6S20Q
   lxRFEnHeJ6AgDGlpklE+4vC3GNSkFqCU6Bhd9IEHyantbFPWwJMYa18fW
   nsz+dW9wuluJSpvq21bSfCt3OI4dLWDZI4dctlqq+Yvmuuf515KjoMWUL
   17r6+iq0YmagABGJ9dqGHni2l38sdqqzimkl5JdZbnzYzrv1xKlWv9BBI
   YIP26pYi/6KjjN3+NvcJyf+Exe2/kz1NaXHK6wToQkwXC9XjPLt0CD3I3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="408034212"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="408034212"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 03:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834837004"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="834837004"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Apr 2023 03:37:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 Apr 2023 13:37:33 +0300
Date:   Tue, 18 Apr 2023 13:37:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <ZD5y7anCaWAiDDGV@kuha.fi.intel.com>
References: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
 <ZDo2mzmjZpWIKbxk@kroah.com>
 <2c960f0c-5cbb-4c2d-07cb-dafd94d22414@linux.intel.com>
 <ZDzjVG7QZP1z9gNX@kroah.com>
 <20cc057d-6b2b-5fc1-524f-c2c579c96a6b@linux.intel.com>
 <2023041859-humpback-thespian-e28c@gregkh>
 <19c137ac-ac95-e6da-27d8-27d9cc8e9e40@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c137ac-ac95-e6da-27d8-27d9cc8e9e40@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:53:46PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> On 4/18/2023 3:48 PM, Greg KH wrote:
> > On Tue, Apr 18, 2023 at 03:10:47PM +0530, Rajat Khandelwal wrote:
> > > Hi,
> > > 
> > > On 4/17/2023 11:42 AM, Greg KH wrote:
> > > > On Mon, Apr 17, 2023 at 11:28:18AM +0530, Rajat Khandelwal wrote:
> > > > > Hi,
> > > > > 
> > > > > On 4/15/2023 11:01 AM, Greg KH wrote:
> > > > > > On Fri, Apr 14, 2023 at 01:49:10PM +0530, Rajat Khandelwal wrote:
> > > > > > > IOM status has a crucial role during debugging to check the
> > > > > > > current state of the type-C port.
> > > > > > > There are ways to fetch the status, but all those require the
> > > > > > > IOM port status offset, which could change with platform.
> > > > > > > 
> > > > > > > Make a debugfs directory for intel_pmc_mux and expose the status
> > > > > > > under it per port basis.
> > > > > > > 
> > > > > > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > v2:
> > > > > > > 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
> > > > > > > 2. Remove explicitly defined one-liner functions
> > > > > > > 
> > > > > > >     drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
> > > > > > >     1 file changed, 34 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > > > index 34e4188a40ff..1d43b111781e 100644
> > > > > > > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > > > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >     #include <linux/usb/typec_mux.h>
> > > > > > >     #include <linux/usb/typec_dp.h>
> > > > > > >     #include <linux/usb/typec_tbt.h>
> > > > > > > +#include <linux/debugfs.h>
> > > > > > >     #include <asm/intel_scu_ipc.h>
> > > > > > > @@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
> > > > > > >     	return 0;
> > > > > > >     }
> > > > > > > +static int port_iom_status_show(struct seq_file *s, void *unused)
> > > > > > > +{
> > > > > > > +	struct pmc_usb_port *port = s->private;
> > > > > > > +
> > > > > > > +	update_port_status(port);
> > > > > > > +	seq_printf(s, "0x%08x\n", port->iom_status);
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +DEFINE_SHOW_ATTRIBUTE(port_iom_status);
> > > > > > > +
> > > > > > > +static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
> > > > > > > +				      struct dentry *pmc_mux_debugfs_root)
> > > > > > > +{
> > > > > > > +	struct dentry *debugfs_dir;
> > > > > > > +	char name[6];
> > > > > > > +
> > > > > > > +	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
> > > > > > > +
> > > > > > > +	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
> > > > > > > +	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
> > > > > > > +			    &port_iom_status_fops);
> > > > > > > +}
> > > > > > > +
> > > > > > >     static int pmc_usb_probe(struct platform_device *pdev)
> > > > > > >     {
> > > > > > >     	struct fwnode_handle *fwnode = NULL;
> > > > > > > +	struct dentry *pmc_mux_debugfs_root;
> > > > > > >     	struct pmc_usb *pmc;
> > > > > > >     	int i = 0;
> > > > > > >     	int ret;
> > > > > > > @@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
> > > > > > >     	if (ret)
> > > > > > >     		return ret;
> > > > > > > +	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
> > > > > > What happens when you have more than one device in the system at the
> > > > > > same time?
> > > > > I'm sorry I didn't understand the question. We would have separate directories
> > > > > for all the ports which would contain the 'iom_status' file, thus representing
> > > > > status for all the ports individually.
> > > > > Can you rephrase the question since I guess you had something else in mind?
> > > > Can you please show the output of the directory
> > > > /sys/kernel/debug/intel_pmc_mux/ with multiple pmc devices in the system
> > > > at the same time?
> > > Sorry, I don't own a system with multiple PMCs. Anyways, do we even have
> > > a system with such design?
> > You might tomorrow.  So please don't create problems like this when you
> > do not have to.
> 
> We still didn't arrive on a culminating note. :)
> What do you suggest I could do for now? This would be a useful debug tool
> for us since we deal with it quite often.
> 
> If we don't have anything constraining this for now, can we keep it like
> this? Let's ameliorate it once such systems actually arrive.
> Suggestions?

You can use the device name. Please check for example how
drivers/usb/typec/tcpm/fusb302.c creates the directory.

thanks,

-- 
heikki
