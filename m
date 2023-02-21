Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED6F69DC77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjBUJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:01:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009A23D84
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGvA+hE+XScDWPe/15r8RAKfRJCxS3MB1AB8lNkzZFE=; b=NsjZU8xTHk8ps1LCbAPOxwdHpc
        y7VWHwQNMM456P0tPKxAIMg9TCFaiKywlDMJfzwipJhl1OvVZDgadL0defwpFHLHSDC0IeGVpjPr/
        qfMPw09vUgyCzJvE6E4Clkv4ymHyXwIWQbDduozafjC7skrBvRZ3J3/9OjJtlnfApXQoivYjvkqCS
        TCUwgAYyrZhkMFq968xF9Fi+x7Ug6MpHwfoB8LpR4+r+3dSnoJduxZDCkp3k9NBcQFvarXOtFriKo
        zGtjhSkbeUd4GBHbR4TIu8bVkVvLWfTQKYO9cgnNRwDePlgPfgPbRJ9Z/T1WE6koI3dwPNJ9wmF7/
        FHLxln/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUOW7-00CSyZ-Qz; Tue, 21 Feb 2023 09:00:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 610E2300472;
        Tue, 21 Feb 2023 10:00:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43FCF2024966D; Tue, 21 Feb 2023 10:00:54 +0100 (CET)
Date:   Tue, 21 Feb 2023 10:00:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Message-ID: <Y/SIRmCE1KJdsRBT@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
 <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
 <87edqkosty.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edqkosty.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:49:45PM +0100, Thomas Gleixner wrote:

> > I thought of improving this by parsing all the valid APIC-IDs in MADT
> > during BSP bootup, and get such information by decoding the APIC-IDs
> > using the APIC-ID layout information retrieved from BSP. But this is
> > likely to be a fertile new source of bugs as Dave concerned.
> 
> The APIC-IDs are only usefull if there is an architected scheme how they
> are assigned. Is there such a thing?

Isn't that given through CPUID? Or are we worried each CPU will have
different values in the topology leafs?

We really should have added that CPUID uniformity sanity check a long
while ago :-(
