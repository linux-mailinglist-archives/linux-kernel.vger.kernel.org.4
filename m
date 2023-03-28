Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150F6CB568
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjC1E0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1E0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3A1BF9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679977526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMNSejxnX4U/6qwiydV9BBtn3L7BUvZOYY/Mz3nRvSM=;
        b=HNi3bbSM49UeVNr5qPhFXRiGH6fanQjOGC/mIvSugREkTzYei0g1jkolACe9P22cv+newc
        yZwN1e5y7PgmZlbbVSAszA8C7fuGi/aDUWZ0antULQNTMnGCOABosexWOnYU2eYv8oImvi
        dHf/R7FEF/fjW9irF60BxbQiyKcHwE4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-jcZ_8fIZNiqa9W6m_kYecQ-1; Tue, 28 Mar 2023 00:25:20 -0400
X-MC-Unique: jcZ_8fIZNiqa9W6m_kYecQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 142373C02B7A;
        Tue, 28 Mar 2023 04:25:20 +0000 (UTC)
Received: from localhost (ovpn-12-210.pek2.redhat.com [10.72.12.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BF9D1415139;
        Tue, 28 Mar 2023 04:25:18 +0000 (UTC)
Date:   Tue, 28 Mar 2023 12:25:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <ZCJsKoKESK+FCQ0a@MiWiFi-R3L-srv>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
 <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
 <ZCDy+nsjPsi/Lllh@MiWiFi-R3L-srv>
 <20230327110932.z3wjdgfuay5dd2or@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327110932.z3wjdgfuay5dd2or@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/23 at 02:09pm, Kirill A. Shutemov wrote:
> On Mon, Mar 27, 2023 at 09:35:54AM +0800, Baoquan He wrote:
> > On 03/26/23 at 10:01am, Dave Hansen wrote:
> > > On 3/25/23 12:25, Kirill A. Shutemov wrote:
> > > > On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
> > > >> On 3/25/23 09:01, Kirill A. Shutemov wrote:
> > > >>> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> > > >>> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> > > >>> it has woken up.
> > > >> ...
> > > >>> +int arch_kexec_load(void)
> > > >>> +{
> > > >>> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > > >>> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> > > >>> +		return -EOPNOTSUPP;
> > > >>> +	}
> > > >>> +
> > > >>> +	return 0;
> > > >>> +}
> > > >>
> > > >> So, let's put all this together:
> > > >>
> > > >> 1. TDX implementations use MADT for wakeup exclusively right now (but
> > > >>    are not necessarily _required_ to do so forever)
> > > >> 2. MADT doesn't support CPU offlining
> > > >> 3. kexec() requires offlining
> > > >>
> > > >> Thus, current TDX implementations can't support TDX guests.  This
> > > >> *doesn't* say that TDX will always use the MADT for wakeups.
> > > >>
> > > >> Yet, the check you have here is for TDX and *not* for the MADT.
> > > > 
> > > > As I described in the commit message there are more than MADT that is
> > > > required to get kexec in TDX guest.
> > > 
> > > I kinda think we should do both.
> > > 
> > > Let's make sure that all systems that depend on MADT wakeups can't
> > > kexec() until the ACPI folks work out what to do there.
> > > 
> > > Separately, let's either fix or *mark* the kexec()-incompatible pieces
> > > that *ARE* specific to TDX.
> > > 
> > > >> That seems wrong.
> > > >>
> > > >> Let's say SEV or arm64 comes along and uses the MADT for their guests.
> > > >> They'll add another arch_kexec_load(), with a check for *their* feature.
> > > >>
> > > >> This all seems like you should be disabling kexec() the moment the MADT
> > > >> CPU wakeup is used instead of making it based on TDX.
> > > > 
> > > > I guess we can go this path if you are fine with taking CR4.MCE and shared
> > > > memory reverting patches (they require some rework, but I can get them
> > > > into shape quickly). After that we can forbid kexec on machines with MADT
> > > > if nr_cpus > 1.
> > > 
> > > This goes back to what I asked before: is anyone actually going to *use*
> > > a single-processor system that wants to kexec()?  If not, let's not
> > > waste the time to introduce code that is just going to bitrot.  Just
> > > mark it broken and move on with life.
> > 
> > Now we have two API for kexec: kexec_load and kexec_file_load. They can
> > be used to do kexec reboot, or crash dumping. For crash dumping, we
> > usually only use one cpu to do the vmcore dumping. At least on our
> > Fedora/centos-stream/RHEL, we do like this with kernel parameter
> > 'nr_cpus=1' added by default. Unless people explicitly remove the
> > 'nr_cpus=1' restriction or set nr_cpus= to other number to persue
> > multithread dumping in kdump kernel.
> 
> Hm. I'm not sure how to determine if the target kernel wants to use >1
> CPU. Scanning cmdline looks fragile. And who said the target kernel is
> Linux.

Ah, I forgot the checking and disabling is done in 1st kernel, it's truly
not convinent to get 2nd kernel's cmdline. Then disabling kexec on TDX
guest for the time being looks resonable to me.

> 
> I guess we can park all CPUs, but CPU0 and target kernel will just fail to
> bring them up which is non-fatal issue (at least for Linux).
> 
> I admit that all looks hackish.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

