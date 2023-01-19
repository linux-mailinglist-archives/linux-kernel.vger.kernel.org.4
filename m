Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB85673D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjASPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjASPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:18:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF18298E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=26Vzdfk8IdehtEF8twTCYdwKeIkT3v/NB65Q8/opuvU=; b=wKnaZKGv244sKaa5/MbOQalVW2
        +GNCgmvInCTBakotr37QLjo2O17nERiNMWouC04X0XvwzhQeQ2HRBa7Ky/ZxAe113ULLv+Cv6837Z
        e1dBTnnlf1nFWPcD5lB2UBtS1LcRKFSukIJl470uUNgWbbFbx0aAxpzf5CsHykGzFNcM7Xl1aiqAM
        SxM3rRtS9MJ3w7eF8P0G2jPScLimVe6bLDg2N3s47NBDsuBkpqOH/2djIM61pojKRKLFCiAX+TSYP
        o4Eagk+2oqsLMmCznNVhTx53iOScKpvk4OvLG3eU6X2XSQziFg4gSg9NrbgPMnvnIkc4nALyjBn+s
        L1o/ho/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIWgV-00158f-Pv; Thu, 19 Jan 2023 15:18:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F9AA30008D;
        Thu, 19 Jan 2023 16:18:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 243BF20DC30B7; Thu, 19 Jan 2023 16:18:34 +0100 (CET)
Date:   Thu, 19 Jan 2023 16:18:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     sandipan.das@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:56:08PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 19, 2023 at 02:23:03AM +0100, Erhard F. wrote:
> > Hi!
> > 
> > I did a kernel bisect for an issue I originally posted on https://github.com/ClangBuiltLinux/linux/issues/1774
> > 
> > It is about kernel 6.1.x not booting on my machines when built with clang. A gcc built kernel with the same config just works fine. Turns out kernel v6.2-rc4 and earlier v6.2-rc are still affected.
> > 
> > I did a kernel bisect which revealed this commit:
> > 
> >  # git bisect bad
> > 706460a96fc654e80b6bed1f562b00d2ce9f2f4d is the first bad commit
> > commit 706460a96fc654e80b6bed1f562b00d2ce9f2f4d
> > Author: Sandipan Das <sandipan.das@amd.com>
> > Date:   Thu Aug 11 17:59:51 2022 +0530
> > 
> >     perf/x86/amd/core: Add generic branch record interfaces
> >     
> >     AMD processors that are capable of recording branches support either Branch
> >     Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
> >     Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
> >     calls which act as gateways to call into the feature-dependent functions
> >     based on what is available on the processor.
> >     
> >     Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >     Link: https://lore.kernel.org/r/b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com
> > 
> >  arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> Using: v6.2-rc4-67-g7287904c8771
> 
> I have an AMD Interlagos and after bringing it back to live/up-to-date I
> can't seem to even boot your .config in qemu/kvm irrespective of
> GCC/Clang.
> 
> When I build defconfig+kvm_guest.config both GCC-12 and clang-15 boot
> just fine in qemu/kvm.

Furthermore, testing localyesconfig based off Debian's
config-6.1.0-1-amd64 boots fine using both GCC-12 and clang-15 as host
kernels on that machine.

