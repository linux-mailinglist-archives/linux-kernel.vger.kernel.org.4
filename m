Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5266272C8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKMVwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKMVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:51:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7BDF81;
        Sun, 13 Nov 2022 13:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668376318; x=1699912318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vwi5xI+ZgoQ66Zhsx8mRj2liZIMevDJUF4Ly/3/uLCg=;
  b=C5JNhKyyIGIdqAA/Iqe+ewtaZccMU66DtlIkfqSkcpi0VZP99dxg5TNg
   pRg0le28hf0hpGvJEBE21ntI3rCDCePNMBuurEpJDtECp2D6CO52uYZFp
   WhgyNtR45vLizYUGC6wpNLTtG0y/DO4MxdOWMbVPB/ShAmJsILdFXpS5s
   8HRJRMbRld85TyRQ8Eq3p5+6xDtlemAR33FnY1ZqpEZON/fk8xWR3gWeM
   syXUyUKpIiusi1UOz8aYW4s7BCfpLi6oSDm8rw/7PiDLCnkWSuLfI8bib
   fwdpE6AVf56sMur2n6aUPRpzMgq5jMa1G9RyYoJjPTe9Z5DsvZDOQI6MC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="299359698"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="299359698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:51:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="780702723"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="780702723"
Received: from perwin-mobl.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.212.163.208])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:51:56 -0800
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
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
Date:   Sun, 13 Nov 2022 13:51:56 -0800
Message-ID: <2537334.Lt9SDvczpP@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <Y3DZmKYV+8HBtZ+Q@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com> <Y3CevK2zhAmiUyG9@kroah.com> <Y3DZmKYV+8HBtZ+Q@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 13 November 2022 03:48:40 PST Borislav Petkov wrote:
> > You can't do it with a three-line shell script, but we're not
> > expecting that shell scripts are the means to use this feature in the
> > first place.
> 
> I consider it a serious design mistake of having to have a *special*
> tool. A special tool is *always* a burden. You need to build it, supply
> it, make sure it is installable on the target system and so on.
> 
> And I'm telling you this with my Linux distributor hat on. It is always
> a pain - trust me.
> 
[cut]
> IOW, I really think that designing our interfaces with user friendliness
> in mind should be of much more higher importance. And requiring the user
> to remember or figure out anything she doesn't really need to, in order
> to run the test is a burden.

We agree that it should be operable without a tool. If nothing else, we will 
run into situations where we need to debug what's happening and the tool is 
not going to work for those conditions. Having a direct access to the API 
right there in /sys is great and is one of the things that Linux excels at and 
differentiates itself from the competition with.

However, I am saying that we shouldn't have to go out of our way to make the 
extreme corner case easy if it comes to the detriment of the 99% case.

Anyway, we can update the tool to print "%02x-%02x-%02x-%02x.%s" instead of 
"%d". That's trivial to us. I just don't think it's a worthwhile change, 
because four of the five placeholders there are enforced by the kernel and 
therefore the kernel must check them again (maybe it does so anyway when it 
opens and validates the file).

What REALLY matters to me is that the current_batch file be readable and I can 
get the last batch that was loaded, in a well-known format. Without this, we 
go from "inconvenience" to "major design change, must talk to customers and 
customers must adapt their workloads". Please help me out here.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Cloud Software Architect - Intel DCAI Cloud Engineering



