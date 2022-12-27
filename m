Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6127656DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiL0SHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0SHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:07:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D70F1D;
        Tue, 27 Dec 2022 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672164467; x=1703700467;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/9t+3QiTlrzSMckrPusT+JZOCoszJNNpwdQ2a2LLAE=;
  b=myneTD6uqN2FF8RH/T2O/wTUEU5JtECK9igbXffWYbCCiQ8OywTeoVug
   ScF6mMmyDmGqcaMm/RpvgJECZEgytpd+idNcEXtKXH8RghldYQXetiO93
   5uci738HZ75s9o6YLubV9evvvOR8zw8TpgTtJCeO8UsUOy7G2PS28WQdG
   nEOHiL6NWoBqGRm+j46ILdYQVhpkHR7reFvZ3vPTwvDn2JFUYZ2yzzMh9
   eL1gEIcNwyfK6g7OAUi0AoHsCJ3s6TivxDOKrTBX8imlmmalc8aupxXad
   OGuaQ+Biiak92SLmYoU1tXztc3Y17b/M71Dh7eJko/dAI6zHINUxHfePJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322715035"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="322715035"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:07:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="653093224"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="653093224"
Received: from wilsona1-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.223.115])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:07:22 -0800
Message-ID: <61b3d3720ac4bfd1fc8b7dcd09f58dd5a2de3cca.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pratyush Yadav <ptyadav@amazon.de>, linux-pm@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Date:   Tue, 27 Dec 2022 10:07:22 -0800
In-Reply-To: <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
References: <20221221155203.11347-1-ptyadav@amazon.de>
         <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
         <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
         <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
         <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
         <mafs07cycdfh4.fsf_-_@amazon.de>
         <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
         <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Tue, 2022-12-27 at 18:02 +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 27, 2022 at 5:40 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> > > Hi Srinivas,
> > > 
> > > On Sat, Dec 24 2022, srinivas pandruvada wrote:
> > > 
> > > > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> > > > > Hi Pratyush,
> > > > > 
> > > > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > > > 
> > > > > > Hi Srinivas,
> > > > > > 
> > > > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > > > > > > When a processor is brought offline and online again,
> > > > > > > > it is
> > > > > > > > unable to
> > > > > > > > use Turbo mode because the _PSS table does not contain
> > > > > > > > the
> > > > > > > > whole
> > > > > > > > turbo
> > > > > > > > frequency range, but only +1 MHz above the max non-
> > > > > > > > turbo
> > > > > > > > frequency.
> > > > > > > > This
> > > > > > > > causes problems when ACPI processor driver tries to set
> > > > > > > > frequency
> > > > > > > > constraints. See patch 2 for more details.
> > > > > > > > 
> > > > > I can reproduce on a Broadwell server platform. But not on a
> > > > > client
> > > > > system with acpi_ppc usage.
> > > > > 
> > > > > Need to check what change broke this.
> > > > 
> > > > When PPC limits enforcement changed to PM QOS, this broke.
> > > > Previously
> > > > acpi_processor_get_platform_limit() was not enforcing any
> > > > limits.
> > > > It
> > > > was just setting variable. So any update done after
> > > > acpi_register_performance_state() call to pr->performance-
> > > > > states[ppc].core_frequency, was effective.
> > > > 
> > > > We don't really need to call
> > > >         ret = freq_qos_update_request(&pr->perflib_req,
> > > >                         pr->performance-
> > > > >states[ppc].core_frequency
> > > > *
> > > > 1000);
> > > > 
> > > > if the PPC is not changed. When PPC is changed, this gets
> > > > called
> > > > again,
> > > > so then we can call the above function to update cpufreq limit.
> > > > 
> > > > The below change fixed for me.
> > > 
> > > Right.
> > I think, this is the only change you require to fix this. In
> > addition
> > set pr->performance_platform_limit = 0 in
> > acpi_processor_unregister_performance().
> 
> Not really, because if the limit is set to a lower frequency and then
> reset to _PSS[0], it needs to be set back to "no limit".
> 

If PPC becomes 0 again after ppc > 0 during dynamic PPC change, pr-
>performance_platform_limit will not match current PPC, so will set to
PPC 0 performance ( which is already patched by driver after return
from acpi_register_performance_state()).

But fine, you can always set freq qos to FREQ_QOS_MAX_DEFAULT_VALUE for
PPC 0 as you are doing in your patch.

Thanks,
Srinivas




> I'll send a patch for that in a while.

