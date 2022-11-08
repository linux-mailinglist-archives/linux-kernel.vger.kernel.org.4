Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2C621C16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKHSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKHSkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:40:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA221822;
        Tue,  8 Nov 2022 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932808; x=1699468808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6svTSErwgcBWmVVssdjVJhxp54lnK//1QR9DvAte5oM=;
  b=h6CWbWNG8zXrPWmQ+SZM2ABSbg5ixcjRW3E4j9tOVyGSdUsWCF0C/r+i
   qlcc4MBTHtY3di3muokFZoJJtPh4+ElSJKFLBfbNM2PFYqkN1o2e5cwcE
   LXmvx2MPtg0xrDDiW3LqbIoWwiHs1ih5mJ2TyJrl0HpYFmAQSn8YYy3Eu
   W04UQdA8LL92Mjy4rX6c8lkO2b8j7iKlB2VqptjzaH/pAMQPRS6HhGNHO
   NRE9QcFX5sZQWy2I+pPcdE9oRTdSYFSMgv4aDs9vkRGU9uDveBHAME6Fq
   yUwsNIPSwWJekKF1hdgdQJR2vvCsE3ZsqmldUEs1zZGrL6vXZGMAVIM81
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311931669"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311931669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:40:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614378400"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="614378400"
Received: from vibhusha-mobl1.amr.corp.intel.com (HELO [10.252.133.56]) ([10.252.133.56])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:40:06 -0800
Message-ID: <98ec85df-cbf8-83b7-df79-12ff379eae9b@intel.com>
Date:   Tue, 8 Nov 2022 10:40:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <206cec042e17f15432d523d12ce6f5ae9267dc77.1663025154.git.pawan.kumar.gupta@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <206cec042e17f15432d523d12ce6f5ae9267dc77.1663025154.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 16:41, Pawan Gupta wrote:
> On an Intel Atom N2600 (and presumable other Cedar Trail models)
> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
> by msr_build_context().

This changelog needs some help.  Shouldn't it be something like this?

pm_save_spec_msr() keeps a list of all the MSRs which _might_ need to be
saved and restored at hibernate?? and resume??.  However, it has zero
awareness of CPU support for these MSRs.  It mostly works by
unconditionally attempting to manipulate these MSRs and relying on
rdmsrl_safe() being able to handle a #GP on CPUs where the support is
unavailable.

However, it's possible for reads (RDMSR) to be supported for a given MSR
while writes (WRMSR) are not.  In this case, msr_build_context() sees a
successful read (RDMSR) and marks the MSR as 'valid'.  Then, later, a
write (WRMSR) fails, producing a nasty (but harmless) error message.

To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
trying to manipulate the MSR when the feature bit is clear.  This
required adding a X86_FEATURE bit for MSRs that do not have one already,
but it's a small price to pay.
