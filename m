Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8059A6D1DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCaKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCaKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:11:52 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D522EA8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:06:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AE0F13200033;
        Fri, 31 Mar 2023 06:06:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 31 Mar 2023 06:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680257184; x=
        1680343584; bh=FVZsS7Q8CRL80mz+OBGzUgzxi1hLCre7tpFSwGVLW6c=; b=g
        74BrP38adlV3AUiyQeWoYGLAcME2rL0+pv7IBNgRy6IN357gg7OYoa8v7XXKHCAf
        sDJN9llWppir27pU7VawuVGewVQya18qdWb9m3BzXn9xIf9Jf5ORbIW4TGD1D+jq
        1aP7VSzB1jekwAqWdBof+0ntl6Q+0vaHvEL5UZKkJpaWg0NiOMKmcZE9g85WQXiS
        RlI/6IZHfNmuABWdMHt79cJp9rHkCX7H1TVPT3gQr126WGLsS12PS3AWxbRlIqZU
        SVsC8NBX9ahtIP75+R77Exa3xm9KTnx43AHvq8JskEi+WX9jMrNk525Z0BWdsE+h
        jfsMjnOvVBhc/a88cSytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680257184; x=1680343584; bh=FVZsS7Q8CRL80
        mz+OBGzUgzxi1hLCre7tpFSwGVLW6c=; b=jkzseWqPQU0PHhQ0L9uvlmc4Qs037
        yn69fNiTAsUORI1iOpm8Ydn5n/KrudKX3PPmsFv7WPQVt20+T+DDYfnu7uJqXj6J
        S4G7fcJkCCH1hpmEaAa+HS7aGcqrURVL3J4hbQoO3KaBno6hRcG/g2XvtmQD6FnG
        zvbepOzmB1o6Q5di+HHRGsLANgi27Us03rza7HjzCpOttk5Mfdu6rE22knuprcj2
        DGESYlEMcOeC/eV6FMKk0KYvBD0JIQ+yyzlYl2oKsS4Uafh9/eUKtc4MF6me9jaC
        rH8gmJ2MNYptvBesPLd4e27ZSVHFFQj6QX7eAzDT9ITb1ZQbDTGRJthWA==
X-ME-Sender: <xms:n7AmZCiyPLc473zVQ-ooSbe5rAxhDwcKKkaaJAZlumyvdgZPU2vy0w>
    <xme:n7AmZDDnvcF8SGLwDatm3-DtIpprd-N-zdmsqzmm_LHxSdI7HI1C1tzITzzzqYQvn
    PcsM7qNOfI8JgZ-0Sc>
X-ME-Received: <xmr:n7AmZKHnMNPthmjaJnzkprv1Bdb9BSk4ajiOVEGmLjlZYlB1bzr1IhmJ-J17CqvCHb4e0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:n7AmZLSxPEcaISG2qDhikX6Zp2TIhjj57cy7YswzZE67LN5s1G3KUg>
    <xmx:n7AmZPwlswKnGaR1fv46FK3FpVXn_1-O_0h1QcpHYP2BQo2FqEjC5g>
    <xmx:n7AmZJ4wnicpdKChFb7DNV85LvKvWl3QneT0OCRAvOhPqCNbmOkiRw>
    <xmx:oLAmZHencbLNpH18mBGebEOtlS-7M3D_DReY3HSI4YDWRaFWgd8CVw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 06:06:23 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2468F104994; Fri, 31 Mar 2023 13:06:20 +0300 (+03)
Date:   Fri, 31 Mar 2023 13:06:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Laight <David.Laight@ACULAB.COM>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wutu.xq2@linux.alibaba.com" <wutu.xq2@linux.alibaba.com>
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Message-ID: <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
 <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
> From: Wu Zongyong
> > Sent: 31 March 2023 03:24
> > 
> > On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
> > > On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> > > > It seems MOVSXD which opcode is 0x63 is not handled, support
> > > > to decode it in insn_decode_mmio().
> > >
> > > Do you have a particular user in mind?
> > To be honest, I don't find a specific user which uses the MOVSXD.
> > 
> > But both Intel and AMD's instructions reference contains MOVSXD and lots
> > of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
> > may be useful to support it in insn_decode_mmio().
> > 
> > Are there some special consideration about this instruction?
> 
> It is a sign-extending memory read (32bit to 64bit).
> You pretty much never want to do that to a device register.
> Also kernel code should be using readl() (etc) which do
> unsigned reads.
> So they should never happen for mmio.
> 
> Of course, if you mmap() PCIe space directly into a program's
> address space anything might happen ...

There are two users of the interface: TDX and SEV. TDX doesn't allow
userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.

Tom?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
