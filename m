Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE763F247
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiLAOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiLAOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:06:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECAA51A8;
        Thu,  1 Dec 2022 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669903566; x=1701439566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WMGpqOgGqrVnBeh6UzML2xLvqnpofIMwJed+MAd9/yQ=;
  b=bNDp34sZzIgc7ao+P7B1kclcl4P4ETABkflFwmHOaAB8AcZlDGVFAy/L
   DPtKr49nm0101AFQJPHy1JOLJ125l8kyHH88e9d21Jij0ARcLxHrf4xiL
   QBoBxy3eBjBQ8PLKTVUyVbkyuGZ7QvyRZ3UObuT+LTJzdSHWrLIcPFRn6
   qgBz86+lZOc4DeQcqHXBvUveHoEYkZEvWCm/cu3jwZFKOfasLZVuZKhIS
   i/Jf90ooHW8SNv7lR4fEdA1l5646l0E0EaQyFWd6SzPxswlOFng9LZAzA
   dBfTl9DgTu9VpIkt+djVFPuy16lvmvAqqdxXgCC47x5fxKfTBDm+CNo/j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296050720"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="296050720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 06:04:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="750816643"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="750816643"
Received: from mdechene-mobl2.amr.corp.intel.com (HELO [10.209.18.63]) ([10.209.18.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 06:04:46 -0800
Message-ID: <05148d42-2573-2b2d-2906-b7480ec21966@intel.com>
Date:   Thu, 1 Dec 2022 06:04:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Content-Language: en-US
To:     Ivan Zahariev <famzah@icdsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com>
 <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
 <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
 <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
 <87y2c28zir.ffs@nanos.tec.linutronix.de>
 <ff5ad474-6d32-8bf8-e297-ed71a967d27c@icdsoft.com>
 <31b30c00-9de9-2881-53c3-b08804571d6c@intel.com>
 <212daa8e-8f48-30d9-cfc8-ee5c2025f02c@icdsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <212daa8e-8f48-30d9-cfc8-ee5c2025f02c@icdsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 04:58, Ivan Zahariev wrote:
> We are running 5.15.75 (LTS) but the problem started when we upgraded
> from 5.15.31 to 5.15.59 and is present ever since. I erroneously said
> that it's present into every 5.15.
> I didn't do my homework well and blamed the commit by Yu-cheng Yu. 
> But this commit never landed into 5.15, nor the fix commit that you>
> referred. There are no functions fpu__clear_all(), 
> copy_init_fpstate_to_fpregs(), copy_user_to_xstate() anywhere in the>
> sources of 5.15.75 or 5.15.31, so the 5.15 kernel is running with a 
> different FPU implementation.
It's also possible that the Ubuntu kernel folks pulled some FPU patches
into their 5.15 kernel from later upstream kernels, which is adding to
the confusion.  I think there may have been some effort to backport the
AMX work.

You might want to file a bug report with the Ubuntu folks.
