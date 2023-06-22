Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BF73A419
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFVPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:01:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D901FE3;
        Thu, 22 Jun 2023 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687446073; x=1718982073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oDOGPCCXCPpeOzBEhFuSXa5oGyPeHz5KQj33C5b1S4=;
  b=PrqrFKu+YRpI4r9cp3pYh44ZCOTbj+ij894EFmtzLydxZNnBUyOMjUK5
   I3rsNZ7y3vqfYD7te2/0YSv/rEbzMWvDWUFq7E6ZFGwvyRyxWxZiN4gdY
   2wof+ISi82mn5zfmFacRlODrLtBBFD9/WP+O752S2iquU7nizO5DuF+Ve
   EPuFZVJZ6eoPVAuK7c6gkbmnJL5GZn3kzQD5E8q7LDyzYxKLLqtegUMBJ
   aRKEzmLWYTWo3rWDo776ExmuwLotaJnEECrz77AyDgplAa/muPIAV3c3i
   RNJQ5h5JruRcKYdEmazcoL6IJi2Bpfs/pJlRSNlkjGX5nJvnH/rod7eaq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350265391"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350265391"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 08:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="1045213934"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="1045213934"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 08:00:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCLn5-005nAO-0h;
        Thu, 22 Jun 2023 18:00:07 +0300
Date:   Thu, 22 Jun 2023 18:00:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
Message-ID: <ZJRh9o1a0k0yMbOG@smile.fi.intel.com>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
 <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
 <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
 <ZJQJqHbZy+00qhsz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQJqHbZy+00qhsz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:43:20AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 21, 2023 at 11:50:51PM +0200, Armin Wolf wrote:

...

> I think that WARN_ON() is a bit bogus. First of all, it can be easily
> transformed to BUG()-equivalent with panic_on_oops and hence kill the
> entire system. If we need the message about wrong GUID format, it should
> be done elsewhere (modpost ?). I.o.w. we shan't expect that code,
> controlled by us, shoots to our foot.

Additional info. There will be another driver elsewhere that may use similar
API and also needs GUID in device ID table.

Looking into that implementation it seems that validation should be made in
file2alias.c for WMI and reused by that driver.

So, taking into account that we have no wrong IDs so far, I would drop
WARN_ON() here and guarantee that file2alias.c will be changed to validate
the GUID one way or the other.

Would it work? Hans, what is your comment here?

-- 
With Best Regards,
Andy Shevchenko


