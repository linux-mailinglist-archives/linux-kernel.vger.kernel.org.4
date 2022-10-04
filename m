Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A075F4380
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJDMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJDMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:48:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0E28736;
        Tue,  4 Oct 2022 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664887618; x=1696423618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1JT9ySOAxREkl5rVt755tp0Zdidwg6Ck2XOSD5c+gW8=;
  b=X3ROUXABLpQZbISb63l0tm93QT7xodF7Ijn1RuOU7CPlOvzv0stD1bOr
   6YKyZxHTunArMvK4Gki1SdZxKiOMOW7eBQCiD/JzBAASGH0j60BNywYlh
   auMgbaysf6UuL3gVvRA/l70+VCIvf9lClKe5HvoznbqOgHidIAoxKO2Ka
   r3DDGmHMztvuPUUz8qAQelefFUuWzMINxku0zj2GM7ZZp+Pd9X6BXwPLv
   dtdAqKfByC4K6V/of7OuBK+ViWQdFInvaIi1laKR40hFGfwDIV7xRMEHA
   ZV7ME+hI/SEVno9waz7890y5Nf3hXOH0cLgtD93vYNsoQoJf3O86ePker
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="283267142"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="283267142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 05:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="575016238"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="575016238"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 05:46:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 64E0317E; Tue,  4 Oct 2022 15:46:55 +0300 (EEST)
Date:   Tue, 4 Oct 2022 15:46:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [RFC 1/3] thunderbolt: Allow XHCI device links to enter runtime
 pm
Message-ID: <YzwrP7O/jTj/pyYI@black.fi.intel.com>
References: <20221004041225.1462336-1-mario.limonciello@amd.com>
 <20221004041225.1462336-2-mario.limonciello@amd.com>
 <Yzu+yq07pIfpEbnG@black.fi.intel.com>
 <d2e853fe-6e58-0056-ba3b-d04a2f97c6f1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e853fe-6e58-0056-ba3b-d04a2f97c6f1@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:38:47AM -0500, Limonciello, Mario wrote:
> On 10/4/2022 00:04, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Mon, Oct 03, 2022 at 11:12:23PM -0500, Mario Limonciello wrote:
> > > Both on Intel's and AMD's USB4 designs it's important that the device
> > > link to the XHCI controller used for tunneling is able to go into D3
> > > for appropriate low power consumption features as well as for system
> > > suspend states such as s0i3.
> > > 
> > > Historically this is accomplished by adding to a hardcoded list in the
> > > XHCI driver, but this requires a change for every single platform.
> > > 
> > > We have a very good proxy that it's safe to do this since the firmware
> > > has indicated the device link needs to be made.  So opt all XHCI
> > > controllers with these device links into runtime PM.
> > 
> > This is good idea.
> > 
> > However, it misses the fact that we have FW CM as well in Intel
> > integrated TBT platforms (ICL, TGL and ADL) and with those you don't
> > have the device link (I think ADL has it for both, though) so we would
> > still need to keep the list in xHCI.
> 
> Can you double check the firmware for ADL for me whether it has it for both?
> I'll respin the series and drop at least the ICL and TGL reverts from patch

Yes, ADL has it for both.

While doing that, I wonder if it would be easier to understand (and
follow) if all this is done in the xHCI side? It can also look for the
property and unblock runtime PM based on that.
