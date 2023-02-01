Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67B686EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjBATOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjBATOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:14:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FB367F9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675278840; x=1706814840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8E/viQsDuVZf98r42WrEgMAhsNl6MKLs4EyRN+Z043s=;
  b=AnJPmGFDnXeBte2r2K1t8m7VJJZISG447217rqFN1utNGtNwfuQG48xx
   MHKI0npS/dPfn4PbK//a939SY7g6TgyfhavJ09FZzx+6cGb4BNZbQnbRa
   3CSbLO+BOJTt9PL00sxfb76RYkoHcVOecQ4PmRgFZEeCcVglmNX/HbukQ
   XcK08XB1S97efO6e9y/y0GyTWzKZO/j8Gm0JqW1fGtR2wyYck9kuf/OaZ
   nYnSmIZYU+tXB66WTkRWg12lxWHudT5cT0RoBaW5oXPtSCrechbaxQjLa
   Lj2jvVt67/n1tD++BlXR9VfKbbeDml4r37ydbrBVJAOF11b2cbIDGDcaf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414452707"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414452707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:14:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993798396"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="993798396"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:13:59 -0800
Message-ID: <388d0260-042c-209f-a986-c9ca47061b3c@intel.com>
Date:   Wed, 1 Feb 2023 11:13:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230130213955.6046-4-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 13:39, Ashok Raj wrote:
> Currently collect_cpu_info() is only returning what was cached earlier
> instead of reading the current revision from the proper MSR.
> 
> Collect the current revision and report that value instead of reflecting
> what was cached in the past.
> 
> [TBD:
>     Need to change microcode/amd.c. I didn't quite follow the logic since
>     it reports the revision from the patch file, instead of reporting the
>     real PATCH_LEVEL MSR.
> 
>     Untested on AMD.
> ]

This thread is meandering a bit.  I think it's because this changelog
doesn't have a problem statement.  It's hard to agree on a patch being a
solution to anything if we haven't first agreed on the problem.

What is the problem?

What does this "fix"?
