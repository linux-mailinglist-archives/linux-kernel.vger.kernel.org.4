Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058215ED480
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiI1GIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1GIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:08:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343311E954;
        Tue, 27 Sep 2022 23:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664345280; x=1695881280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0JP+LUSjEf9hakX8vnrL+5YHg+ADJr/BPGofrW28dc=;
  b=kwZdjOkGcV8Yv3Zz6P17oqk6bCFmmMZTWCwbx0qyNsGtPx9stwtjZCqP
   rtUJ8hFFksmi+u/KUJvRxGdnRl/zFDPpnJ9iDzLE18Ta40c9v4KSUDzbV
   rf6/Pl/b0vGecJTSJcx9/6Cv5ae1zi2xUs8w6jMSi7bbDkQo7JSqixXgs
   4XVzBS8UGDDij/BQfc0NbdbLFvPhr7yoLe/MsbGorozg0+E88hfq0Ju+s
   2UwDBhxQ1q+WZ6/9+PssKMgKpWVxkLJkv2TNN7mrz0Cn6AkkqTpct7Qdu
   552o7BIqJtwxq879pbmPSubSg9kWAN9YoVKEAZS2UbIrP+GVHB3KeEpMS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288672221"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="288672221"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 23:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="572912632"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="572912632"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2022 23:07:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CA95DF7; Wed, 28 Sep 2022 09:08:16 +0300 (EEST)
Date:   Wed, 28 Sep 2022 09:08:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add wake on connect/disconnect on USB4 ports
Message-ID: <YzPk0IE3LmSy5lvZ@black.fi.intel.com>
References: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
 <YzMpaa1V492X52/J@kroah.com>
 <YzPVDzI4K4cbG7Mk@black.fi.intel.com>
 <YzPjvo8pkAmO2rra@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPjvo8pkAmO2rra@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:03:42AM +0200, Greg KH wrote:
> On Wed, Sep 28, 2022 at 08:01:03AM +0300, Mika Westerberg wrote:
> > Hi Greg,
> > 
> > On Tue, Sep 27, 2022 at 06:48:41PM +0200, Greg KH wrote:
> > > On Wed, Sep 28, 2022 at 06:30:05PM +0530, Rajat Khandelwal wrote:
> > > > Wake on connect/disconnect is only supported while runtime suspend
> > > > for now, which is obviously necessary. Its also not inherently
> > > > desired for the system to wakeup on thunderbolt hot events.
> > > > However, we can still make user in control of waking up the system
> > > > in the events of hot plug/unplug.
> > > > This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> > > > attribute and only enables wakes on connect/disconnect to the
> > > > respective port when 'wakeup' is set to 'enabled'. The attribute
> > > > is set to 'disabled' by default.
> > > > 
> > > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> > > 
> > > Including the issue pointed out below by my bot, Intel has a "special"
> > > requirement that you are not meeting here in order to send out patches
> > > for review on a public mailing list in a subsystem like this (i.e. one
> > > that I and others review patches on.)
> > > 
> > > Please meet that requirement first before sending any future kernel
> > > patches out.
> > 
> > I asked Khandelwal to send this patch upstream after we did an internal
> > review for it (I think I also asked him to send this out after v6.1-rc1
> > is released but whatever).
> 
> So the correct rules were not followed, please fix that :(

We will, sorry about this.
