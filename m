Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D357265C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFGQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:22:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499521FC4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686154978; x=1717690978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/JdBz1OAl+lZBpvZKH84j111UsFWU7StDH6W6EAR7MA=;
  b=WR+I7ncd2HBfplm7B+SRYcaR3QmjjttV1Im7g/LH9EwmRZl0HTzZ76qv
   tS+5AEYCc1K9Xe1CKLyC2oU68uNupSnT+Z2lBxQQMgJMljyDNfnWgZHZb
   3id845lkwO4mtELfxvBZTBuzAG3pIbEcypCQqEHgT2I1NeQwG3eBjnbxy
   ltygI18MEqhtLfSxQW+m0GTVJZioMIg6SnQGe7QbZ7MHnI9+VE3Xnn3DX
   CvR723g1A36LMvSGMV/0UgxNNp1SYbOS56lbi+2Zq9pu2uIFt79pvSmEU
   nIYCHDBiqMDzn3AWfT9neGA6QRCji6jq69mECJs5t87xGn/FkGELeZddW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="385366854"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="385366854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="712719091"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="712719091"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:22:57 -0700
Date:   Wed, 7 Jun 2023 09:21:25 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Message-ID: <ZICuhZHCqSYvR4IO@araj-dh-work>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm694jmg.ffs@tglx>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:41:43AM +0200, Thomas Gleixner wrote:
> On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
> > On Sat, Jun 03, 2023, Thomas Gleixner wrote:
> >> This is only half safe because HLT can resume execution due to NMI, SMI and
> >> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
> >
> > On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
> > single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
> > *might* cause shutdown, but at least there's a chance it will work.  And presumably
> > modern CPUs do pend the #MC until GIF=1.
> 
> Abusing SVME for that is definitely in the realm of creative bonus
> points, but not necessarily a general purpose solution.
> 
> >> So parking them via INIT is not completely solving the problem, but it
> >> takes at least NMI and SMI out of the picture.
> >
> > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> > potentially cause problems too?
> 
> Not that I'm aware of. If so then this would be a hideous firmware bug
> as firmware must be aware of CPUs which hang around in INIT independent
> of this.

SMM does do the rendezvous of all CPUs, but also has a way to detect the
blocked ones, in WFS via some package scoped ubox register. So it knows to
skip those. I can find this in internal sources, but they aren't available
in the edk2 open reference code. They happen to be documented only in the
BWG, which isn't available freely.

I believe its behind the GetSmmDelayedBlockedDisabledCount()->
	SmmCpuFeaturesGetSmmRegister() 
