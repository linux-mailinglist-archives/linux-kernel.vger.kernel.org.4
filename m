Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F816656D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiL0Qky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiL0QkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:40:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3061BE23;
        Tue, 27 Dec 2022 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672159222; x=1703695222;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRATqieH5GzTgS6odrliQ0LbeJjujXJnPHSE5feiNho=;
  b=CvmKrK72CG1B3J2i9iaOgIN3OE6jyZDxsBwxRdpCtFONBXm4NHm/0BBR
   EhACz6/M/tISnAt+K/IsXIMgXnY8eNPFJCNdpJmUUkkdXCEOKEcxmwJ9t
   OwfjNalkW0exHGcB0S59XkSDbsNxApFBPmi8gZ0roIQxoeTIqNmoBKEUL
   rQtmN/5MQpdkcevzHWz6rVgCmMR/TGt1CY58a5JEgMSmsryr8vClkbaGF
   ZxruJR8gaA/vEucUp37CtNZJxxHN+hu9Bnh75VTsfFtESmPey0V1TmqH8
   pn8pSvVXKg9/uJ4sf3wpPzdkh4j3o3i1Jq0X36GXja3ctJtiWHNkpeSAD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="321958438"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="321958438"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 08:40:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741781189"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="741781189"
Received: from admiller-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.206.1])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 08:40:21 -0800
Message-ID: <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
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
Date:   Tue, 27 Dec 2022 08:40:21 -0800
In-Reply-To: <mafs07cycdfh4.fsf_-_@amazon.de>
References: <20221221155203.11347-1-ptyadav@amazon.de>
         <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
         <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
         <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
         <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
         <mafs07cycdfh4.fsf_-_@amazon.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> Hi Srinivas,
> 
> On Sat, Dec 24 2022, srinivas pandruvada wrote:
> 
> > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> > > Hi Pratyush,
> > > 
> > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > 
> > > > Hi Srinivas,
> > > > 
> > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > > > > When a processor is brought offline and online again, it is
> > > > > > unable to
> > > > > > use Turbo mode because the _PSS table does not contain the
> > > > > > whole
> > > > > > turbo
> > > > > > frequency range, but only +1 MHz above the max non-turbo
> > > > > > frequency.
> > > > > > This
> > > > > > causes problems when ACPI processor driver tries to set
> > > > > > frequency
> > > > > > constraints. See patch 2 for more details.
> > > > > > 
> > > I can reproduce on a Broadwell server platform. But not on a
> > > client
> > > system with acpi_ppc usage.
> > > 
> > > Need to check what change broke this.
> > 
> > When PPC limits enforcement changed to PM QOS, this broke.
> > Previously
> > acpi_processor_get_platform_limit() was not enforcing any limits.
> > It
> > was just setting variable. So any update done after
> > acpi_register_performance_state() call to pr->performance-
> > > states[ppc].core_frequency, was effective.
> > 
> > We don't really need to call
> >         ret = freq_qos_update_request(&pr->perflib_req,
> >                         pr->performance->states[ppc].core_frequency
> > *
> > 1000);
> > 
> > if the PPC is not changed. When PPC is changed, this gets called
> > again,
> > so then we can call the above function to update cpufreq limit.
> > 
> > The below change fixed for me.
> 
> Right. 
I think, this is the only change you require to fix this. In addition
set pr->performance_platform_limit = 0 in
acpi_processor_unregister_performance().

Thanks,
Srinivas

> Should I re-roll my patches with your diff below then? Or do you
> think my patches should be good to merge as-is?
> 
> > 
> > diff --git a/drivers/acpi/processor_perflib.c
> > b/drivers/acpi/processor_perflib.c
> > index 757a98f6d7a2..c6ced89c00dd 100644
> > --- a/drivers/acpi/processor_perflib.c
> > +++ b/drivers/acpi/processor_perflib.c
> > @@ -75,6 +75,11 @@ static int
> > acpi_processor_get_platform_limit(struct
> > acpi_processor *pr)
> >         pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr-
> > >id,
> >                        (int)ppc, ppc ? "" : "not");
> > 
> > +       if (ppc == pr->performance_platform_limit) {
> > +               pr_debug("CPU %d: _PPC is %d - frequency not
> > changed\n", pr->id, ppc);
> > +               return 0;
> > +       }
> > +
> >         pr->performance_platform_limit = (int)ppc;
> > 
> >         if (ppc >= pr->performance->state_count ||
> > 
> 

