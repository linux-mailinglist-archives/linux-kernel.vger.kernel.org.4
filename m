Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8662E6C0E08
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCTKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCTKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:03:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67FDEF87;
        Mon, 20 Mar 2023 03:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E63EB80DB6;
        Mon, 20 Mar 2023 10:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDB5C4339E;
        Mon, 20 Mar 2023 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679306551;
        bh=m+dT1Fldxa66anQiAD5chZaxSHfu7R3YXUoFLoVhDDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zf63xN9WAa4njasw9U//z79z4OPMwYhDas2HJ2C+xnMNEwv9SDncJMlRDc4OOdsvK
         PD9B4qA9rlDO3XdgiBeiQBOTE2ZukuLPNAnKZLaaFokbuomAiMTMMYhPEdLuntktuI
         ZtU2/TYp1KErZN4931crJCph8+GEUor5mFxQWxnA=
Date:   Mon, 20 Mar 2023 11:02:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jui Chang Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH] usb: xhci: tegra: fix sleep in atomic call
Message-ID: <ZBgvNEaRWK56gC3i@kroah.com>
References: <20230320074028.186282-1-haotienh@nvidia.com>
 <ZBgU0GtLAVdaBQQ1@kroah.com>
 <1ba86b0d74344459188a85c46bdcfbcb8cb3e8f2.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba86b0d74344459188a85c46bdcfbcb8cb3e8f2.camel@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:54:28AM +0000, Haotien Hsu wrote:
> On Mon, 2023-03-20 at 09:09 +0100, Greg Kroah-Hartman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Mar 20, 2023 at 03:40:28PM +0800, Haotien Hsu wrote:
> > > From: Wayne Chang <waynec@nvidia.com>
> > > 
> > > When we set the OTG port to Host mode, we observed the following
> > > splat:
> > > [  167.057718] BUG: sleeping function called from invalid context
> > > at
> > > include/linux/sched/mm.h:229
> > > [  167.057872] Workqueue: events tegra_xusb_usb_phy_work
> > > [  167.057954] Call trace:
> > > [  167.057962]  dump_backtrace+0x0/0x210
> > > [  167.057996]  show_stack+0x30/0x50
> > > [  167.058020]  dump_stack_lvl+0x64/0x84
> > > [  167.058065]  dump_stack+0x14/0x34
> > > [  167.058100]  __might_resched+0x144/0x180
> > > [  167.058140]  __might_sleep+0x64/0xd0
> > > [  167.058171]  slab_pre_alloc_hook.constprop.0+0xa8/0x110
> > > [  167.058202]  __kmalloc_track_caller+0x74/0x2b0
> > > [  167.058233]  kvasprintf+0xa4/0x190
> > > [  167.058261]  kasprintf+0x58/0x90
> > > [  167.058285]  tegra_xusb_find_port_node.isra.0+0x58/0xd0
> > > [  167.058334]  tegra_xusb_find_port+0x38/0xa0
> > > [  167.058380]  tegra_xusb_padctl_get_usb3_companion+0x38/0xd0
> > > [  167.058430]  tegra_xhci_id_notify+0x8c/0x1e0
> > > [  167.058473]  notifier_call_chain+0x88/0x100
> > > [  167.058506]  atomic_notifier_call_chain+0x44/0x70
> > > [  167.058537]  tegra_xusb_usb_phy_work+0x60/0xd0
> > > [  167.058581]  process_one_work+0x1dc/0x4c0
> > > [  167.058618]  worker_thread+0x54/0x410
> > > [  167.058650]  kthread+0x188/0x1b0
> > > [  167.058672]  ret_from_fork+0x10/0x20
> > > 
> > > The function tegra_xusb_padctl_get_usb3_companion eventually calls
> > > tegra_xusb_find_port and this in turn calls kasprintf which might
> > > sleep
> > > and so cannot be called from an atomic context.
> > > 
> > > Fix this by moving the call to tegra_xusb_padctl_get_usb3_companion
> > > to
> > > the tegra_xhci_id_work function where it is really needed.
> > > 
> > > Signed-off-by: Wayne Chang <waynec@nvidia.com>
> > > Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> > 
> > What commit id does this fix?  And does it need to be backported to
> > older kernels?
> > 
> 
> Sorry for missing "Fixes:" and "Cc: stable" lines.

What should be listed for the Fixes line?  Please add it when you
resubmit it.

thanks,

greg k-h
