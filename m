Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D525E6A0D78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjBWQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjBWQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781F137726
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677168031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf5SCrPN7PXFqJ124Pgf7U6gRRFbIhLBQzEmAht0jJg=;
        b=LxAgFT6TtR/00NtWGtG4+E4/LNVEmgzM693KvN3b3UVWCWSG02E2M25lRjC8WRfOebO0IK
        XJskJ23o0f1ihglvdxxP3Y/Z/ZBWHDsCP/+Kfq3LzdYMz6B0t2rZQ0eyGpmy29AK5TVbIM
        uz76gVPxytcgJBSWHjLkImclSjkRbNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607--1jXzU_7PRmVsIqEwn375g-1; Thu, 23 Feb 2023 11:00:18 -0500
X-MC-Unique: -1jXzU_7PRmVsIqEwn375g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1014A85D18D;
        Thu, 23 Feb 2023 16:00:13 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7638B404BEC0;
        Thu, 23 Feb 2023 16:00:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 46AF0400DC95C; Thu, 23 Feb 2023 11:34:06 -0300 (-03)
Date:   Thu, 23 Feb 2023 11:34:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
Message-ID: <Y/d5XhtOaYkNRnpQ@tpad>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
 <20230221041440.GA1934@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221041440.GA1934@templeofstupid.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
> On Mon, Feb 20, 2023 at 11:01:18PM +0100, Thomas Gleixner wrote:
> > On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> > > @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
> > >  	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > >  	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > >  
> > > -	/* tsc_mode = no_emulate (2) */
> > > -	if (ebx != 2)
> > > +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
> > >  		return 0;
> > >  
> > >  	return 1;
> > 
> > What about removing more stupidity from that function?
> > 
> > static bool __init xen_tsc_safe_clocksource(void)
> > {
> > 	u32 eax, ebx. ecx, edx;
> >  
> > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > 
> > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> > }
> 
> I'm all for simplifying.  I'm happy to clean up that return to be more
> idiomatic.  I was under the impression, perhaps mistaken, though, that
> the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
> check_tsc_unstable() checks were actually serving a purpose: to ensure
> that we don't rely on the tsc in environments where it's being emulated
> and the OS would be better served by using a PV clock.  Specifically,
> kvmclock_init() makes a very similar set of checks that I also thought
> were load-bearing.

kvmclock_init will lower the rating of kvmclock so that TSC clocksource
can be used instead:

        /*
         * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
         * with P/T states and does not stop in deep C-states.
         *
         * Invariant TSC exposed by host means kvmclock is not necessary:
         * can use TSC as clocksource.
         *
         */
        if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
            boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
            !check_tsc_unstable())
                kvm_clock.rating = 299;



