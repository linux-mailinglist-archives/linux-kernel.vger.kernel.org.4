Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2969D673
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjBTWtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjBTWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:49:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69576FF20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:49:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676933386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4REKONumzntUhpjAdx/ul7dch4UeuVuiZYvJXFD06E=;
        b=jKTsBSIcF97lEYrZMgUtc8x7jgln4+fAVn61Zw1TpEnIA3AhJIMj+Fn9CCKyyDDHZowvr/
        hAb2/ruThXViPdro0ibVF0Pd2UwC4RCM8g4xEutD9b0gKkR6+LgL12hUId76+e61nUDw9e
        0SRVqcDA4K3DQRHrV7kLs2Lm/qbgTCGipiULCzh9zXeo59UmpfBhpjfuIvJ7uslmWufsUM
        L06RDBmDHu90enIJGNqVx2k9vKu212DPCiyYAN4ZCgEfDd2JhrToz5BEFzdBuyq9k5vktC
        4KD8IFWXInk72UVEEWC5u8Auxl1XwTglLc33IxGPka0Y46Rcy3DOtl0cDuLQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676933386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4REKONumzntUhpjAdx/ul7dch4UeuVuiZYvJXFD06E=;
        b=Lzqakw22zZENwWxxGe7/x3cxDQcjLjCFA38C3NhqA7RmglMeyAT8WXc06I54PuVt3f9wuS
        JIaS7DHSEqrkW0CQ==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
In-Reply-To: <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
 <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
Date:   Mon, 20 Feb 2023 23:49:45 +0100
Message-ID: <87edqkosty.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20 2023 at 14:33, Rui Zhang wrote:
> On Mon, 2023-02-20 at 12:08 +0100, Peter Zijlstra wrote:
>> Also, perhaps you want to look at calculate_max_logical_packages().
>> That has a comment about there not being heterogeneous systems :/
>
> yeah, I noticed this previously.
>
>         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
>         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
>
> The DIV_ROUND_UP() makes it to work on systems with current asymmetric
> core systems. But
> 1. if a core can support more than 2 HT siblings, this can break if
> there are multi symmetric packages.
> 2. if the system has asymmetric packages, this can break.
> So far we don't have such platforms.
> 3. it can also be broken when using boot option 'maxcpus' as booted_cor
> es changes.
>
> But ironically, we don't have a better way to get __max_logical_packages.

Sadly enough this was communicated to Intel hard/firmware people many
years ago.

>> Anyway, the reason I went and had a look there, is because I remember
>> Thomas and me spend entirely too much time to try and figure out
>> means
>> to size an array for number of pacakges at boot time and getting it
>> wrong too many times to recount.
>> 
>> If only there was a sane way to tell these things without actually
>> bringing everything online first :-(
>
> I thought of improving this by parsing all the valid APIC-IDs in MADT
> during BSP bootup, and get such information by decoding the APIC-IDs
> using the APIC-ID layout information retrieved from BSP. But this is
> likely to be a fertile new source of bugs as Dave concerned.

The APIC-IDs are only usefull if there is an architected scheme how they
are assigned. Is there such a thing?

The SDM is not helpful at all, but according to the ACPI spec there
exists:

  Processor Properties Topology Table (PPTT)

That table actually provides pretty much what we are looking for, but
that table is optional and there is actually code for that in the
kernel, which is ARM64 specific.

So while this would be useful it's not usable on x86 because that would
make too much sense, right?

Thanks,

        tglx
