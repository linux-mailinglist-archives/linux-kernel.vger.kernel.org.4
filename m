Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7996ABA82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCFJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCFJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:57:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D723867;
        Mon,  6 Mar 2023 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678096670; x=1709632670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zw8ACHBTfBKbkV3WdWBT9lNUpXLLqnmCovTf6wdsoF0=;
  b=J2L7EQU1oppjFA4+1BmVMejekS9dgMEEt9NP6sYssNDAb4GiRIDJiyWj
   TgOyfZ6Oo60vmljF9XiEdgx7tGxjCHP8AWSU1/LlTRsew9fxPlBEYAq/N
   zbMmgMX8/uE5fZdU3bKhFEaM3Zq4ihYg4e9Jybq/GFSNhEdkz4v/HWQTs
   v8ICxDd6jlaWtGv0qKdrGL9qrbXEE2uj7YwlZkTZdrs+PofExemwtrIJ3
   vNIqE7ZrTrmcm43DP0RR4d/uN2QhhtbhSTRcGigpkUsm1Tv4PsBgH/LlV
   HVwVHsTPTzimB25DYolEdT4fuuaHbiujgJQzT/JFo3krSzb9iqYDyMmtO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="319342835"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="319342835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="740270615"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="740270615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2023 01:57:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 831B1143; Mon,  6 Mar 2023 11:57:53 +0200 (EET)
Date:   Mon, 6 Mar 2023 11:57:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-usb@vger.kernel.org, Sanju.Mehta@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD USB4
 routers
Message-ID: <20230306095753.GD62143@black.fi.intel.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230223210743.9819-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Thu, Feb 23, 2023 at 03:07:40PM -0600, Mario Limonciello wrote:
> TBT3 devices when connected to an AMD USB4 router occasionally fail to
> properly respond to requests for the DROM via bit banging.
> 
> Depending upon which part of the request failed will impact the severity.
> A number of workarounds have been put in place to let the driver handle
> the failed requests:
> 
> commit e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure scenarios")
> commit a283de3ec646f ("thunderbolt: Do not resume routers if UID is not set")
> commit 6915812bbd109 ("thunderbolt: Do not make DROM read success compulsory")
> commit f022ff7bf377 ("thunderbolt: Retry DROM read once if parsing fails")
> 
> Still even with these changes the failures do make it through. In comparing
> other CM implementations utilized on AMD systems, they all access the
> DROM directly from the NVM.
> 
> To avoid triggering this issue, try to get the DROM directly from the NVM
> in Linux as well when devices have an LC.
> 
> v4:
>  * Style fixups
>  * Fixup for wrong path for USB4 devices
> 
> Mario Limonciello (3):
>   thunderbolt: Adjust how NVM reading works
>   thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
>   thunderbolt: Refactor DROM reading

I split the device side into a separate function too, renamed root
switch to host router (as that's the correct USB4 term), and fixed a
couple style issues and applied to thunderbolt.git/next, thanks!

Please check that I did not mess up anything :)
