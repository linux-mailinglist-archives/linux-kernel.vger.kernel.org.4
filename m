Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FD62C653
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiKPR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiKPR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:26:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D82BD7;
        Wed, 16 Nov 2022 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668619586; x=1700155586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o1iIaX+edOL6x2mU3GukuAAteHiHRtQuPyP7zogbaFQ=;
  b=iSukFpOmJUGShJ/Z/jlF+2beYmcwuL9uldQNZKv/AF8N4zw1pTjLLpc9
   iTEskiFXF4smuxkB/qmyTLYeXjA1hbkZnDwl6sgjlZY9fypBEqcS546f0
   1gK86SVdL9Fu3Bw2aF4AcZcmP09o9vMjCfIxd0lUny5QiYMN+AVBgXhAx
   tlyQvA1xbil226UsyhfIK1D01974Me5RFmBTSzNxofF3cbnHhi9V7YS0l
   px1mWbckg3iSm4jTMFhyDY2EBgvVAwklZ4TuI/C8dem/mZJr/q/i13RwN
   URmGXGyJVKDp8o/CQswuzFbBAcRzqSCDtz2ZECKKtq+mHmhswKgfgQkrL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313759160"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313759160"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:26:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617253213"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617253213"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:26:21 -0800
Date:   Wed, 16 Nov 2022 09:26:19 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH v2 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Message-ID: <Y3UdO8/oaEnlEk7s@agluck-desk3.sc.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-10-jithu.joseph@intel.com>
 <Y253FKtLnmV3r7Kj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y253FKtLnmV3r7Kj@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:23:48PM +0100, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 02:53:18PM -0800, Jithu Joseph wrote:
> >  static int scan_chunks_sanity_check(struct device *dev)
> >  {
> > -	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
> >  	struct ifs_data *ifsd = ifs_get_data(dev);
> > +	int curr_pkg, cpu, ret = -ENOMEM;
> >  	bool *package_authenticated;
> >  	struct ifs_work local_work;
> > -	char *test_ptr;
> >  
> >  	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> >  	if (!package_authenticated)
> >  		return ret;
> 
> Bah, how big is that thing so that you can't simply do a bitfield on the
> stack here instead of kcalloc-ing?

Kernel is built with gcc options that prevent a variable sized local
array. So:

	DECLARE_BITMAP(auth, topology_max_packages());

grumbles:

drivers/platform/x86/intel/ifs/load.c:196:2: warning: ISO C90 forbids variable length array ‘ifs_auth2’ [-Wvla]

We could pick a likely big enough static number:

#define MAX_SUPPORTED_PACKAGES	128

	DECLARE_BITMAP(auth, MAX_SUPPORTED_PACKAGES);

and error out of this code if SGI or someone build a monster machine:

	if (topology_max_packages() > MAX_SUPPORTED_PACKAGES) {
		pr_error_once("IFS driver needs update to support this machine\n");
		return -E2BIG;
	}

That avoids the kcalloc() and making sure to kfree() in all error paths.

But seems a bit hacky.  Other ideas?

-Tony
