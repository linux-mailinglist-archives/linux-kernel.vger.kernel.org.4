Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626B374EFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGKNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:16:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE8B1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RiA4pM3h/lCIroSWwMXlgXmt7zvVpoD39zDbY61jes=; b=mRuOZQUJVhY+QlCVgkUZmJTMWh
        XnsREmAA0qHWw0OB8NQ/2RyEWEEYQVHLXqjER1qA7dQlYMZF7wDlW97MqcGGJ+RCt8OMbyB0zy+N+
        WnepmD3UZTXa5p4GG2/84lZZrY7k6zO4C0peoaexY3ZqY2PlLP3Dp7yBXNtGpGl0scmJyhbo4QdVD
        J3rtU8XNMBx4EBOf1JjTlZjLYwxGMzforSZRx/wLa7Wbd44WdCJLJI7oICywn7eW4qZm6/NmsmqzJ
        n0Uh9cAQoYgzc40zhL8RiaRiUhkeFem2uBMa2FkZW87g6aUePaEGKGLdj21uc0QDLP3uaFPJ9P5Jo
        h+9i5tYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJDDi-00FkIv-Ih; Tue, 11 Jul 2023 13:15:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36F493002B1;
        Tue, 11 Jul 2023 15:15:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 207B22439FF31; Tue, 11 Jul 2023 15:15:57 +0200 (CEST)
Date:   Tue, 11 Jul 2023 15:15:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     arjan@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230711131557.GA3063741@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:55:57PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 02:25:51PM +0200, Bruno Goncalves wrote:
> 
> > R640 2x  Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz
> 
> Gawd, I hate our naming :/ Google tells me that is a skylake.
> 
> > and start the VM with:
> > 
> > -accel kvm -cpu
> > Skylake-Server-IBRS,ss=on,vmx=on,pdcm=on,hypervisor=on,tsc-adjust=on,clflushopt=on,umip=on,pku=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaves=on,ibpb=on,ibrs=on,amd-stibp=on,amd-ssbd=on,rsba=on,skip-l1dfl-vmentry=on,pschange-mc-no=on
> 
> You tell it to be a skylake
> 
> > The decoded call trace:
> 
> > /builds/4626306068/workdir/drivers/idle/intel_idle.c:1820
> 
> And that's skx_idle_state_table_update() reading
> MSR_PKG_CST_CONFIG_CONTROL and that code has been around since 2021.
> 
> So things are somewhat consistent. But I find it weird that intel_idle
> gets selected for a guest, I'm not exactly sure what's up with that.
> 
> Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
> commit babbles something about waking CPUs from idle to do TLB
> invalidate, but that shouldn't be the case, that's what we have
> kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
> vcpu-enter.
> 
> Arjan, what is the actual problem you're trying to solve any why hide
> this in intel_idle ?

Also, I thought we already had a virt specific cpuidle driver
somewhere....

/me rummages around and finds cpuidle-haltpoll.c. That thing was
specifically created for virt IIRC. Can we please stick all the virt
stuff in there? That seems far simpler to extend anyway.

Rafael?
