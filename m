Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26D6272B1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiKMVVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:21:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8487FD19;
        Sun, 13 Nov 2022 13:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668374509; x=1699910509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8I6vKZArkiJeRn6HbKXPPaIQ6La44IOkt0n5HuZBRNs=;
  b=cEFGu+goS6HiIHkDjwOsuyiMAOi7EFzVTmNGiASMdu31OBxrnRsYw7vC
   hIPJALpslvqaplXjS15eoyFkJVmEUzvDq1Sov6l4Bf1H/g1jmO80VieWA
   /Wmfw3+GuOUo7Gx5729YwAa757JxzBcCkDIVwlAUFvkIfey2p/BzuULKz
   qqZBrY9vJMryB2mZ589/AcLJrqr0kJsjQ3H/9pc6EuNNkcoBrXJoLY1qn
   Dr1kVm9lEawn28jhDXZP8RMuVUgCslz6R9GQcsVatG/2NPX0d7+01Owzq
   B930CxitxSQ37u7g5WzZoUT7YWx6Q99W94DFwhzfXn4xoOqE6pmGThIqH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="292240956"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292240956"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:21:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883308898"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883308898"
Received: from perwin-mobl.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.212.163.208])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:21:49 -0800
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs entry
Date:   Sun, 13 Nov 2022 13:21:41 -0800
Message-ID: <2206677.iZASKD2KPV@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <Y3EiKUzpShqwzEf6@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com> <5e65889d-d68c-b29d-6cea-7b4ce4c87b4a@intel.com> <Y3EiKUzpShqwzEf6@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 13 November 2022 08:58:17 PST Borislav Petkov wrote:
> * if f/m/s matches, you execute
> 
>     if still within the timeout, you return -EAGAIN from
>     current_batch_store() to tell userspace, take a nap and try again.
> 
> * if the f/m/s doesn't match you return -EINVAL to say, wrong filename,
> try the next one.

But if it matches but is corrupt or the HW fails to accept it, you also get an 
error. So you now need to differentiate a failure to load a candidate file and 
an attempt to load a non-candidate.

I'm assuming that the kernel would provide different error conditions for 
those. But handling those in shell scripting is very difficult: you'd need to 
start a subshell and parse stderr. It's MUCH easier in C, of course, but 
incrementing a number is magnitudes easier in C than performing a globbing.

Either way, incrementing a number in shell is pretty easy too. The simplest 
script with just the numbers would be:

i=0
while echo $i > /sys/devices/virtual/misc/intel_ifs_0/current_batch; do
    test_all_cpus
done

It's four lines and does not need to know about where the scan files are 
located, how they're named and if some files it may find are not to be used. But 
I've hidden a lot of complexity in the test_all_cpus shell function, which 
would be common to either solution of how we specify the batch to be loaded.

And this is part of my argument of why it's unlikely people will use their 
shells to do this. That shell function is easily another 10 lines of 
scripting, if it's meant to do its job properly. To make that easier, we've 
developed two tools, one of them the OpenDCDiag tool I linked to, but both 
just happen to be written in C and C++ instead of shell.

> For all Intel employees here on the thread, there's a world outside
> Intel and people do not talk (family model stepping) tuples like we do.
> All they wanna do is run their damn tests.

Indeed they do. I have personally been in contact with the few that will 
represent over 90% of the deployment of this feature for the next few years. 
They want this functionality to integrate with their existing health-check 
scanning methodology. This is where OpenDCDiag comes in, because it does 
integrate with their workflows, like logging. For another example, it obeys the 
cpuset that the parent process may have set with sched_setaffinity() or alike 
tools (taskset(1) or schedtool(8)). I have zero clue how to do that with shell 
scripting.

Which actually means I am the maintainer of the tool that is going to be 
driving 99% or more of all scans (that's why I was cc'ed in the submission). I 
am your user.

I'm not saying I am the only user. I definitely want to see the best interface 
so that others could write tools too if they want to. And I don't want there 
to be a kludge that we need to keep compatibility with for a decade, or to set 
a bad precedent. But I am giving you the constraints that I need to work under 
and the kernel interface to support me. I am telling you this is very good 
right now and your proposal makes it worse for me, not better, for little 
apparent gain.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Cloud Software Architect - Intel DCAI Cloud Engineering



