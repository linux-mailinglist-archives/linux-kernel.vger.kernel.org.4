Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F486235FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKIVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:41:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4F29C8A;
        Wed,  9 Nov 2022 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668030093; x=1699566093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1U/Ysvzugqok1OiNYXo54FZ7q5XZ9HUDIbpMFGaIxRg=;
  b=bnV3xqAO+cKRILFyRhMHTvVYbT9ywddCRAAHpkQKmXhvPrEPIOPCNPaz
   eEC1qm1BEB4tQ3VjcaDSf9YuAVDWqmANclsazZJUUQr8N9cMYDTc5esSh
   gbYLzjuusK4u802+PWyk1wCxBIFyK79NCSQvHUBhUfDGIzMFBlr6i6OPs
   ojDvl9kBgg1zDWUv+BzsvUxKueM2J/ClyZXApX0vGvnKE6DcIuGxz2pK6
   Bby7r+IprEj2d3knF/38/2FPdvDwTiNmz+aT5L36usnCNVYnoiiTCiWFW
   lWt1TdrDQsMR2Wz3g10BEITYwUdHuLwNYQ1+4a+lPoTIr7ewnRn1kz7OC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309835698"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="309835698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 13:41:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="762036677"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="762036677"
Received: from sibacon-mobl1.amr.corp.intel.com (HELO desk) ([10.212.38.58])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 13:41:29 -0800
Date:   Wed, 9 Nov 2022 13:41:26 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
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
Message-ID: <20221109214126.ao477sucsks6msyd@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
 <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
 <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
 <20221109173720.4ovtb2ao3vuuge43@desk>
 <Y2vyz2OAp1xKedYc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2vyz2OAp1xKedYc@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 07:34:55PM +0100, Borislav Petkov wrote:
>On Wed, Nov 09, 2022 at 09:37:20AM -0800, Pawan Gupta wrote:
>> Looks like we need to restore this MSR too,
>
>Why do we? Is that MSR read-only too or what is the reason for that one?

Please ignore, it doesn't concern this series.

>Yes, MSR_AMD64_LS_CFG is used in SSBD mitigations. For everything <= 0x12:
>
>        /* AMD Family 0xf - 0x12 */
>        VULNWL_AMD(0x0f,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
>        VULNWL_AMD(0x10,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
>        VULNWL_AMD(0x11,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
>        VULNWL_AMD(0x12,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
>
>On F14h it says here:
>
>[    0.278930] Speculative Store Bypass: Vulnerable
>
>simply because it is not present there.

So looks like MSR_AMD64_LS_CFG should only be restored when
X86_FEATURE_LS_CFG_SSBD is present. I will make this change in v2.
