Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB785E6132
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiIVLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIVLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:34:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05269E21D2;
        Thu, 22 Sep 2022 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846466; x=1695382466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtC0bXObJ2zTCLRvIKDIB0E66QUQdLom9U6HVS3krRA=;
  b=bFvWMqxO4W124eGgi5pXXA0ehtnZviGSF+CCHXwvxIu7gOHdDhOq8/Z/
   kq68WKO5U3mU/btFFkpKGzo6+mJNHfBBbEZp8YuZWXSsW6vjznXVVCMP7
   Mm1iCdqI8Oj+NvLhr44+dv9G0DHzahzGR+aLpe2/5Odmcu95H+oMhj7Gk
   LbaPwkH5MGQ/QvwXD/rkOubS8U0CGZXldim5thjdLCbsDjm+koBoSarqP
   n+lYICbflWfrwB/lPdU4ML3evj1k0FuuKJU9bw7YOWxm/36wY/UxAR2wj
   vlSodePlL2AIGa8stIGGGRaIr68WNksAnCVabYSvZCNaiAJIE4Bv3LVEj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364251998"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364251998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570928017"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 04:34:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E2DA7238; Thu, 22 Sep 2022 14:34:40 +0300 (EEST)
Date:   Thu, 22 Sep 2022 14:34:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, sanju.mehta@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix some hotplug event issues
Message-ID: <YyxIUDIZM23tzmhg@black.fi.intel.com>
References: <20220921145434.21659-1-mario.limonciello@amd.com>
 <YysxhSh73nwMC1Kb@kroah.com>
 <6283792d-3c91-0ec2-6f2b-edd647d0de67@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6283792d-3c91-0ec2-6f2b-edd647d0de67@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Sep 21, 2022 at 10:48:17AM -0500, Limonciello, Mario wrote:
> On 9/21/2022 10:45, Greg KH wrote:
> > On Wed, Sep 21, 2022 at 09:54:31AM -0500, Mario Limonciello wrote:
> > > On AMD Pink Sardine it's been observed that if another CM has run before
> > > the Linux CM that some registers may not match expectations which leads
> > > to a non-functional hotplug for PCIe devices.
> > > 
> > > Explicitly set these registers that have been observed to cause problems
> > > with hotplug to the defaults of the USB4 spec.
> > > 
> > > Mario Limonciello (2):
> > >    thunderbolt: Explicitly reset plug events delay back to USB4 spec
> > >      value
> > >    thunderbolt: Explicitly enable lane adapter hotplug events at startup
> > > 
> > >   drivers/thunderbolt/switch.c  |  5 +++++
> > >   drivers/thunderbolt/tb.h      |  1 +
> > >   drivers/thunderbolt/tb_regs.h |  1 +
> > >   drivers/thunderbolt/usb4.c    | 19 +++++++++++++++++++
> > >   4 files changed, 26 insertions(+)
> > 
> > Any specific reason these were not tagged for stable backports?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> No; no particular reason.  If Mika agrees with them, I think they are good
> candidates to include for stable too.  If I respin them, I'll tag
> accordingly.  If Mika picks them up as v1 I think he can add the tag when
> committing them.

I applied the first one to my fixes branch and tagged it for stable. For
the second one, I have a couple of comments that I would like you to
address (sent in a separate email) ;-)

