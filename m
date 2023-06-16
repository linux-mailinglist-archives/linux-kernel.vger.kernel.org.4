Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77616732963
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjFPICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFPICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:02:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899381FD7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/h7ptSjmrjGNVXx3sl40Rmz9oev998DxwHWJ5AOlooM=; b=J9WJ9fdtVfm/SeEXznFC+bef/U
        07yl+nwkohaQqMts4p/xQ+1ReyMp4oQAXiZn9dukLEgWN4mdjG8OShJLmuRZmGebyrqerfJuchipU
        tuzaFiDPprUUJEgZdPwH5cMcmJtBE1hXjXJ9CHpD96r8nm8JYbcBUIx3giO5y+xJVLqLaPI+7fHwD
        xGVTHt6BJ+E3YgV38HY4710KLktfuMTjP1g3LVsfu5UYSb1T19Mu282SaloYiIDirh51jyeKLPDIn
        PpTd3BuQu7zNLfnsRDfv+lTGn9PuwaPST9JiilU7M6Q3/60hm7BVjMvCWq64+l4k4pFEm4jhqAb1a
        CTquXZKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA4Pg-008h60-MB; Fri, 16 Jun 2023 08:02:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C0E3300208;
        Fri, 16 Jun 2023 10:02:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56FCB2008E47B; Fri, 16 Jun 2023 10:02:31 +0200 (CEST)
Date:   Fri, 16 Jun 2023 10:02:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:53:21AM +0000, Zhang, Rui wrote:
> On Thu, 2023-06-15 at 11:20 +0200, Peter Zijlstra wrote:

> > So I have at least two machines where I boot with 'possible_cpus=#'
> > because the BIOS MADT is reporting a stupid number of CPUs that
> > aren't
> > actually there.
> 
> Does the MADT report those CPUs as disabled but online capable?
> can you send me a copy of the acpidmp?

Sent privately, it's a bit big.

> I had a patch to parse MADT and count the number of physical packages
> by decoding all the valid APICIDs in MADT.
> I'm wondering if the patch still works on this machine.

I can certainly give it a spin; it has IPMI serial-over-ethernet that
works. Brilliant dev machine.

> > So I think I'm lucky and side-stepped this nonsense, but if someone
> > were
> > to use nr_cpus= for this same purpose, they get screwed over and get
> > the
> > watchdog. Sad day for them I suppose.
> 
> what if using package_count_from_MADT?

So I'm thinking that if you cap possible_mask the actual logical
packages is the right number.

Suppose you have a machine with 8 sockets, but limit possible_mask to
only 1 socket. Then TSC will actually be stable, it doesn't matter you
have 7 idle sockets that are not synchronized.

Then again, perhaps if you limit it to 2 sockets you're still in
trouble, I'm not entirely sure how the TSC sync stuff comes apart on
these large systems.
