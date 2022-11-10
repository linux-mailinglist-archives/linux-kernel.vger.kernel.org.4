Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4DF623B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKJGJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJGJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:09:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E6620360;
        Wed,  9 Nov 2022 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668060546; x=1699596546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gCpsGsdtgZE/7Vhf7IeyYczfiB+d1IkXsbbAc6pMtXU=;
  b=iMr8zDBeG2mbqtwBn5R1G4FmdBE04z+fMw21AQ9fWzxYhfS42uPrVErT
   Wek0MrZN/gPvQL2gNKVko7s8VjfptAM8+YiskLSraZXjpKlMb5gjz0sJ9
   Q6Xs0NvSaQFOAM2+ThZ/D5CB9SCN7Nj90NpldLsjLaCRqNmxN0UTSPzRz
   EII8EZ7hV8Y4cGgxWes12gYkLJamxRSSGcBXagTP5n55gvRzajtCDcwlQ
   +IOBm2ErPEw2flsAhlXFmEpQHIaz0MT7UMlBGGhSp8RknhbOZVz1LYQ27
   1jlppbJf/S8eiw37PUr+R//pZzyogSZZ8bfAB82uuwhVt4UiKm5P5Ao24
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309938258"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="309938258"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 22:09:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="639487879"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="639487879"
Received: from sibacon-mobl1.amr.corp.intel.com (HELO desk) ([10.212.38.58])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 22:09:05 -0800
Date:   Wed, 9 Nov 2022 22:09:03 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "antonio.gomez.iglesias@linux.intel.com" 
        <antonio.gomez.iglesias@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <20221110060903.vud266getvlihxet@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
 <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
 <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
 <20221109173720.4ovtb2ao3vuuge43@desk>
 <bee087ff-d7f7-4f6a-4c43-8c91fdec043a@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bee087ff-d7f7-4f6a-4c43-8c91fdec043a@citrix.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:00:11AM +0000, Andrew Cooper wrote:
>On 09/11/2022 17:37, Pawan Gupta wrote:
>> If SSBD is the only reason to restore MSR_AMD64_LS_CFG then we should be
>> able to use X86_FEATURE_LS_CFG_SSBD for enumeration.
>
>Yeah, although it occurs to me that you probably don't want to
>save/restore the whole MSR.  It's full of other things which want to
>stay in their current configuration.

Upstream currently saves and restores the whole MSR_AMD64_LS_CFG at
suspend/resume.

Is it that the configuration saved at suspend(other than SSBD) will not
be relevant at resume for this MSR? Is there any harm if keep the
current behavior?
