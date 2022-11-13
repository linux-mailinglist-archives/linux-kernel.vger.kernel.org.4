Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F496272BC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiKMVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:33:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1ADA1A7;
        Sun, 13 Nov 2022 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668375232; x=1699911232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDsXd/OK/i8ZazYsmMhzsAb7ml0526jel4iO8E7C1A4=;
  b=lY2r250vlLioCXMAX7u1Ml/lC4xRm7lfSJH9Gs4CUvQhMw0XzTsSkvdU
   qjcwWKHq86Do2ajlNVEGgHWwTl8pFYHmWpGeyAfe9LyzsMNq0v1D4rV7r
   YoqlR0AE48mwzrTleU/QSJpKrTFvRB98h5D6u3iVYMsubPUarw7RiiVb6
   /fBmwJ/2FOTM27L3hsB5FPyL21nBSVUkJZP8hc5EzuzjsQaEX+bnWvHHQ
   wz1NT1TrJQmjpkjbqsI2oNZDpcuBDKGBlvQ4sS1iQRDprTgHeRuK98IyQ
   wHYP9SlSxnK/T2hbLo4/OTbVp0uXW3ZpNr1G3c4lIODc70EwAM67UQfFt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="373970396"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="373970396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:33:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616053966"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616053966"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:33:51 -0800
Date:   Sun, 13 Nov 2022 13:33:50 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
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
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3Fivuffbh2QE/s6@agluck-desk3.sc.intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <5e65889d-d68c-b29d-6cea-7b4ce4c87b4a@intel.com>
 <Y3EiKUzpShqwzEf6@zn.tnic>
 <f307b37f-26de-cb8f-e199-f327f2c7f807@intel.com>
 <Y3E3DkX4wHRgSUlJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3E3DkX4wHRgSUlJ@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 07:27:26PM +0100, Borislav Petkov wrote:
> On Sun, Nov 13, 2022 at 09:55:00AM -0800, Joseph, Jithu wrote:
> > Then we were told not to specify a filename via sysfs file (apologies
> > for being repetitive)
> 
> Yeah, I'm unclear on why that is either and am hoping that Greg will
> clarify. He fears that there will be file path resolution which I'm not
> even thinking about.

Summarizing the competing proposals here:

Option 1 (patches as currently posted)

	User writes the batch number to the sysfs file:

	# echo 4 > /sys/devices/virtual/misc/intel_ifs_0/current_batch

	Driver turns that into a *partial* path (with test type, family-model-stepping
	and batch number filled in):

		"intel/ifs_%d/%02x-%02x-%02x-%02x.scan"

	Feeds that to request_firmware_direct() (which looks in /lib/firmware)

Option 2 (proposed by Boris)

	User writes a filename to the sysfs file:

	# echo 06-8f-06-04.scan > /sys/devices/virtual/misc/intel_ifs_0/current_batch

	Driver parses that:
		If family-mode-stepping does not match current CPU, then
		fail with -EINVAL
		If filename doesn't end with a ".scan" suffix, also
		fails with -EINVAL

	Otherwise proceeds in similar manner to above. Constructs partial
	pathname (just fills in test type and filename:

		"intel/ifs_%d/%s"

	Feeds that to request_firmware_direct() (which looks in /lib/firmware)


IMHO option 1 is following the microcode precedent of having the kernel
construct the filename based on the {x86,model,stepping} fields of
struct cpuinfo_x86.

I think option 2 isn't really doing the user any favors. Having them
feed all the *.scan files they find in /lib/firmware/intel/ifs_0 to the
driver to see which ones work becomes progressively worse in every CPU
generation. Any script/app running tests is likely to do the ff-mm-ss
filter itself ... so why have the kernel do it too?

-Tony
