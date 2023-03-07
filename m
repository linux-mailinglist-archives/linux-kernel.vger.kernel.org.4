Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04D6AD911
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCGISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCGISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:18:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D344FF1A;
        Tue,  7 Mar 2023 00:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678177068; x=1709713068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rQ2uMWsh8WrWEidiSFRwazqpAR3clxkIu/TXsSQtLE=;
  b=W4zQXqPmTqES1FRayB6elIONp6ObDQK+vZJLZ6Icls56gMxUO/xHyDdg
   7hgA5isQFU9xRmEI8/B8OkAgY36Psc0WukVjIAHRz7Vz0X95gxy3KAzhU
   XDbrwCtnc/e7ZRVe9HDN9EfBCKSv8vrsAz0PpssVtYlqm7r5dT0Uac+KS
   q1w+90poy/jSe20LC3L3jjEwCi+e7dc5lowUb4EoEubjkagn7PqhgHmg3
   2PH1RcLaq8YoBSBGbiqu9c2B0PksqPBuU88YdmuVAshiNpp2O08mfuoPQ
   8sN0igslCz27DtYjzKdZmM0ts5oFYcD2FvZocriT1E5rvqvCvh3FmiCeE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="338118576"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="338118576"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="740635618"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="740635618"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2023 00:17:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 81DDC14F; Tue,  7 Mar 2023 10:18:28 +0200 (EET)
Date:   Tue, 7 Mar 2023 10:18:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD USB4
 routers
Message-ID: <20230307081828.GI62143@black.fi.intel.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
 <20230306095753.GD62143@black.fi.intel.com>
 <MN0PR12MB6101C93AC579DB2E23952D83E2B69@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101C93AC579DB2E23952D83E2B69@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 06, 2023 at 03:14:07PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Monday, March 6, 2023 03:58
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: linux-usb@vger.kernel.org; Mehta, Sanju <Sanju.Mehta@amd.com>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD
> > USB4 routers
> > 
> > Hi Mario,
> > 
> > On Thu, Feb 23, 2023 at 03:07:40PM -0600, Mario Limonciello wrote:
> > > TBT3 devices when connected to an AMD USB4 router occasionally fail to
> > > properly respond to requests for the DROM via bit banging.
> > >
> > > Depending upon which part of the request failed will impact the severity.
> > > A number of workarounds have been put in place to let the driver handle
> > > the failed requests:
> > >
> > > commit e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure
> > scenarios")
> > > commit a283de3ec646f ("thunderbolt: Do not resume routers if UID is not
> > set")
> > > commit 6915812bbd109 ("thunderbolt: Do not make DROM read success
> > compulsory")
> > > commit f022ff7bf377 ("thunderbolt: Retry DROM read once if parsing fails")
> > >
> > > Still even with these changes the failures do make it through. In comparing
> > > other CM implementations utilized on AMD systems, they all access the
> > > DROM directly from the NVM.
> > >
> > > To avoid triggering this issue, try to get the DROM directly from the NVM
> > > in Linux as well when devices have an LC.
> > >
> > > v4:
> > >  * Style fixups
> > >  * Fixup for wrong path for USB4 devices
> > >
> > > Mario Limonciello (3):
> > >   thunderbolt: Adjust how NVM reading works
> > >   thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
> > >   thunderbolt: Refactor DROM reading
> > 
> > I split the device side into a separate function too, renamed root
> > switch to host router (as that's the correct USB4 term), and fixed a
> > couple style issues and applied to thunderbolt.git/next, thanks!
> > 
> > Please check that I did not mess up anything :)
> 
> They look good, thanks!

Thanks for checking!

> Would you consider to take 8d7f459107f74fbbdde3dd5b3874d2e748cb8a21 to
> the RC though, or would prefer to let it bake in next?

I would like to keep it too in next just to make sure nothing breaks
accidentally.
