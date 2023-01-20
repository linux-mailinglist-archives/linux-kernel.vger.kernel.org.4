Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04F6753D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjATLuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjATLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:49:49 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA6B2E40
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:49:44 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NyyTX1vfFz9sZF;
        Fri, 20 Jan 2023 12:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1674215376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92KU+WEdaKmCx89GUNEMzmScd/kAwMjKbyFV6AyGaZg=;
        b=x220oPkqG04YU08/LUhccN4/VVJi4bf4m35RXWYgQsGcptABcN+2nVv8WLBea+UQ+2ZnL/
        qbKmjc4lKM3pI2YfbIzYRnC7F1ehHhVc5gfYRTGC2ndKq/njyDBG/yAGCPdL5JTiMIZZB4
        fGoLOfFGDWJqGxo031C2Qy4tcIk0MPu8xEQn8rx+xA/kTPNHiz4mX5k5XHw8NnoVamfwxX
        5OoDhh+pbs4r2146C4JhJzKCzim8gQWGzgMk0kug7nazC0SuWqEJsuJnTCWYtPhGEGNPrR
        ibr2gjIt930Uk69k/Ly8MbRfxk79R0T/LUj7zStCTpE2GM5o1YP0s72oMfY3QA==
Date:   Fri, 20 Jan 2023 12:49:33 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <20230120124933.69c3ae99@yea>
In-Reply-To: <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
        <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
        <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
        <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
        <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3y4poe14iazdh46o4tu1kdiytfccighf
X-MBO-RS-ID: e3cceb96acebe8aaa38
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 12:16:26 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 20, 2023 at 11:20:53AM +0530, Sandipan Das wrote:
> 
> > With the combination of defconfig+kvm_guest.config+localyesconfig, the only
> > thing that made a difference was the compiler optimization choice. The kernel
> > boots up with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y but not with
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Both Clang 15 and 16 kernel builds are affected.  
> 
> *groan*..
> 
> 0000000000000350 <amd_pmu_add_event>:
> 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4
> 
> and static_call() can't deal with Jcc, I wonder why we've not seen that
> before -- this isn't totally idiotic code-gen and esp. clang is known to
> do this (see the retpoline thing).
> 
> Let me see if I can do something about that.

I can confirm that with -O2 I get a booting kernel with netconsole output using the .config I originally posted.

However the machine does not finish booting, even with -O2. In the netconsole dmesg I get to the point "Run /sbin/init as init process" but that's it, no on-screen ouput on the laptop itself... So there seem to be 2 issues.

And sorry for my custom .config! Forgot that it was tailored for my Lenovo Thinkpad A275. Next time I'll try to replicate my issues with a more generic config (hopefully) bootable on a VM.

Regards,
Erhard
