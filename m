Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198D865537F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiLWSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLWSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:10:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB761D0FB;
        Fri, 23 Dec 2022 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671819028; x=1703355028;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHQ+fQ0PDjXdAmyvbXTIdBDCDsIgBAPhIBp4uzkZHPs=;
  b=BcXvmIvSWExAjiCiiu1TGxHqn8xeszlfvQ6MuUAhTDorSWiywvvsUXkC
   yeFSSkjOns3s5zYJIe/cfu6PGZrK5nyZnvOm67vvxhNeNu8u1TF9pDq0h
   xqFyhroo5clKQR2J5ix+AN0kS0jyLlAG0bKO0F5NhT4gjixQSm/G19g0E
   KJDWUu9jrOIhTzjQwN99HnkP8Em0GDNvYCoD0KYQND2U9dST3CF6oq239
   wDwkaysVGlLsUu2f5GaE6ANyoYRr1PPqiNGo8Uo9Yz9GMJc/wHR2gWJZA
   zurB/LBMRMqM3klahIz0pS83Fo0/pUCiPiVDWOjFgCVobnGXdOjwWNCWy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="303837404"
X-IronPort-AV: E=Sophos;i="5.96,269,1665471600"; 
   d="scan'208";a="303837404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 10:10:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="980987420"
X-IronPort-AV: E=Sophos;i="5.96,269,1665471600"; 
   d="scan'208";a="980987420"
Received: from nsbhole-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.21.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 10:10:26 -0800
Message-ID: <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Date:   Fri, 23 Dec 2022 10:10:26 -0800
In-Reply-To: <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
References: <20221221155203.11347-1-ptyadav@amazon.de>
         <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
         <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> 
> Hi Srinivas,
> 
> On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > When a processor is brought offline and online again, it is
> > > unable to
> > > use Turbo mode because the _PSS table does not contain the whole
> > > turbo
> > > frequency range, but only +1 MHz above the max non-turbo
> > > frequency.
> > > This
> > > causes problems when ACPI processor driver tries to set frequency
> > > constraints. See patch 2 for more details.
> > > 
I can reproduce on a Broadwell server platform. But not on a client
system with acpi_ppc usage.

Need to check what change broke this.

Thanks,
Srinivas

> > 
> > Thanks,
> > Srinivas
> > 
> > > Pratyush Yadav (2):
> > >   acpi: processor: allow fixing up the frequency for a
> > > performance
> > > state
> > >   cpufreq: intel_pstate: use acpi perflib to update turbo
> > > frequency
> > > 
> > >  drivers/acpi/processor_perflib.c | 40
> > > ++++++++++++++++++++++++++++++++
> > >  drivers/cpufreq/intel_pstate.c   |  5 ++--
> > >  include/acpi/processor.h         |  2 ++
> > >  3 files changed, 45 insertions(+), 2 deletions(-)
> > > 
> > > --
> > > 2.38.1
> > > 
> > 
> 

