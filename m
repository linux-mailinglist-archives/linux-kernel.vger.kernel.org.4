Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC063DAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiK3QsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3QsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:48:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FF23E9B;
        Wed, 30 Nov 2022 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669826898; x=1701362898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uTrgL6k/pta00i+eT2v7N/wL/p9QjJsL21ekxDAFN/o=;
  b=L0g2Z03ZKirwlDjjzk/hbcCMCcWSqLG4loVGqrcKO3kt8Aq2Pzdn9Vml
   RZkYLgxr+1MTVJk9LoNFZQr1K9fraFo2j9P4oYM0O1oZH1i1xkVPIQGXy
   OPGN1W9G0zaPhhBi4021C50y6n2mx/YXgfjuMFXk+8bRbyqu0oLT80Wur
   A68dbvstMCoSYSr+U3uj8kaHn00x+cgX1m8vpTVWB+rpnPYGWABob69tQ
   P/Bkk73C7Q5ibdsDo/WSXkRcVFnfdf6jsgN2Q++lD32WplIo0bDTCReZw
   JdDQVKIX+gUARRvhSjtgMLYtYarsXw1MitCYXaWesOo475lO6p3iXNshq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314141263"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="314141263"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 08:48:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="973170182"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="973170182"
Received: from xwang-mobl1.amr.corp.intel.com (HELO [10.212.177.221]) ([10.212.177.221])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 08:48:16 -0800
Message-ID: <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
Date:   Wed, 30 Nov 2022 08:48:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
 <Y4d8cm97hn5zuRQ1@Air-de-Roger>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y4d8cm97hn5zuRQ1@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 07:53, Roger Pau Monné wrote:
> On Tue, Nov 29, 2022 at 09:43:53AM -0800, Dave Hansen wrote:
>> On 11/21/22 02:21, Roger Pau Monne wrote:
>>> When running as a Xen dom0 the number of CPUs available to Linux can
>>> be different from the number of CPUs present on the system, but in
>>> order to properly fetch processor performance related data _PDC must
>>> be executed on all the physical CPUs online on the system.
>>
>> How is the number of CPUs available to Linux different?
>>
>> Is this a result of the ACPI tables that dom0 sees being "wrong"?
> 
> Depends on the mode.  This is all specific to Linux running as a Xen
> dom0.
> 
> For PV dom0 the ACPI tables that dom0 sees are the native ones,
> however available CPUs are not detected based on the MADT, but using
> hypercalls, see xen_smp_ops struct and the
> x86_init.mpparse.get_smp_config hook used in smp_pv.c
> (_get_smp_config()).
> 
> For a PVH dom0 Xen provides dom0 with a crafted MADT table that does
> only contain the CPUs available to dom0, and hence is likely different
> from the native one present on the hardware.
> 
> In any case, the dynamic tables dom0 sees where the Processor
> objects/devices reside are not modified by Xen in any way, so the ACPI
> Processors are always exposed to dom0 as present on the native
> tables.
> 
> Xen cannot parse the dynamic ACPI tables (neither should it, since
> then it would act as OSPM), so it relies on dom0 to provide same data
> present on those tables for Xen to properly manage the frequency and
> idle states of the CPUs on the system.
> 
>>> The current checks in processor_physically_present() result in some
>>> processor objects not getting their _PDC methods evaluated when Linux
>>> is running as Xen dom0.  Fix this by introducing a custom function to
>>> use when running as Xen dom0 in order to check whether a processor
>>> object matches a CPU that's online.
>>
>> What is the end user visible effect of this problem and of the solution?
> 
> Without this fix _PDC is only evaluated for the CPUs online from dom0
> point of view, which means that if dom0 is limited to 8 CPUs but the
> system has 24 CPUs, _PDC will only get evaluated for 8 CPUs, and that
> can have the side effect of the data then returned by _PSD method or
> other methods being different between CPUs where _PDC was evaluated vs
> CPUs where the method wasn't evaluated.  Such mismatches can
> ultimately lead to for example the CPU frequency driver in Xen not
> initializing properly because the coordination methods between CPUs on
> the same domain don't match.
> 
> Also not evaluating _PDC prevents the OS (or Xen in this case)
> from notifying ACPI of the features it supports.
> 
> IOW this fix attempts to make sure all physically online CPUs get _PDC
> evaluated, and in order to to that we need to ask the hypervisor if a
> Processor ACPI ID matches an online CPU or not, because Linux doesn't
> have that information when running as dom0.
> 
> Hope the above makes sense and allows to make some progress on the
> issue, sometimes it's hard to summarize without getting too
> specific,

Yes, writing changelogs is hard. :)

Let's try though.  I was missing some key pieces of background here.
Believe it or not, I had no idea off the top of my head what _PDC was or
why it's important.

the information about _PDC being required on all processors was missing,
as was the information about the dom0's incomplete concept of the
available physical processors.

== Background ==

In ACPI systems, the OS can direct power management, as opposed to the
firmware.  This OS-directed Power Management is called OSPM.  Part of
telling the firmware that the OS going to direct power management is
making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
calls must be made on every processor.  If these _PDC calls are not
completed on every processor it can lead to inconsistency and later
failures in things like the CPU frequency driver.

In a Xen system, the dom0 kernel is responsible for system-wide power
management.  The dom0 kernel is in charge of OSPM.  However, the Xen
hypervisor hides some processors information from the dom0 kernel.  This
is presumably done to ensure that the dom0 system has less interference
with guests that want to use the other processors.

== Problem ==

But, this leads to a problem: the dom0 kernel needs to run _PDC on all
the processors, but it can't always see them.

== Solution ==

In dom0 kernels, ignore the existing ACPI method for determining if a
processor is physically present because it might not be accurate.
Instead, ask the hypervisor for this information.

This ensures that ...

----

Is that about right?
