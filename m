Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43B73A1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFVNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFVNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:15:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2A210E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Ufmc0Z6O1yW0ICUZh7aoz2TN+c20tRHp51mRicssOYA=; b=W37UuZpUw1vREEI3wtlUKuUETq
        JEynIINmlJItVhZGOkbubOleNJDmZZqE60AGeCIw/dWswSudEfoUxqtiMTqdm0MSfpujyoLq1xtdZ
        16FkN/+uMIIGBENQbQeqPVxaQGhysLA9KCZkZDx3Mh+nAwY3+ZsNYMPMu0vjKViVygVGexQr7pltB
        MCtKV7sQFwyPjIocL174eAywjD21NXhWSW0uP6rPpV2sV6fRmJTeoSaxHw8CVQUBnfWJerD4cluCf
        3I6A8+kHsEtLMzS27V7vmn1MDVq1n9uCbu3bwZv/0852Vzvb4ni892/NkqFw29VdsqzjJD+I3A5uB
        XXkNe7cA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCK98-001BsM-2N;
        Thu, 22 Jun 2023 13:14:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 032D43002F0;
        Thu, 22 Jun 2023 15:14:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D74EA24263362; Thu, 22 Jun 2023 15:14:45 +0200 (CEST)
Date:   Thu, 22 Jun 2023 15:14:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>, Per Bilse <Per.Bilse@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Message-ID: <20230622131445.GQ4253@hirez.programming.kicks-ass.net>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
 <e8f0d101-d803-8ccb-80a0-fc7c6c45ab77@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8f0d101-d803-8ccb-80a0-fc7c6c45ab77@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:05:13PM +0100, Andrew Cooper wrote:
> On 22/06/2023 9:26 am, Peter Zijlstra wrote:
> > On Thu, Jun 22, 2023 at 07:22:53AM +0200, Juergen Gross wrote:
> >
> >> The hypercalls we are talking of are synchronous ones. They are running
> >> in the context of the vcpu doing the call (like a syscall from userland is
> >> running in the process context).
> > (so time actually passes from the guest's pov?)
> 
> Yes.  And in principle it's wired into stolen time.

Hmm, that means that if the scheduler accounts for stolen time (see
update_rq_clock_task(), PARAVIRT_TIME_ACCOUNTING hunk) then it appears
as if no time has passed, which might affect preemption decisions.

Oh well, we'll think about it when it's shown to be a problem I suppose
:-)
