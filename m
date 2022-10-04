Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BF5F3C52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJDFD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDFDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:03:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3D1F62F;
        Mon,  3 Oct 2022 22:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664859833; x=1696395833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kviKUqiT8pBeVsCDEFp0UnRDN3zB0t0iniuXt9pOE1s=;
  b=E1AMY3Gh75iUL+th6zFD5rhkXVRkWBAVRabzwzAK24uJFvxnvWS5odpQ
   OmJyOHfeMHfxJJD/XzKs4GqXgqQdu1oHpMIBwtPbywGpgK5/2hGRyODWF
   6GG5UssX/K4ZgURyP4M0t7SSbIoc00JUXEUJ3gxO1utv40YSsONPh6zPA
   hPSjAVm9ZAxgAmcBGbgv6g+jvO8FxeTBJr75s3T5Bq1NvLofEA35VKiS3
   rFAfZalUL76Nlp2RGQvJdolzkwkPgU+1642Q8QsoXT1dUJMQGKu0GWXCj
   6aF9rLg9uILhzpV+jjsBwnDSq/DS9Rxh7fH/e6P7fvQMaahkpfIpU9/lF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302807976"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="302807976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 22:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="626054280"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="626054280"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2022 22:03:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F3CE8D0; Tue,  4 Oct 2022 08:04:10 +0300 (EEST)
Date:   Tue, 4 Oct 2022 08:04:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [RFC 1/3] thunderbolt: Allow XHCI device links to enter runtime
 pm
Message-ID: <Yzu+yq07pIfpEbnG@black.fi.intel.com>
References: <20221004041225.1462336-1-mario.limonciello@amd.com>
 <20221004041225.1462336-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004041225.1462336-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Mon, Oct 03, 2022 at 11:12:23PM -0500, Mario Limonciello wrote:
> Both on Intel's and AMD's USB4 designs it's important that the device
> link to the XHCI controller used for tunneling is able to go into D3
> for appropriate low power consumption features as well as for system
> suspend states such as s0i3.
> 
> Historically this is accomplished by adding to a hardcoded list in the
> XHCI driver, but this requires a change for every single platform.
> 
> We have a very good proxy that it's safe to do this since the firmware
> has indicated the device link needs to be made.  So opt all XHCI
> controllers with these device links into runtime PM.

This is good idea.

However, it misses the fact that we have FW CM as well in Intel
integrated TBT platforms (ICL, TGL and ADL) and with those you don't
have the device link (I think ADL has it for both, though) so we would
still need to keep the list in xHCI.
