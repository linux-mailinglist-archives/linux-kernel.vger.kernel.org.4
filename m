Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C138656E16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiL0St7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL0Stv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:49:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34520D2C8;
        Tue, 27 Dec 2022 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672166990; x=1703702990;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7pXQAZMf1WL75uIYHs9KgSY6E2yOmxH87Domw3cw/lo=;
  b=jpJysF/UCLTQumODIhB8bCRReDK1RjX2GRbA3vc0/SetcQ/X0sj1N8do
   Tv8L4mCb4vhr4FmaNYjcwbGkFz5UHA7ukXbdzZaiUKgdMWW6Siev7Qw+v
   fQS6LTgMOo4KXPlDOL29Hux3FHeA7Me3Lr3hnAXaJzPuVwVvsM5zsZ5I2
   SXtwpMHtzPBDfgTz8CdQZezVuVu+5wpHQu2spsIBR59ku4UqqztWN95TT
   c8/BvRncYT+tfoGiL+D8vrj3wX4jz57y5f3FtR1TOx63BLcYKF5cZRZkL
   IA64U/AHMgSFK5E1suMXEC5ujOAXhJPjxGhroi4JIBkBrx+71OUV6/Y3C
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="318419886"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="318419886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:49:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="630760692"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="630760692"
Received: from wilsona1-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.223.115])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:49:49 -0800
Message-ID: <aad6d76a4a1bc986cb4187e041b9750d98196d80.camel@linux.intel.com>
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
Date:   Tue, 27 Dec 2022 10:49:49 -0800
In-Reply-To: <CAJZ5v0hbiuvvP_HKnP5m0TBwGsN2-=32bMXTRUUanc4cFRJKwQ@mail.gmail.com>
References: <20221221155203.11347-1-ptyadav@amazon.de>
         <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
         <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
         <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
         <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
         <mafs07cycdfh4.fsf_-_@amazon.de>
         <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
         <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
         <61b3d3720ac4bfd1fc8b7dcd09f58dd5a2de3cca.camel@linux.intel.com>
         <CAJZ5v0hbiuvvP_HKnP5m0TBwGsN2-=32bMXTRUUanc4cFRJKwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-27 at 19:47 +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 27, 2022 at 7:07 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Tue, 2022-12-27 at 18:02 +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 27, 2022 at 5:40 PM srinivas pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> > > > > Hi Srinivas,
> > > > > 
> > > > > On Sat, Dec 24 2022, srinivas pandruvada wrote:
> > > > > 
> > > > > > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada
> > > > > > wrote:
> > > > > > > Hi Pratyush,
> > > > > > > 
> > > > > > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > > > > > 
> > > > > > > > Hi Srinivas,
> > > > > > > > 
> > > > > > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav
> > > > > > > > > wrote:
> > > > > > > > > > When a processor is brought offline and online
> > > > > > > > > > again,
> > > > > > > > > > it is
> > > > > > > > > > unable to
> > > > > > > > > > use Turbo mode because the _PSS table does not
> > > > > > > > > > contain
> > > > > > > > > > the
> > > > > > > > > > whole
> > > > > > > > > > turbo
> > > > > > > > > > frequency range, but only +1 MHz above the max non-
> > > > > > > > > > turbo
> > > > > > > > > > frequency.
> > > > > > > > > > This
> > > > > > > > > > causes problems when ACPI processor driver tries to
> > > > > > > > > > set
> > > > > > > > > > frequency
> > > > > > > > > > constraints. See patch 2 for more details.
> > > > > > > > > > 
> > > > > > > I can reproduce on a Broadwell server platform. But not
> > > > > > > on a
> > > > > > > client
> > > > > > > system with acpi_ppc usage.
> > > > > > > 
> > > > > > > Need to check what change broke this.
> > > > > > 
> > > > > > When PPC limits enforcement changed to PM QOS, this broke.
> > > > > > Previously
> > > > > > acpi_processor_get_platform_limit() was not enforcing any
> > > > > > limits.
> > > > > > It
> > > > > > was just setting variable. So any update done after
> > > > > > acpi_register_performance_state() call to pr->performance-
> > > > > > > states[ppc].core_frequency, was effective.
> > > > > > 
> > > > > > We don't really need to call
> > > > > >         ret = freq_qos_update_request(&pr->perflib_req,
> > > > > >                         pr->performance-
> > > > > > > states[ppc].core_frequency
> > > > > > *
> > > > > > 1000);
> > > > > > 
> > > > > > if the PPC is not changed. When PPC is changed, this gets
> > > > > > called
> > > > > > again,
> > > > > > so then we can call the above function to update cpufreq
> > > > > > limit.
> > > > > > 
> > > > > > The below change fixed for me.
> > > > > 
> > > > > Right.
> > > > I think, this is the only change you require to fix this. In
> > > > addition
> > > > set pr->performance_platform_limit = 0 in
> > > > acpi_processor_unregister_performance().
> > > 
> > > Not really, because if the limit is set to a lower frequency and
> > > then
> > > reset to _PSS[0], it needs to be set back to "no limit".
> > > 
> > 
> > If PPC becomes 0 again after ppc > 0 during dynamic PPC change, pr-
> > > performance_platform_limit will not match current PPC, so will
> > > set to
> > PPC 0 performance ( which is already patched by driver after return
> > from acpi_register_performance_state()).
> 
> I see.
> 
> > But fine, you can always set freq qos to FREQ_QOS_MAX_DEFAULT_VALUE
> > for
> > PPC 0 as you are doing in your patch.
> 
> I think that using the "no limit" value to represent the "no limit"
> condition makes sense.
Agree.

> 
> Also, I'm wondering if the patching of states[0].core_frequency will
> still be necessary after this change.

I don't think so. We can remove the patching.

