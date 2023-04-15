Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30B6E2F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 07:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDOFbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 01:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 01:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9B559E;
        Fri, 14 Apr 2023 22:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEDA60909;
        Sat, 15 Apr 2023 05:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038A2C433D2;
        Sat, 15 Apr 2023 05:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681536670;
        bh=ko6PymeA5xvgjVFiXMholwdBNBxLBMHvW3f+JGVMg9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsldKxdwmlyeV0wzFPQ8hZzSgz3QrSDZkr1AYyjFapTQvp3+NzMM4J+iYK3LrxRbK
         LOiHMxACE0JYLNdIe6qXE/CYXE2tDCMUvagiTVhQ5gKbStoVk8a6zBP/VxcaqRv6eM
         4p3K9C2fEBIqEJZnZnIse5brYIfgiGShlciC3Z5Y=
Date:   Sat, 15 Apr 2023 07:31:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <ZDo2mzmjZpWIKbxk@kroah.com>
References: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:49:10PM +0530, Rajat Khandelwal wrote:
> IOM status has a crucial role during debugging to check the
> current state of the type-C port.
> There are ways to fetch the status, but all those require the
> IOM port status offset, which could change with platform.
> 
> Make a debugfs directory for intel_pmc_mux and expose the status
> under it per port basis.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
> 
> v2:
> 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
> 2. Remove explicitly defined one-liner functions
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 34e4188a40ff..1d43b111781e 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -15,6 +15,7 @@
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_tbt.h>
> +#include <linux/debugfs.h>
>  
>  #include <asm/intel_scu_ipc.h>
>  
> @@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  	return 0;
>  }
>  
> +static int port_iom_status_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_usb_port *port = s->private;
> +
> +	update_port_status(port);
> +	seq_printf(s, "0x%08x\n", port->iom_status);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(port_iom_status);
> +
> +static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
> +				      struct dentry *pmc_mux_debugfs_root)
> +{
> +	struct dentry *debugfs_dir;
> +	char name[6];
> +
> +	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
> +
> +	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
> +	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
> +			    &port_iom_status_fops);
> +}
> +
>  static int pmc_usb_probe(struct platform_device *pdev)
>  {
>  	struct fwnode_handle *fwnode = NULL;
> +	struct dentry *pmc_mux_debugfs_root;
>  	struct pmc_usb *pmc;
>  	int i = 0;
>  	int ret;
> @@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);

What happens when you have more than one device in the system at the
same time?

thanks,

greg k-h
