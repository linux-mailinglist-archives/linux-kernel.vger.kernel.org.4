Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614A6221E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiKICUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKICUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:20:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749665E43;
        Tue,  8 Nov 2022 18:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667960443; x=1699496443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fezt0Cu+vkPGTot42PBg9h+PcE0RZfW5+7ObsZ9NHzQ=;
  b=S6KMsscMfYuZj+p5270aIqTxh9Cj6AcllP90sBstNdrfQ8alvgYB+00z
   a/f2gjaTYxbQv1PXOfuhKNa55i5WcB5Zen4d2B9+CWhzNO3CkmrRyFel1
   N69Zky0B1M4IY4vPmuyT0JxfsCHpxTVm81dAO60RhREmA4UYzePaHCq9v
   E6xyNE2pkxFOM0y7lyTicZEjN4afR8lI56QaDnJmGRC0pYq5GsvW7MtnF
   zrlDWzXKYouZQK3+Xh+31glGoE+zoB8zBemMHJ7uaGSbbhZOPlQ+SNuMO
   hkIzI3faUndNwGfEyCDQ4pVwIF/fRDW7kyqtugi8Lu4Penc7e9A+oDf/W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="373011833"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="373011833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:18:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700166126"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700166126"
Received: from ehartman-mobl.amr.corp.intel.com (HELO desk) ([10.212.198.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:18:31 -0800
Date:   Tue, 8 Nov 2022 18:18:29 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <20221109021829.h26g4puxxfrv7xxg@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
 <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2rh6FN+gbD6Vbzj@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:10:32AM +0100, Borislav Petkov wrote:
>On Tue, Nov 08, 2022 at 02:51:41PM -0800, Pawan Gupta wrote:
>> Looking at bsp_init_amd() this feature bit will only be set on AMD
>> families 0x15-0x17. Andrew mentioned that the MSR LS_CFG is present on
>> AMD family >= 0x10 && family <= 0x18.
>
>Do you need to save that MSR on those families?
>
>Or do 0x15-0x18 suffice?
>
>Yes, 0x18 because that's Hygon and that does its own detection.
>
>So, do you need to save it on families 0x10-0x14?

As per Andrew's comment [1] the MSR needs to be restored for dispatch
serialising bit(except for family 0x11) :

   AMD LS_CFG is more complicated, because the dispatch serialising bit
   needs setting unilaterally (families 0x10, 0x12 thru 0x18), but the SSBD
   control ought to resolve on the next context switch.

[1] https://lore.kernel.org/lkml/6049e5bc-122f-5b4c-c1dc-0591eccf3525@citrix.com/
