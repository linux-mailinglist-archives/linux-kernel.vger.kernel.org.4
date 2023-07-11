Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0ED74F011
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjGKN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGKN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:26:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A321E5F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIbIs7qALfTkQpijTnEcAoyrwK1musx6nJU1Uy2RWNc=; b=iwVQ1n9K/yCsf96VsGZlhJtCU2
        chrMyygEfGuAHO8LtJ9CMTYW+6zdciQqrt6J6ji+6NRBqlEA9UNFSkaHB+THwgZIKF37CHn0KNlm4
        UJBe/5DCjF+jJpYoojBHbWVR94zXz9JaLSoEZ+V3fr5FMGhJ3YLgnkGit8DhF46qrSlk6asmH1GYn
        gV+0JycjUegHNJPUozmYIhAkl0uDBZF29g5LrHNQtIJ3raHoInfI9PyaWP6AuuBB2u9XoP4VEzP8A
        rS5wIIeFurDR/K8QNOk+W+FHw9Q4FMqM1A9gNbH9ooKh6Oa2Z9mRcnD58ZM7KscHeTw2R5botU17K
        NkDn5VtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJDNK-00FkgC-Cs; Tue, 11 Jul 2023 13:25:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0923E300222;
        Tue, 11 Jul 2023 15:25:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E665A243429D2; Tue, 11 Jul 2023 15:25:53 +0200 (CEST)
Date:   Tue, 11 Jul 2023 15:25:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     arjan@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:55:57PM +0200, Peter Zijlstra wrote:

> Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
> commit babbles something about waking CPUs from idle to do TLB
> invalidate, but that shouldn't be the case, that's what we have
> kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
> vcpu-enter.
> 
> Arjan, what is the actual problem you're trying to solve any why hide
> this in intel_idle ?


static __always_inline int __intel_idle_hlt(struct cpuidle_device *dev,
					struct cpuidle_driver *drv, int index)
{
	raw_safe_halt();
	raw_local_irq_disable();
	return index;
}

Which does:

	STI
	HLT
	CLI

static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
                                   struct cpuidle_driver *drv, int index)
{
       int ret;

       raw_local_irq_enable();
       ret = __intel_idle_hlt(dev, drv, index);
       raw_local_irq_disable();

       return ret;
}

That is nonsensical code; because now you have:

	STI
	STI
	HLT
	CLI
	CLI

And that makes sense how?

Rafael, can we please just pull these patches and try again later?

