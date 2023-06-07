Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA184727198
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjFGWZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFGWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:25:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9664E2689
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686176697; x=1717712697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWrcl5RLtV27uRfGpUsqXK1OJLGa0Ts8dBhu0iCMJjQ=;
  b=kffq3Hu9c6tpIVmktmCW3xaOJ3ORCwz1gmOMjvG7xFecIiPFg+lH/AF+
   B4eBW3rfgzsXSqrqW00lEDK1Uns6QCNyKba70JtfDfC9htJuHSPMzBLNX
   sTPddlD44lOLI/NfsysiERpDVv/E4jm940B45tN/uHBbmI4l63MD+Up/d
   UMdKA+c5oSj4PohHFuRGzkyy4m3ugZNBQ56DPkPnEAE3zm9+wEdJOqOs2
   s0JTGP3qeyzEZwh6nqpnRdN2EH0fT+lUWaQ5cVJWKd8qe6a32uVOgbzmk
   mDJCSJFOfmvsqGSLivd2XSPvYxRNQjgMxXcA+JDiJk88BbF2aNqU7MNho
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355982217"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="355982217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 15:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703839900"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="703839900"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 15:20:47 -0700
Date:   Wed, 7 Jun 2023 15:19:16 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Message-ID: <ZIECZMHxtEYnuBAJ@araj-dh-work>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx>
 <ZICuhZHCqSYvR4IO@araj-dh-work>
 <ZIC/b+AwvH2wIz/o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIC/b+AwvH2wIz/o@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:33:35AM -0700, Sean Christopherson wrote:
> On Wed, Jun 07, 2023, Ashok Raj wrote:
> > On Tue, Jun 06, 2023 at 12:41:43AM +0200, Thomas Gleixner wrote:
> > > On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
> > > > On Sat, Jun 03, 2023, Thomas Gleixner wrote:
> > > >> This is only half safe because HLT can resume execution due to NMI, SMI and
> > > >> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
> > > >
> > > > On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
> > > > single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
> > > > *might* cause shutdown, but at least there's a chance it will work.  And presumably
> > > > modern CPUs do pend the #MC until GIF=1.
> > > 
> > > Abusing SVME for that is definitely in the realm of creative bonus
> > > points, but not necessarily a general purpose solution.
> > > 
> > > >> So parking them via INIT is not completely solving the problem, but it
> > > >> takes at least NMI and SMI out of the picture.
> > > >
> > > > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> > > > potentially cause problems too?
> > > 
> > > Not that I'm aware of. If so then this would be a hideous firmware bug
> > > as firmware must be aware of CPUs which hang around in INIT independent
> > > of this.
> > 
> > SMM does do the rendezvous of all CPUs, but also has a way to detect the
> > blocked ones, in WFS via some package scoped ubox register. So it knows to
> > skip those. I can find this in internal sources, but they aren't available
> > in the edk2 open reference code. They happen to be documented only in the
> > BWG, which isn't available freely.
> 
> Ah, so putting CPUs into WFS shouldn't result in odd delays.  At least not on
> bare metal.  Hmm, and AFAIK the primary use case for SMM in VMs is for secure

Never knew SMM had any role in VM's.. I thought SMM was always native. 

Who owns this SMM for VM's.. from the VirtualBIOS?

> boot, so taking SMIs after booting and putting CPUs back into WFS should be ok-ish.
> 
> Finding a victim to test this in a QEMU VM w/ Secure Boot would be nice to have.

I always seem to turn off secureboot installing Ubuntu :-).. I'll try to
find someone who might know especially doing SMM In VM. 

Can you tell what needs to be validated in the guest?  Would doing kexec
inside the guest with the new patch set be sufficient? 

Or you mean in guest, do a kexec and launch secure boot of new kernel?

If there is a specific test you want done, let me know.
