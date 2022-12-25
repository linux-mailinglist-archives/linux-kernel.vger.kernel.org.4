Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F2655C06
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 01:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLYA2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 19:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 19:28:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797E658F;
        Sat, 24 Dec 2022 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671928100; x=1703464100;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNm9/E9vQwOQhQmRGADmicSeDE6R/5EWg07gbn3dlB4=;
  b=elI4GEBtrmlcZZ1lkvMjwfk/V6MsBQngM63bUnkEtfrfGEOpROE38ZV8
   lCBgpE923OvBo7pzaKj58Xkxnl/WQNB4wG94lLrhhNlgqxFRF30jzGdiM
   VOlE8qZi0k4ToV5SVETjLCs10VkWMW2N70YkjpPc2LBZLAxYIjNP4jC4l
   CTHwTTQxKp4T6y81JemY/FCU9LifQbeYRWJOzolKcips8bQd1LoLMLQ6q
   Ju3DT5R4GmX1F8WUw6pgRq7BGIj5SEs1wluY7tYS1genOVlL9nIVp8whc
   DXQ7G9I9u1RzG8oXoIis31XPI0Gjc0FeiV1TDRD0t6/wmuhgFnQkox3KH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="319158882"
X-IronPort-AV: E=Sophos;i="5.96,272,1665471600"; 
   d="scan'208";a="319158882"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 16:28:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="654475609"
X-IronPort-AV: E=Sophos;i="5.96,272,1665471600"; 
   d="scan'208";a="654475609"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 16:28:20 -0800
Message-ID: <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
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
Date:   Sat, 24 Dec 2022 16:28:19 -0800
In-Reply-To: <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
References: <20221221155203.11347-1-ptyadav@amazon.de>
         <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
         <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
         <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> Hi Pratyush,
> 
> On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > 
> > Hi Srinivas,
> > 
> > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > > When a processor is brought offline and online again, it is
> > > > unable to
> > > > use Turbo mode because the _PSS table does not contain the whole
> > > > turbo
> > > > frequency range, but only +1 MHz above the max non-turbo
> > > > frequency.
> > > > This
> > > > causes problems when ACPI processor driver tries to set frequency
> > > > constraints. See patch 2 for more details.
> > > > 
> I can reproduce on a Broadwell server platform. But not on a client
> system with acpi_ppc usage.
> 
> Need to check what change broke this.

When PPC limits enforcement changed to PM QOS, this broke. Previously
acpi_processor_get_platform_limit() was not enforcing any limits. It
was just setting variable. So any update done after
acpi_register_performance_state() call to pr->performance-
>states[ppc].core_frequency, was effective.

We don't really need to call
	ret = freq_qos_update_request(&pr->perflib_req,
			pr->performance->states[ppc].core_frequency *
1000);

if the PPC is not changed. When PPC is changed, this gets called again,
so then we can call the above function to update cpufreq limit.

The below change fixed for me.

diff --git a/drivers/acpi/processor_perflib.c
b/drivers/acpi/processor_perflib.c
index 757a98f6d7a2..c6ced89c00dd 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -75,6 +75,11 @@ static int acpi_processor_get_platform_limit(struct
acpi_processor *pr)
        pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
                       (int)ppc, ppc ? "" : "not");
 
+       if (ppc == pr->performance_platform_limit) {
+               pr_debug("CPU %d: _PPC is %d - frequency not
changed\n", pr->id, ppc);
+               return 0;
+       }
+
        pr->performance_platform_limit = (int)ppc;
 
        if (ppc >= pr->performance->state_count ||

Thanks,
Srinivas

> 
> Thanks,
> Srinivas
> 
> > > 
> > > Thanks,
> > > Srinivas
> > > 
> > > > Pratyush Yadav (2):
> > > >   acpi: processor: allow fixing up the frequency for a
> > > > performance
> > > > state
> > > >   cpufreq: intel_pstate: use acpi perflib to update turbo
> > > > frequency
> > > > 
> > > >  drivers/acpi/processor_perflib.c | 40
> > > > ++++++++++++++++++++++++++++++++
> > > >  drivers/cpufreq/intel_pstate.c   |  5 ++--
> > > >  include/acpi/processor.h         |  2 ++
> > > >  3 files changed, 45 insertions(+), 2 deletions(-)
> > > > 
> > > > --
> > > > 2.38.1
> > > > 
> > > 
> > 
> 


