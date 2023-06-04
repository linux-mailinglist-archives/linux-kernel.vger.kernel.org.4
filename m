Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE224721608
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFDKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFDKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:25:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A645E0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685874332; x=1717410332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BFuHYTo96KVRYmLJAGn3MPzGjuz0gcyUnANZWXbqx98=;
  b=fFqiylzP6cVjxa6p1z2KcdzXlPEDoz85FjV+6aPGlyg2QxiKeAWR9FEc
   4T4OsHaiRv35dtV7zsfDl/iDaK6nE0FmllyquWVSreD2w/BiDWCyOkuw4
   Mg42FIAeiU3j4/2y8QVPojLzqebxSA/2q5PqNsim2kloUx412enzzCcG7
   FIRAJp+J3x36HqijbsfD8U2GugBpV7rryeQYCN9+FjHpHmPffEt1XG9gb
   JF8tcy9Oy+0U7Qzmytd76cfDyHsC6cEPStK1RNLqc0K7k82bq4ugr54se
   MU7YStWKWEW0/AoXevFTe8dhbqARfbQ4hiM5J/UKX+Lcz/lKHZ56PKsmw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356185133"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356185133"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 03:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="658754466"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658754466"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 03:25:31 -0700
Date:   Sun, 4 Jun 2023 03:24:01 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@mbosol.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 5/6] x86/smp: Split sending INIT IPI out into a helper
 function
Message-ID: <ZHxmQQ8h/MctCjyK@araj-dh-work>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.889612295@linutronix.de>
 <b9cef72f-0bcf-5bd6-e828-f11bd822fe33@mbosol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9cef72f-0bcf-5bd6-e828-f11bd822fe33@mbosol.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sun, Jun 04, 2023 at 07:02:33AM +0300, Mika Penttilä wrote:
> Hi,
> 
> On 3.6.2023 23.07, Thomas Gleixner wrote:
> > Putting CPUs into INIT is a safer place during kexec() to park CPUs.
> > 
> > Split the INIT assert/deassert sequence out so it can be reused.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >   arch/x86/kernel/smpboot.c |   51 +++++++++++++++++++---------------------------
> >   1 file changed, 22 insertions(+), 29 deletions(-)
> > 
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -853,47 +853,40 @@ wakeup_secondary_cpu_via_nmi(int apicid,
> >   	return (send_status | accept_status);
> >   }
> > -static int
> > -wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
> > +static void send_init_sequence(int phys_apicid)
> >   {
> > -	unsigned long send_status = 0, accept_status = 0;
> > -	int maxlvt, num_starts, j;
> > -
> > -	maxlvt = lapic_get_maxlvt();
> > +	int maxlvt = lapic_get_maxlvt();
> > -	/*
> > -	 * Be paranoid about clearing APIC errors.
> > -	 */
> > +	/* Be paranoid about clearing APIC errors. */
> >   	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
> > -		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
> > +		/* Due to the Pentium erratum 3AP.  */
> > +		if (maxlvt > 3)
> >   			apic_write(APIC_ESR, 0);
> >   		apic_read(APIC_ESR);
> >   	}
> > -	pr_debug("Asserting INIT\n");
> > -
> > -	/*
> > -	 * Turn INIT on target chip
> > -	 */
> > -	/*
> > -	 * Send IPI
> > -	 */
> > -	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT,
> > -		       phys_apicid);
> > -
> > -	pr_debug("Waiting for send to finish...\n");
> > -	send_status = safe_apic_wait_icr_idle();
> > +	/* Assert INIT on the target CPU */
> > +	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT, phys_apicid);
> > +	safe_apic_wait_icr_idle();
> >   	udelay(init_udelay);
> > -	pr_debug("Deasserting INIT\n");
> > -
> > -	/* Target chip */
> > -	/* Send IPI */
> > +	/* Deassert INIT on the target CPU */
> >   	apic_icr_write(APIC_INT_LEVELTRIG | APIC_DM_INIT, phys_apicid);
> > +	safe_apic_wait_icr_idle();
> > +}
> > +
> > +/*
> > + * Wake up AP by INIT, INIT, STARTUP sequence.
> > + */
> > +static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
> > +{
> > +	unsigned long send_status = 0, accept_status = 0;
> > +	int maxlvt, num_starts, j;

Also maxlvt used uninitialized.

> > +
> > +	preempt_disable();
> 
> This seems like an unbalanced preempt disable..
> 
> > -	pr_debug("Waiting for send to finish...\n");
> > -	send_status = safe_apic_wait_icr_idle();
> > +	send_init_sequence(phys_apicid);
> >   	mb();
> > 
> 
> 
> --Mika
> 
