Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889FE678C34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAWXnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAWXnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:43:18 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA630284
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:43:10 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 360FF824E0;
        Mon, 23 Jan 2023 23:43:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674517390;
        bh=9DfZPqZPMZoxg4dALK/KfFdag/hMsQm1yfpdpUWQNlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmCh6LwnGcm+A8xipz/T13V/dm/ltum2pcvT0pPb5G5biVrRXsu9RUUZxrpe6Eyti
         F57r+b8B+8GRqwEhFXR592b3h6LW/fuduCBp1o/EBEhxt53Y87PlbT1TAs3INVNf2e
         B8d7vsVcNru8bNpckIHtLOji6vmKKe7Uybecm0QAejEAMH+ztrXhajSjdBrZ4sc8Tb
         AJNW79Ey+lGoGpoFnogajzAHsnNJ5awyrQIqaGvLGqki8+Pu4K0yIRxLw4jnCTW4E0
         KEYmq8g79BBY99jdOT4cqBcxH9gz8qRbLYuInWytIoWYrkqeEmqFVnUgogcPgLu430
         m2jbYLnxicgkg==
Date:   Tue, 24 Jan 2023 06:43:02 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Message-ID: <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:43:35AM -0800, H. Peter Anvin wrote:
> Good spotting. %rax needs to be marked clobbered, too.

Yeah, that 'syscall' variable should be using a "+a" constraint.

But anyway, I found something wrong with this. I was playing with your
code and I found it failed to assert that %r11 == rflags_sentinel on a
non-FRED system. It happens because "popf" doesn't set the %rflags
to the expected value.

I tried to simplify it like this:

    pushq  $0x200893
    popf              # This popf sets %rflags to 0x200a93, not to 0x200893.
    pushf
    popq   %r11

    # Now %r11 == 0x200a93,
    # but the expected value is %r11 == 0x200893.

Looking into their bits:

    (gdb) p/t 0x200893
    $1 = 1000000000100010010011
    (gdb) p/t 0x200a93
    $2 = 1000000000101010010011

Align them to spot differences:

    0x200893 = 0b1000000000100010010011
    0x200a93 = 0b1000000000101010010011
                             ^

Or just xor them to find the differences:

    (gdb) p/x 0x200893 ^ 0x200a93
    $3 = 0x200

** Checks my Intel SDM cheat sheets. **

Then, I was like "Oh, that's (1 << 9) a.k.a. IF. Of course we can't
change rflags[IF] from userspace!!!".

In short, we can't use 0x200893 as the rflags_sentinel value because it
clears the interrupt flag.

-- 
Ammar Faizi

