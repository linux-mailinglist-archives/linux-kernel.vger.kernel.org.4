Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9472F7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbjFNIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbjFNIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:37:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874DD19AC;
        Wed, 14 Jun 2023 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686731821; x=1718267821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMum+gjal/9wA31JowjRQ84WyffkULU6yDKWFn84QpM=;
  b=DvOrxpXWkuBZTKZvUZrfXcx0BpI9wDyjGyPs97k72AfhMhNXUXSySKgy
   RVXYvUAtMWOECt5XnQ22lyyqKri6pu3+qcMnaDWwSDfSs6WC17z4gwwNg
   Ohx4NQc1fgfQ3hCST8pwq//0k0eX/54JTdk+slas3/onRY4n9irmhl2jX
   mxpwnGmjGankEBs3SSYFD7dNqefpovu08x/bIIAC5zby1VceH4fQPVTFo
   /qRao4w7hrtY/XA6/wKmcG5W0Ww0NtiKiUqkGD/INQUGZv4x0M8UPXaEy
   dl0INr+/GYT/sBU/HUc0WXhXjbtBSYANtUkEBauZiOvpMSaB2K3mWXlVF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338909360"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="338909360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856423301"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="856423301"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2023 01:36:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Jun 2023 11:36:57 +0300
Date:   Wed, 14 Jun 2023 11:36:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <ZIl8KeaePdKHCnVY@kuha.fi.intel.com>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZIhOm5LKwn+YVGzT@kuha.fi.intel.com>
 <73854744-03ef-2c5c-a5d6-284f004a5497@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73854744-03ef-2c5c-a5d6-284f004a5497@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:55:10AM +0530, Prashanth K wrote:
> 
> 
> On 13-06-23 04:40 pm, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Wed, May 31, 2023 at 08:11:14PM +0530, Prashanth K wrote:
> > > Currently if we bootup a device without cable connected, then
> > > usb-conn-gpio won't call set_role() since last_role is same as
> > > current role. This happens because during probe last_role gets
> > > initialised to zero.
> > > 
> > > To avoid this, added a new constant in enum usb_role, last_role
> > > is set to USB_ROLE_UNKNOWN before performing initial detection.
> > 
> > So why can't you fix this by just always setting the role
> > unconditionally to USB_ROLE_NONE in your probe function before the
> > initial detection?
> > 
> Hi Heikki, thats exactly what we are doing here.
> 
> +	/* Set last role to unknown before performing the initial detection */
> +	info->last_role = USB_ROLE_UNKNOWN;

No, I'm asking why can't you just call set_role(USB_ROLE_NONE)
(together with any other steps that you need to take in order to fix
you issue) directly from your probe function?

That USB_ROLE_UNKNOWN as a global is not acceptable - there is no
difference between USB_ROLE_UNKNOWN and USB_ROLE_NONE from the role
switch PoW. So if you want to use something like that, you have to
confine it to your driver.

But I honestly don't think you need it at all. You should be able to
refactor your driver in order to solve the issue described in the
commit message without any need for it.

Note! I just realised that you are not modifying
drivers/usb/roles/class.c, so this patch is actually broken.

thanks,

-- 
heikki
