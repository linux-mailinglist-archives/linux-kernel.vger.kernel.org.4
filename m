Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8036CA231
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjC0LJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0LJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:09:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44AA46A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:09:35 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 164BC5C00D2;
        Mon, 27 Mar 2023 07:09:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 Mar 2023 07:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679915375; x=
        1680001775; bh=zuQVwgWzdxxG6OjMCmHkNo6kbIdD+LHMQN/MYMfDnfI=; b=H
        m8R6xPILIfJfAPKhshVfzFX/gsc6lcgoXxfJ1Sshiw7BaNEMKl0UoblsIyECaU3g
        K/dYOV3LcZEAsCvKyt54Dech9daqJ0oj4nsY8RPxbilJrcz+UBgMB7LWq5cjS8+G
        ghGnAy8roY4t+PmX87LqbRAm3XUUPbiu1K5BpUjkRQRYd7o1eI/WiYpPJrYBqBrb
        Z+J751Sx09GjnGgeRELdEGS2k8T11F5jY7dMh/inBFTKjVMqLWEhnNm18pvMTJBA
        RrIvj5dyVMyQbnxTnoghXhAfZbLVaQi8piAfpJ6UEsMesCGw7gcKMZ+9L6er5NaY
        52jv7Y9sN0JPHVg18+GxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679915375; x=1680001775; bh=zuQVwgWzdxxG6
        OjMCmHkNo6kbIdD+LHMQN/MYMfDnfI=; b=l1U9RT21ubrfotWDtweeWbt9jMx/9
        InYi7kUThBSBCuVvResq9UiqT6Z6JInNRZuF96huKKqf8xlHqxI7TjSHew/CRNhj
        Y9SuvYcr1saIFHtQXL3027/iTNuOsrmXBwlRR90LYZxhoBRk1xgTyCAahyp2OimB
        3sZp4Ok480/SyqQ45VC7n2aXcY9C9vhQTiryt3SvzzTWDU/HDlPVEdmf9UCZ11fw
        1D5G8yEvUgiT/cliZYvtvTZkslTK4iqwV2JnzyhMp57DDsW/HUqa7Xy7U/DDH7Jw
        /saHZT7Os23LSUodgF57l0KUbKoeGk3Sdf8qjVlwLRtn7aaEG+ZG4KNew==
X-ME-Sender: <xms:bnkhZKVs2jEK_6bE7yclsW_86dv6BehI_ldYO7wMIGcOXg9VzXnq3Q>
    <xme:bnkhZGmcrv1WcDuuthXLtAIKcqV8wNmd29HJrqaA-fSHNxCmZfxu3dLDUVuin-yAH
    9mwXuDkMb_U_ItHm8k>
X-ME-Received: <xmr:bnkhZOZGCxrkTaWxpKRwWnSEZ1Y0rImIleP2vKnEWafeLNytW_q34Dun0QjvJNCCNdFqwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:bnkhZBVAa03v1HEsfX61m3ICe2toU5t38qhRdOt1h7Yp8LZdOUxqfg>
    <xmx:bnkhZEnr3NeEOn-bUHZNw0EPaXRgTCpbUDU2MFLyOWGSnX2QQ-8UPA>
    <xmx:bnkhZGdgphpN-2qo-PvWein5LhsotSHpPaRSJZGVYejrYb3fZ3lnlQ>
    <xmx:b3khZBiQVIXy8V-2pBFlBSqg5fSuIcUZRrObyHb4RIlu09BJ0SQfYg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 07:09:34 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 99789109BD6; Mon, 27 Mar 2023 14:09:32 +0300 (+03)
Date:   Mon, 27 Mar 2023 14:09:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <20230327110932.z3wjdgfuay5dd2or@box.shutemov.name>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
 <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
 <ZCDy+nsjPsi/Lllh@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCDy+nsjPsi/Lllh@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:35:54AM +0800, Baoquan He wrote:
> On 03/26/23 at 10:01am, Dave Hansen wrote:
> > On 3/25/23 12:25, Kirill A. Shutemov wrote:
> > > On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
> > >> On 3/25/23 09:01, Kirill A. Shutemov wrote:
> > >>> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> > >>> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> > >>> it has woken up.
> > >> ...
> > >>> +int arch_kexec_load(void)
> > >>> +{
> > >>> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > >>> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> > >>> +		return -EOPNOTSUPP;
> > >>> +	}
> > >>> +
> > >>> +	return 0;
> > >>> +}
> > >>
> > >> So, let's put all this together:
> > >>
> > >> 1. TDX implementations use MADT for wakeup exclusively right now (but
> > >>    are not necessarily _required_ to do so forever)
> > >> 2. MADT doesn't support CPU offlining
> > >> 3. kexec() requires offlining
> > >>
> > >> Thus, current TDX implementations can't support TDX guests.  This
> > >> *doesn't* say that TDX will always use the MADT for wakeups.
> > >>
> > >> Yet, the check you have here is for TDX and *not* for the MADT.
> > > 
> > > As I described in the commit message there are more than MADT that is
> > > required to get kexec in TDX guest.
> > 
> > I kinda think we should do both.
> > 
> > Let's make sure that all systems that depend on MADT wakeups can't
> > kexec() until the ACPI folks work out what to do there.
> > 
> > Separately, let's either fix or *mark* the kexec()-incompatible pieces
> > that *ARE* specific to TDX.
> > 
> > >> That seems wrong.
> > >>
> > >> Let's say SEV or arm64 comes along and uses the MADT for their guests.
> > >> They'll add another arch_kexec_load(), with a check for *their* feature.
> > >>
> > >> This all seems like you should be disabling kexec() the moment the MADT
> > >> CPU wakeup is used instead of making it based on TDX.
> > > 
> > > I guess we can go this path if you are fine with taking CR4.MCE and shared
> > > memory reverting patches (they require some rework, but I can get them
> > > into shape quickly). After that we can forbid kexec on machines with MADT
> > > if nr_cpus > 1.
> > 
> > This goes back to what I asked before: is anyone actually going to *use*
> > a single-processor system that wants to kexec()?  If not, let's not
> > waste the time to introduce code that is just going to bitrot.  Just
> > mark it broken and move on with life.
> 
> Now we have two API for kexec: kexec_load and kexec_file_load. They can
> be used to do kexec reboot, or crash dumping. For crash dumping, we
> usually only use one cpu to do the vmcore dumping. At least on our
> Fedora/centos-stream/RHEL, we do like this with kernel parameter
> 'nr_cpus=1' added by default. Unless people explicitly remove the
> 'nr_cpus=1' restriction or set nr_cpus= to other number to persue
> multithread dumping in kdump kernel.

Hm. I'm not sure how to determine if the target kernel wants to use >1
CPU. Scanning cmdline looks fragile. And who said the target kernel is
Linux.

I guess we can park all CPUs, but CPU0 and target kernel will just fail to
bring them up which is non-fatal issue (at least for Linux).

I admit that all looks hackish.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
