Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3155ED411
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiI1FAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI1FAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:00:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8839EF6F45;
        Tue, 27 Sep 2022 22:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664341247; x=1695877247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/2zGoQgNymumNYm4rYvWOJ+xjwF2Dtxg4b9qhp4L5A=;
  b=S1UMGYdZU0Xm2uRm/1qdWvZdrCYmzy+PSMcBhPNOqzl1SCKBG8xrrrSL
   TjKdTJ9RmijKwpsQP20wJOJAbE7LYyPleKj0TC397WZHrOhaCoiQxRMpI
   VJIMNR5OBRj6F2cDjQlm/1bPFysweMVdyQ74OHxDDTIOQOAiE+mQBvF87
   bRHOaAGRGP2GCQHW+BbT0hskCvQAWyeVivLfaTTATBhFwIJXlvLRn31Od
   z7Y/Z7L674phzhC3/M7VUiChAgV7h44QkkVqXGFZvr8wj4NDq6aUz9v6Y
   SUtEDSBrQI1Y1ne9ERWbdOCJzGT/AihspyfOp8PKCEeONzdU+FaaIyBYO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327869349"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="327869349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 22:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652538869"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="652538869"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2022 22:00:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AB2C586; Wed, 28 Sep 2022 08:01:03 +0300 (EEST)
Date:   Wed, 28 Sep 2022 08:01:03 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add wake on connect/disconnect on USB4 ports
Message-ID: <YzPVDzI4K4cbG7Mk@black.fi.intel.com>
References: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
 <YzMpaa1V492X52/J@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMpaa1V492X52/J@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Sep 27, 2022 at 06:48:41PM +0200, Greg KH wrote:
> On Wed, Sep 28, 2022 at 06:30:05PM +0530, Rajat Khandelwal wrote:
> > Wake on connect/disconnect is only supported while runtime suspend
> > for now, which is obviously necessary. Its also not inherently
> > desired for the system to wakeup on thunderbolt hot events.
> > However, we can still make user in control of waking up the system
> > in the events of hot plug/unplug.
> > This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> > attribute and only enables wakes on connect/disconnect to the
> > respective port when 'wakeup' is set to 'enabled'. The attribute
> > is set to 'disabled' by default.
> > 
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> 
> Including the issue pointed out below by my bot, Intel has a "special"
> requirement that you are not meeting here in order to send out patches
> for review on a public mailing list in a subsystem like this (i.e. one
> that I and others review patches on.)
> 
> Please meet that requirement first before sending any future kernel
> patches out.

I asked Khandelwal to send this patch upstream after we did an internal
review for it (I think I also asked him to send this out after v6.1-rc1
is released but whatever).

I think the bot noticed the v4 he sent earlier that was the same we
reviewed internally.

I was planning to pick this up after the merge window closes if there
are no objections.
